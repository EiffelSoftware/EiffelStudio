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

	make_from_string (a_string: READABLE_STRING_8)
			-- Parse `a_string' as a URI as specified by RFC3986
			--| Note: for now the result of the parsing does not check the strict validity of each part.
			--| URI         = scheme ":" hier-part [ "?" query ] [ "#" fragment ]
		note
			EIS: "name=Syntax Components", "protocol=URI", "src=http://tools.ietf.org/html/rfc3986#section-3"
		local
			p,q: INTEGER
			s, t: STRING_8
		do
			is_valid := True
			p := a_string.index_of (':', 1)
			if p > 0 then
				set_scheme (a_string.substring (1, p - 1))
				if a_string.count > p + 1 and then a_string[p+1] = '/' and then a_string[p+2] = '/' then
						--| Starts by scheme://
						--| waiting for hierarchical part username:password@hostname:port
					p := p + 2
					q := a_string.index_of ('@', p + 1)
					if q > 0 then
							--| found user:passwd
						t := a_string.substring (p + 1, q - 1)
						set_userinfo (t)
						p := q
					end
					q := a_string.index_of ('/', p + 1)
					if q > 0 then
						t := a_string.substring (p + 1, q - 1)
					else
						q := a_string.count
						t := a_string.substring (p + 1, q)
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

				if q > 0 and q <= a_string.count then
						--| found query
					t := a_string.substring (q, a_string.count)
					q := t.index_of ('?', 1)
					if q > 0 then
						s := t.substring (1, q - 1)
						if is_valid_in_uri_string (s) then
							set_path (s)
						else
							set_path ("")
							is_valid := False
						end
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
						if is_valid_in_uri_string (t) then
							set_path (t)
						else
							set_path ("")
							is_valid := False
						end
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
			same_if_valid: is_valid and not is_corrected implies a_string.starts_with (string)
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
			if not is_valid_fragment (fragment) then
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
			-- Scheme name.
			--| scheme      = ALPHA *( ALPHA / DIGIT / "+" / "-" / "." )

	userinfo: detachable IMMUTABLE_STRING_8
			-- User information.
			--| username:password
			--|	RFC3986: userinfo    = *( unreserved / pct-encoded / sub-delims / ":" )

	host: detachable IMMUTABLE_STRING_8
			-- Host name.
			--| RFC3986: host = IP-literal / IPv4address / reg-name

	port: INTEGER
			-- Associated port, if `0' this is not defined.
			-- RFC3986: port = *DIGIT

	path: IMMUTABLE_STRING_8
			-- Path component containing data, usually organized in hierarchical form.

	query: detachable IMMUTABLE_STRING_8
			-- Query string.

	fragment: detachable IMMUTABLE_STRING_8
			-- The fragment identifier component of a URI allows indirect
			-- identification of a secondary resource by reference to a primary
			-- resource and additional identifying information.

feature -- Access

	decoded_path: READABLE_STRING_32
			-- Decoded `path'
		local
			s: STRING_32
		do
			create s.make (path.count)
			append_decoded_www_form_urlencoded_string_to (path, s)
			Result := s
		end

	path_segments: LIST [READABLE_STRING_8]
			-- Segments composing `path'.
		do
			Result := path.split ('/')
		end

	decoded_path_segments: LIST [READABLE_STRING_32]
			-- Decoded Segments composing `path'.
		local
			lst: like path_segments
		do
			lst := path_segments
			create {ARRAYED_LIST [READABLE_STRING_32]} Result.make (lst.count)
			across
				lst as e
			loop
				Result.force (decoded_www_form_urlencoded_string (e.item))
			end
		end

	query_items: detachable LIST [TUPLE [name: READABLE_STRING_8; value: detachable READABLE_STRING_8]]
			-- Query items composing the `query'.
		local
			lst: LIST [READABLE_STRING_8]
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

	decoded_query_items: detachable LIST [TUPLE [name: READABLE_STRING_32; value: detachable READABLE_STRING_32]]
			-- Decoded query items composing the `query'.	
		do
			if attached query_items as lst then
				create {ARRAYED_LIST [like decoded_query_items.item]} Result.make (lst.count)
				across
					lst as e
				loop
					if attached e.item.value as l_val then
						Result.force ([decoded_www_form_urlencoded_string (e.item.name), decoded_www_form_urlencoded_string (l_val)])
					else
						Result.force ([decoded_www_form_urlencoded_string (e.item.name), Void])
					end
				end
			end
		end

feature -- Query

	hier: READABLE_STRING_8
			-- Hier part.
			-- hier-part   = "//" authority path-abempty
            --      / path-absolute
            --      / path-rootless
            --      / path-empty
		local
			s: STRING_8
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

	username_password: detachable TUPLE [username: READABLE_STRING_8; password: detachable READABLE_STRING_8]
			-- Username and password value extrated from `userinfo'.
			--| userinfo = username:password
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
			-- Eventual username.
		do
			if attached username_password as up then
				Result := up.username
			end
		end

	password: detachable READABLE_STRING_8
			-- Eventual password.
		do
			if attached username_password as up then
				Result := up.password
			end
		end

	authority: detachable READABLE_STRING_8
			-- Hierarchical element for naming authority.
			--| RFC3986: authority   = [ userinfo "@" ] host [ ":" port ]
		local
			s: STRING_8
		do
			if attached host as h then
				if attached userinfo as u then
					create s.make_from_string (u)
					s.append_character ('@')
					s.append (h)
				else
					create s.make_from_string (h)
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

	string: READABLE_STRING_8
			-- String representation.
			-- scheme://username:password@hostname/path?query#fragment
		local
			s: STRING_8
		do
			if attached scheme as l_scheme and then not l_scheme.is_empty then
				create s.make_from_string (l_scheme)
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

	resolved_uri: URI
			-- Resolved URI, i.e remove segment-component from `path'
		local
			p: STRING_8
			lst: like path_segments
			l_first: BOOLEAN
		do
			from
				lst := path_segments
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

feature -- Comparison

	is_same_uri (a_uri: URI): BOOLEAN
			-- Is `a_uri' same as Current ?
			--| See http://en.wikipedia.org/wiki/Percent-encoding#Percent-encoding_unreserved_characters
		do
			Result := decoded_www_form_urlencoded_string (string).same_string (decoded_www_form_urlencoded_string (a_uri.string))
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

	set_userinfo (v: detachable READABLE_STRING_8)
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
					Result := is_alpha_character (string_item (s, i))
					i := 2
				until
					not Result or i > n
				loop
					c := string_item (s, i)
					Result := is_alpha_or_digit_character (c) or c = '+' or c = '-' or c = '.'
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
					c := string_item (s, i)
						-- unreserved
					if is_unreserved_character (c)
						or is_sub_delims_character (c)
						or c = ':'
					then
						-- True
					elseif c = '%%' then
						if
							i + 2 <= n and then
							is_hexa_decimal_character (string_item (s, i+ 1)) and is_hexa_decimal_character (string_item (s, i + 2))
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
				if string_item (s, 1) = '[' and string_item (s, s.count) = ']' then
					Result := True  -- IPV6 : to complete
				else
					Result := is_hexa_decimal_character (string_item (s, 1)) -- IPV4 or reg-name : to complete
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
			if s.is_empty or string_item (s, 1) = '/' then
				Result := is_valid_in_uri_string (s)
			elseif has_authority then
				if string_item (s, 1) = '/' and (s.count > 1 implies string_item (s, 2) /= '/') then
					Result := is_valid_in_uri_string (s)
				end
			elseif s.is_empty then
				Result := True
			else
				Result := is_valid_in_uri_string (s)
			end
			-- TO COMPLETE
		end

	is_valid_query (s: detachable READABLE_STRING_GENERAL): BOOLEAN
			-- 	query = *( pchar / "/" / "?" )	
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
					c := string_item (s, i)
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
							is_hexa_decimal_character (string_item (s, i + 1)) and is_hexa_decimal_character (string_item (s, i + 2))
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
					c := string_item (s, i)
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
							is_alpha_or_digit_character (string_item (s, i + 1)) and is_alpha_or_digit_character (string_item (s, i + 2))
						then
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

feature -- Helper

	string_item (s: READABLE_STRING_GENERAL; i: INTEGER): CHARACTER_32
		do
			Result := s.code (i).to_character_32
		end

	append_www_form_urlencoded_string_to (a_string: READABLE_STRING_GENERAL; a_target: STRING_GENERAL)
			-- The application/x-www-form-urlencoded encoded string for `a_string'.
			-- character encoding is UTF-8.
			-- See http://www.w3.org/TR/html5/forms.html#url-encoded-form-data
		do
			append_percent_encoded_string_to (a_string, a_target)
		end

	www_form_urlencoded_string (a_string: READABLE_STRING_GENERAL): STRING_8
			-- The application/x-www-form-urlencoded encoded string for `a_string'.
			-- character encoding is UTF-8.
			-- See http://www.w3.org/TR/html5/forms.html#url-encoded-form-data
		do
			create Result.make (a_string.count)
			append_percent_encoded_string_to (a_string, Result)
		end

	append_decoded_www_form_urlencoded_string_to (a_string: READABLE_STRING_GENERAL; a_target: STRING_GENERAL)
			-- The string decoded from application/x-www-form-urlencoded encoded string `a_string'.
			-- character encoding is UTF-8.
			-- See http://www.w3.org/TR/html5/forms.html#url-encoded-form-data
		do
			append_percent_decoded_string_to (a_string, a_target)
		end

	decoded_www_form_urlencoded_string (a_string: READABLE_STRING_GENERAL): STRING_32
			-- The string decoded from application/x-www-form-urlencoded encoded string `a_string'.
			-- character encoding is UTF-8.
			-- See http://www.w3.org/TR/html5/forms.html#url-encoded-form-data
		do
			create Result.make (a_string.count)
			append_percent_decoded_string_to (a_string, Result)
		end

feature -- Assertion helper

	is_valid_in_uri_string (s: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `s' composed only of ASCII character?
		local
			i,n: INTEGER
		do
			from
				Result := True
				i := 1
				n := s.count
			until
				not Result or i > n
			loop
				if s.code (i) > 0x7F then
					Result := False
				end
				i := i + 1
			end
		end

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
		local
			s: STRING
		do
			create s.make_empty
			s.append (string)
			Result := s
		end

;note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
