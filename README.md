# Using JSONAPI-RB

## Overview

A much more simple library which includes four libraries

- [jsonapi-deserializable](https://github.com/jsonapi-rb/jsonapi-deserializable) — Conveniently deserialize JSON API payloads into custom hashes
- [jsonapi-serializable]()




## Creating Scheduled Tracks

`bin/rails g model scheduled_track position:integer state schedule:belongs_to`

### Deserializable

The `deserializable_resource` method expects the `jsonapi-rails` params parser to be used, which places the JSON payload into `params[:_jsonapi]` for requests with `Content-Type: application/vnd.api+json`.

### Serializable



## Controllers



## Testing

Using an RSpec as usual with additional libraries to help

- Rspec
- Factory Bot
- Faker
- Database Cleaner
