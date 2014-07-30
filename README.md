[![Build Status](https://travis-ci.org/ericroberts/percentable.png?branch=master)](https://travis-ci.org/ericroberts/percentable)
[![Code Climate](https://codeclimate.com/github/ericroberts/percentable.png)](https://codeclimate.com/github/ericroberts/percentable)

# Percentable

Small gem to make working with percents easier.

## Installation

Add this line to your application's Gemfile:

    gem 'percentable'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install percentable

## Usage

### So how do I use this thing?

Well, you can use this a couple of ways.

``` ruby
percent = Percent.new(50)
percent.value   #=> 50.0
percent.to_s    #=> '50%'
percent.to_f    #=> 0.5
percent == 50   #=> false
percent == 0.5  #=> true
```

That's the basics of the object itself. You probably want to know about how it works with other percents though, right?

``` ruby
percent = Percent.new(10)
percent + percent   #=> Percent.new(20)
percent - percent   #=> Percent.new(0)
percent * percent   #=> Percent.new(1)
percent / percent   #=> Percent.new(1)
```

And even more importantly, how it works with other Numeric objects:

``` ruby
percent = Percent.new(50)
percent + 10    #=> Percent.new(60)
percent - 10    #=> Percent.new(40)
percent * 10    #=> Percent.new(500)
percent / 10    #=> Percent.new(5)
```

Repeat steps above for Floats, BigDecimals, etc. It should all work.

### Can I turn other Numerics into Percents?

Yes, yes you can.

``` ruby
10.to_percent   #=> Percent.new(10)
```

### How do I use this with Rails?

Well let's say you have a User model, and on that user model you have a health attribute. You want to set that to a number that represents the percent. Just use the extend Percentable::Percentize method, and then use the percentize method to make sure you are returned percent objects always. Example below:

``` ruby
class User < ActiveRecord::Base
  extend Percentable::Percentize

  percentize :health
end

user = User.new(health: 100)
user.health     #=> Percent.new(100)
```

### What if I don't use Rails but want to use percentize?

That works too, there's nothing Rails specific about `Percentable::Percentize`. Example below:

``` ruby
class OriginalClass
  def returns_a_percent
    10
  end
end

class PercentizedClass
  extend Percentable::Percentize

  percentize :returns_a_percent
end

percentize_object = PercentizedClass.new
percentize_object.returns_a_percent     #=> Percent.new(10)
```

### OK, but why would I want this?

I don't know, all I can tell you is that I found it useful. Instead of writing methods to translate from 0.1 to 10% all over the place, I now have a class to represent everything to do with percents.

### Is that it?

Hey, I only wrote this in a night. Happy to except contributions from others!

## Contributing

1. Fork it ( https://github.com/ericroberts/percentable/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
