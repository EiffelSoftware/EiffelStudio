note
	description: "Request handler related to /nodes."
	date: "$Date$"
	revision: "$Revision$"

class
	NODES_HANDLER

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
			l_response: CMS_RESPONSE
			s: STRING
			n: CMS_NODE
			lnk: CMS_LOCAL_LINK
			l_page_helper: CMS_PAGINATION_GENERATOR
			s_pager: STRING
			l_count: NATURAL_64
			l_include_trashed: BOOLEAN
		do
				-- At the moment the template are hardcoded, but we can
				-- get them from the configuration file and load them into
				-- the setup class.

			l_count := node_api.nodes_count

			create {GENERIC_VIEW_CMS_RESPONSE} l_response.make (req, res, api)

			create s.make_empty
			if l_count > 1 then
				l_response.set_title ("Listing " + l_count.out + " nodes")
			else
				l_response.set_title ("Listing " + l_count.out + " node")
			end

			create s_pager.make_empty
			create l_page_helper.make ("nodes/?page={page}&size={size}", node_api.nodes_count, 25) -- FIXME: Make this default page size a global CMS settings
			l_page_helper.get_setting_from_request (req)
			if l_page_helper.has_upper_limit and then l_page_helper.pages_count > 1 then
				l_page_helper.append_to_html (l_response, s_pager)
				if l_page_helper.page_size > 25 then
					s.append (s_pager)
				end
			end

			if attached node_api.recent_nodes (create {CMS_DATA_QUERY_PARAMETERS}.make (l_page_helper.current_page_offset, l_page_helper.page_size)) as lst then
				if attached {WSF_STRING} req.query_parameter ("include_trash") as v and then v.is_case_insensitive_equal ("yes") then
					l_include_trashed := l_response.has_permissions (<<"view trash", "view any trash">>)
				end
				s.append ("<ul class=%"cms-nodes%">%N")
				across
					lst as ic
				loop
					n := ic.item
					if not n.is_trashed or else l_include_trashed then
						lnk := node_api.node_link (n)
						s.append ("<li class=%"cms_type_"+ n.content_type)
						if not n.is_published then
							s.append (" not-published")
						elseif n.is_trashed then
							s.append (" trashed")
						end
						s.append ("%">")
						s.append (l_response.link (lnk.title, lnk.location, Void))
						if not n.is_published then
							s.append (" <em>(not-published)</em>")
						elseif n.is_trashed then
							s.append (" <em>(trashed)</em>")
						end
						debug
							if attached node_api.node_type (n.content_type) as ct then
								s.append ("<span class=%"description%">")
								s.append (html_encoded (ct.title))
								s.append ("</span>")
							end
						end
					end
					s.append ("</li>%N")
				end
				s.append ("</ul>%N")
			end
				-- Again the pager at the bottom, if needed
			s.append (s_pager)

			if l_response.has_permissions (<<"view trash", "view any trash">>) then
				if not l_include_trashed then
					s.append (l_response.link ("With trashed items", l_response.location + "?include_trash=yes", Void))
					s.append (" | ")
				end

				s.append (l_response.link ("Global-Trash", "trash", Void))
				s.append (" | ")
			end
			if attached l_response.user as u and then l_response.has_permission ("view own trash") then
				s.append (l_response.link ("Your-trash", "trash?user=" + l_response.url_encoded (u.name), Void))
				s.append (" | ")
			end

			l_response.set_main_content (s)
			l_response.execute
		end

end
