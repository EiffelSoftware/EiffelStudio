note
	description: "Summary description for {ENVIRONMENT_ARGUMENTS_SOURCE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ENVIRONMENT_ARGUMENTS_SOURCE

inherit
	ARGUMENT_SOURCE

create
	make

feature {NONE} -- Initialization

	make (args: ENVIRONMENT_ARGUMENTS)
		require
			args_set: args /= Void
		do
			env_arguments := args
		end

	env_arguments: ENVIRONMENT_ARGUMENTS

feature -- Access

	arguments: ARRAYED_LIST [IMMUTABLE_STRING_32]
			-- <Precursor>
		local
			l_count: INTEGER
			i: INTEGER
		once
			l_count := env_arguments.argument_count
			create Result.make (l_count)
			from i := 1 until i > l_count loop
				Result.extend (env_arguments.argument (i))
				i := i + 1
			end
		end

feature -- Status report

	is_empty: BOOLEAN
			-- <Precursor>
		do
			Result := env_arguments.argument_count = 0
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
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
