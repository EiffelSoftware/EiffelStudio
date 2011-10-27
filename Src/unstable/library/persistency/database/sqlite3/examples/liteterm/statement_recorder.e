note
	description: "[
		A class for record user entered statements on the interactive terminal.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	STATEMENT_RECORDER

inherit
	INTERACTIVE_TERMINAL_FACADE

create
	make

feature {NONE} --Initialization

	make (a_terminal: like interactive_terminal; a_writer: like writer)
			-- Initialize the recorder with a medium to write to.
			--
			-- `a_terminal': The terminal object.
			-- `a_writer': File to record to.
		require
			a_writer_is_writable: a_writer.is_writable
		do
			interactive_terminal := a_terminal
			writer := a_writer
		ensure
			interactive_terminal_set: interactive_terminal = a_terminal
			writer_set: writer = a_writer
		end

feature -- Access

	interactive_terminal: INTERACTIVE_TERMINAL
			-- Terminal used for interaction.

	writer: FILE
			-- Medium to record statements to.

feature -- Status report

	is_writable: BOOLEAN
			-- Indicates if the record is writable
		do
			Result := writer.is_open_write and then writer.is_writable
		ensure
			is_writable: Result implies (writer.is_open_write and then writer.is_writable)
		end

feature -- Basic operation

	record (a_statement: SQLITE_STATEMENT)
			-- Records an SQLite statement.
			--
			-- `a_statement': The statement to record.
		require
			is_writable: is_writable
			a_statement_is_compiled: a_statement.is_compiled
		do
			writer.put_string (a_statement.string)
			writer.new_line
			writer.flush
		end

	close
			-- Close the reporter.
			--
			-- Note: Closing the reporter will render the recorder inoperable from then on.
		require
			is_writable: is_writable
		do
			writer.close
		ensure
			writer_is_closed: writer.is_closed
			not_is_writable: not is_writable
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
