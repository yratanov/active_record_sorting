# ActiveRecordSorting ![Build Status](https://travis-ci.org/yratanov/active_record_sorting.svg)

Simple gem to sort your records keeping model clean

## Installation

Add this line to your application's Gemfile:

    gem 'active_record_sorting'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_record_sorting

## Why?

Usually when your application grows your models become a mess of different kind of logic (scopes, auth, everything).
And usually you need to provide an API for sorting. 
Of course you add some magic Concerns and use it like this `User.sort(order)` and add custom orders' logic right in your model class. 
But if you care about you code being clean and follow single responsibility principle then you need this gem to extract sorting logic out of the model. 

## Usage

1. Create sorting class:
    ```ruby
    # app/sortings/user_sorting
    class UserSorting < ActiveRecordSorting::Base
      named_sorting_orders :full_name
    
      def full_name(order)
        scope.order(first_name: order, last_name: order)
      end   
    end
```
2. In your controller:
   
    ```ruby
   UserSorting.sort(user_scope, 'id_asc').another_scope 
   UserSorting.sort(user_scope, 'created_at_desc')
   UserSorting.sort(user_scope, 'relation.column_asc')
   UserSorting.sort(user_scope, 'full_name_asc')
   UserSorting.sort(user_scope, 'any_column_desc')
    ```

You can also define basic sorting class if you don't want to create it for each model:

```ruby
# app/sortings/sorting
class Sorting < ActiveRecordSorting::Base
end
```

Usage: 

```ruby
Sorting.sort(User, params[:sort])

```

If you still want to access sort from your model just do the following:

```ruby
class User < ActiveRecord::Base
   def self.sort(order)
     UserSorting.sort(self, order)
   end
end

# Usage

User.sort(params[:sort])

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
