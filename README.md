# Terraforming::DNSimple
[![Build Status](https://travis-ci.org/dtan4/terraforming-dnsimple.svg?branch=master)](https://travis-ci.org/dtan4/terraforming-dnsimple)
[![Code Climate](https://codeclimate.com/github/dtan4/terraforming-dnsimple/badges/gpa.svg)](https://codeclimate.com/github/dtan4/terraforming-dnsimple)
[![Test Coverage](https://codeclimate.com/github/dtan4/terraforming-dnsimple/badges/coverage.svg)](https://codeclimate.com/github/dtan4/terraforming-dnsimple/coverage)
[![Gem Version](https://badge.fury.io/rb/terraforming-dnsimple.svg)](http://badge.fury.io/rb/terraforming-dnsimple)
[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)

[Terraforming](https://github.com/dtan4/terraforming) extension for [DNSimple](https://dnsimple.com)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'terraforming-dnsimple'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install terraforming-dnsimple

## Usage

```bash
$ terraforming-dnsimple
Commands:
  terraforming-dnsimple dnsr            # DNSimple Record
  terraforming-dnsimple help [COMMAND]  # Describe available commands or one specific command
```

Output `.tf` style:

```bash
$ terraforming s3 --user=<user name> --token=<api token>
```

```go
resource "dnsimple_record" "31-hoge-A" {
    domain = "example1.com"
    name   = "hoge"
    value  = "192.168.0.1"
    type   = "A"
    ttl    = "60"
}
```

To output `.tfstate` style, specify `--tfstate` option:

```bash
$ terraforming s3 --tfstate --user=<user name> --token=<api token>
```

```json
{
  "version": 1,
  "serial": 1,
  "modules": {
    "path": [
      "root"
    ],
    "outputs": {
    },
    "resources": {
      "dnsimple_record.31-hoge-A": {
        "type": "dnsimple_record",
        "primary": {
          "id": "31",
          "attributes": {
            "id": "31",
            "value": "192.168.0.1",
            "type": "A",
            "ttl": "60",
            "priority": "",
            "domain_id": "1",
            "domain": "example1.com",
            "hostname": "hoge.example1.com"
          }
        }
      }
    }
  }
}
```

## Development

After checking out the repo, run `script/setup` to install dependencies. Then, run `script/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/dtan4/terraforming-dnsimple/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
