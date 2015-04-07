note
	description: "[
	Mock implementation of the WGI_RESPONSE interface.

	Used for testing the ewf core and also web applications.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	WGI_RESPONSE_NULL

inherit

	WGI_RESPONSE

create
	make

feature {NONE} -- Initialization

	make
		do
			create output.make_empty
			create error.make_empty
		end

feature {WGI_CONNECTOR, WGI_SERVICE} -- Commit

	commit
			-- Commit the current response
		do
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
			if attached a_reason_phrase as l_rp then
				output.prepend (l_rp)
			end
			output.prepend (" ")
			output.prepend (a_code.out)
			output.append ("%R%N")
			status_committed := True
		end

	status_code: INTEGER
			-- Response status

	status_reason_phrase: detachable READABLE_STRING_8
			-- Custom status reason phrase for the Response (optional)

feature -- Header output operation		

	put_header_text (a_text: READABLE_STRING_8)
		do
			output.append (a_text)
			output.append ("%R%N")
			header_committed := True
		end

feature -- Output operation

	put_character (c: CHARACTER_8)
			-- Send the character `c'
		do
			output.append_character (c)
		end

	put_string (s: READABLE_STRING_8)
			-- Send the string `s'
		do
			output.append (s)
		end

	put_substring (s: READABLE_STRING_8; start_index, end_index: INTEGER)
			-- Send the substring `start_index:end_index]'
			--| Could be optimized according to the target output
		do
			output.append_substring (s, start_index, end_index)
		end

	flush
		do
			output.wipe_out
		end

feature -- Error reporting

	put_error (a_message: READABLE_STRING_8)
			-- Report error described by `a_message'
			-- This might be used by the underlying connector
		do
			if attached error as err then
				err.append (a_message)
			end
		end

feature -- Implementation: Access

	output: STRING
			-- Server output channel

	error: detachable STRING
			-- Server output channel


end
