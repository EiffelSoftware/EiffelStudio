note
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

create
	make

feature {NONE} -- Initialization

	make
			-- Initializes the application.
		local
			l_parser: ARGUMENT_PARSER
			l_tree: ARRAYED_TREE [REAL_64]
			l_child: ARRAYED_TREE [REAL_64]
		do
			create l_tree.make (3, 0.0)
			l_tree.put_child (create {ARRAYED_TREE [REAL_64]}.make (1, 1.0))
			l_tree.put_child (create {ARRAYED_TREE [REAL_64]}.make (1, 2.0))

			create l_child.make (1, 3.0)
			l_child.put_child (create {ARRAYED_TREE [REAL_64]}.make (1, 3.1))
			l_tree.put_child (l_child)

--			across l_tree as l_cursor loop
--				print (l_cursor.item.item)
--				print ("%N")
--			end

			create l_parser.make
			l_parser.execute (agent start (l_parser))
			if not l_parser.is_successful then
				(create {EXCEPTIONS}).die (1)
			end
		end

feature {NONE} -- Basic operations

	start (a_parser: ARGUMENT_PARSER)
			-- Starts the application.
			--
			-- `a_parser': Parser used to collect command line information.
		require
			a_parser_is_successful: a_parser.is_successful
		local
			l_source: SQLITE_FILE_SOURCE
			l_database: SQLITE_DATABASE
			l_console: INTERACTIVE_TERMINAL
		do
			create l_source.make (a_parser.file_name)
			create l_database.make (l_source)
			if a_parser.is_open_create_read_write then
				l_database.open_create_read_write
			elseif a_parser.is_open_read_write then
				l_database.open_read_write
			else
				l_database.open_read
			end

			create l_console.make (l_database)
			l_console.begin_interaction
			l_database.close
		end

;note
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
