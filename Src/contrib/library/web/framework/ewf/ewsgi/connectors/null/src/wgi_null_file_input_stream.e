note
	description: "Summary description for WGI_NULL_FILE_INPUT_STREAM."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WGI_NULL_FILE_INPUT_STREAM

inherit
	WGI_NULL_INPUT_STREAM

create
	make

feature {NONE} -- Initialization

	make (f: FILE)
		do
			file := f
		end

	file: FILE

feature -- Input

	read_character
			-- Read the next character in input stream.
			-- Make the result available in `last_character'
		do
			file.read_character
		end

	read_string (nb: INTEGER)
			-- Read the next `nb' characters and
			-- make the string result available in `last_string'
		do
			file.read_stream (nb)
		end

feature -- Access

	last_string: STRING_8
			-- Last string read.
			--
			-- Note: this query *might* return the same object.
			-- Therefore a clone should be used if the result
			-- is to be kept beyond the next call to this feature.
			-- However `last_string' is not shared between file objects.)
		do
			Result := file.last_string
		end

	last_character: CHARACTER_8
			-- Last item read.
		do
			Result := file.last_character
		end

feature -- Status report

	is_open_read: BOOLEAN
			-- Can items be read from input stream?
		do
			Result := file.is_open_read
		end

	end_of_input: BOOLEAN
			-- Has the end of input stream been reached?
		do
			Result := file.end_of_file
		end


invariant


note
	copyright: "2011-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
