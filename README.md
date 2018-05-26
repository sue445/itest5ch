# Itest5ch

5ch (a.k.a. 2ch) reader via http://itest.5ch.net/

[![Gem Version](https://badge.fury.io/rb/itest5ch.svg)](https://badge.fury.io/rb/itest5ch)
[![CircleCI](https://circleci.com/gh/sue445/itest5ch/tree/master.svg?style=svg&circle-token=6424acab43b6dd71c3e09619ff7bb2e9b5611aa0)](https://circleci.com/gh/sue445/itest5ch/tree/master)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'itest5ch'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install itest5ch

## Usage

### [Itest5ch::Board](lib/itest5ch/board.rb)

#### Get all boards

```ruby
category_boards = Itest5ch::Board.all
#=> {"地震"=>
  [#<Itest5ch::Board:0x00007f821c5bb4b8 @name="地震headline", @url="http://itest.5ch.net/subback/bbynamazu">,
   #<Itest5ch::Board:0x00007f821c5b9f78 @name="地震速報", @url="http://itest.5ch.net/subback/namazuplus">,
   #<Itest5ch::Board:0x00007f821c5b8a38 @name="臨時地震", @url="http://itest.5ch.net/subback/eq">,
   #<Itest5ch::Board:0x00007f821c5c37d0 @name="臨時地震+", @url="http://itest.5ch.net/subback/eqplus">,
   #<Itest5ch::Board:0x00007f821c5c2290 @name="緊急自然災害", @url="http://itest.5ch.net/subback/lifeline">],
 "おすすめ"=>
  [#<Itest5ch::Board:0x00007f821c5d3dd8 @name="スマートフォン", @url="http://itest.5ch.net/subback/smartphone">,
   #<Itest5ch::Board:0x00007f821c5d2898 @name="ハワイ州", @url="http://itest.5ch.net/subback/hawaii">,
   #<Itest5ch::Board:0x00007f821c5d1358 @name="大学生活", @url="http://itest.5ch.net/subback/campus">,
   #<Itest5ch::Board:0x00007f821c5dbf38 @name="恋愛サロン", @url="http://itest.5ch.net/subback/lovesaloon">,
   #<Itest5ch::Board:0x00007f821c5da9f8 @name="アレルギー", @url="http://itest.5ch.net/subback/allergy">,
   #<Itest5ch::Board:0x00007f821c5d94b8 @name="ラブライブ！", @url="http://itest.5ch.net/subback/lovelive">,
   #<Itest5ch::Board:0x00007f821ca0e8d0 @name="Apple", @url="http://itest.5ch.net/subback/apple2">,
   #<Itest5ch::Board:0x00007f821c5e2ba8 @name="初心者の質問", @url="http://itest.5ch.net/subback/qa">],
```

#### Get boards of a category

```ruby
boards = Itest5ch::Board.find_category_boards("おすすめ")
#=> [#<Itest5ch::Board:0x00007f821c639840 @name="スマートフォン", @url="http://itest.5ch.net/subback/smartphone">,
 #<Itest5ch::Board:0x00007f821c628dd8 @name="ハワイ州", @url="http://itest.5ch.net/subback/hawaii">,
 #<Itest5ch::Board:0x00007f821c6185c8 @name="大学生活", @url="http://itest.5ch.net/subback/campus">,
 #<Itest5ch::Board:0x00007f821c67bf10 @name="恋愛サロン", @url="http://itest.5ch.net/subback/lovesaloon">,
 #<Itest5ch::Board:0x00007f821c66b728 @name="アレルギー", @url="http://itest.5ch.net/subback/allergy">,
 #<Itest5ch::Board:0x00007f821c65add8 @name="ラブライブ！", @url="http://itest.5ch.net/subback/lovelive">,
 #<Itest5ch::Board:0x00007f821c64a258 @name="Apple", @url="http://itest.5ch.net/subback/apple2">,
 #<Itest5ch::Board:0x00007f821c6b9658 @name="初心者の質問", @url="http://itest.5ch.net/subback/qa">]
```

#### Get a board
```ruby
board = Itest5ch::Board.find("スマートフォン")

# or

board = Itest5ch::Board.find("smartphone")
```

### [Itest5ch::Thread](lib/itest5ch/thread.rb)
#### Get threads
```ruby
threads = board.threads
```

#### Get a thread
```ruby
# with PC url
thread = Itest5ch::Thread.new("http://egg.5ch.net/test/read.cgi/smartphone/0000000000")

# or

# with Smartphone url
thread = Itest5ch::Thread.new("http://itest.5ch.net/egg/test/read.cgi/smartphone/0000000000")
```

### [Itest5ch::Comment](lib/itest5ch/comment.rb)
```ruby
comments = thread.comments
```

### [Itest5ch::Config](lib/itest5ch/config.rb)
```ruby
Itest5ch.config.user_agent = "XXXX"
```

* `user_agent` : User Agent

## ProTip
When `Time.zone` is initialized, `Itest5ch::Comment#date` returns `ActiveSupport::TimeWithZone` instead of `Time` (requirements `activesupport`)

```ruby
comment.date
#=> 2018-03-06 12:34:56 +0900
comment.date.class
#=> Time
```

```ruby
require "active_support/time"
Time.zone = "Tokyo"

comment.date
#=> Tue, 06 Mar 2018 12:34:56 JST +09:00
comment.date.class
#=> ActiveSupport::TimeWithZone
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sue445/itest5ch.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
