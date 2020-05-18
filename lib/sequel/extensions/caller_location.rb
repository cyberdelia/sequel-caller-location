# frozen-string-literal: true

require 'sequel'

module Sequel
  module CallerLocation
    def insert_sql(*values)
      sql = super(*values)
      backtrace = caller_locations(1).find { |c| c.path !~ /gems/ }
      append_location(sql, backtrace)
      sql
    end

    def update_sql(*values)
      sql = super(*values)
      backtrace = caller_locations(1).find { |c| c.path !~ /gems/ }
      append_location(sql, backtrace)
      sql
    end

    def select_sql(*values)
      sql = super(*values)
      backtrace = caller_locations(1).find { |c| c.path !~ /gems/ }

      @cache.delete(:_select_sql)
      append_location(sql, backtrace)
      sql
    end

    def delete_sql(*values)
      sql = super(*values)
      backtrace = caller_locations(1).find { |c| c.path !~ /gems/ }
      @cache.delete(:_delete_sql)
      append_location(sql, backtrace)
      sql
    end

    private

    def append_location(sql, backtrace)
      sql << format_sql_comment(backtrace) if !sql.frozen? && backtrace
    end

    def format_sql_comment(comment)
      " -- #{comment.to_s.gsub(/\s+/, ' ')}\n"
    end
  end

  Dataset.register_extension(:caller_location, CallerLocation)
end
