# Sequel Caller Location

Set the caller location as comments to your SQL.

## Installation

Install it directly using gem:

```
gem install sequel_caller_location
```

Or adding it to your ``Gemfile``:

```
gem "sequel_caller_location"
```

## Usage

## Configure

A straightforward example, this will let sequel_caller_location add the caller location
automatically:

```ruby
DB.extension(:caller_location)
```
