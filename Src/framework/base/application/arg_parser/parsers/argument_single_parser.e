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
			command_option_configuration,
			validate_arguments
		end

	ARGUMENT_BASE_PARSER
		rename
			make as make_lite
		export
			{NONE} values
		undefine
			extended_usage
		redefine
			command_option_configuration,
			validate_arguments
		end

feature -- Access

	single_value: STRING is
			-- Specified loose argument value
		require
			successful: successful
		do
			Result := values.first
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Usage

	command_option_configuration: STRING is
			-- Command line option configuration string (to display in usage)
		local
			l_suffix: STRING
			l_arg: STRING
		once
			l_arg := loose_argument_name_arg
			l_suffix := Precursor {ARGUMENT_BASE_PARSER}
			if l_suffix /= Void then
				create Result.make (l_arg.count + l_suffix.count + 1)
				Result.append (l_arg)
				Result.append_character (' ')
				Result.append (l_suffix)
			else
				Result := l_arg
			end
		ensure then
			result_attached: Result /= Void
		end

feature {NONE} -- Validation

	validate_arguments is
			-- Validates arguments to ensure they are configured correctly
		do
			if values.count > 1 then
				add_template_error (multi_loose_argument_error, [loose_argument_type.as_lower])
			end
			Precursor {ARGUMENT_MULTI_PARSER}
		end

feature {NONE} -- Error Constants

	multi_loose_argument_error: STRING is "Only one {1} can be specified."
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

end -- class {ARGUMENT_SINGLE_PARSER}
