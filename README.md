# Stored Procedure Migration Example

This repo was created to provide an example of an issue I observed while updating a Rails app from Rails 6 to 7, bumping the `activerecord-sqlserver-adapter` gem to `7.0.3.0`.

## Setup

Clone the repo, enter it (RVM is assumed so ruby version and gemset will be resolved automatically), `gem install bundler` and `bundle install`.

## DB Config

Copy the example file `config/database.yml.example` to `config/database.yml` and fill it in with the connection information for your own SQL Server installation.

## Run example

This example migration task will create a new database named `stored_procedure_migration_example_database` and will run the example migration inside it.

```
bundle exec rake example_rake_task
```

The migration will fail with the error `ActiveRecord::StatementInvalid: Table 'SomeTableName' doesn't exist`.

You can also checkout the `rails6` branch (you'll need to redo `bundle install`) and run the same task to observe that it succeeded in prior versions.
