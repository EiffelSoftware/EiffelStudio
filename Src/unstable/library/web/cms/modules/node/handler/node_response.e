note
	description: "Generic CMS Response for a CMS NODE."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NODE_RESPONSE

inherit
	CMS_RESPONSE
		rename
			make as make_response
		end

feature {NONE} -- Initialization

	make (req: WSF_REQUEST; res: WSF_RESPONSE; a_api: like api; a_node_api: like node_api)
		do
			node_api := a_node_api
			make_response (req, res, a_api)
		end

feature -- Access

	node_api: CMS_NODE_API
			-- Associated node API.

feature -- Helpers

	node_id_path_parameter: INTEGER_64
			-- Node id passed as path parameter for request `request'.
		local
			s: READABLE_STRING_GENERAL
		do
			if attached {WSF_STRING} request.path_parameter ("id") as p_nid then
				s := p_nid.value
				if s.is_integer_64 then
					Result := s.to_integer_64
				end
			end
		end

feature -- Helpers: cms link

	node_local_link (n: CMS_NODE; a_opt_title: detachable READABLE_STRING_GENERAL): CMS_LOCAL_LINK
		do
			if attached n.link as lnk then
				Result := lnk
			else
				Result := node_api.node_link (n)
			end
			if a_opt_title /= Void and then not Result.title.same_string_general (a_opt_title) then
				Result := local_link (a_opt_title, Result.location)
			end
		end

feature -- Helpers: html link

	node_html_link (n: CMS_NODE; a_opt_title: detachable READABLE_STRING_GENERAL): like link
		local
			l_title: detachable READABLE_STRING_GENERAL
		do
			if a_opt_title /= Void then
				l_title := a_opt_title
			else
				l_title := n.title
			end
			Result := link (l_title, node_api.node_path (n), Void)
		end

feature -- Helpers: URL		

	node_url (n: CMS_NODE): like url
		require
			n_with_id: n.has_id
		do
			Result := url (node_api.node_link (n).location, Void)
		end

end
