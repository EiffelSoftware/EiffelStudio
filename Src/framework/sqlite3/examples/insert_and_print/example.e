note
	description: "[
		Example 1
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
			l_statement: SQLITE_MODIFY_STATEMENT
			l_query: SQLITE_QUERY_STATEMENT
			i, i_count: INTEGER
		do
				-- Opens (or creates if it does not exist) a hidden database file.
			create l_db.make_create_read_write (".db")
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
