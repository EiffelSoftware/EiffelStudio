note
	description : "[
				Object that represent a URI Scheme
				
				See http://en.wikipedia.org/wiki/URI_scheme
				See http://en.wikipedia.org/wiki/Uniform_resource_identifier
				See http://en.wikipedia.org/wiki/Uniform_resource_locator
				See http://tools.ietf.org/html/rfc3986 (URI)

			]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=URI-RFC3986", "protocol=URI", "src=http://tools.ietf.org/html/rfc3986"
	EIS: "name=URI-Wikipedia", "protocol=URI", "src=http://en.wikipedia.org/wiki/URI_scheme"
	EIS: "name=IRI-RFC3987", "protocol=URI", "src=http://tools.ietf.org/html/rfc3987"
	EIS: "name=IRI-Wikipedia", "protocol=URI", "src=http://en.wikipedia.org/wiki/Internationalized_Resource_Identifier"
	EIS: "name=Percent-encoding", "protocol=URI", "src=http://en.wikipedia.org/wiki/Percent-encoding"


class
	URI

inherit
	ANY

	DEBUG_OUTPUT

create
	make_from_string,
	make_from_iri_string

feature {NONE} -- Initialization

	make_from_string (s: READABLE_STRING_8)
			-- Initialize `Current'.
		note
			EIS: "name=Syntax Components", "protocol=URI", "src=http://tools.ietf.org/html/rfc3986#section-3"
		local
			p,q: INTEGER
			t: STRING_8
		do
			p := s.index_of (':', 1)
			if p > 0 then
				scheme := s.substring (1, p - 1)
				is_valid := True
				if s.count > p + 1 and then s[p+1] = '/' and then s[p+2] = '/' then
						--| Starts by scheme://
						--| waiting for hierarchical part username:password@hostname:port
					p := p + 2
					q := s.index_of ('@', p + 1)
					if q > 0 then
						--| found user:passwd
						t := s.substring (p + 1, q - 1)
						p := t.index_of (':', 1)
						if p > 0 then
							password := t.substring (p + 1, t.count)
							t.keep_head (p - 1)
							username := t
						else
							username := t
							password := Void
						end
						p := q
					end
					q := s.index_of ('/', p + 1)
					if q > 0 then
						t := s.substring (p + 1, q - 1)
--						q := q + 1 --| exclude the '/' from potential path
					else
						q := s.count
						t := s.substring (p + 1, q)
						q := 0 --| end of processing						
					end
					p := t.index_of (':', 1)
					if p > 0 then
						hostname := t.substring (1, p - 1)
						t.remove_head (p)
						if t.is_integer then
							port := t.to_integer
						else
							port := 0
							is_valid := False
						end
					else
						hostname := t
						port := 0
					end
				else
					--| Keep eventual '/'  as part of the path
					q := p + 1
					hostname := Void
				end

				if q > 0 and q <= s.count then
					--| found query
					t := s.substring (q, s.count)
					q := t.index_of ('?', 1)
					if q > 0 then
						path := t.substring (1, q - 1)
						t.remove_head (q)
						q := t.index_of ('#', 1)
						if q > 0 then
							query := t.substring (1, q - 1)
							t.remove_head (q)
							fragment := t
						else
							query := t
						end
					else
						path := t
					end
				else
					path := ""
				end
--				else
--					--| urn:example:foo:bar ... as urn:path
--					hostname := ""
--					path := s.substring (p + 1, s.count)
--				end
			else
				scheme := ""
				hostname := Void
				path := ""
			end
		ensure
			same_if_valid: is_valid implies s.starts_with (string)
		end

	make_from_iri_string (a_iri: READABLE_STRING_GENERAL)
			-- Make from Internationalized resource identifier text `s'
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
			s := utf.utf_32_string_to_utf_8_string_8 (a_iri)
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
			make_from_string (l_uri_string)
		end

feature -- Status

	is_valid: BOOLEAN

	has_authority: BOOLEAN
		do
			Result := hostname /= Void
		end

	has_query: BOOLEAN
		do
			Result := query /= Void
		end

	has_path: BOOLEAN
		do
			Result := not path.is_empty
		end

	has_fragment: BOOLEAN
		do
			Result := fragment /= Void
		end

feature -- Access

	scheme: STRING

	username: detachable STRING

	password: detachable STRING

	hostname: detachable STRING

	port: INTEGER
			-- Associated port, if `0' this is not defined

	path: STRING

	decoded_path: STRING_32
		do
			Result := percent_decoded_string (path)
		end

	query: detachable STRING

	fragment: detachable STRING

feature -- Query

	userinfo: detachable STRING
			--| username:password
		do
			if attached username as u then
				create Result.make_from_string (u)
				if attached password as p then
					Result.append_character (':')
					Result.append (p)
				end
			else
				check is_valid implies password = Void end
			end
		end

	authority: detachable STRING
			--| username:password@hostname:port
		do
			if attached hostname as h then
				if attached userinfo as u then
					create Result.make_from_string (u)
					Result.append_character ('@')
					Result.append (h)
				else
					create Result.make_from_string (h)
				end
				if port /= 0 then
					Result.append_character (':')
					Result.append_integer (port)
				end
			else
				check not is_valid or else (userinfo = Void and port = 0) end
			end
		end

feature -- Change

	add_query_parameter (a_name: READABLE_STRING_GENERAL; a_value: detachable READABLE_STRING_GENERAL)
			-- Add non percent-encoded parameters
		local
			q: detachable STRING
		do
			q := query
			if q = Void then
				create q.make_empty
			end
			if not q.is_empty then
				q.append_character ('&')
			end

			q.append (percent_encoded_string (a_name))
			if a_value /= Void then
				q.append_character ('=')
				q.append (percent_encoded_string (a_value))
			end
			query := q
		end

	add_query_parameters (lst: ITERABLE [TUPLE [name: READABLE_STRING_GENERAL; value: detachable READABLE_STRING_GENERAL]])
			-- Add non percent-encoded parameters from manifest
		do
			across
				lst as c
			loop
				add_query_parameter (c.item.name, c.item.value)
			end
		end

	add_query_parameters_from_table (tb: TABLE_ITERABLE [detachable READABLE_STRING_GENERAL, READABLE_STRING_GENERAL])
			-- Add non percent-encoded parameters from table
		local
			q: detachable STRING
		do
			across
				tb as c
			loop
				add_query_parameter (c.key, c.item)
			end
		end


feature -- Conversion

	string: STRING_8
			-- String representation
			-- scheme://username:password@hostname/path?query#fragment
		do
			create Result.make_from_string (uri_string)
			if attached fragment as f then
				Result.append_character ('#')
				Result.append (f)
			end
		end

	uri_string: STRING_8
			-- String representation without `fragment'
			-- scheme://username:password@hostname/path?query
		do
			create Result.make_from_string (scheme)
			Result.append_character (':')
			if attached authority as a then
				Result.append ("//")
				Result.append (a)
			end
			Result.append (path)
			if attached query as q then
				Result.append_character ('?')
				Result.append (q)
			end
		end

feature {NONE} -- Implementation

	percent_encoded_string (a_string: READABLE_STRING_GENERAL): STRING_8
		local
			s: STRING_8
			c: CHARACTER_32
			utf: UTF_CONVERTER
			i,n: INTEGER
		do
			s := utf.utf_32_string_to_utf_8_string_8 (a_string)
			from
				i := 1
				n := s.count
				create Result.make (n)
			until
				i > n
			loop
				c := s[i]

				if
					c.is_digit
					or ('a' <= c and c <= 'z')
					or ('A' <= c and c <= 'Z')
				then
					Result.extend (c.to_character_8)
				else
					inspect c
					when
						'-', '.', '_', '~' -- unreserved characters
					then
						Result.extend (c.to_character_8)
					else
						Result.append (percent_encoded_char (c))
					end
				end
				i := i + 1
			end
		end

	percent_encoded_char (a_code: CHARACTER_32): STRING_8
		do
			create Result.make (3)
			Result.extend ('%%')
			Result.append (a_code.natural_32_code.to_hex_string)
			from
			until
				Result.count < 2 or else Result[2] /= '0'
			loop
				Result.remove (2)
			end
		ensure
			exists: Result /= Void
		end

	percent_decoded_string (v: READABLE_STRING_8): STRING_32
			-- The URL-decoded equivalent of the given string
		local
			s: STRING_8
			i, n: INTEGER
			c: CHARACTER
			pr: CELL [INTEGER]
			changed: BOOLEAN
			has_error: BOOLEAN -- useless
			utf: UTF_CONVERTER
		do
			has_error := False
			n := v.count
			create s.make (n)
			from i := 1
			until i > n
			loop
				c := v.item (i)
				inspect c
				when '%%' then
					-- An escaped character ?
					if i = n then
						s.append_character (c)
					else
						changed := True
						create pr.put (i)
						s.append (percent_decoded_char (v, pr))
						i := pr.item
					end
				else
					s.append_character (c)
				end
				i := i + 1
			end
			Result := utf.utf_8_string_8_to_string_32 (s)
		end

	percent_decoded_char (buf: READABLE_STRING_8; posr: CELL [INTEGER]): STRING_8
			-- Character(s) resulting from decoding the URL-encoded string
		require
			stream_exists: buf /= Void
			posr_exists: posr /= Void
			valid_start: posr.item <= buf.count
		local
			c: CHARACTER
			i, n: INTEGER
			not_a_digit: BOOLEAN
			ascii_pos: NATURAL_32
			ival: INTEGER_32
			pos: INTEGER
			uc_s32: STRING_32
			utf: UTF_CONVERTER
		do
				--| pos is index in stream of escape character ('%')
			pos := posr.item
			create Result.make (4)
			if buf.item (pos + 1) = 'u' then
				-- NOTE: this is not a standard, but it can occurs, so use this for decoding only
				-- An escaped Unicode (ucs2) value, from ECMA scripts
				-- Has the form: %u<n> where <n> is the UCS value
				-- of the character (two byte integer, one to 4 chars
				-- after escape sequence).
				-- UTF-8 result can be 1 to 4 characters
				n := buf.count
				from i := pos + 2
				until (i > n) or not_a_digit
				loop
					c := buf.item (i)
					if c.is_hexa_digit then
						ival := ival * 16
						if c.is_digit then
							ival := ival + (c |-| '0')
						else
							ival := ival + (c.upper |-| 'A') + 10
						end
						i := i + 1
					else
						not_a_digit := True
						i := i - 1
					end
				end
				posr.replace (i)
				-- ival is now UCS2 value; needs conversion to UTF8
				create uc_s32.make (1)
				uc_s32.append_character (ival.to_character_32)
				Result.append (utf.utf_32_string_to_utf_8_string_8 (uc_s32))
			else
				-- ASCII char?
				ascii_pos := hexadecimal_string_to_natural_32 (buf.substring (pos+1, pos+2))
				if {NATURAL_32} 0x80 <= ascii_pos and ascii_pos <= {NATURAL_32} 0xff then
					-- Might be improperly escaped
					Result.append_code (ascii_pos)
					posr.replace (pos + 2)
				else
					Result.append_code (ascii_pos)
					posr.replace (pos + 2)
				end
			end
		ensure
			exists: Result /= Void
		end

	is_hexa_decimal (a_string: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_string' a valid hexadecimal sequence?
		local
			l_convertor: like ctoi_convertor
		do
			l_convertor := ctoi_convertor
			l_convertor.reset ({NUMERIC_INFORMATION}.type_natural_32)
			l_convertor.parse_string_with_type (a_string, {NUMERIC_INFORMATION}.type_natural_32)
			Result := l_convertor.is_integral_integer
		end

	hexadecimal_string_to_natural_32 (a_hex_string: READABLE_STRING_GENERAL): NATURAL_32
			-- Convert hexadecimal value `a_hex_string' to its corresponding NATURAL_32 value.
		require
			is_hexa: is_hexa_decimal (a_hex_string)
		local
			l_convertor: like ctoi_convertor
		do
			l_convertor := ctoi_convertor
			l_convertor.parse_string_with_type (a_hex_string, {NUMERIC_INFORMATION}.type_no_limitation)
			Result := l_convertor.parsed_natural_32
		end

	ctoi_convertor: HEXADECIMAL_STRING_TO_INTEGER_CONVERTER
			-- Convertor used to convert string to integer or natural
		once
			create Result.make
			Result.set_leading_separators_acceptable (False)
			Result.set_trailing_separators_acceptable (False)
		ensure
			ctoi_convertor_not_void: Result /= Void
		end

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make_empty
			Result.append (string)
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
