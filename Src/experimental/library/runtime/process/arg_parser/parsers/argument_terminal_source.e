note
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

feature -- Access

	arguments: ARRAYED_LIST [IMMUTABLE_STRING_32]
			-- <Precursor>
		local
			l_args: ARRAY [IMMUTABLE_STRING_32]
			l_count: INTEGER
			i: INTEGER
		once
			l_args := terminal_arguments.argument_array
			l_count := l_args.upper
			create Result.make (l_count)
			from i := 1 until i > l_count
			loop
				Result.extend (l_args [i])
				i := i + 1
			end
		end

feature {NONE} -- Access

	terminal_arguments: ARGUMENTS_32
			-- Command line arguments from the terminal/console.
		once
			create Result
		end

feature -- Status report

	is_empty: BOOLEAN
			-- <Precursor>
		do
			Result := terminal_arguments.argument_count = 0
		end

;note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
