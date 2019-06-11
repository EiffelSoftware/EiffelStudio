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

obsolete "Use an up-to-date version of the arguments parser library. [2019-11-30]"

inherit
	ARGUMENT_SOURCE

feature -- Access

	arguments: ARRAY [STRING]
			-- <Precursor>
		local
			l_args: ARRAY [STRING]
			l_arg: detachable STRING
			l_count: INTEGER
			i: INTEGER
		once
			l_args := terminal_arguments.argument_array
			l_count := l_args.upper
			create Result.make_filled ("", 1, l_count)
			from i := 1 until i > l_count
			loop
				l_arg := l_args.item (i)
				if l_arg = Void then
					create l_arg.make_empty
				end
				Result.put (l_arg, i)
				i := i + 1
			end
		end

feature {NONE} -- Access

	terminal_arguments: ARGUMENTS
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
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
