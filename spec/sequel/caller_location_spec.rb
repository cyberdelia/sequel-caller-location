# frozen_string_literal: true

require 'spec_helper'

describe Sequel::CallerLocation do
  let(:ds) { Sequel.mock[:t].extension(:caller_location) }

  it 'add caller location to select statement' do
    expect(ds.select_sql).to eq("SELECT * FROM t -- #{caller_locations(0, 1).first}\n")
  end

  it 'add caller location to select statement only once' do
    ds.select_sql
    expect(ds.select_sql).to eq("SELECT * FROM t -- #{caller_locations(0, 1).first}\n")
  end

  it 'add caller location to insert statement' do
    expect(ds.insert_sql(a: 1)).to eq("INSERT INTO t (a) VALUES (1) -- #{caller_locations(0, 1).first}\n")
  end

  it 'add caller location to delete statement' do
    expect(ds.delete_sql).to eq("DELETE FROM t -- #{caller_locations(0, 1).first}\n")
  end

  it 'add caller location to delete statement only once' do
    ds.delete_sql
    expect(ds.delete_sql).to eq("DELETE FROM t -- #{caller_locations(0, 1).first}\n")
  end

  it 'add caller location to update statement' do
    expect(ds.update_sql(a: 1)).to eq("UPDATE t SET a = 1 -- #{caller_locations(0, 1).first}\n")
  end

  it 'does not mutate frozen SQL' do
    sql = String.new('SELECT * FROM t').freeze
    location = caller_locations(0, 1).first

    result = ds.send(:append_location, sql, location)

    expect(result).to eq("SELECT * FROM t -- #{location}\n")
  end

  it 'preserves SQL identity for placeholder literalizers' do
    loader = ds.placeholder_literalizer_loader do |placeholder, dataset|
      dataset.where(id: placeholder.arg)
    end

    expect(loader.sql(1)).to start_with('SELECT * FROM t WHERE (id = 1) -- ')
  end
end
