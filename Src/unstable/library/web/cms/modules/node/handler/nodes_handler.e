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
			new_mapping as new_uri_mapping,
			execute as execute_uri
		end

	WSF_URI_TEMPLATE_HANDLER
		rename
			new_mapping as new_uri_template_mapping,
			execute as execute_uri_template
		select
			new_uri_template_mapping
		end

	WSF_RESOURCE_HANDLER_HELPER
		redefine
			do_get
		end

	REFACTORING_HELPER

create
	make

feature -- execute

	execute_uri (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			execute (req, res)
		end

	execute_uri_template (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			execute (req, res)
		end

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute_methods (req, res)
		end

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_content_type: detachable CMS_CONTENT_TYPE
		do
			if attached {WSF_STRING} req.path_parameter ("type") as p_node_type and then attached api.content_type (p_node_type.value) as ct then
				l_content_type := api.content_type (p_node_type.value)
			end
			if l_content_type /= Void and then req.path_info.ends_with_general ("/feed") then
				do_nodes_feed (l_content_type, req, res)
			else
				do_nodes_html (l_content_type, req, res)
			end
		end

	do_nodes_feed (a_content_type: CMS_CONTENT_TYPE; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_feed: FEED
			l_size: NATURAL_64
			mesg: CMS_CUSTOM_RESPONSE_MESSAGE
			l_payload: STRING
		do
			if attached {WSF_STRING} req.query_parameter ("size") as p_size and then p_size.is_integer then
				l_size := p_size.integer_value.to_natural_64
			else
				l_size := 25
			end

			l_feed := node_api.feed (a_content_type, l_size, req.percent_encoded_path_info)

			create l_payload.make (2_048)
			l_feed.accept (create {ATOM_FEED_GENERATOR}.make (l_payload))
			create mesg.make ({HTTP_STATUS_CODE}.ok)
			mesg.set_payload (l_payload)
			res.send (mesg)
		end

	do_nodes_html (a_content_type: detachable CMS_CONTENT_TYPE; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_response: CMS_RESPONSE
			s: STRING
			n: CMS_NODE
			lnk: CMS_LOCAL_LINK
			l_page_helper: CMS_PAGINATION_GENERATOR
			s_pager: STRING
			l_count: NATURAL_64
			inc: BOOLEAN
			l_include_trashed: BOOLEAN
			lst: detachable ITERABLE [CMS_NODE]
		do
			-- At the moment the template are hardcoded, but we can
			-- get them from the configuration file and load them into
			-- the setup class.
			create {GENERIC_VIEW_CMS_RESPONSE} l_response.make (req, res, api)

			create s.make_empty
			across
				api.content_types as ic
			loop
				if attached {CMS_NODE_TYPE [CMS_NODE]} ic.item as l_note_type then
					create lnk.make (l_note_type.name, "nodes/" + l_note_type.name)
					if l_note_type = a_content_type then
						lnk.set_is_active (True)
					end
					l_response.add_to_primary_tabs (lnk)
				end
			end

			create s_pager.make_empty
			if a_content_type /= Void then
				l_count := node_api.nodes_of_type_count (a_content_type)
				if l_count > 1 then
					l_response.set_title ("Listing " + l_count.out + " " + a_content_type.name + " nodes")
				else
					l_response.set_title ("Listing " + l_count.out + " " + a_content_type.name + " node")
				end
				create l_page_helper.make ("nodes/" + a_content_type.name + "/?page={page}&size={size}", l_count, 25) -- FIXME: Make this default page size a global CMS settings
			else
				l_count := node_api.nodes_count
				if l_count > 1 then
					l_response.set_title ("Listing " + l_count.out + " nodes")
				else
					l_response.set_title ("Listing " + l_count.out + " node")
				end
				create l_page_helper.make ("nodes/?page={page}&size={size}", l_count, 25) -- FIXME: Make this default page size a global CMS settings
			end

			l_page_helper.get_setting_from_request (req)
			if l_page_helper.has_upper_limit and then l_page_helper.pages_count > 1 then
				l_page_helper.append_to_html (l_response, s_pager)
				if l_page_helper.page_size > 25 then
					s.append (s_pager)
				end
			end

			if a_content_type /= Void then
				lst := node_api.recent_nodes_of_type (a_content_type, create {CMS_DATA_QUERY_PARAMETERS}.make (l_page_helper.current_page_offset, l_page_helper.page_size))
			else
				lst := node_api.recent_nodes (create {CMS_DATA_QUERY_PARAMETERS}.make (l_page_helper.current_page_offset, l_page_helper.page_size))
			end
			if lst /= Void then
				if attached {WSF_STRING} req.query_parameter ("include_trash") as v and then v.is_case_insensitive_equal ("yes") then
					l_include_trashed := l_response.has_permissions (<<"view trash", "view any trash">>)
				end
				s.append ("<ul class=%"cms-nodes%">%N")
				across
					lst as ic
				loop
					n := ic.item
					inc := True
					if not n.is_published then
						inc := view_unpublished_node_permitted (n)
					end
					if inc and n.is_trashed then
						inc := l_include_trashed
					end
					if inc then
						lnk := node_api.node_link (n)
						s.append ("<li class=%"cms_type_"+ n.content_type)
						if not n.is_published then
							s.append (" not-published")
						elseif n.is_trashed then
							s.append (" trashed")
						end
						s.append ("%">")
						l_response.append_cms_link_to_html (lnk, Void, s)
						if not n.is_published then
							s.append (" <span class=%"info%">(not-published)</span>")
						elseif n.is_trashed then
							s.append (" <span class=%"info%">(trashed)</span>")
						end
						s.append (" <span class=%"info%"> ("+ api.formatted_date_time_ago (n.modification_date) +")</span>")
						s.append (" <span class=%"info%"> #"+ n.id.out +"</span>")

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
				s.append (l_response.link ("Your-trash", "trash?user=" + u.id.out, Void))
				s.append (" | ")
			end

			l_response.set_main_content (s)
			l_response.execute
		end

feature -- Helper

	view_unpublished_node_permitted (n: CMS_NODE): BOOLEAN
		do
			if api.has_permission ("view unpublished " + n.content_type) then
				Result := True
			elseif attached api.user as u then
				Result := u.same_as (n.author)
			end
		end

end
