# Itest5ch

5ch (a.k.a. 2ch) reader via http://itest.5ch.net/

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

### [Board](lib/itest5ch/board.rb)

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

#### Get boards of of category

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

### [Thread](lib/itest5ch/thread.rb)
#### Get threads
```ruby
threads = board.threads
```

#### Get a thread
```ruby
# with PC url
thread = Itest5ch::Thread.new("http://egg.5ch.net/test/read.cgi/smartphone/1520158116")

# or

# with Smartphone url
thread = Itest5ch::Thread.new("http://itest.5ch.net/egg/test/read.cgi/smartphone/1520158116")
```

### [Comment](lib/itest5ch/comment.rb)
```ruby
comments = thread.comments
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sue445/itest5ch.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
