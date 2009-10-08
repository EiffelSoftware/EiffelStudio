note
	description: "[
		Example of using CREATE TABLE, INSERT and SELECT statements.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EXAMPLE

inherit
	SQLITE_SHARED_API

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_db: SQLITE_DATABASE
			l_modify: SQLITE_MODIFY_STATEMENT
			l_insert: SQLITE_INSERT_STATEMENT
			l_query: SQLITE_QUERY_STATEMENT
			i: INTEGER
		do
			print ("%NOpening Database...%N")

				-- Open/create a Database.
			create l_db.make_open ("data.sqlite", {SQLITE_OPEN_MODE}.create_read_write)

			print ("Creating Example Table...%N")

				-- Remove any existing table
			create l_modify.make ("DROP TABLE IF EXISTS Example;", l_db)
			l_modify.execute

				-- Create a new table
			create l_modify.make ("CREATE TABLE Example (Id INTEGER PRIMARY KEY, Text TEXT, Value FLOAT);", l_db)
			l_modify.execute

			print ("Generating Example Data...%N")

				-- Create a insert statement with variables
			create l_insert.make ("INSERT INTO Example (Text, Value) VALUES (?1, :VAL_VAR);", l_db)
			check l_insert_is_compiled: l_insert.is_compiled end

				-- Commit handling
			l_db.begin_transaction (False)

				-- Execute the statement multiple (10) times
			from until i = 10 loop
					-- Execute the INSERT statement with the argument list.
				l_insert.execute_with_arguments ([
						"Eiffel SQLite Rocks!", -- Using Eiffel object (unnamed variable @ index 1 will replace ?1)
						create {SQLITE_DOUBLE_ARG}.make (":VAL_VAR", (i * 3.14)) -- Using a named argument (will replace :VAL_VAR)
					])
				i := i + 1
			end

				-- Commit changes
			l_db.commit

			print ("Contents of Example Table:%N")

				-- Query the contents of the Example table
			create l_query.make ("SELECT * FROM Example LIMIT 10;", l_db)
			l_query.execute (agent (ia_row: SQLITE_RESULT_ROW): BOOLEAN
				local
					j, j_count: NATURAL
				do
					print ("> Row " + ia_row.index.out + ": ")

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
						if not ia_row.is_null (j) then
							print (ia_row.string_value (j))
						else
							print ("<NULL>")
						end

						if j < j_count then
							print (", ")
						end
						j := j + 1
					end
					print ("%N")

						-- Cut processing after 5 rows of data have been returned
					Result := (ia_row.index \\ 5) = 0
					if Result then
						print ("--> We have 5 results, lets forget the rest%N")
					end
				end)

			print ("Closing Database...%N")

				-- Perform final close.
			l_db.close
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
