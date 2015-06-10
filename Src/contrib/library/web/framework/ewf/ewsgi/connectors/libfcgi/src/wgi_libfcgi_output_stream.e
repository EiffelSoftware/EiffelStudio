note
	description: "Output stream for libFCGI connector."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WGI_LIBFCGI_OUTPUT_STREAM

inherit
	WGI_OUTPUT_STREAM

	WGI_ERROR_STREAM

	HTTP_STATUS_CODE_MESSAGES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_fcgi: like fcgi)
		require
			valid_fcgi: a_fcgi /= Void
		do
			fcgi := a_fcgi
		end

feature -- Status report

	is_open_write: BOOLEAN
			-- Can items be written to output stream?
		do
			Result := True
		end

feature -- Status report

	is_available: BOOLEAN = True
			-- <Precursor>

feature -- Status writing

	put_status_line (a_code: INTEGER; a_reason_phrase: detachable READABLE_STRING_8)
			-- <Precursor>
		local
			s: STRING
			m: detachable READABLE_STRING_8
		do
			if a_code /= 200 then
				create s.make (16)
				s.append ("Status:")
				s.append_character (' ')
				s.append_integer (a_code)
				m := a_reason_phrase
				if m = Void then
					m := http_status_code_message (a_code)
				end
				if m /= Void then
					s.append_character (' ')
					s.append_string (m)
				end
				put_header_line (s)
			end
		end

feature -- Basic operation

	put_string (s: READABLE_STRING_8)
			-- Send `s' to http client
		do
			fcgi.put_string (s)
		end

	put_character (c: CHARACTER_8)
			-- Send `c' to http client
		do
			fcgi.put_string (c.out)
		end

feature -- Basic operations

	flush
			-- Flush buffered data to disk.
		do
		end

feature -- Error

	put_error (a_message: READABLE_STRING_8)
		do
			fcgi.put_error (a_message)
		end

feature {NONE} -- Implementation

	fcgi: FCGI
			-- Bridge to FCGI world

invariant
	fcgi_attached: fcgi /= Void

note
	copyright: "2011-2015, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
