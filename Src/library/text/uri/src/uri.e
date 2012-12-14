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
	EIS: "name=RFC3986", "protocol=URI", "src=http://tools.ietf.org/html/rfc3986"
	EIS: "name=Wikipedia", "protocol=URI", "src=http://en.wikipedia.org/wiki/URI_scheme"

class
	URI

inherit
	ANY

	DEBUG_OUTPUT

create
	make_from_string

feature {NONE} -- Initialization

	make_from_string (s: READABLE_STRING_8)
			-- Initialize `Current'.
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

feature -- Status

	is_valid: BOOLEAN

	scheme: STRING

	username: detachable STRING

	password: detachable STRING

	hostname: detachable STRING

	port: INTEGER
			-- Associated port, if `0' this is not defined

	path: STRING

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

feature -- Output

	string: STRING_8
			-- String representation
			-- scheme://username:password@hostname/path
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
			if attached fragment as f then
				Result.append_character ('#')
				Result.append (f)
			end
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
