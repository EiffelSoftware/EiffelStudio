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
		do
				-- At the moment the template is hardcoded, but we can
				-- get them from the configuration file and load them into
				-- the setup class.

			create {GENERIC_VIEW_CMS_RESPONSE} l_page.make (req, res, api)

			if attached current_user (req) as l_user then

				l_page.add_variable (node_api.trashed_nodes (l_user), "nodes")

					-- NOTE: for development purposes we have the following hardcode output.
				create s.make_from_string ("<p>Nodes:</p>")
				if attached node_api.trashed_nodes (l_user) as lst then
					s.append ("<ul class=%"cms-nodes%">%N")
					across
						lst as ic
					loop
						n := ic.item
						lnk := node_api.node_link (n)
						s.append ("<li class=%"cms_type_"+ n.content_type +"%">")
						s.append (l_page.link (lnk.title, lnk.location, Void))
						s.append ("</li>%N")
					end
					s.append ("</ul>%N")
				end

				l_page.set_main_content (s)
				-- l_page.add_block (create {CMS_CONTENT_BLOCK}.make ("nodes_warning", Void, "/nodes/ is not yet fully implemented<br/>", Void), "highlighted")
				l_page.execute
			end
		end

end
