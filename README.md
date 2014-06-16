# Accounty

A program to take an entry file, and parse it into actual account numbers.

**Of Note:**
Each entry is 4 lines long, and each line has 27 characters. The first 3
lines of each entry contain an account number written using pipes and
underscores, and the fourth line is blank. Each account number should have 9
digits, all of which should be in the range 0-9. A normal file contains
around 500 entries.

## Installation

Add this line to your application's Gemfile:

    gem 'accounty'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install accounty

## Usage

Given the file `entries.txt` containing:

```
    _  _     _  _  _  _  _ 
  | _| _||_||_ |_   ||_||_|
  ||_  _|  | _||_|  ||_| _|
                           
    _  _  _  _  _     _  _ 
|_||_ |_   ||_||_|  | _| _|
  | _||_|  ||_| _|  ||_  _|
                           
 _  _  _     _  _     _  _ 
  ||_||_|  | _| _||_||_ |_ 
  ||_| _|  ||_  _|  | _||_|
                           
```

Executing `accounty` as below returns the parsed account numbers:

```
$ accounty entries.txt
$ 123456789
$ 456789123
$ 789123456
```

## Contributing

1. Fork it ( https://github.com/danthompson/accounty/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
