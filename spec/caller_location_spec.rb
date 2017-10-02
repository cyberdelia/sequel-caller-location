# frozen-string-literal: true

require 'spec_helper'

describe Sequel::CallerLocation do
  let(:ds) { Sequel.mock[:t].extension(:caller_location) }

  it 'add caller location comment' do
    expect(ds.select_sql).to eq("SELECT * FROM t -- #{caller_locations(0, 1).first}\n")
    expect(ds.insert_sql(a: 1)).to eq("INSERT INTO t (a) VALUES (1) -- #{caller_locations(0, 1).first}\n")
    expect(ds.delete_sql).to eq("DELETE FROM t -- #{caller_locations(0, 1).first}\n")
    expect(ds.update_sql(a: 1)).to eq("UPDATE t SET a = 1 -- #{caller_locations(0, 1).first}\n")
  end
end
