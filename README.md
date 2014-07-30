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

    percent = Percent.new(50)
    percent.value   #=> 50
    percent.to_s    #=> '50%'
    percent.to_f    #=> 0.5

    class User < ActiveRecord::Base
      extend Percentable::Percentize

      percentize :health
    end
    
    user = User.new(health: 100)
    user.health     #=> Percent.new(100)

### OK, but why would I want this?

I don't know, all I can tell you is that I found it useful. Instead of writing methods to translate from 0.1 to 10% all over the place, I now have a class to represent everything to do with percents.

### What else can it do?

It can handle the normal things you would expect from a `Numeric` object. Addition, subtraction, multiplication, division, etc.

    percent = Percent.new(10)
    percent + percent         #=> Percent.new(20)
    percent - percent         #=> Percent.new(0)
    percent * percent         #=> Percent.new(100)
    percent / percent         #=> Percent.new(1)

You probably want to know how it works with other Numerics though.

    percent = Percent.new(50)
    percent + 10              #=> Percent.new(60)
    percent - 10              #=> Percent.new(40)
    percent * 10              #=> Percent.new(500)
    percent / 10              #=> Percent.new(5)

### Is that it?

Hey, I only wrote this in a night. Happy to except contributions from others!

## Contributing

1. Fork it ( https://github.com/ericroberts/percentable/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
