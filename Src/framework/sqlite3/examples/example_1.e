note
	description: "[
		Example 1
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EXAMPLE_1

inherit
	SQLITE_SHARED_API

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_db: SQLITE_DATABASE
			l_statement: SQLITE_MODIFY_STATEMENT
			l_query: SQLITE_QUERY_STATEMENT
			i, i_count: INTEGER
		do
				-- Opens (or creates if it does not exist) a hidden database file.
			create l_db.make_read_write (".db")
			if not l_db.is_readable then
				create l_db.make_create_read_write (".db")
			end
			check is_readable: l_db.is_readable end

				-- Drop any existing table
			create l_statement.make ("DROP TABLE IF EXISTS my_table", l_db)
			l_statement.execute

				-- Create the new table
			create l_statement.make ("CREATE TABLE my_table (Id INTEGER PRIMARY KEY, Info TEXT, F1 FLOAT);", l_db)
			l_statement.execute

				-- Fill in some test data
			from
				i := 1
				i_count := 10
			until
				i > i_count
			loop
					-- We'll be able to use variable soon, but for now this is how we have to do it.
				create l_statement.make ("INSERT INTO my_table (Info, F1) VALUES ('Row #" + i.out + "', 23.1);", l_db)
				l_statement.execute
				i := i + 1
			end

			create l_query.make ("SELECT * FROM my_table;", l_db)
			l_query.execute_with_callback (agent (ia_row: SQLITE_RESULT_ROW)
				local
					j, j_count: NATURAL
				do
					from
						j := 1
						j_count := ia_row.count
					until
						j > j_count
					loop
							-- Print the column name.
						print (ia_row.column_name (j))
						print (":")

							-- Print the text value, regardless of type.
						print (ia_row.string_value (j))

						if j < j_count then
							print (", ")
						end
						j := j + 1
					end
					print ("%N")
						-- Forget it
					--a_row.statement.abort
				end)

				-- Let the GC handle the clean up (There's also a bug)
			--l_db.close
		end

end
