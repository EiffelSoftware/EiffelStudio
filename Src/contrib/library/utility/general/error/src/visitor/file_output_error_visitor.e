note
	description: "File error output visitor"
	date: "$Date$"
	revision: "$Revision$"

class
	FILE_OUTPUT_ERROR_VISITOR

inherit
	OUTPUT_ERROR_VISITOR
		redefine
			output_integer,
			output_new_line
		end

create
	make

feature {NONE} -- Creation

	make (f: like file)
		require
			f_open_write: f /= Void and then f.is_open_write
		do
			file := f
		end

feature -- Access

	file: FILE

feature -- Output

	output_string (a_str: detachable READABLE_STRING_GENERAL)
			-- Output Unicode string.
		do
			if a_str /= Void then
				to_implement ("Convert into UTF-8 or console encoding before output")
				file.put_string ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (a_str))
			end
		end

	output_integer (i: INTEGER)
		do
			file.put_integer (i)
		end

	output_new_line
		do
			file.put_new_line
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
