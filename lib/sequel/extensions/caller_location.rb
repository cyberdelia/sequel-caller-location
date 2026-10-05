# frozen_string_literal: true

require 'sequel'

module Sequel
  module CallerLocation
    def insert_sql(*values)
      sql = super
      backtrace = caller_locations(1).find { |c| c.path !~ /gems/ }
      append_location(sql, backtrace)
    end

    def update_sql(*values)
      sql = super
      backtrace = caller_locations(1).find { |c| c.path !~ /gems/ }
      append_location(sql, backtrace)
    end

    def select_sql(*values)
      sql = super
      backtrace = caller_locations(1).find { |c| c.path !~ /gems/ }

      @cache.delete(:_select_sql)
      append_location(sql, backtrace)
    end

    def delete_sql(*values)
      sql = super
      backtrace = caller_locations(1).find { |c| c.path !~ /gems/ }
      @cache.delete(:_delete_sql)
      append_location(sql, backtrace)
    end

    private

    def append_location(sql, backtrace)
      return sql unless backtrace

      comment = format_sql_comment(backtrace)
      sql.frozen? ? sql + comment : sql << comment
    end

    def format_sql_comment(comment)
      " -- #{comment.to_s.gsub(/\s+/, ' ')}\n"
    end
  end

  Dataset.register_extension(:caller_location, CallerLocation)
end
