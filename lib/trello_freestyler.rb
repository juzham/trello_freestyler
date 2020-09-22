# frozen_string_literal: true

require 'trello_freestyler/version'
require_relative 'trello_freestyler/cli'
require_relative 'trello_freestyler/main'
require 'tty-spinner'

if ARGV.length.positive?
  spinners = TTY::Spinner::Multi.new("[:spinner] Trello Freestyler")
  sp1 = spinners.register "[:spinner] Validate input options"
  sp1.auto_spin

  options = TrelloFreestyler::Cli.parse(ARGV)

  sp1.success

  sp2 = spinners.register "[:spinner] Download and clean trello data"
  sp3 = spinners.register "[:spinner] Output data to: '#{options.output}'"
  sp2.auto_spin
  sp3.auto_spin

  TrelloFreestyler::Main.dump(options)

  sp2.success
  sp3.success
else
  TrelloFreestyler::Cli.parse %w[--help]
end