# TrelloFreestyler

Uses the Trello API to dump json line files for a Trello board and its actions.
Built with the intention of ingesting the files into BigQuery but they can be used as is.
For BigQuery ingestion we need json line files and they need to be scrubbed of any empty objects.
(BigQuery will not ingest an empty json object unless you also supply a schema, which is a hassle and also means we won't auto load new columns that Trello create)

Two key trello concepts are exported
- `cards.jsonl`
- `actions.jsonl`

From the above, one can do analysis on how long the card has spent in each column and which trello user was on the card at any point in time.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'trello_freestyler'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install trello_freestyler

## Usage

```
trello_freestyler --help
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/trello_freestyler. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/trello_freestyler/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TrelloFreestyler project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/trello_freestyler/blob/master/CODE_OF_CONDUCT.md).
