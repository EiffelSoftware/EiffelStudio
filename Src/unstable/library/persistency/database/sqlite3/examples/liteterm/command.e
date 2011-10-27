note
	description: "[
		Abstract built-in executable command on the interactive terminal.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COMMAND

inherit
	INTERACTIVE_TERMINAL_FACADE

feature {NONE} --Initialization

	make (a_terminal: like interactive_terminal)
			-- Initialize the command using the source terminal.
			--
			-- `a_terminal': The terminal object.
		do
			interactive_terminal := a_terminal
		ensure
			interactive_terminal_set: interactive_terminal = a_terminal
		end

feature -- Access

	interactive_terminal: INTERACTIVE_TERMINAL
			-- Terminal used for interaction.

	description: IMMUTABLE_STRING_8
			-- Description of the command, used for quick help.
		deferred
		ensure
			not_result_is_empty: not Result.is_empty
			not_result_contains_new_line: not Result.has ('%N')
		end

feature -- Basic operations

	execute (a_args: detachable ARRAY [READABLE_STRING_8])
			-- Performs an interactive command.
			--
			-- `a_args': The arguments to use with the command.
		require
			interactive_terminal_is_interactive: interactive_terminal.is_interactive
		deferred
		end

	display_help (a_args: detachable ARRAY [READABLE_STRING_8])
			-- Displays command help.
			--
			-- `a_args': The arguments to use with the help command.
		require
			terminal_is_interactive: interactive_terminal.is_interactive
		local
			l_writer: like terminal_writer
		do
			l_writer := terminal_writer
			l_writer.put_string (description)
		end

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
