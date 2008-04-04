indexing
	description: "Objects that sends command as a string to possible receivers."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COMMAND_SENDER

inherit
	COMMAND_CONSTANTS
		export
			{NONE} all
		end

feature -- Operation

	send_command (a_string, a_key: !STRING) is
			-- Send `a_string' as command to receiver processes with `a_key'.
			-- `a_key' to identify receivers.
			-- The `a_key' is recommended to be an UUID.
		do
			if implementation = Void then
				create_implementation
			end
			implementation.send_command (a_string, a_key)
		end

	send_command_process (a_string, a_key: !STRING; a_process_id: INTEGER) is
			-- Send `a_string' as command to receiver process of `a_process_id' with `a_key'.
		do
			if implementation = Void then
				create_implementation
			end
			implementation.send_command_process (a_string, a_key, a_process_id)
		end

feature -- Querry

	last_command_handled: BOOLEAN
			-- Was last command handled?
		do
			if implementation /= Void then
				Result := implementation.last_command_handled
			end
		end

	last_command_reached: BOOLEAN
			-- See if last command has really reached the target process by `send_command_process'.
		do
			if implementation /= Void then
				Result := implementation.last_command_reached
			end
		end

feature {NONE} -- Implementation

	implementation: ?COMMAND_SENDER_I

feature {NONE} -- Implementation

	create_implementation is
			-- Create implementation
		do
			create {COMMAND_SENDER_IMP}implementation
		ensure
			implementation_not_void: implementation /= Void
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
