note
	description: "Summary description for {IRON_ARGUMENT_PARSER_I}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_ARGUMENT_PARSER_I

feature {NONE} -- Initialization

	initialize_with_task (a_task: like task)
		do
			set_argument_source (a_task.argument_source)
			set_is_using_builtin_switches (not is_verbose_switch_used)
			set_is_case_sensitive (True)
		end

	set_is_using_builtin_switches (b: BOOLEAN)
		deferred
		end

	set_is_case_sensitive (b: BOOLEAN)
		deferred
		end

	set_argument_source (a_source: like argument_source)
		deferred
		end

	argument_source: ARGUMENT_SOURCE
		deferred
		end

feature {NONE} -- Status report		

	is_verbose_switch_used: BOOLEAN
		deferred
		end

	is_using_unix_switch_style: BOOLEAN = True
			-- <Precursor>
			--| Avoid using /flag ...

	switch_prefixes: ARRAY [CHARACTER_32]
			-- Prefixes used to indicate a command line switch.
		once
			Result := <<'-'>>
		end

	help_switch: IMMUTABLE_STRING_32
			-- Display usage information switch.
		once
			create Result.make_from_string_general ("h|help")
		end

	version_switch: IMMUTABLE_STRING_32
		once
			create Result.make_from_string_general ("version")
		end

	logo_switch: IMMUTABLE_STRING_32
		once
			create Result.make_from_string_general ("logo")
		end

feature -- Access

	task: IRON_TASK

	sub_system_name: IMMUTABLE_STRING_32
		do
			create Result.make_from_string_general (task.name)
		end

feature {NONE} -- Usage

	name: IMMUTABLE_STRING_32
		do
			create Result.make_from_string_general ({IRON_CONSTANTS}.executable_name + " " + sub_system_name)
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
