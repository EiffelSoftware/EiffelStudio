note
	description: "Summary description for {WSF_URI_MAPPING_I}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_URI_MAPPING_I

inherit
	WSF_ROUTER_MAPPING

	WSF_SELF_DOCUMENTED_ROUTER_MAPPING

feature {NONE} -- Initialization

	make (a_uri: READABLE_STRING_8; h: like handler)
		do
			set_handler (h)
			uri := a_uri
		end

	make_trailing_slash_ignored (a_uri: READABLE_STRING_8; h: like handler)
		do
			make (a_uri, h)
			trailing_slash_ignored := True
		end

feature -- Access

	associated_resource: READABLE_STRING_8
			-- Associated resource
		do
			Result := uri
		end

	uri: READABLE_STRING_8

	trailing_slash_ignored: BOOLEAN

feature -- Change

	set_handler	(h: like handler)
		deferred
		end

feature -- Documentation

	description: STRING_32 = "Is-URI"

feature -- Status

	is_mapping (a_path: READABLE_STRING_8; req: WSF_REQUEST; a_router: WSF_ROUTER): BOOLEAN
			-- <Precursor>
		local
			p: READABLE_STRING_8
			l_uri: like uri
		do
			p := a_path
			l_uri := based_uri (uri, a_router)
			if l_uri.ends_with ("/") then
				if not p.ends_with ("/") then
					p := p + "/"
				end
			else
				if p.ends_with ("/") then
					p := p.substring (1, p.count - 1)
				end
			end
			if p.same_string (l_uri) then
				Result := True
			end
		end

	try (a_path: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE; sess: WSF_ROUTER_SESSION; a_router: WSF_ROUTER)
			-- <Precursor>
		do
			if is_mapping (a_path, req, a_router) then
				sess.set_dispatched_handler (handler)
				a_router.execute_before (Current)
				execute_handler (handler, req, res)
				a_router.execute_after (Current)
			end
		end

feature {NONE} -- Execution

	execute_handler (h: like handler; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler `h' with `req' and `res' for Current mapping
		deferred
		end

feature {NONE} -- Implementation

	based_uri (a_uri: like uri; a_router: WSF_ROUTER): like uri
		local
			s: STRING_8
		do
			if attached a_router.base_url as l_base_url then
				create s.make_from_string (l_base_url)
				s.append_string (a_uri)
				Result := s
			else
				Result := a_uri
			end
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
