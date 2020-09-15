note
	description: "Request handler related to /trash "
	date: "$Date$"
	revision: "$Revision$"

class
	TRASH_HANDLER


inherit
	CMS_NODE_HANDLER

	WSF_URI_HANDLER
		rename
			new_mapping as new_uri_mapping
		end

	WSF_RESOURCE_HANDLER_HELPER
		redefine
			do_get
		end

	REFACTORING_HELPER

create
	make

feature -- execute

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute_methods (req, res)
		end

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_page: CMS_RESPONSE
			s: STRING
			n: CMS_NODE
			lnk: CMS_LOCAL_LINK
			l_username: detachable READABLE_STRING_32
			l_trash_owner: detachable CMS_USER
		do
				-- At the moment the template is hardcoded, but we can
				-- get them from the configuration file and load them into
				-- the setup class.
			create {GENERIC_VIEW_CMS_RESPONSE} l_page.make (req, res, api)
			if attached {WSF_STRING} req.query_parameter ("user") as p_username then
				l_username := p_username.value
				if l_username.is_integer_64 then
					l_trash_owner := api.user_api.user_by_id (l_username.to_integer_64)
				else
					l_trash_owner := api.user_api.user_by_name (l_username)
				end
			end
			if
				(l_trash_owner /= Void and then l_page.has_permissions (<<"view any trash", "view own trash">>))
				or else (l_page.has_permission ("view trash"))
			then
					-- NOTE: for development purposes we have the following hardcode output.
				if l_trash_owner /= Void then
					create s.make_from_string ("<p>Trash for user " + l_page.html_encoded (l_page.user_profile_name (l_trash_owner)) + "</p>")
				else
					create s.make_from_string ("<p>Trash</p>")
				end

				if attached node_api.trashed_nodes (l_trash_owner) as lst then
					s.append ("<ul class=%"cms-nodes%">%N")
					across
						lst as ic
					loop
						n := ic.item
						lnk := node_api.node_link (n)
						s.append ("<li class=%"cms_type_"+ n.content_type +"%">")
						l_page.append_cms_link_to_html (lnk, Void, s)
						s.append ("</li>%N")
					end
					s.append ("</ul>%N")
				end

				l_page.set_main_content (s)
				-- l_page.add_block (create {CMS_CONTENT_BLOCK}.make ("nodes_warning", Void, "/nodes/ is not yet fully implemented<br/>", Void), "highlighted")
				l_page.execute
			else
				send_custom_access_denied (Void, <<"view trash", "view any trash", "view own trash">>, req, res)
			end
		end

end
