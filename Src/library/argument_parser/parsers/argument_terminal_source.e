indexing
	description: "[
			An argument parser's arguments from the terminal.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_TERMINAL_SOURCE

inherit
	ARGUMENT_SOURCE

	ARGUMENTS

feature -- Access

	application: !STRING
			-- <Precursor>
		once
			create Result.make_from_string (argument (0))
		end

	application_base: !STRING
			-- <Precursor>
		local
			l_result: ?STRING
			l_path: STRING
			i: INTEGER
		once
			l_path := argument_array [0]
			if l_path /= Void and then not l_path.is_empty then
				i := l_path.last_index_of (operating_environment.directory_separator, l_path.count)
				if i > 0 then
					l_result := l_path.substring (1, i - 1)
				end
			end
			if l_result = Void or else l_result.is_empty then
				l_result := (create {EXECUTION_ENVIRONMENT}).current_working_directory
			end
			create {STRING} Result.make_from_string (l_result)
		end

	arguments: !ARRAY [!STRING]
			-- <Precursor>
		local
			l_args: like argument_array
			l_arg: ?STRING
			l_count: INTEGER
			i: INTEGER
		once
			l_args := argument_array
			if l_args /= Void then
				l_count := l_args.upper
				create Result.make (1, l_count)
				from i := 1 until i > l_count
				loop
					l_arg := l_args.item (i)
					if l_arg = Void then
						create l_arg.make_empty
					end
					Result.put (l_arg, i)
					i := i + 1
				end
			else
				create Result.make (1, 0)
			end
		end

feature -- Status report

	is_empty: BOOLEAN
			-- <Precursor>
		do
			Result := argument_count = 0
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
