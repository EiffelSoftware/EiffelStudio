note
	description: "[
				WGI response acting as a filter.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	WGI_FILTER_RESPONSE

inherit
	WGI_RESPONSE

create
	make_with_response

feature {NONE} -- Initialization

	make_with_response (res: WGI_RESPONSE)
		do
			wgi_response := res
			res.set_post_commit_action (agent commit)
		end

feature -- Access		

	wgi_response: WGI_RESPONSE

feature {WGI_FILTER_RESPONSE} -- Change		

	update_wgi_response (res: WGI_RESPONSE)
			-- Set `wgi_response' with `res'.
		do
			if wgi_response /= res then
				res.set_post_commit_action (wgi_response.post_commit_action)
				wgi_response.set_post_commit_action (Void)
			else
				-- Same response object
			end
		end

feature {WGI_CONNECTOR, WGI_SERVICE} -- Commit

	commit
			-- Commit the current response
		do
			wgi_response.set_post_commit_action (Void)
		end

feature -- Status report

	status_committed: BOOLEAN
			-- Is status code set and committed?
			-- i.e: sent to the client and could not be changed anymore
		do
			Result := wgi_response.status_committed
		end

	header_committed: BOOLEAN
			-- Header committed?
		do
			Result := wgi_response.header_committed
		end

	message_committed: BOOLEAN
			-- Message committed?
		do
			Result := wgi_response.message_committed
		end

	message_writable: BOOLEAN
			-- Can message be written?
		do
			Result := wgi_response.message_writable
		end

feature -- Status setting

	status_is_set: BOOLEAN
			-- Is status set?
		do
			Result := wgi_response.status_is_set
		end

	set_status_code (a_code: INTEGER; a_reason_phrase: detachable READABLE_STRING_8)
			-- Set response status code with custom `a_reason_phrase' if precised
			-- Should be done before sending any data back to the client
		do
			wgi_response.set_status_code (a_code, a_reason_phrase)
		end

	status_code: INTEGER
			-- Response status
		do
			Result := wgi_response.status_code
		end

	status_reason_phrase: detachable READABLE_STRING_8
			-- Custom status reason phrase for the Response (optional)
		do
			Result := wgi_response.status_reason_phrase
		end

feature -- Header output operation

	put_header_text (a_text: READABLE_STRING_8)
			-- Write http header string `a_text'
			-- It should not contain the ending CR LF CR LF
			-- since it is the duty of `put_header_text' to write it.
		do
			wgi_response.put_header_text (a_text)
		end

feature -- Output operation

	put_character (c: CHARACTER_8)
			-- Send the character `c'
		do
			wgi_response.put_character (c)
		end

	put_string (s: READABLE_STRING_8)
			-- Send the string `s'
		do
			wgi_response.put_string (s)
		end

	put_substring (s: READABLE_STRING_8; a_begin_index, a_end_index: INTEGER)
			-- Send the substring `s[a_begin_index:a_end_index]'
		do
			wgi_response.put_substring (s, a_begin_index, a_end_index)
		end

	flush
			-- Flush if it makes sense
		do
			wgi_response.flush
		end

feature -- Error reporting

	put_error (a_message: READABLE_STRING_8)
			-- Report error described by `a_message'
			-- This might be used by the underlying connector
		do
			wgi_response.put_error (a_message)
		end

note
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
