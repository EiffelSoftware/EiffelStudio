indexing
	description: "Command sender implemtation interface."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COMMAND_SENDER_I

feature -- Action

	send_command (a_string, a_key: !STRING) is
			-- Send `a_string' as command to receiver processes.
			-- `a_key' to identify receiver.
		deferred
		end

	send_command_process (a_string, a_key: !STRING; a_process_id: INTEGER) is
			-- Send `a_string' as command to receiver process of `a_process_id' with `a_key'.
		deferred
		end

feature -- Querry

	last_command_handled: BOOLEAN is
			-- Was last `send_command' or `send_command_process' correctly handled?
		deferred
		end

	last_command_reached: BOOLEAN
			-- Has last by `send_command_process' really reached the target process?
		deferred
		end

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
