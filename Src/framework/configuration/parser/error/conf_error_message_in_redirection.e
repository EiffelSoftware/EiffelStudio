note
	description: "[
			 Message found in configuration redirection.
		 ]"
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_MESSAGE_IN_REDIRECTION

inherit
	CONF_ERROR

create
	make

feature {NONE} -- Initialization

	make (a_file: like redirection_file; a_dest_file: like destination_file; msg: READABLE_STRING_GENERAL)
			-- Create Current for redirection file `a_file' toward destination `a_dest_file'
			-- and associated message `msg'.
		do
			redirection_file := a_file
			destination_file := a_dest_file
			message := msg
		end

feature -- Access

	redirection_file: READABLE_STRING_GENERAL
			-- Associated file.

	destination_file: READABLE_STRING_GENERAL
			-- Destination of the redirection.

	text: STRING_32
			-- Error message.
		do
			Result := {STRING_32} "Message in configuration file redirection:%N"
			Result.append ({STRING_32} "Redirection file name: ")
			Result.append_string_general (redirection_file)
			Result.append_character ('%N')
			Result.append ({STRING_32} "Destination file name: ")
			Result.append_string_general (destination_file)
			Result.append_character ('%N')
			Result.append ({STRING_32} "Message: ")
			Result.append_string_general (message)
			Result.append_character ('%N')
		end

	message: READABLE_STRING_GENERAL
			-- Associated message.

invariant
	redirection_file_attached: redirection_file /= Void
	destination_file_attached: destination_file /= Void

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
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
