# Change Log

## Version 0.5.0

- `execution_datetime` is now formatted to be bigquery compatible, ie: `%Y-%m-%d %H:%M:%S.%L %:z`

## Version 0.4.0

- add `execution_datetime` and `execution_local_date` field to each row of the data we export.

## Version 0.3.0

- moved `TrelloFreestyler::Cli::Options` to `TrelloFreestyler::Options`
- added instructions on how to use without the cli
