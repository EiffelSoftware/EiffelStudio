note
	description : "[
				Object that represents an IRI Scheme
				
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
			make_from_string as make_from_uri_string,
			userinfo as uri_userinfo,
			path as uri_path, path_segments as uri_path_segments,
			query as uri_query, query_items as uri_query_items,
			fragment as uri_fragment,
			username_password as uri_username_password,
			username as uri_username, password as uri_password,
			hier as uri_hier,
			authority as uri_authority,
			string as uri_string
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
			l_uri_string: STRING_8
		do
			create l_uri_string.make (a_string.count)
			iri_into_uri (a_string, l_uri_string)
			make_from_uri_string (l_uri_string)
		end

	make_from_uri (a_uri: URI)
			-- Make Current Internationalized resource identifier from `uri' object
		do
			make_from_uri_string (a_uri.string)
		end

feature -- Access

	userinfo: detachable READABLE_STRING_32
			-- User information.
			--| username:password
			--|	RFC3986: userinfo    = *( unreserved / pct-encoded / sub-delims / ":" )
		do
			Result := to_internationalized_percent_encoded_string (uri_userinfo)
		end

	path: READABLE_STRING_32
			-- Path component containing data, usually organized in hierarchical form.
		do
			Result := to_attached_internationalized_percent_encoded_string (uri_path)
		end

	query: detachable READABLE_STRING_32
			-- Query string.
		do
			Result := to_internationalized_percent_encoded_string (uri_query)
		end

	fragment: detachable READABLE_STRING_32
			-- The fragment identifier component of a URI allows indirect
			-- identification of a secondary resource by reference to a primary
			-- resource and additional identifying information.
		do
			Result := to_internationalized_percent_encoded_string (uri_fragment)
		end

feature -- Access

	path_segments: LIST [READABLE_STRING_32]
			-- Segments composing `path'.
		do
			Result := path.split ('/')
		end

	query_items: detachable LIST [TUPLE [name: READABLE_STRING_32; value: detachable READABLE_STRING_32]]
			-- Query items composing the `query'.
		local
			lst: LIST [READABLE_STRING_32]
			i: INTEGER
		do
			if attached query as q then
				lst := q.split ('&')
				create {ARRAYED_LIST [like query_items.item]} Result.make (lst.count)
				across
					lst as e
				loop
					i := e.item.index_of ('=', 1)
					if i > 0 then
						Result.force ([e.item.substring (1, i - 1), e.item.substring (i + 1, e.item.count)])
					else
						Result.force ([e.item, Void])
					end
				end
			end
		end

feature -- Query

	hier: READABLE_STRING_32
			-- Hier part.
			-- hier-part   = "//" authority path-abempty
            --      / path-absolute
            --      / path-rootless
            --      / path-empty
		local
			s: STRING_32
		do
			create s.make (10)
			if attached authority as l_authority then
				s.append_character ('/')
				s.append_character ('/')
				s.append (l_authority)
			end
			s.append (path)
			Result := s
		end

	username_password: detachable TUPLE [username: READABLE_STRING_32; password: detachable READABLE_STRING_32]
			-- Username and password value extrated from `userinfo'.
			--| userinfo = username:password
		local
			i: INTEGER
			u,p: detachable READABLE_STRING_32
		do
			if attached userinfo as t then
				i := t.index_of (':', 1)
				if i > 0 then
					p := t.substring (i + 1, t.count)
					u := t.substring (1, i - 1)
				else
					u := t
					p := Void
				end
				Result := [u, p]
			end
		end

	username: detachable READABLE_STRING_32
			-- Eventual username.
		do
			if attached username_password as up then
				Result := up.username
			end
		end

	password: detachable READABLE_STRING_32
			-- Eventual password.
		do
			if attached username_password as up then
				Result := up.password
			end
		end

	authority: detachable READABLE_STRING_32
			-- Hierarchical element for naming authority.
			--| RFC3986: authority   = [ userinfo "@" ] host [ ":" port ]
		local
			s: STRING_32
		do
			if attached host as h then
				if attached userinfo as u then
					create s.make_from_string (u)
					s.append_character ('@')
					s.append_string_general (h)
				else
					create s.make_from_string_general (h)
				end
				if port /= 0 then
					s.append_character (':')
					s.append_integer (port)
				end
				Result := s
			else
				check not is_valid or else (userinfo = Void and port = 0) end
			end
		end

feature -- Conversion	

	string: READABLE_STRING_32
			-- String representation.
			-- scheme://username:password@hostname/path?query#fragment
		local
			s: STRING_32
		do
			if attached scheme as l_scheme and then not l_scheme.is_empty then
				create s.make_from_string_general (l_scheme)
				s.append_character (':')
			else
				create s.make_empty
			end
			s.append (hier)
			if attached query as q then
				s.append_character ('?')
				s.append (q)
			end
			if attached fragment as f then
				s.append_character ('#')
				s.append (f)
			end
			Result := s
		end

	to_uri: URI
		do
			create Result.make_from_string (uri_string)
		end

feature {NONE} -- Implementation: Internationalization

	iri_into_uri (a_string: READABLE_STRING_GENERAL; a_result: STRING_8)
		require
			is_valid_iri: True
		local
			i,n: INTEGER
			c: NATURAL_32
		do
			from
				i := 1
				n := a_string.count
			until
				i > n
			loop
				c := a_string.code (i)
				if c > 0x7F then
					-- extended ASCII and/or Unicode
					append_percent_encoded_character_code_to (c, a_result)
--				elseif c = 37 then -- '%'
--						-- Check for %u + code
--					if i + 1 <= n then
--						c := a_string.code (i + 1)
--						if c = 85 or c = 117 then -- 85 'U' 117 'u'
--							TODO: Convert it to standard percent-encoding without %U...
--						end
--					else						
--						a_result.append_code (c)
--					end
				else
					-- keep as it is
					a_result.append_code (c)
				end
				i := i + 1
			end
		end

	to_internationalized_percent_encoded_string (s: detachable READABLE_STRING_8): detachable STRING_32
			-- Convert string `s' to Internationalized Resource Identifier string
			-- Result is Void if `s' is Void.
		do
			if s /= Void then
				create Result.make (s.count)
				append_percent_encoded_string_into_internationalized_percent_encoded_string (s, Result)
			end
		end

	to_attached_internationalized_percent_encoded_string (s: READABLE_STRING_8): STRING_32
			-- Convert string `s' to Internationalized Resource Identifier string
		do
			create Result.make (s.count)
			append_percent_encoded_string_into_internationalized_percent_encoded_string (s, Result)
		end

	append_percent_encoded_string_into_internationalized_percent_encoded_string (v: READABLE_STRING_GENERAL; a_result: STRING_32)
			-- Append to `a_result' the Internationalized URL-decoded equivalent of the given percent-encoded string `v'
			-- It simply decode any percent-encoded Unicode character and kept the rest untouched
			-- "http://example.com/summer/%C3%A9t%C3%A9" will be converted to IRI "http://example.com/summer/�t�"
		local
			i,n: INTEGER
			c1,
			c: NATURAL_32
			pr: CELL [INTEGER]
		do
			from
				i := 1
				create pr.put (i)
				n := v.count
			until
				i > n
			loop
				c := v.code (i)
				inspect c
				when 43 then -- 43 '+'
						-- Some implementation are replacing spaces with "+" instead of "%20"
						-- Here fix this bad behavior
					a_result.append_code (37) -- 37 '%'
					a_result.append_code (50) -- 50 '2'
					a_result.append_code (48) -- 48 '0'
				when 37 then -- 37 '%%'
						-- An escaped character ?
					if i = n then -- Error?
						a_result.append_code (c)
					elseif i + 1 <= n then
						c1 := v.code (i + 1)
						if c1 = 85 or c1 = 117 then -- 117 'u'  85 'U'
								-- %u + UTF-32 code
							pr.replace (i)
							c1 := next_percent_decoded_character_code (v, pr)
							i := pr.item
							a_result.append_code (c1)
						else
							pr.replace (i)
							c1 := next_percent_decoded_unicode_character_code (v, pr)
							if c1 > 0x7F then
								a_result.append_code (c1)
								i := pr.item
							else
								a_result.append_code (c)
							end
						end
					end
				else
					a_result.append_code (c)
				end
				i := i + 1
			end
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
