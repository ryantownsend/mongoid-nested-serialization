# MongoidNestedSerialization

Loads nested Mongoid documents using JSON serialization.

[![Build Status][2]][1]

  [1]: http://travis-ci.org/ryantownsend/mongoid-nested-serialization
  [2]: https://secure.travis-ci.org/ryantownsend/mongoid-nested-serialization.png?branch=master

## Installation

Add this line to your application's Gemfile:

```ruby
gem "mongoid-nested-serialization"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mongoid-nested-serialization

## Usage

The module will be automatically loaded into your `Mongoid::Document` objects:

```ruby
class User
  include Mongoid::Document
  # also performs:
  # include Mongoid::NestedSerialization
  
  # objects may be embedded within others
  embedded_in :account, inverse_of: :users
end

# find the root object
account = Account.first
# create a persisted object within it
user = account.users.create # => <User id:123>
# load the JSON needed to find the object
json = user.finder_json
# => { class_name: "Account", id: 456, embedded: { collection: "users", id: 123 } }
User.find_by_json(json)
# => <User id:123>
```

You can also talk directly with our classes:

```ruby
json = Mongoid::NestedSerialization::Serializer.new(user).to_json
# => { class_name: "Account", id: 456, embedded: { collection: "users", id: 123 } }
Mongoid::NestedSerialization::Finder.find(json)
# => <User id:123>
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Add your code and tests
4. Run the full test suite (`bundle exec rake`) and ensure it passes 100%
5. Commit your changes (`git commit -am 'Added some feature'`)
6. Push to the branch (`git push origin my-new-feature`)
7. Create new Pull Request
