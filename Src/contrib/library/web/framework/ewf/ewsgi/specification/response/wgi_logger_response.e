note
	description: "Summary description for {WGI_LOGGER_RESPONSE}."
	date: "$Date$"
	revision: "$Revision$"

class
	WGI_LOGGER_RESPONSE

inherit
	WGI_FILTER_RESPONSE
		redefine
			set_status_code,
			put_header_text,
			put_character,
			put_string,
			put_substring,
			flush,
			put_error
		end

create
	make_with_response_and_output

feature {NONE} -- Initialization

	make_with_response_and_output (res: WGI_RESPONSE; a_out: FILE; a_err: FILE)
		do
			output := a_out
			error := a_err
			make_with_response (res)
		end

	output: FILE
	error: FILE

feature -- Status setting

	set_status_code (a_code: INTEGER; a_reason_phrase: detachable READABLE_STRING_8)
			-- Set response status code with custom `a_reason_phrase' if precised
			-- Should be done before sending any data back to the client
		do
			output.put_string ("Status: " + a_code.out)
			if a_reason_phrase /= Void then
				output.put_string (" " + a_reason_phrase)
			end
			output.put_new_line
			Precursor (a_code, a_reason_phrase)
		end

feature -- Header output operation

	put_header_text (a_text: READABLE_STRING_8)
			-- Write http header string `a_text'
			-- It should not contain the ending CR LF CR LF
			-- since it is the duty of `put_header_text' to write it.
		do
			output.put_string (a_text)
			output.put_character ('%R')
			output.put_character ('%N')
			output.put_character ('%R')
			output.put_character ('%N')
			Precursor (a_text)
		end

feature -- Output operation

	put_character (c: CHARACTER_8)
			-- Send the character `c'
		do
			output.put_character (c)
			Precursor (c)
		end

	put_string (s: READABLE_STRING_8)
			-- Send the string `s'
		do
			output.put_string (s)
			Precursor (s)
		end

	put_substring (s: READABLE_STRING_8; a_begin_index, a_end_index: INTEGER)
			-- Send the substring `s[a_begin_index:a_end_index]'
		do
			output.put_string (s.substring (a_begin_index, a_end_index))
			Precursor (s, a_begin_index, a_end_index)
		end

	flush
			-- Flush if it makes sense
		do
			output.flush
			Precursor
		end

feature -- Error reporting

	put_error (a_message: READABLE_STRING_8)
			-- Report error described by `a_message'
			-- This might be used by the underlying connector
		do
			error.put_string (a_message)
			error.flush
			Precursor (a_message)
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
