note
	description: "UUID mismatch error in file redirection."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_UUID_MISMATCH_IN_REDIRECTION

inherit
	CONF_ERROR

create
	make

feature {NONE} -- Initialization

	make (f1: like redirected_file; f2: like file; uuid1, uuid2: detachable UUID)
		do
			redirected_file := f1
			file := f2
			redirected_file_uuid := uuid1
			file_uuid := uuid2
		end

feature -- Access

	file: detachable READABLE_STRING_32
			-- Associated file.

	redirected_file: detachable READABLE_STRING_32
			-- Associated redirected file.

	text: STRING_32
			-- Error message.
		do
			Result := {STRING_32} "UUID mismatched in configuration file redirection:%N"
			if attached redirected_file as f then
				Result.append ({STRING_32} " - %"" + f + {STRING_32} "%"")
				Result.append_character ('%N')
			end
			Result.append ({STRING_32} "   uuid=")
			if attached redirected_file_uuid as u1 then
				Result.append (u1.string)
			else
				Result.append ({STRING_32} "none")
			end
			Result.append_character ('%N')
			if attached file as f then
				Result.append ({STRING_32} " - %"" + f + {STRING_32} "%"")
				Result.append_character ('%N')
			end
			Result.append ({STRING_32} "   uuid=")
			if attached file_uuid as u2 then
				Result.append (u2.string)
			else
				Result.append ({STRING_32} "none")
			end
		end

	file_uuid, redirected_file_uuid: detachable UUID
			-- Associated UUID.

invariant
	file_attached: file /= Void

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
