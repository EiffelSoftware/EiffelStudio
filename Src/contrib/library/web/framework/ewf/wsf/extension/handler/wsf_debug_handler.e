note
	description: "Handler returning debug information."

	date: "$Date$"
	revision: "$Revision$"

class
	WSF_DEBUG_HANDLER

inherit
	WSF_STARTS_WITH_HANDLER
		rename
			execute as execute_starts_with
		end

	WSF_SELF_DOCUMENTED_HANDLER

create
	make,
	make_hidden

feature {NONE} -- Initialization

	make
		do
		end

	make_hidden
		do
			make
			is_hidden := True
		end

	is_hidden: BOOLEAN
			-- Current mapped handler should be hidden from self documentation		

feature -- Documentation

	mapping_documentation (m: WSF_ROUTER_MAPPING; a_request_methods: detachable WSF_REQUEST_METHODS): WSF_ROUTER_MAPPING_DOCUMENTATION
			-- <Precursor>
		do
			create Result.make (m)
			Result.set_is_hidden (is_hidden)
			Result.add_description ("Debug handler (mainly to return request information)")
		end

feature -- Access

	execute_starts_with (a_path: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			s: STRING_8
			p: WSF_PAGE_RESPONSE
			l_len: INTEGER
			dbg: WSF_DEBUG_INFORMATION
		do
			create s.make (2048)
			s.append ("= EWF DEBUG =")
			s.append ("%N")

			create dbg.make
			dbg.set_is_verbose (True)
			dbg.set_unicode_output_enabled (True)
			dbg.append_cgi_variables_to (req, res, s)
			dbg.append_information_to (req, res, s)

			s.append ("= END =")
			s.append ("%N")


			create p.make_with_body (s)
			if
				{PLATFORM}.is_windows and then
				attached req.wgi_connector as conn and then
				is_cgi_connector (conn)
			then
					--| FIXME: the CGI connector add %R for any single %N character, so update the Content-Length accordingly.
					-- Dirty hack to handle correctly CGI on Windows, since it seems "abc%N" will be sent as "abc%R%N"
				l_len := 0
				across s as ic loop
					if ic.item = '%R' then
						l_len := l_len + 1
						ic.forth
						if
							not ic.after and then
							ic.item = '%N'
						then
							l_len := l_len + 1
						end
					elseif ic.item = '%N' then
						l_len := l_len + 2 -- %R will be added by the CGI connector...
					else
						l_len := l_len + 1
					end
				end
			else
				l_len := s.count
			end

			p.header.put_content_length (l_len)
			p.header.put_content_type_utf_8_text_plain
			res.send (p)
		end

	is_cgi_connector (conn: separate WGI_CONNECTOR): BOOLEAN
		local
			s: STRING
		do
			create s.make_from_separate (conn.name)
			Result := s.is_case_insensitive_equal_general ("cgi")
		end


note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
