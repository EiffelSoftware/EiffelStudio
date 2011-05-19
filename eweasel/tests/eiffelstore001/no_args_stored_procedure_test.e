note
	description: "Action to reset database"
	revision: "$Revision$"

class
	NO_ARGS_STORED_PROCEDURE_TEST

inherit
	CHANGE_ACTION
		redefine
			execute_change
		end

create
	make

feature -- Execute

	execute_change
			-- Execute the action
		local
			l_proc: DB_PROC
			l_schema: STRING_32
		do
			create l_proc.make (Proc_name)
			l_proc.load

			if attached table_schema as l_s then
				l_schema := l_s
			else
				create l_schema.make_empty
			end

			if l_proc.exists then
				l_proc.drop
			end

			l_proc.load
			l_proc.store (statement)
			if l_proc.is_ok then
				l_proc.load
			end

			if l_proc.exists then
				database_change.set_map_name (l_schema, {STRING_32}"store_eweasel_test")
				l_proc.execute (database_change)
				database_change.clear_all
			end
		end

feature -- Element Change

	set_table_schema (a_table_schema: like table_schema)
			-- Set `table_schema' with `a_table_schema'
		do
			table_schema := a_table_schema
		ensure
			table_schema_set: table_schema = a_table_schema
		end

feature -- Access

	table_schema: detachable STRING_32
			-- The schema from which data will be removed

feature {NONE} -- Implementation

	proc_name: STRING = "clean_up_data"

	statement: STRING_32 =
			"[
				  DECLARE done INT DEFAULT 0;
				  DECLARE register VARCHAR (255);
				  DECLARE cur1 CURSOR FOR SELECT TABLE_NAME from `information_schema`.`tables` where table_schema = 'store_eweasel_test';
				  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
				  OPEN cur1;
				  FETCH cur1 INTO register;
				  WHILE done = 0 DO
				  
					  SET @stmt_text=CONCAT("ALTER TABLE ", register, " DISABLE KEYS");
					  PREPARE stmt FROM @stmt_text;
					  EXECUTE stmt;

					  SET FOREIGN_KEY_CHECKS=0;

					  SET @stmt_text=CONCAT("TRUNCATE TABLE ", register);
					  PREPARE stmt FROM @stmt_text;
					  EXECUTE stmt;

					  SET FOREIGN_KEY_CHECKS=1;

					  SET @stmt_text=CONCAT("ALTER TABLE ", register, " ENABLE KEYS");
					  PREPARE stmt FROM @stmt_text;
					  EXECUTE stmt;

					  FETCH cur1 INTO register;
				  END WHILE;
				  CLOSE cur1
			]"

end
