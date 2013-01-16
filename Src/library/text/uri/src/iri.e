note
	description : "[
				Object that represent a IRI Scheme
				
				See http://en.wikipedia.org/wiki/Internationalized_Resource_Identifier
				See http://tools.ietf.org/html/rfc3987 (IRI)

			]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=IRI-RFC3987", "protocol=URI", "src=http://tools.ietf.org/html/rfc3987"
	EIS: "name=IRI-Wikipedia", "protocol=URI", "src=http://en.wikipedia.org/wiki/Internationalized_Resource_Identifier"

class
	IRI

inherit
	URI
		rename
			make_from_string as make_from_uri_string
		end

create
	make_from_string,
	make_from_uri

feature {NONE} -- Initialization

	make_from_string (a_string: READABLE_STRING_GENERAL)
			-- Make from Internationalized resource identifier text `a_string'
		note
			EIS: "name=IRI-RFC3987", "protocol=URI", "src=http://tools.ietf.org/html/rfc3987"
			EIS: "name=IRI-Wikipedia", "protocol=URI", "src=http://en.wikipedia.org/wiki/Internationalized_Resource_Identifier"
		local
			s: STRING
			l_uri_string: STRING_8
			i,n: INTEGER
			c: CHARACTER_32
			utf: UTF_CONVERTER
		do
			s := utf.utf_32_string_to_utf_8_string_8 (a_string)
			from
				i := 1
				n := s.count
				create l_uri_string.make (n)
			until
				i > n
			loop
				c := s[i]

				if
					c.is_digit
					or ('a' <= c and c <= 'z')
					or ('A' <= c and c <= 'Z')
				then
					l_uri_string.extend (c.to_character_8)
				else
					inspect c
					when
						'-', '.', '_', '~', -- unreserved characters
						':', '/', '?', '#', '[', ']', '@', -- reserved = gen-delims
						'!', '$', '&', '%'', '(', ')', '*', -- reserved = sub-delims
						'+', ',', ';', '=', -- reserved = sub-delims
						'%%' -- percent encoding ...
					then
						l_uri_string.extend (c.to_character_8)
					else
						l_uri_string.append (percent_encoded_char (c))
					end
				end
				i := i + 1
			end
			make_from_uri_string (l_uri_string)
		end

	make_from_uri (a_uri: URI)
		do
			make_from_uri_string (a_uri.string)
		end

feature -- Conversion	

	to_uri: URI
		do
			create Result.make_from_string (string)
		end

;note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
