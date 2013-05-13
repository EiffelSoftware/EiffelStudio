note
	description: "Fingerprint implemented by MD5 hash"
	date: "$Date$"
	revision: "$Revision$"

class
	EIS_MD5_FINGERPRINT

inherit
	EIS_FINGERPRINT

create
	make_empty,
	make_with_content

feature {NONE} -- Init

	make_empty
			-- Make empty
		do
			create md5.make_empty
		end

	make_with_content (a_content: READABLE_STRING_GENERAL)
			-- Make with `a_content'.
		do
			md5 := generate_md5 (a_content)
		ensure
			md5_set: md5 /= Void
		end

	generate_md5 (a_content: READABLE_STRING_GENERAL): STRING
			-- Generate MD5 from `a_content'
		require
			a_content_set: a_content /= Void
		local
			u: UTF_CONVERTER
		do
			md5_computer.update_from_string (u.utf_32_string_to_utf_8_string_8 (a_content))
			Result := md5_computer.digest_as_string
			md5_computer.reset
		ensure
			Result_set: Result /= Void
		end

feature -- Query

	same_fingerprint (a_fingerprint: EIS_FINGERPRINT): BOOLEAN
			-- Same fingerprint?
		do
			if a_fingerprint = Current then
				Result := True
			else
				if attached {EIS_MD5_FINGERPRINT} a_fingerprint as l_f then
					Result := md5.same_string (l_f.md5)
				end
			end
		end

feature -- Access

	md5: STRING
			-- MD5 of the content

feature {NONE} -- Implemetation

	md5_computer: MD5
			-- MD5 computer
		once
			create Result.make
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
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
