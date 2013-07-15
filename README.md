# Oceanarium - Use Digital Ocean API in your Ruby applications!

Digital Ocean is good SSD cloud hosting and we love it. So, we wrote this gem for the great justice :) It will help your Ruby/Rails application communicate with Digital Ocean's API.

Warning: We're not affiliated with Digital Ocean, so we can't guarantee that API, used by this gem, still valid. If you experiencing errors, just ping us (and Digital Ocean).

## Installation

Add this line to your application's Gemfile:

~~~ruby
gem 'oceanarium'
~~~

And then execute:

~~~bash
$ bundle
~~~

Or install it yourself as:

~~~bash
$ gem install oceanarium
~~~

## Usage

DigitalOcean uses for authentication two keys: API key and Client ID. Before any action you must provide it to current ruby process. In command line you must enter this:

~~~ruby
Oceanarium::Config.api_key = "your_api_key"
Oceanarium::Config.client_id = "your_client_id"
~~~

Now you're ready to use Digital Ocean API. If you using Oceanarium with Rails, you must add file config/initializers/oceanarium.rb with same two lines, as above.

After this, you can use any Digital Ocean API with this gem. All API callers are mnemonic, so you don't need to remember anything -- official Digital Ocean API will be your friend.

For example:

~~~ruby
Oceanarium::droplet(100500)
~~~

will return you all droplet information, and

~~~ruby
Oceanarium::droplet(100500).reboot
~~~

will reboot it.

And so on, and so on, and so on, and... read the official gem documentation at http://oceanarium.so for more verbose help.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

See LICENSE.txt.

Copyright 2013 Valdos Sine, Delta-Zet LLC
