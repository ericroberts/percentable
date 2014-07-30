[![Gem Version](https://badge.fury.io/rb/percentable.png)](http://badge.fury.io/rb/percentable)
[![Build Status](https://travis-ci.org/ericroberts/percentable.png?branch=master)](https://travis-ci.org/ericroberts/percentable)
[![Code Climate](https://codeclimate.com/github/ericroberts/percentable.png)](https://codeclimate.com/github/ericroberts/percentable)
[![Coverage Status](https://coveralls.io/repos/ericroberts/percentable/badge.png?branch=master)](https://coveralls.io/r/ericroberts/percentable?branch=master)

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

And with the number on the other side...

``` ruby
percent = Percent.new(50)
10 + percent    #=> 15
10 - percent    #=> 5
10 * percent    #=> 5
10 / percent    #=> 20
```

Repeat steps above for Floats, BigDecimals, etc. It should all work.

### Can I turn Numerics into Percents?

Yes, yes you can.

``` ruby
10.to_percent   #=> Percent.new(10)
```

### What if I want to turn my Numeric into what it would actually be as a percent?

Sometimes 10.to_percent is not what you want. That returns you `Percent.new(10)` which is equal only to 0.1. If you have 0.1 and want to turn that into a percent representation, use the code below:

``` ruby
Percent.from_numeric(1)   #=> Percent.new(100)
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

class PercentizedClass < OriginalClass
  extend Percentable::Percentize

  percentize :returns_a_percent
end

percentize_object = PercentizedClass.new
percentize_object.returns_a_percent     #=> Percent.new(10)
```

### What else can percentize do?

You can percentize multiple methods at a time:

``` ruby
class PercentizedClass < OriginalClass
  extend Percentable::Percentize

  percentize :method1, :method2
end
```

You can also define defaults for when the percentized method returns nil:

``` ruby
class PercentizedClass < OriginalClass
  extend Percentable::Percentize

  percentize :method1, :method2, default: 20
end

# assuming method1 on OriginalClass returns nil
percentize_object = PercentizedClass.new
percentize_object.method1     #=> Percent.new(20)
```

### OK, but why would I want this?

I don't know, all I can tell you is that I found it useful. Instead of writing methods to translate from 0.1 to 10% all over the place, I now have a class to represent everything to do with percents.

### Is that it?

Hey, I only wrote this in a night. Happy to accept contributions from others!

### Your math is totally wrong and you are an idiot.

That's not a question. I've had a fair bit of discussion with the fine folks at [Boltmade](http://www.boltmade.com) about how it should behave, and the examples you see above are what we settled on. If you would like to propose a change, the best way would be to edit the README to show examples for how you would like it to act. You can also submit a pull request that changes the code, but if you submit the README first we can have a discussion about whether or not it makes sense. I'm not totally sold on the current implementation and would be happy to discuss changes.

## Contributing

1. Fork it ( https://github.com/ericroberts/percentable/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
