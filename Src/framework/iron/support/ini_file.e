note
	description: "Summary description for {INI_FILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INI_FILE

inherit
	TABLE_ITERABLE [detachable READABLE_STRING_32, READABLE_STRING_GENERAL]

create
	make_empty,
	make_with_path

feature {NONE} -- Initialization

	make_empty
		do
			create data.make_equal_caseless (3)

			is_valid := True
		end

	make_with_path (p: PATH)
		do
			make_empty
			import (p)
		end

feature -- Status report

	is_valid: BOOLEAN

feature -- Access

	item (n: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
		require
			is_valid: is_valid
		do
			Result := data.item (n)
		end

	table_item (a_name: READABLE_STRING_GENERAL): detachable STRING_TABLE [READABLE_STRING_32]
		require
			is_valid: is_valid
		local
			s: READABLE_STRING_GENERAL
			i, n: INTEGER
		do
			create Result.make (0)
			n := a_name.count
			across
				data as ic
			loop
				if attached ic.item as l_item then
					s := ic.key
					if s.count > n and then s.starts_with (a_name) and then s[n+1] = '[' then
						i := s.index_of (']', n + 1)
						if i > 0 then
							Result.force (l_item, s.substring (n + 2, i - 1))
						end
					end
				end
			end
			if Result.is_empty then
				Result := Void
			end
		end

feature -- Access

	new_cursor: TABLE_ITERATION_CURSOR [detachable READABLE_STRING_32, READABLE_STRING_GENERAL]
			-- Fresh cursor associated with current structure
		do
			Result := data.new_cursor
		end

feature -- Change

	put (v: detachable READABLE_STRING_GENERAL; k: READABLE_STRING_GENERAL)
		do
			if v /= Void then
				data.force (v.to_string_32, k)
			else
				data.force (Void, k)
			end
		end

	remove (k: READABLE_STRING_GENERAL)
		do
			data.remove (k)
		end

feature -- Basic operation

	save_to (p: PATH)
		local
			f: PLAIN_TEXT_FILE
			utf: UTF_CONVERTER
		do
			create f.make_with_path (p)
			if not f.exists or else f.is_access_writable then
				f.create_read_write
				across
					data as c
				loop
					if attached c.item as v then
						f.put_string (utf.utf_32_string_to_utf_8_string_8 (c.key))
						f.put_character (':')
						f.put_string (utf.utf_32_string_to_utf_8_string_8 (v))
					else
						f.put_string ("#")
						f.put_string (utf.utf_32_string_to_utf_8_string_8 (c.key))
						f.put_character (':')
					end
					f.put_new_line
				end
				f.close
			end
		end

feature {NONE} -- Implementation

	import (p: PATH)
		local
			f: PLAIN_TEXT_FILE
			s: STRING_8
			i,i2: INTEGER
			v: READABLE_STRING_8
			utf: UTF_CONVERTER
		do
			create f.make_with_path (p)
			if f.exists and then not f.is_directory and then f.is_access_readable then
				f.open_read
				from
				until
					f.exhausted
				loop
					f.read_line
					s := f.last_string
					s.left_adjust
					if s.is_empty then
					elseif s[1] = '#' then
						-- skip
					else
						i := s.index_of (':', 1)
						i2 := s.index_of ('=', 1)
						if i = 0 or else (0 < i2 and i2 < i) then
							i := i2
						end
						if i > 0 then
							v := s.tail (s.count - i)
							s := s.head (i - 1)
							data.force (utf.string_32_to_utf_8_string_8 (v), utf.string_32_to_utf_8_string_8 (s))
						else
							is_valid := False
						end
					end
				end
				f.close
			else
				is_valid := False
			end
		end

	data: STRING_TABLE [detachable READABLE_STRING_32]

;note
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
