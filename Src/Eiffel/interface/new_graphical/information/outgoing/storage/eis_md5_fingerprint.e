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
			l_md5: MD5
			u: UTF_CONVERTER
		do
			create l_md5.make
			l_md5.sink_string (u.utf_32_string_to_utf_8_string_8 (a_content))
			l_md5.do_final (md5_output, 0)
			Result := special_to_string (md5_output)
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

	md5_output: SPECIAL [NATURAL_8]
			-- Output buffer for MD5
		once
			create Result.make_filled (0, 16)
		end

	special_to_string (a_special: SPECIAL [NATURAL_8]): STRING_8
			-- Create string instance from special
		do
			create Result.make (a_special.count * 2)
			a_special.do_all_in_bounds (
					agent (a_n: NATURAL_8; a_string: STRING_8)
						do
							a_string.append_string (a_n.to_hex_string)
						end (?, Result),
					a_special.lower, a_special.upper)
		ensure
			correct_result_length: a_special.count * 2 = Result.count
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
