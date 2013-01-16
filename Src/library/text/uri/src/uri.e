note
	description : "[
				Object that represent a URI Scheme
				
				See http://en.wikipedia.org/wiki/URI_scheme
				See http://en.wikipedia.org/wiki/Uniform_resource_identifier
				See http://en.wikipedia.org/wiki/Uniform_resource_locator
				See http://tools.ietf.org/html/rfc3986 (URI)

				Global syntax element:
				   pchar         = unreserved / pct-encoded / sub-delims / ":" / "@"
				   pct-encoded   = "%" HEXDIG HEXDIG
				   unreserved    = ALPHA / DIGIT / "-" / "." / "_" / "~"
				   reserved      = gen-delims / sub-delims
				   gen-delims    = ":" / "/" / "?" / "#" / "[" / "]" / "@"
				   sub-delims    = "!" / "$" / "&" / "'" / "(" / ")"
				                 / "*" / "+" / "," / ";" / "="
			]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=URI-RFC3986 Generic syntax", "protocol=URI", "src=http://tools.ietf.org/html/rfc3986"
	EIS: "name=URI-Wikipedia", "protocol=URI", "src=http://en.wikipedia.org/wiki/URI_scheme"
	EIS: "name=IRI-RFC3987", "protocol=URI", "src=http://tools.ietf.org/html/rfc3987"
	EIS: "name=IRI-Wikipedia", "protocol=URI", "src=http://en.wikipedia.org/wiki/Internationalized_Resource_Identifier"
	EIS: "name=Percent-encoding", "protocol=URI", "src=http://en.wikipedia.org/wiki/Percent-encoding"

	EIS: "name=url-RFC1738", "protocol=URI", "src=http://tools.ietf.org/html/rfc1738"
	EIS: "name=mailto-RFC2368", "protocol=URI", "src=http://tools.ietf.org/html/rfc2368"
	EIS: "name=ipv6-RFC2373", "protocol=URI", "src=http://tools.ietf.org/html/rfc2373"
	EIS: "name=ipv6-RFC2373 in URL", "protocol=URI", "src=http://tools.ietf.org/html/rfc2732"


class
	URI

inherit
	ANY

	PERCENT_ENCODER
		export
			{NONE} all
		end

	DEBUG_OUTPUT

create
	make_from_string

feature {NONE} -- Initialization

	make_from_string (s: READABLE_STRING_8)
			-- Parse `s' as a URI as specified by RFC3986
			--| Note: for now the result of the parsing does not check the strict validity of each part.
			--| URI         = scheme ":" hier-part [ "?" query ] [ "#" fragment ]
		note
			EIS: "name=Syntax Components", "protocol=URI", "src=http://tools.ietf.org/html/rfc3986#section-3"
		local
			p,q: INTEGER
			t: STRING_8
		do
			is_valid := True
			p := s.index_of (':', 1)
			if p > 0 then
				set_scheme (s.substring (1, p - 1))
				if s.count > p + 1 and then s[p+1] = '/' and then s[p+2] = '/' then
						--| Starts by scheme://
						--| waiting for hierarchical part username:password@hostname:port
					p := p + 2
					q := s.index_of ('@', p + 1)
					if q > 0 then
						--| found user:passwd
						t := s.substring (p + 1, q - 1)
						set_userinfo (t)
						p := q
					end
					q := s.index_of ('/', p + 1)
					if q > 0 then
						t := s.substring (p + 1, q - 1)
					else
						q := s.count
						t := s.substring (p + 1, q)
						q := 0 --| end of processing						
					end
					if not t.is_empty and then t[1] = '[' then
						p := t.index_of (']', 2)
						if p > 0 then
							p := t.index_of (':', p + 1)
						else
							is_valid := False
						end
					else
						p := t.index_of (':', 1)
					end
					if p > 0 then
						set_hostname (t.substring (1, p - 1))
						t.remove_head (p)
						if t.is_integer then
							set_port (t.to_integer)
						else
							set_port (0)
							is_valid := False
						end
					else
						set_hostname (t)
						set_port (0)
					end
				else
					--| Keep eventual '/'  as part of the path
					q := p + 1
					set_hostname (Void)
				end

				if q > 0 and q <= s.count then
					--| found query
					t := s.substring (q, s.count)
					q := t.index_of ('?', 1)
					if q > 0 then
						set_path (t.substring (1, q - 1))
						t.remove_head (q)
						q := t.index_of ('#', 1)
						if q > 0 then
							set_query (t.substring (1, q - 1))
							t.remove_head (q)
							set_fragment (t)
						else
							set_query (t)
						end
					else
						set_path (t)
					end
				else
					set_path ("")
				end
			else
				set_scheme ("")
				set_hostname (Void)
				set_path ("")
			end
			if is_valid then
				check_validity (True)
			end
		ensure
			same_if_valid: is_valid and not is_corrected implies s.starts_with (string)
		end

feature -- Basic operation		

	check_validity (a_fixing: BOOLEAN)
			-- Check validity of URI
			-- If `a_fixing' is True, attempt to correct input URI.
		local
			s: STRING_8
		do
			-- check scheme
			--		TODO: RFC3986: scheme = ALPHA *( ALPHA / DIGIT / "+" / "-" / "." )
			if not is_valid_scheme (scheme) then
				is_valid := False
			end

			-- check userinfo
			--		TODO: RFC3986: userinfo = *( unreserved / pct-encoded / sub-delims / ":" )
			if not is_valid_userinfo (userinfo) then
				is_valid := False
			end

			-- check host
			-- 		TODO: RFC3986: host = IP-literal / IPv4address / reg-name
			if not is_valid_host (host) then
				is_valid := False
			end

			-- Check path
			-- 		TODO: no space, all character well escaped, ...
			if path.has (' ') then
					-- Fix bad URI
				if a_fixing then
					create s.make_from_string (path)
					s.replace_substring_all (" ", "%%20")
					set_path (s)
					is_corrected := True
				end
			end
			if not is_valid_path (path) then
				is_valid := False
			end

			-- Check query
			-- 		TODO: no space, all character well escaped, ...			
			if attached query as q then
				if q.has (' ') then
						-- Fix bad URI						
					if a_fixing then
						create s.make_from_string (q)
						s.replace_substring_all (" ", "%%20")
						set_query (s)
						is_corrected := True
					else
						is_valid := False
					end
				end
			end
			if not is_valid_query (query) then
				is_valid := True
			end

			-- Check fragment
			if is_valid_fragment (fragment) then
				is_valid := False
			end
		end

feature -- Status

	is_valid: BOOLEAN
			-- Is Current valid?

	is_corrected: BOOLEAN
			-- Is Current valid after eventual correction?

	has_authority: BOOLEAN
		do
			Result := host /= Void
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

	scheme: IMMUTABLE_STRING_8
			-- scheme name.
			--| scheme      = ALPHA *( ALPHA / DIGIT / "+" / "-" / "." )

	userinfo: detachable STRING_8
			--| username:password
			--|	RFC3986: userinfo    = *( unreserved / pct-encoded / sub-delims / ":" )

	host: detachable IMMUTABLE_STRING_8
			--| RFC3986: host = IP-literal / IPv4address / reg-name

	port: INTEGER
			-- Associated port, if `0' this is not defined
			-- RFC3986: port = *DIGIT

	path: IMMUTABLE_STRING_8
			-- The path component contains data, usually organized in hierarchical form

	path_components: LIST [IMMUTABLE_STRING_8]
		do
			Result := path.split ('/')
		end

	decoded_path: STRING_32
			-- Decoded `path'
		do
			Result := percent_decoded_string (path)
		end

	query: detachable IMMUTABLE_STRING_8

	fragment: detachable IMMUTABLE_STRING_8

	split: TABLE_ITERABLE [detachable READABLE_STRING_8, READABLE_STRING_GENERAL]
		local
			l_port: detachable STRING_8
			tb: STRING_TABLE [detachable READABLE_STRING_8]
		do
			if port = 0 then
			else
				create l_port.make (5)
				l_port.append_integer (port)
			end
			create tb.make (5)
			tb.put (scheme, "scheme")
			tb.put (userinfo, "userinfo")
			tb.put (host, "host")
			tb.put (l_port, "port")
			tb.put (path, "path")
			tb.put (query, "query")
			tb.put (fragment, "fragment")
			Result := tb
		end

feature -- Query

	hier: STRING_8
			-- hier-part   = "//" authority path-abempty
            --      / path-absolute
            --      / path-rootless
            --      / path-empty
		do
			create Result.make (10)
			if attached authority as l_authority then
				Result.append_character ('/')
				Result.append_character ('/')
				Result.append (l_authority)
			end
			Result.append (path)
		end

	username_password: detachable TUPLE [username: READABLE_STRING_8; password: detachable READABLE_STRING_8]
			-- userinfo = username:password
		local
			i: INTEGER
			u,p: detachable READABLE_STRING_8
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

	username: detachable READABLE_STRING_8
		do
			if attached username_password as up then
				Result := up.username
			end
		end

	password: detachable READABLE_STRING_8
		do
			if attached username_password as up then
				Result := up.password
			end
		end

	authority: detachable STRING_8
			-- Hierarchical element for naming authority
			--| RFC3986: authority   = [ userinfo "@" ] host [ ":" port ]
		do
			if attached host as h then
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
			if attached scheme as s and then not s.is_empty then
				create Result.make_from_string (scheme)
				Result.append_character (':')
			else
				create Result.make_empty
			end
			Result.append (hier)
			if attached query as q then
				Result.append_character ('?')
				Result.append (q)
			end
		end

feature -- Query

	resolved_uri: URI
			-- Resolve path, i.e remove segment-component
		local
			p: STRING_8
			lst: like path_components
			l_first: BOOLEAN
		do
			from
				lst := path_components
				lst.start
			until
				lst.off
			loop
				if lst.item.same_string (".") then
					lst.remove
				elseif lst.item.same_string ("..") then
					lst.back
					if not lst.before then
						lst.remove
						lst.remove
					else
						lst.forth
						lst.remove
					end
				else
					lst.forth
				end
			end
			create p.make (path.count)
			l_first := True
			across
				lst as c
			loop
				if l_first then
					l_first := False
				else
					p.append_character ('/')
				end
				p.append (c.item)
			end
			if p.is_empty then
			else
				if p.item (1) /= '/' then
					if not path.is_empty and then path.item (1) = '/' then
						p.prepend_character ('/')
					end
				end
			end
			create Result.make_from_string (string)
			Result.set_path (p)
		end

feature -- Element Change

	set_scheme (v: READABLE_STRING_8)
			-- Set `scheme' to `v'
		require
			is_valid_scheme (v)
		do
			create scheme.make_from_string (v)
		ensure
			scheme_set: scheme.same_string (v)
		end

	set_userinfo (v: detachable READABLE_STRING_GENERAL)
		require
			is_valid_userinfo (v)
		do
			if v = Void then
				userinfo := Void
			else
				create userinfo.make_from_string (v.as_string_8)
			end
		ensure
			userinfo_set: is_same_string (v, userinfo)
		end

	set_hostname (v: detachable READABLE_STRING_8)
			-- Set `host' to `v'
		require
			is_valid_host (v)
		do
			if v = Void then
				host := Void
			else
				create host.make_from_string (v)
			end
		ensure
			hostname_set: is_same_string (v, host)
		end

	set_port (v: like port)
			-- Set `port' to `v'
		do
			port := v
		ensure
			port_set: port = v
		end

	set_path (a_path: READABLE_STRING_8)
			-- Set `path' to `a_path'	
		require
			is_valid_path (a_path)
		do
			create path.make_from_string (a_path)
		ensure
			path_set: path.same_string_general (a_path)
		end

	set_query (v: detachable READABLE_STRING_8)
			-- Set `query' to `v'
		require
			is_valid_query (v)
		do
			if v = Void then
				query := Void
			else
				create query.make_from_string (v)
			end
		ensure
			query_set: is_same_string (v, query)
		end

	set_fragment (v: detachable READABLE_STRING_8)
			-- Set `fragment' to `v'
		require
			is_valid_fragment (v)
		do
			if v = Void then
				fragment := Void
			else
				create fragment.make_from_string (v)
			end
		ensure
			fragment_set: is_same_string (v, fragment)
		end

feature -- Change: query

	remove_query
			-- Remove query from Current URI
		do
			query := Void
		end

	add_query_parameter (a_name: READABLE_STRING_GENERAL; a_value: detachable READABLE_STRING_GENERAL)
			-- Add non percent-encoded parameters
		local
			q: detachable STRING
		do
			if attached query as l_query then
				create q.make_from_string (l_query)
			else
				create q.make_empty
			end
			if not q.is_empty then
				q.append_character ('&')
			end

			q.append (www_form_urlencoded_string (a_name))
			if a_value /= Void then
				q.append_character ('=')
				q.append (www_form_urlencoded_string (a_value))
			end
			create query.make_from_string (q)
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
		do
			across
				tb as c
			loop
				add_query_parameter (c.key, c.item)
			end
		end

feature -- Status report

	is_valid_scheme (s: READABLE_STRING_GENERAL): BOOLEAN
			-- 		scheme = ALPHA *( ALPHA / DIGIT / "+" / "-" / "." )
		local
			i,n: INTEGER
			c: CHARACTER_32
		do
			if s.is_empty then
				Result := False -- Check for URI-reference ..
			else
				from
					i := 1
					n := s.count
					Result := s.item (i).is_alpha
					i := 2
				until
					not Result or i > n
				loop
					c := s.item (i)
					Result := c.is_alpha or c.is_digit or c = '+' or c = '-' or c = '.'
					i := i + 1
				end
			end
		end

	is_valid_userinfo (s: detachable READABLE_STRING_GENERAL): BOOLEAN
			--		userinfo = *( unreserved / pct-encoded / sub-delims / ":" )
		local
			i,n: INTEGER
			c: CHARACTER_32
		do
			Result := True
			if s /= Void then
				from
					i := 1
					n := s.count
				until
					not Result or i > n
				loop
					c := s.item (i)
					-- unreserved
					if is_unreserved_character (c)
						or is_sub_delims_character (c)
						or c = ':'
					then
						-- True
					elseif c = '%%' then
						if
							i + 2 <= n and then
							s.item (i + 1).is_hexa_digit and s.item (i + 2).is_hexa_digit
						then
							-- True
							i := i + 2
						else
							Result := False
						end
					else
						Result := False
					end
					i := i + 1
				end
			end
		end

	is_valid_host (s: detachable READABLE_STRING_GENERAL): BOOLEAN
			--		host = IP-literal / IPv4address / reg-name
			-- 		IP-literal = "[" ( IPv6address / IPvFuture  ) "]"
			-- 		IPvFuture  = "v" 1*HEXDIG "." 1*( unreserved / sub-delims / ":" )
			--      IPv6address =                            6( h16 ":" ) ls32
			--                  /                       "::" 5( h16 ":" ) ls32
			--                  / [               h16 ] "::" 4( h16 ":" ) ls32
			--                  / [ *1( h16 ":" ) h16 ] "::" 3( h16 ":" ) ls32
			--                  / [ *2( h16 ":" ) h16 ] "::" 2( h16 ":" ) ls32
			--                  / [ *3( h16 ":" ) h16 ] "::"    h16 ":"   ls32
			--                  / [ *4( h16 ":" ) h16 ] "::"              ls32
			--                  / [ *5( h16 ":" ) h16 ] "::"              h16
			--                  / [ *6( h16 ":" ) h16 ] "::"
			--
			--      ls32        = ( h16 ":" h16 ) / IPv4address
			--                  ; least-significant 32 bits of address
			--
			--      h16         = 1*4HEXDIG
			--                  ; 16 bits of address represented in hexadecimal			
			--
			--      IPv4address = dec-octet "." dec-octet "." dec-octet "." dec-octet
			--
			--      dec-octet   = DIGIT                 ; 0-9
			--                  / %x31-39 DIGIT         ; 10-99
			--                  / "1" 2DIGIT            ; 100-199
			--                  / "2" %x30-34 DIGIT     ; 200-249
			--                  / "25" %x30-35          ; 250-255
			--
			--		reg-name    = *( unreserved / pct-encoded / sub-delims )			
		do
			Result := True
			if s /= Void and then not s.is_empty then
				if s.item (1) = '[' and s.item (s.count) = ']' then
					Result := True  -- IPV6 : to complete
				else
					Result := s.item (1).is_alpha_numeric -- IPV4 or reg-name : to complete
				end
			end
		end

	is_valid_path (s: READABLE_STRING_GENERAL): BOOLEAN
			--      path          = path-abempty    ; begins with "/" or is empty
			--                    / path-absolute   ; begins with "/" but not "//"
			--                    / path-noscheme   ; begins with a non-colon segment
			--                    / path-rootless   ; begins with a segment
			--                    / path-empty      ; zero characters
			--
			--      path-abempty  = *( "/" segment )
			--      path-absolute = "/" [ segment-nz *( "/" segment ) ]
			--      path-noscheme = segment-nz-nc *( "/" segment )
			--      path-rootless = segment-nz *( "/" segment )
			--      path-empty    = 0<pchar>		
			--      segment       = *pchar
			--      segment-nz    = 1*pchar
			--      segment-nz-nc = 1*( unreserved / pct-encoded / sub-delims / "@" )
			--                    ; non-zero-length segment without any colon ":"
			--
			--      pchar         = unreserved / pct-encoded / sub-delims / ":" / "@"			
		do
			if s.is_empty or s.item (1) = '/' then
				Result := True
			elseif has_authority then
				if s.item (1) = '/' and (s.count > 1 implies s.item (2) /= '/') then
					Result := True
				end
			elseif scheme.is_empty then
				Result := True
			elseif s.item (1).is_alpha_numeric then
				Result := True
			else
				--...
			end
			-- TO COMPLETE
		end

	is_valid_query (s: detachable READABLE_STRING_GENERAL): BOOLEAN
			--query = *( pchar / "/" / "?" )	
		local
			i,n: INTEGER
			c: CHARACTER_32
		do
			Result := True
			if s /= Void then
				from
					i := 1
					n := s.count
				until
					not Result or i > n
				loop
					c := s.item (i)
					-- pchar = unreserved / pct-encoded / sub-delims / ":" / "@"	
					if -- pchar
						is_unreserved_character (c)
						or is_sub_delims_character (c)
						or c = ':' or c = '@'
					then
						Result := True
					elseif c = '/' or c = '?' then
						Result := True
					elseif c = '%%' then
						if
							i + 2 <= n and then
							s.item (i + 1).is_hexa_digit and s.item (i + 2).is_hexa_digit
						then
							-- True
							i := i + 2
						else
							Result := False
						end
					else
						Result := False
					end
					i := i + 1
				end
			end
		end

	is_valid_fragment (s: detachable READABLE_STRING_GENERAL): BOOLEAN
			--fragment = *( pchar / "/" / "?" )	
		local
			i,n: INTEGER
			c: CHARACTER_32
		do
			Result := True
			if s /= Void then
				from
					i := 1
					n := s.count
				until
					not Result or i > n
				loop
					c := s.item (i)
					-- pchar = unreserved / pct-encoded / sub-delims / ":" / "@"	
					if -- pchar
						is_unreserved_character (c)
						or is_sub_delims_character (c)
						or c = ':' or c = '@'
					then
						Result := True
					elseif c = '/' or c = '?' then
						Result := True
					elseif c = '%%' then
						if
							i + 2 <= n and then
							s.item (i + 1).is_hexa_digit and s.item (i + 2).is_hexa_digit
						then
							-- True
							i := i + 2
						else
							Result := False
						end
					else
						Result := False
					end
					i := i + 1
				end
			end
		end

feature {NONE} -- Status report

	is_unreserved_character (c: CHARACTER_32): BOOLEAN
			-- unreserved  = ALPHA / DIGIT / "-" / "." / "_" / "~"
		do
			if c.is_alpha or c.is_digit then
				Result := True
			else
				inspect c
				when '-', '.', '_', '~' then -- unreserved
					Result := True
				else
				end
			end
		end

	is_reserved_character (c: CHARACTER_32): BOOLEAN
			-- reserved    = gen-delims / sub-delims
		do
			Result := is_gen_delims_character (c) or is_sub_delims_character (c)
		end

	is_gen_delims_character (c: CHARACTER_32): BOOLEAN
			-- gen-delims  = ":" / "/" / "?" / "#" / "[" / "]" / "@"	
		do
			inspect c
			when ':' , ',' , '?' , '#' , '[' , ']' , '@' then
				Result := True
			else
			end
		end

	is_sub_delims_character (c: CHARACTER_32): BOOLEAN
			-- sub-delims  = "!" / "$" / "&" / "'" / "(" / ")"
            --				   / "*" / "+" / "," / ";" / "="
		do
			inspect c
			when '!' , '$' , '&' , '%'' , '(' , ')' , '*' , '+' , ',' , ';' , '=' then -- sub-delims
				Result := True
			else
			end
		end

feature -- Helper		

	www_form_urlencoded_string (a_string: READABLE_STRING_GENERAL): STRING_8
			-- The application/x-www-form-urlencoded encoded string for `a_string'.
			-- character encoding is UTF-8.
			-- See http://www.w3.org/TR/html5/forms.html#url-encoded-form-data
		do
			Result := percent_encoded_string (a_string)
		end

	decoded_www_form_urlencoded_string (a_string: READABLE_STRING_8): READABLE_STRING_32
			-- The string decoded from application/x-www-form-urlencoded encoded string `a_string'.
			-- character encoding is UTF-8.
			-- See http://www.w3.org/TR/html5/forms.html#url-encoded-form-data
		do
			Result := percent_decoded_string (a_string)
		end

feature -- Assertion helper

	is_same_string (s1, s2: detachable READABLE_STRING_GENERAL): BOOLEAN
			-- `s1' and `s2' have same string content?
		do
			if s1 = Void then
				Result := s2 = Void
			elseif s2 = Void then
				Result := False
			else
				Result := s1.same_string (s2)
			end
		end

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make_empty
			Result.append (string)
		end

invariant
	valid_scheme: is_valid implies is_valid_scheme (scheme)
	valid_path: is_valid implies is_valid_path (path)

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
