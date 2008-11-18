indexing
	description: "Argument parser that requires a single or can accept mutliple loose arguments."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ARGUMENT_MULTI_PARSER

inherit
	ARGUMENT_BASE_PARSER
		rename
			make as make_base_parser
		redefine
			command_option_group_configuration,
			extended_usage,
			validate_non_switched_arguments
		end

feature {NONE} -- Initialization

	make (a_cs: like is_case_sensitive; a_non_switch_required: like is_non_switch_argument_required)
			-- Initialize the base parser options.
			--
			-- `a_cs': True if the switches are treated with case-sensitive; False otherwise.
			-- `a_non_switch_required': True to require a non-switched argument; False otherwise.
		do
			make_base_parser (a_cs, True, a_non_switch_required)
		ensure
			is_case_sensitive_set: is_case_sensitive = a_cs
			is_non_switch_argument_required_set: is_non_switch_argument_required = a_non_switch_required
			is_allowing_non_switched_arguments: is_allowing_non_switched_arguments
		end

feature {NONE} -- Access

	non_switched_argument_name: !STRING
			-- Name of non-switched argument, used in usage information.
		deferred
		ensure
			not_result_is_empty: not Result.is_empty
		end

	non_switched_argument_description: !STRING
			-- Description of non-switched argument, used in usage information.
		deferred
		ensure
			not_result_is_empty: not Result.is_empty
		end

	non_switched_argument_type: !STRING
			-- Type of non-switched argument, used in usage information.
			-- A type is a short description of the argument. I.E. "Configuration File"
		deferred
		ensure
			not_result_is_empty: not Result.is_empty
		end

	frozen non_switched_argument_name_arg: !STRING
			-- Name of non-switched argument arg name, used in usage information.
		once
			create Result.make (non_switched_argument_name.count + 2)
			Result.append_character ('<')
			Result.append (non_switched_argument_name)
			Result.append_character ('>')
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Query

	command_option_group_configuration (a_group: !LIST [!ARGUMENT_SWITCH]; a_show_non_switch: BOOLEAN; a_non_switch_required: BOOLEAN; a_add_appurtenances: BOOLEAN; a_src_group: !LIST [!ARGUMENT_SWITCH]): ?STRING
			-- <Precursor>
		local
			l_suffix: STRING
			l_arg: STRING
			l_args: STRING
		do
			l_suffix := Precursor {ARGUMENT_BASE_PARSER} (a_group, a_show_non_switch, a_non_switch_required, a_add_appurtenances, a_src_group)

			create Result.make (30)
			if a_show_non_switch then
				l_arg := non_switched_argument_name_arg
				l_args := l_arg + "[ " + l_arg + ", ...]"
				if not a_non_switch_required then
					Result.append_character ('[')
				end
				Result.append (l_args)
				if not a_non_switch_required then
					Result.append_character (']')
				end
			end

			if l_suffix /= Void then
				if not Result.is_empty then
					Result.append_character (' ')
				end
				Result.append (l_suffix)
			end
		end

	extended_usage: !STRING
			-- <Precursor>
		local
			l_tabbed_nl: STRING
			l_desc: STRING
		once
			create l_tabbed_nl.make_filled (' ', tab_string.count + 2 + non_switched_argument_name_arg.count)
			l_tabbed_nl.insert_string ("%N", 1)
			l_desc := non_switched_argument_description.twin
			l_desc.replace_substring_all ("%N", l_tabbed_nl)

			create Result.make (30)
			Result.append ("NON-SWITCHED ARGUMENTS:%N")
			Result.append (tab_string)
			Result.append (non_switched_argument_name_arg)
			Result.append (": ")
			Result.append (l_desc)
		end

feature {NONE} -- Validation

	validate_non_switched_arguments (a_groups: ?LIST [!ARGUMENT_GROUP])
			-- <Precursor>
		local
			l_check_non_switched_arguments: BOOLEAN
			l_cursor: CURSOR
		do
			Precursor {ARGUMENT_BASE_PARSER} (a_groups)

			l_check_non_switched_arguments := a_groups = Void
			if not l_check_non_switched_arguments then
					-- There are groups so check if non-switch arguments are used.
				l_cursor := a_groups.cursor
				from a_groups.start until a_groups.after or l_check_non_switched_arguments loop
					l_check_non_switched_arguments := a_groups.item.is_allowing_non_switched_arguments
					a_groups.forth
				end
				a_groups.go_to (l_cursor)
			end

			if l_check_non_switched_arguments then
				if not has_non_switched_argument and then is_non_switch_argument_required and not is_help_usage_displayed then
					add_template_error (e_missing_non_switched_argument, [non_switched_argument_type.as_lower])
				end
			end
		end

feature {NONE} -- Internationalization

	e_missing_non_switched_argument: !STRING = "{1} is require and was not specified."

invariant
	is_allowing_non_switched_arguments: is_allowing_non_switched_arguments

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class {ARGUMENT_MULTI_PARSER}
