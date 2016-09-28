# frozen-string-literal: true
require 'spec_helper'

describe Sequel::Comments do
  let(:ds) { Sequel.mock[:t].extension(:comments) }

  it 'add location comment if one is not set for the dataset' do
    expect(ds.select_sql).to eq("SELECT * FROM t -- #{caller_locations(0, 1).first}\n")
    expect(ds.insert_sql(a: 1)).to eq("INSERT INTO t (a) VALUES (1) -- #{caller_locations(0, 1).first}\n")
    expect(ds.delete_sql).to eq("DELETE FROM t -- #{caller_locations(0, 1).first}\n")
    expect(ds.update_sql(a: 1)).to eq("UPDATE t SET a = 1 -- #{caller_locations(0, 1).first}\n")
  end

  it 'add a comment if one is set for the dataset' do
    dataset = ds.comment("Some\nComment\r\n Here")
    expect(dataset.select_sql).to eq("SELECT * FROM t -- Some Comment Here\n")
    expect(dataset.insert_sql(a: 1)).to eq("INSERT INTO t (a) VALUES (1) -- Some Comment Here\n")
    expect(dataset.delete_sql).to eq("DELETE FROM t -- Some Comment Here\n")
    expect(dataset.update_sql(a: 1)).to eq("UPDATE t SET a = 1 -- Some Comment Here\n")
  end

  it 'handle comments used in nested datasets' do
    dataset = ds.comment("Some\nComment\r\n Here")
    expect(dataset.where(id: dataset).select_sql).to eq("SELECT * FROM t WHERE (id IN (SELECT * FROM t -- Some Comment Here\n)) -- Some Comment Here\n")
  end
end
