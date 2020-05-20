note
	description: "Facilities to read and write UTF-8 encoded strings"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	UTF8_READER_WRITER

feature -- Reading

	file_read_string_32_with_length (a_file: FILE; n_bytes: INTEGER): STRING_32
			-- Read `n_bytes' from `a_file' and interpret them as the UTF-8 encoding of a string
		require
			a_file_not_void: a_file /= Void
			file_open_readable: a_file.is_open_read
			n_non_negative: n_bytes >= 0
		local
			l_read: detachable STRING
		do
			if n_bytes = 0 then
				create Result.make_empty
			else
				a_file.read_stream (n_bytes)
				l_read := a_file.last_string
				if l_read /= Void then
					Result := {UTF_CONVERTER}.utf_8_string_8_to_string_32 (l_read)
				else
					create Result.make_empty
				end
			end
		ensure
			result_not_void: Result /= Void
		end

feature -- Writing

	file_write_string_32 (a_file: FILE; a_string: STRING_32)
			-- Write `a_string' to `a_file' at current position using UTF-8 encoding
		require
			a_file_not_void: a_file /= Void
			file_open_writeable: a_file.is_open_write
			string_not_void: a_string /= Void
		local
			l_str_to_write: STRING
		do
			l_str_to_write := {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (a_string)
			a_file.put_string (l_str_to_write)
		end

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
