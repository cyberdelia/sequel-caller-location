# frozen-string-literal: true

require 'spec_helper'

describe Sequel::CallerLocation do
  let(:ds) { Sequel.mock[:t].extension(:caller_location) }

  it 'add caller location to select statement' do
    expect(ds.select_sql).to eq("SELECT * FROM t -- #{caller_locations(0, 1).first}\n")
  end

  it 'add caller location to insert statement' do
    expect(ds.insert_sql(a: 1)).to eq("INSERT INTO t (a) VALUES (1) -- #{caller_locations(0, 1).first}\n")
  end

  it 'add caller location to delete statement' do
    expect(ds.delete_sql).to eq("DELETE FROM t -- #{caller_locations(0, 1).first}\n")
  end

  it 'add caller location to update statement' do
    expect(ds.update_sql(a: 1)).to eq("UPDATE t SET a = 1 -- #{caller_locations(0, 1).first}\n")
  end
end
