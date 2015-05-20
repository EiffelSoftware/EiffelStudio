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
		redefine
			custom_prepare
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

feature -- Generation

	custom_prepare (page: CMS_HTML_PAGE)
		do
			if attached variables as l_variables then
				across l_variables as c loop page.register_variable (c.item, c.key) end
			end
		end

feature -- Helpers

	node_id_path_parameter (req: WSF_REQUEST): INTEGER_64
			-- Node id passed as path parameter for request `req'.
		local
			s: STRING
		do
			if attached {WSF_STRING} req.path_parameter ("id") as p_nid then
				s := p_nid.value
				if s.is_integer_64 then
					Result := s.to_integer_64
				end
			end
		end

feature -- Helpers: cms link

	user_local_link (u: CMS_USER; a_opt_title: detachable READABLE_STRING_GENERAL): CMS_LOCAL_LINK
		do
			if a_opt_title /= Void then
				create Result.make (a_opt_title, user_url (u))
			else
				create Result.make (u.name, user_url (u))
			end
		end

	node_local_link (n: CMS_NODE; a_opt_title: detachable READABLE_STRING_GENERAL): CMS_LOCAL_LINK
		do
			if attached n.link as lnk then
				Result := lnk
			else
				Result := node_api.node_link (n)
			end
			if a_opt_title /= Void and then not Result.title.same_string_general (a_opt_title) then
				create Result.make (a_opt_title, Result.location)
			end
		end

feature -- Helpers: html link

	user_html_link (u: CMS_USER): like link
		do
			Result := link (u.name, "user/" + u.id.out, Void)
		end

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

	user_url (u: CMS_USER): like url
		require
			u_with_id: u.has_id
		do
			Result := url ("user/" + u.id.out, Void)
		end

	node_url (n: CMS_NODE): like url
		require
			n_with_id: n.has_id
		do
			Result := url (node_api.node_link (n).location, Void)
		end

end
