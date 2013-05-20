note
	description: "Summary description for WGI_CGI_OUTPUT_STREAM."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WGI_CGI_OUTPUT_STREAM

inherit
	WGI_OUTPUT_STREAM
		rename
			put_string as put_readable_string_8
		end

	CONSOLE
		rename
			make as console_make
		end

	HTTP_STATUS_CODE_MESSAGES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			make_open_stdout ("stdout")
		end

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

	put_readable_string_8 (s: READABLE_STRING_8)
			-- Write `s' at end of default output.
		local
			ext: C_STRING
		do
			if s.count > 0 then
				create ext.make (s)
				console_ps (file_pointer, ext.managed_data.item, s.count)
			end
		end

note
	copyright: "2011-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
