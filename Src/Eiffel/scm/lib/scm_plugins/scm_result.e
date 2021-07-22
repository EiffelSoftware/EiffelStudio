note
	description: "Summary description for {SCM_RESULT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_RESULT

create
	make_with_command,
	make_success,
	make_failure

convert
	to_string_32: {STRING_32}

feature {NONE} -- Initialization

	make_with_command (cmd: READABLE_STRING_GENERAL)
		do
			command := cmd
		end

	make_success (cmd: detachable READABLE_STRING_GENERAL)
		do
			if cmd /= Void then
				make_with_command (cmd)
			end
			failed := False
			message := Void
		end

	make_failure (cmd: detachable READABLE_STRING_GENERAL)
		do
			if cmd /= Void then
				make_with_command (cmd)
			end
			failed := True
			message := Void
		end

feature -- Status report

	succeed: BOOLEAN
			-- Svn command succeed?
		do
			Result := not failed
		end

	failed: BOOLEAN
			-- Svn command failed?

	command: detachable READABLE_STRING_32
			-- Optional command information.

	message: detachable IMMUTABLE_STRING_32
			-- Potential message.

feature -- Conversion

	to_string_32: STRING_32
		do
			if attached message as msg then
				Result := msg
			else
				if succeed then
					Result := {STRING_32} "Succeed"
				else
					check failed end
					Result := "Failed"
				end
				if attached command as cmd then
					Result.append_string ({STRING_32} ": ")
					Result.append_string (cmd)
				end
			end
		end

feature -- Element change

	set_message (msg: detachable READABLE_STRING_GENERAL)
			-- Set `message' to `msg'.
		do
			if msg = Void then
				message := Void
			else
				create message.make_from_string_general (msg)
			end
		end

	set_command (cmd: detachable READABLE_STRING_GENERAL)
			-- Set `command' to `cmd'.
		do
			if cmd = Void then
				command := Void
			else
				create {IMMUTABLE_STRING_32} command.make_from_string_general (cmd)
			end
		end

;note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
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
end
