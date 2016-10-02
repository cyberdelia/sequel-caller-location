# Sequel-comments

Set a custom message or the caller location as comments to your SQL.

## Installation

Install it directly using gem:

```
gem install sequel_comments
```

Or adding it to your ``Gemfile``:

```
gem "sequel_comments"
```

## Usage

## Configure

A straightforward example, this will let sequel_comments add the caller location
automatically:

```ruby
DB.extension(:comments)
```
