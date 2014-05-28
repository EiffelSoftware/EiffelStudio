note
	description: "Summary description for {IRON_ARGUMENT_MULTI_PARSER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_ARGUMENT_MULTI_PARSER

inherit
	ARGUMENT_MULTI_PARSER
		rename
			make as make_parser
		undefine
			sub_system_name,
			is_using_unix_switch_style,
			switch_prefixes,
			help_switch,
			version_switch
		end

	IRON_ARGUMENT_PARSER_I

feature {NONE} -- Initialization

	make (a_task: like task)
			-- Initialize argument parser
		do
			make_with_option (a_task, True)
		end

	make_with_option (a_task: like task; a_non_switch_required: BOOLEAN)
			-- Initialize argument parser
		do
			task := a_task
			make_parser (False, a_non_switch_required)
			initialize_with_task (a_task)
		end

feature -- Change

	set_is_using_builtin_switches (b: BOOLEAN)
		do
			is_using_builtin_switches := b
		end

	set_is_case_sensitive (b: BOOLEAN)
		do
			is_case_sensitive := b
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
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
