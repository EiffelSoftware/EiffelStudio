note
	description: "Base implementation for all command-line argument builders."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COMMAND_LINE_BUILDER

inherit
	ANY
	
	COMMAND_LINE_BUILDING_FUNCTIONS
		export
			{NONE} all
		end

feature -- Access

	command_line_arguments: STRING
			-- Generates a command line based on set compiler-related properties
		do
			if attached internal_command_line as l_result then
				Result := l_result
			else
				Result := generate_command_line_arguments
				internal_command_line:= generate_command_line_arguments
			end
		ensure
			result_attached: attached Result
			result_consistent: Result ~ command_line_arguments
		end

feature {NONE} -- Basic operations

	generate_command_line_arguments: STRING
			-- Request command-line arguments be generated
		deferred
		ensure
			result_attached: attached Result
		end

feature {NONE} -- Status setting

	invalidate_command_line
			-- Invalidates any cached command line generated data so the next call
			-- to `command_line_arguments' will re-evaluate current state for a new
			-- command line string.
		do
			internal_command_line := Void
		ensure
			internal_command_line_unattached: not attached internal_command_line
		end

feature {NONE} -- Implementation

	internal_command_line: detachable STRING;
			-- Cached version of `command_line'
			-- Note: Do not use directly.

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end -- class {COMMAND_LINE_BUILDER}
