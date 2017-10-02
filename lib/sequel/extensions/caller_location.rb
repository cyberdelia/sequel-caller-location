# frozen-string-literal: true

require 'sequel'

module Sequel
  module CallerLocation
    %w[select insert update delete].each do |type|
      define_method(:"#{type}_sql") do |*a|
        sql = super(*a)
        if !sql.frozen? && (backtrace = caller_locations(1).find { |c| c.path !~ /gems/ })
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

  Dataset.register_extension(:caller_location, CallerLocation)
end
