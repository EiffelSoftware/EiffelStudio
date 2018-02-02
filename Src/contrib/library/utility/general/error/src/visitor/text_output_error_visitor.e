note
	description: "Text error output visitor"
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_OUTPUT_ERROR_VISITOR

inherit
	OUTPUT_ERROR_VISITOR
		redefine
			output_integer,
			output_new_line
		end

create
	make

feature {NONE} -- Creation

	make (buf: like buffer)
		require
			buf_attached: buf /= Void
		do
			buffer := buf
		end

feature -- Access

	buffer: STRING

feature -- Output

	output_string (a_str: detachable READABLE_STRING_GENERAL)
			-- Output Unicode string.
		do
			if a_str /= Void then
				to_implement ("Convert into UTF-8 or console encoding before output")
				buffer.append_string_general (a_str)
			end
		end

	output_integer (i: INTEGER)
		do
			buffer.append_integer (i)
		end

	output_new_line
		do
			buffer.append_character ('%N')
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
