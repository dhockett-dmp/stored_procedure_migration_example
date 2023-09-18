require 'rake'
require 'active_record'

db_config_file = File.join(File.expand_path(__dir__), 'config', 'database.yml')
db_config = YAML.load_file(db_config_file)

task :example_rake_task do
  # Connect to SQL Server with all connection info *except* the DB name, since it may not exist.
  ActiveRecord::Base.establish_connection(db_config['base'])
  # Keep the DB name on-hand, separately.
  db_name = db_config['main']['database']

  begin
    # Through the DB-agnostic connection, try to drop the DB.
    ActiveRecord::Base.connection.drop_database(db_name)
    puts "Dropped #{db_name}"
  rescue ActiveRecord::StatementInvalid
    puts "#{db_name} doesn\'t exist."
  rescue StandardError => e
    puts "Couldn\'t drop database because of error: #{e.message}"
  end

  begin
    # Through the DB-agnostic connection, try to create the DB.
    ActiveRecord::Base.connection.create_database(db_name)
    puts "Created #{db_name}"
  rescue ActiveRecord::StatementInvalid
    puts "#{db_name} already exists."
  rescue StandardError => e
    puts "Couldn\'t create database because of error: #{e.message}"
  end

  # Now that our DB exists and must be empty after being dropped and created, reconnect within that DB.
  ActiveRecord::Base.establish_connection(db_config['main'])

  # Migrate.
  ActiveRecord::Migrator.new(
    :up,
    [
      ActiveRecord::MigrationProxy.new(
        'AddStoredProc',
        nil,
        'db/migrate/20230918000000_add_stored_proc.rb',
        ''
      )
    ],
    ActiveRecord::SchemaMigration,
    nil
  ).run
end
