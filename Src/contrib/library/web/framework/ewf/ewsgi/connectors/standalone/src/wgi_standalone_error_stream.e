note
	description: "[
			Error stream for the Standalone Web Server connector.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WGI_STANDALONE_ERROR_STREAM

inherit
	WGI_ERROR_STREAM

create
	make,
	make_stderr,
	make_stdout

feature {NONE} -- Initialization

	make (a_identifier: READABLE_STRING_8; a_file: PLAIN_TEXT_FILE)
		do
			identifier := a_identifier
			output := a_file
		end

	make_stderr (a_identifier: READABLE_STRING_8)
		do
			make (a_identifier, io.error)
		end

	make_stdout (a_identifier: READABLE_STRING_8)
		do
			make (a_identifier, io.error)
		end

feature -- Access

	identifier: READABLE_STRING_8

	output: FILE

feature -- Error

	put_error (a_message: READABLE_STRING_8)
		local
			s: STRING
		do
			create s.make (a_message.count + identifier.count + 4)
			s.append_character ('[')
			s.append (identifier)
			s.append_character (']')
			s.append_character (' ')
			s.append (a_message)
			s.append_character ('%N')
				-- Display it at once.
			output.put_string (s)
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
