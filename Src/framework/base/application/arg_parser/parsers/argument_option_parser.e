indexing
	description: "Argument parser that accepts only switch options."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ARGUMENT_OPTION_PARSER

inherit
	ARGUMENT_BASE_PARSER
		rename
			make as make_lite
		export
			{NONE} values
		redefine
			execute_noop
		end

feature {NONE} -- Initialization

	make (a_cs: like case_sensitive; a_usage_on_error: like display_usage_on_error) is
			-- Initializes argument parser
		do
			make_lite (a_cs, False, False, a_usage_on_error)
		ensure
			case_sensitive_set: case_sensitive = a_cs
			display_usage_on_error_set: display_usage_on_error = a_usage_on_error
		end

feature {NONE} -- Basic Operations

	execute_noop (a_agent: PROCEDURE [ANY, TUPLE]) is
			-- Executes `a_agent' when no arguments of any worth are passed.
		do
			a_agent.call ([])
		end

invariant
	not_accepts_loose_argument: not accepts_loose_argument
	not_accepts_multiple_loose_arguments: not accepts_multiple_loose_arguments

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

end -- class {ARGUMENT_OPTION_PARSER}
