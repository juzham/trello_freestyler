# TrelloFreestyler

Uses the Trello API to dump json line files for a Trello board and its actions.
Built with the intention of ingesting the files into BigQuery (but obviously this gem can be used for other purposes)
For BigQuery ingestion we need json line files and they need to be scrubbed of any empty objects.
This is because BigQuery will not ingest an empty json object unless you also supply a schema, which is a hassle and also means we won't auto load new columns that Trello create.

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

```bash
  trello_freestyler --key <TRELLO_KEY> --token <TRELLO_TOKEN> --board_id <TRELLO_BOARD_ID>
```

or

```ruby
require 'trello_freestyler'

options = TrelloFreestyler::Options.new(
  key = <YOUR TRELLO DEVELOPER TOKEN>,
  token = <YOUR TRELLO TOKEN>,
  url = nil, # use default trello api url
  board_id = <YOUR TRELLO BOARD ID>,
  action_types = nil, # get default trello actions
  output = nil, # use default output folder .output
  timezone = nil # use default timezone for data stamping folder
)

# Will get card and action trello data and export it to options.output
TrelloFreestyler::Main.dump(options)

```

## Output

The gem will output two files.

- `.output/cards.jsonl`
- `.output/actions.jsonl`

### Card Data Example

Example:
```json
{
  "id": "5f55b9c16c827d25a1102c86",
  "checkItemStates": null,
  "closed": false,
  "dateLastActivity": "2020-09-18T06:04:20.026Z",
  "desc": "Long description of what is going on in this card",
  "dueReminder": null,
  "idBoard": "5a83b75266739ccd8007fb93",
  "idList": "5a83b77ebc78a107c1ee0123",
  "idMembersVoted": [],
  "idShort": 1727,
  "idAttachmentCover": null,
  "idLabels": ["5f4c45dbff786e0e699910e5", "5f4c45dbff786e0e699910ca"],
  "manualCoverAttachment": false,
  "name": "Write lots of code",
  "pos": 1081343,
  "shortLink": "IEOr8bp4",
  "isTemplate": false,
  "badges": {
    "attachmentsByType": {
      "trello": {
        "board": 0,
        "card": 0
      }
    },
    "location": false,
    "votes": 0,
    "viewingMemberVoted": false,
    "subscribed": false,
    "fogbugz": "",
    "checkItems": 0,
    "checkItemsChecked": 0,
    "checkItemsEarliestDue": null,
    "comments": 0,
    "attachments": 0,
    "description": true,
    "due": null,
    "dueComplete": false,
    "start": null
  },
  "dueComplete": false,
  "due": null,
  "idChecklists": [],
  "idMembers": [],
  "labels": [{
    "id": "5f4c45dbff786e0e699910e5",
    "idBoard": "5a83b75266739ccd8007fb93",
    "name": "Important",
    "color": "sky"
  }, {
    "id": "5f4c45dbff786e0e699910ca",
    "idBoard": "5a83b75266739ccd8007fb93",
    "name": "Build XYZ",
    "color": "yellow"
  }],
  "shortUrl": "https://trello.com/c/IEOr8bp4",
  "start": null,
  "subscribed": false,
  "url": "https://trello.com/c/IEOr8bp4/1727-interesting-trello-card",
  "cover": {
    "idAttachment": null,
    "color": null,
    "idUploadedBackground": null,
    "size": "normal",
    "brightness": "light"
  }
}
```

### Actions Data Example

Only a subset of actions are exported.
By default the cli will export these actions.
- `'addMemberToCard,removeMemberFromCard,createCard,moveCardFromBoard,moveCardToBoard,updateCard'`

They form the minimum requirements to work out which member was on which card at any given point in time.

```json
{
  "id": "5e78321d12600747e2e88a22",
  "idMemberCreator": "59681948d79a0c42c27891da",
  "data": {
    "card": {
      "id": "5e78321c12600747e2e88a21",
      "name": "Iteration goals",
      "idShort": 1398,
      "shortLink": "XiyVVDx0"
    },
    "list": {
      "id": "5a83b76966d66e23d2198d72",
      "name": "Iteration Details"
    },
    "board": {
      "id": "5a83b75266739ccd8007fb93",
      "name": "Go team go board",
      "shortLink": "HOdivmmF"
    }
  },
  "type": "createCard",
  "date": "2020-03-23T03:50:53.024Z",
  "memberCreator": {
    "id": "59681948d79a0c42c27891da",
    "username": "rachel",
    "activityBlocked": false,
    "avatarHash": "20e3b40ee3bc83d5200348d96485a3be",
    "avatarUrl": "https://trello-members.s3.amazonaws.com/59681948d79a0c42c27891da/20e3b40ee3bc83",
    "fullName": "Rachel",
    "idMemberReferrer": null,
    "initials": "RF",
    "nonPublicAvailable": false
  }
}
```

## Development

Sets up the docker development environment

```bash
  ./auto/dev
```

Github actions automatically deploy new gem version

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/trello_freestyler. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/trello_freestyler/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TrelloFreestyler project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/trello_freestyler/blob/master/CODE_OF_CONDUCT.md).
