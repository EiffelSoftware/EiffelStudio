note
	description: "[
			WGI Response implemented using stream buffer

		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WGI_RESPONSE_STREAM

inherit
	WGI_RESPONSE

create
	make

feature {NONE} -- Initialization

	make (a_output: like output; a_error: like error)
		do
			output := a_output
			error := a_error
		end

feature {WGI_CONNECTOR, WGI_SERVICE} -- Commit

	commit
			-- Commit the current response
		do
			output.flush
			message_committed := True
		end

feature -- Status report

	status_committed: BOOLEAN
			-- Status code set and committed?

	header_committed: BOOLEAN
			-- Header committed?

	message_committed: BOOLEAN
			-- Message committed?

	message_writable: BOOLEAN
			-- Can message be written?
		do
			Result := status_is_set and header_committed
		end

feature -- Status setting

	status_is_set: BOOLEAN
			-- Is status set?	
		do
			Result := status_code > 0
		end

	set_status_code (a_code: INTEGER; a_reason_phrase: detachable READABLE_STRING_8)
			-- Set response status code
			-- Should be done before sending any data back to the client
		do
			status_code := a_code
			status_reason_phrase := a_reason_phrase
			output.put_status_line (a_code, a_reason_phrase)
			status_committed := True
		end

	status_code: INTEGER
			-- Response status

	status_reason_phrase: detachable READABLE_STRING_8
			-- Custom status reason phrase for the Response (optional)

feature -- Header output operation		

	put_header_text (a_text: READABLE_STRING_8)
		do
			output.put_string (a_text)
			output.put_crlf
			header_committed := True
		end

feature -- Output operation

	put_character (c: CHARACTER_8)
			-- Send the character `c'
		do
			output.put_character (c)
		end

	put_string (s: READABLE_STRING_8)
			-- Send the string `s'
		do
			output.put_string (s)
		end

	put_substring (s: READABLE_STRING_8; start_index, end_index: INTEGER)
			-- Send the substring `start_index:end_index]'
			--| Could be optimized according to the target output
		do
			output.put_substring (s, start_index, end_index)
		end

	put_file_content (f: FILE; a_offset: INTEGER; a_count: INTEGER)
			-- Send `a_count' bytes from the content of file `f' starting at offset `a_offset'.
		do
			output.put_file_content (f, a_offset, a_count)
		end

	flush
		do
			output.flush
		end

feature -- Error reporting

	put_error (a_message: READABLE_STRING_8)
			-- Report error described by `a_message'
			-- This might be used by the underlying connector
		do
			if attached error as err then
				err.put_error (a_message)
			end
		end

feature {NONE} -- Implementation: Access

	output: WGI_OUTPUT_STREAM
			-- Server output channel

	error: detachable WGI_ERROR_STREAM
			-- Server output channel

;note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
