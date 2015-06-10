note
	description: "Output stream for Nino connector."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WGI_NINO_OUTPUT_STREAM

inherit
	WGI_OUTPUT_STREAM

	HTTP_STATUS_CODE_MESSAGES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_target: like target)
		do
			set_target (a_target)
		end

feature {WGI_NINO_CONNECTOR, WGI_SERVICE} -- Nino

	set_target (o: like target)
		do
			target := o
		end

	target: TCP_STREAM_SOCKET

feature -- Status writing

	put_status_line (a_code: INTEGER; a_reason_phrase: detachable READABLE_STRING_8)
			-- <Precursor>
		local
			s: STRING
			m: detachable READABLE_STRING_8
		do
			create s.make (16)
			s.append ({HTTP_CONSTANTS}.http_version_1_1)
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

feature -- Output

	put_string (s: READABLE_STRING_8)
			-- Send `s' to http client
		do
			target.put_readable_string_8 (s)
		end

	put_character (c: CHARACTER_8)
		do
			target.put_character (c)
		end

feature -- Status report

	is_open_write: BOOLEAN
			-- Can items be written to output stream?
		do
			Result := target.is_open_write
		end

feature -- Status report

	is_available: BOOLEAN
			-- <Precursor>
			-- FIXME: see how "standalone" connection is doing that.
		do
			Result := target.is_open_read
		end

feature -- Basic operations

	flush
		do
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
