note
	description: "Summary description for {WGI_DELAYED_HEADER_RESPONSE}."
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_WGI_DELAYED_HEADER_RESPONSE

inherit
	WGI_FILTER_RESPONSE
		redefine
			set_status_code,
			commit,
			put_character,
			put_string,
			put_substring,
			flush,
			message_writable,
			message_committed
		end

	WSF_RESPONSE_EXPORTER

create
	make

feature {NONE} -- Initialization

	make (r: WGI_RESPONSE; res: WSF_RESPONSE)
		do
			wsf_response := res
			make_with_response (r)
		end

feature {WSF_RESPONSE} -- Change

	update_wsf_response (res: WSF_RESPONSE)
			-- Set `wsf_response' with `res'.
		do
			wsf_response := res
		ensure
			wsf_response_set: wsf_response = res
		end

feature {NONE} -- Implementation		

	wsf_response: WSF_RESPONSE
			-- Origin WSF response

	commit
			-- Send the delayed header is not yet done.
		do
			if not header_committed then
				process_header
			end
			Precursor
		end

	process_header
			-- Process the delayed header, i.e send it to the client.
		require
			header_not_committed: not header_committed
		do
				-- If no content is sent, the final `{WGI_REPONSE}.push' will call `process_header'
				-- via `{WGI_RESPONSE}.post_commit_action'
			wgi_response.set_post_commit_action (Void)

				-- commit status code and reason phrase
				-- commit header text
			wsf_response.process_header

				-- update wgi_response on wsf_response to send content directly
			wsf_response.set_wgi_response (wgi_response)
		ensure
			header_committed: header_committed
		end

feature -- Status setting

	set_status_code (a_code: INTEGER; a_reason_phrase: detachable READABLE_STRING_8)
			-- Set response status code with custom `a_reason_phrase' if precised
			-- Should be done before sending any data back to the client
		do
			if a_reason_phrase /= Void then
				wsf_response.set_status_code_with_reason_phrase (a_code, a_reason_phrase)
			else
				wsf_response.set_status_code (a_code)
			end
		end

feature -- Status report	

	message_writable: BOOLEAN = True
			-- Can message be written?

	message_committed: BOOLEAN
			-- <Precursor>
		do
			Result := header_committed
		end

feature -- Output operation

	put_character (c: CHARACTER_8)
			-- Send the character `c'
		do
			process_header
			Precursor (c)
		end

	put_string (s: READABLE_STRING_8)
			-- Send the string `s'
		do
			process_header
			Precursor (s)
		end

	put_substring (s: READABLE_STRING_8; a_begin_index, a_end_index: INTEGER)
			-- Send the substring `s[a_begin_index:a_end_index]'
		do
			process_header
			Precursor (s, a_begin_index, a_end_index)
		end

	flush
			-- Flush if it makes sense
		do
			process_header
			Precursor
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
