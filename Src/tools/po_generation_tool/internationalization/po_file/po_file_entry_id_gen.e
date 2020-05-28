note
	description: "Po file entry id generator"
	date: "$Date$"
	revision: "$Revision$"

expanded class
	PO_FILE_ENTRY_ID_GEN

feature -- Generation

	generate_id_from_msgid_and_msgctxt (a_msgid: READABLE_STRING_GENERAL; a_msgctxt: detachable READABLE_STRING_GENERAL): STRING_32
			-- Generate id from msgid and msgctxt.
		require
			a_msg_id_not_void: a_msgid  /= Void
		do
			if attached a_msgctxt then
				Result := a_msgid.as_string_32 + a_msgctxt.as_string_32
			else
				Result := a_msgid.as_string_32
			end
		ensure
			Result_set: Result /= Void
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
