# frozen-string-literal: true
require 'sequel'

module Sequel
  module Comments
    def comment(comment)
      clone(comment: (format_sql_comment(comment) if comment))
    end

    %w(select insert update delete).each do |type|
      define_method(:"#{type}_sql") do |*a|
        sql = super(*a)
        if (comment = @opts[:comment])
          sql << comment
        elsif (backtrace = caller_locations(1).find { |c| c.path !~ /gems/ })
          sql << format_sql_comment(backtrace)
        end
        sql
      end
    end

    private

    def format_sql_comment(comment)
      " -- #{comment.to_s.gsub(/\s+/, ' ')}\n"
    end
  end
  Dataset.register_extension(:comments, Comments)
end
