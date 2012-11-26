# Open Charities

A simple library for querying http://opencharities.org/ database.

## Installation

To install as a standalone
```sh
$ gem install open-charities
```
or as a dependency in a Gemfile
```ruby
gem "open-charities", "~> 0.1.0", require: 'open_charities'
```

## Usage

```ruby
charity = OpenCharities.lookup("1149855")
=> #<OpenCharities::Response:0x00000001738d30 @attributes={"address"...>

charity['title']
=> "VETERAN'S HEADQUARTERS"

charity.title
=> "VETERAN'S HEADQUARTERS"

charity.charity_number
=> "1149855"

charity.address
=> {"region"=>nil, "raw_address"=>nil, "created_at"=>"2012-11-22T05:00:54+00:00"...}
```
As can be seen from this example, some of the attributes are exposed as instance
methods. More specifically, the methods that are exposed correspond to the
top-level keys in the Hash containing information about the charity.
As in the above example, the `address` attribute returns another Hash.

## Caching

Requests can be cached by configuring the gem to use an external cache (for example,
the Rails cache).

```ruby
# file config/initializers/open_charities.rb

# swap in your own cache here
OpenCharities.cache = Rails.cache

# Optional
OpenCharities.cache_args = { expires_in: 10.minutes }
```

## Testing

To run the tests, issue `rspec spec` on the command-line.

### Available testing data

There is testing data available `spec/data/veteransheadquarters.json`. The same
data is used by the tests in `spec/`.
