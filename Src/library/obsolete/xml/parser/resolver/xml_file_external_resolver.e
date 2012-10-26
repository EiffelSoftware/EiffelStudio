note

	description:
		"[
			External resolver that opens files on the local filesystem

			Note: the original code is from Gobo's XM library (http://www.gobosoft.com/)
		]"
	date: "$Date$"
	revision: "$Revision$"

class XML_FILE_EXTERNAL_RESOLVER

inherit
	XML_EXTERNAL_RESOLVER

create
	make

feature {NONE} -- Initialization

	make
			-- Make.
		do
			last_error := "no stream"
		end

feature -- Action(s)

	resolve (a_system_name: STRING)
			-- Open file with corresponding name.
		local
			s: like last_stream
			e: like last_error
		do
			last_error := Void
			create {XML_FILE_INPUT_STREAM} s.make_with_filename (a_system_name)
			last_stream := s
			s.open_read
			if not s.is_open_read then
				create e.make_from_string ("cannot open input file: ")
				e.append (a_system_name)
				last_error := e
				last_stream := Void
			end
		end

feature -- Result

	last_stream: detachable XML_FILE_INPUT_STREAM
			-- File matching stream

	last_error: detachable STRING
			-- Error

	has_error: BOOLEAN
			-- Is there an error?
		do
			Result := last_error /= Void
		end

invariant
	error_or_stream: last_stream /= Void xor last_error /= Void

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
