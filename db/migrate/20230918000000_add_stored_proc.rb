class AddStoredProc < ActiveRecord::Migration[6.1]
  def change
    reversible do |direction|
      direction.up do
        execute <<-SQL
          CREATE OR ALTER PROCEDURE do_some_task
          AS
          IF NOT EXISTS(SELECT * FROM sys.objects WHERE type = 'U' AND name = 'SomeTableName')
          BEGIN
            CREATE TABLE SomeTableName (SomeNum int PRIMARY KEY CLUSTERED);
            INSERT INTO SomeTableName(SomeNum) VALUES(1);
          END
        SQL
      end
    
      direction.down do
        execute <<-SQL
          DROP PROCEDURE IF EXISTS dbo.do_some_task;
        SQL
      end
    end
  end
end
