indexing
	description: "Argument parser that requires a single loose argumen to be specified."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ARGUMENT_SINGLE_PARSER

inherit
	ARGUMENT_MULTI_PARSER
		export
			{NONE} values
		redefine
			command_option_group_configuration,
			validate_arguments
		end

	ARGUMENT_BASE_PARSER
		rename
			make as make_base_parser
		export
			{NONE} values
		undefine
			extended_usage,
			validate_non_switched_arguments
		redefine
			command_option_group_configuration,
			validate_arguments
		end

feature -- Access

	value: !STRING
			-- Specified non-switched argument value.
		require
			is_successful: is_successful
			has_non_switched_argument: has_non_switched_argument
		do
			Result := values.first
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Usage

	command_option_group_configuration (a_group: !LIST [!ARGUMENT_SWITCH]; a_show_non_switch: BOOLEAN; a_non_switch_required: BOOLEAN; a_add_appurtenances: BOOLEAN; a_src_group: !LIST [!ARGUMENT_SWITCH]): STRING
			-- Command line option configuration string (to display in usage)
		local
			l_suffix: STRING
			l_arg: STRING
		do
			l_suffix := Precursor {ARGUMENT_BASE_PARSER} (a_group, a_show_non_switch, a_non_switch_required, a_add_appurtenances, a_src_group)

			create Result.make (30)
			if a_show_non_switch then
				l_arg := non_switched_argument_name_arg
				if not a_non_switch_required then
					Result.append_character ('[')
				end
				Result.append (l_arg)
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

feature {NONE} -- Validation

	validate_arguments
			-- <Precursor>
		do
			if values.count > 1 then
					-- Only allowed one non-switched argument.
				add_template_error (e_one_non_switch_only, [non_switched_argument_type.as_lower])
			end
			Precursor {ARGUMENT_MULTI_PARSER}
		end

feature {NONE} -- Internationalization

	e_one_non_switch_only: STRING is "Only one {1} can be specified."

;indexing
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

end -- class {ARGUMENT_SINGLE_PARSER}
