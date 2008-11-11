indexing
	description: "[
			An argument parser's arguments from the terminal.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_STRING_SOURCE

inherit
	ARGUMENT_SOURCE

create
	make,
	make_from_array

feature {NONE} -- Initialization

	make (a_arguments: !SEQUENCE [?READABLE_STRING_GENERAL])
			-- Initialize a new argument source from a sequence of strings.
			--
			-- `a_arguments': An sequence of string arguments.
		require
			a_arguments_contains_attached_items: a_arguments.has (Void)
		local
			l_args: !ARRAY [!STRING]
			l_arg: !STRING
			i: INTEGER
		do
			create l_args.make (1, a_arguments.count)
			from
				i := 1
				a_arguments.start
			until
				a_arguments.after
			loop
				l_args.put (a_arguments.item.as_string_8.as_attached, i)
				i := i + 1
			end
			arguments := l_args
		ensure
			arguments_has_same_count: arguments.count = a_arguments.count
		end

	make_from_array (a_arguments: !ARRAY [?READABLE_STRING_GENERAL])
			-- Initialize a new argument source from a array of strings.
			--
			-- `a_arguments': An array of string arguments.
		require
			a_arguments_contains_attached_items: a_arguments.has (Void)
		local
			l_args: !ARRAY [!STRING]
			l_arg: !STRING
			l_upper: INTEGER
			i, j: INTEGER
		do
			create l_args.make (1, a_arguments.count)
			from
				i := a_arguments.lower
				l_upper := a_arguments.upper
			until
				i > l_upper
			loop
				l_arg := a_arguments.item (i + j).as_string_8.as_attached
				j := j + 1
				l_args.put (l_arg, j)
			end
			arguments := l_args
		ensure
			arguments_has_same_count: arguments.count = a_arguments.count
		end

feature -- Access

	application: !STRING
			-- <Precursor>
		once
			create Result.make_from_other_string ((create {ARGUMENTS}).argument (0))
		end

	application_base: !STRING
			-- <Precursor>
		do
			Result := (create {EXECUTION_ENVIRONMENT}).current_working_directory.as_attached
		end

	arguments: !ARRAY [!STRING]
			-- <Precursor>

feature -- Status report

	is_empty: BOOLEAN
			-- <Precursor>
		do
			Result := arguments.is_empty
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
