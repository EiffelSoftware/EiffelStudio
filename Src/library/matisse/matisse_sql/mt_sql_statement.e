indexing
	description: "Represents a SQL statement";
	date: "$Date$";
	revision: "$Revision$"

class
	MT_SQL_STATEMENT

inherit
	MT_CONSTANTS

	MT_SQL_EXTERNAL

creation
	make

feature -- Initialization
	make is
		do
			database := current_db
		end

feature -- Queryf

	execute_query (statement: STRING): MT_SQL_RESULT_SET is
		local
			to_c: ANY
			selection_id: INTEGER
		do
			to_c := statement.to_c
			selection_id := c_sql_exec ($to_c)
			!! Result.make (selection_id)
		end
		
feature {NONE}

	database: MATISSE
	
end -- class MT_SQL_STATEMENT
