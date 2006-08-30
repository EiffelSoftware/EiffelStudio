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
			make as make_lite
		redefine
			command_option_group_configuration,
			extended_usage,
			validate_arguments
		end

feature {NONE} -- Initialization

	make (a_cs: like case_sensitive; a_usage_on_error: like display_usage_on_error) is
			-- Initializes argument parser
		do
			make_lite (a_cs, True, True, a_usage_on_error)
		ensure
			case_sensitive_set: case_sensitive = a_cs
			display_usage_on_error_set: display_usage_on_error = a_usage_on_error
		end

feature {NONE} -- Usage

	loose_argument_name: STRING is
			-- Name of lose argument, used in usage information
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	loose_argument_description: STRING is
			-- Description of lose argument, used in usage information
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	loose_argument_type: STRING is
			-- Type of lose argument, used in usage information.
			-- A type is a short description of the argument. I.E. "Configuration File"
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	frozen loose_argument_name_arg: STRING is
			-- Name of lose argument arg name, used in usage information
		once
			Result := "<" + loose_argument_name + ">"
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	command_option_group_configuration (a_group: LIST [ARGUMENT_SWITCH]; a_add_appurtenances: BOOLEAN; a_src_group: LIST [ARGUMENT_SWITCH]): STRING is
			-- Command line option configuration string (to display in usage)
		local
			l_suffix: STRING
			l_arg: STRING
			l_args: STRING
		do
			if not a_add_appurtenances then
				Result := Precursor {ARGUMENT_BASE_PARSER} (a_group, a_add_appurtenances, a_src_group)
			else
				l_arg := loose_argument_name_arg
				l_args := l_arg + "[" + l_arg + ", ...]"
				l_suffix := Precursor {ARGUMENT_BASE_PARSER} (a_group, a_add_appurtenances, a_src_group)
				if l_suffix /= Void then
					create Result.make (l_arg.count + l_suffix.count + 1)
					Result.append (l_args)
					Result.append_character (' ')
					Result.append (l_suffix)
				else
					Result := l_args
				end
			end
		end

	extended_usage: STRING is
			-- Retrieces extended configuration information
			-- Redefine in subclass.
		local
			l_tabbed_nl: STRING
			l_desc: STRING
		once
			create l_tabbed_nl.make_filled (' ', tab_string.count + 2 + loose_argument_name_arg.count)
			l_tabbed_nl.insert_string ("%N", 1)
			l_desc := loose_argument_description.twin
			l_desc.replace_substring_all ("%N", l_tabbed_nl)

			Result := "NON-SWITCHED ARGUMENTS:%N" + tab_string + loose_argument_name_arg + ": " + l_desc
		end

feature {NONE} -- Validation

	validate_arguments is
			-- Validates arguments to ensure they are configured correctly
		do
			if not has_loose_argument or else values.first.is_empty then
				add_template_error (no_loose_argument_error, [loose_argument_type.as_lower])
			end
			Precursor {ARGUMENT_BASE_PARSER}
		end

feature {NONE} -- Error Constants

	no_loose_argument_error: STRING_8 is "{1} is require and was not specified.";
		-- Errors

invariant
	accepts_loose_argument: accepts_loose_argument
	accepts_multiple_loose_arguments: accepts_multiple_loose_arguments

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
