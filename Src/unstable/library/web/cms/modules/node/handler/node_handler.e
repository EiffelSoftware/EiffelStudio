note
	description: "[
			handler for CMS node in the CMS interface.
			
			TODO: implement REST API.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	NODE_HANDLER

inherit
	CMS_NODE_HANDLER

	WSF_URI_HANDLER
		rename
			execute as uri_execute,
			new_mapping as new_uri_mapping
		end

	WSF_URI_TEMPLATE_HANDLER
		rename
			execute as uri_template_execute,
			new_mapping as new_uri_template_mapping
		select
			new_uri_template_mapping
		end

	WSF_RESOURCE_HANDLER_HELPER
		redefine
			do_get,
			do_post,
			do_put,
			do_delete
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

	uri_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute (req, res)
		end

	uri_template_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute (req, res)
		end

feature -- Query

	node_id_path_parameter (req: WSF_REQUEST): INTEGER_64
			-- Node id passed as path parameter for request `req'.
		local
			s: READABLE_STRING_GENERAL
		do
			if attached {WSF_STRING} req.path_parameter ("id") as p_nid then
				s := p_nid.value
				if s.is_integer_64 then
					Result := s.to_integer_64
				end
			end
		end

feature -- Permissions

	view_unpublished_permissions (a_node: CMS_NODE): ITERABLE [READABLE_STRING_8]
			-- Permissions to view unpublished node `a_node`.
		do
			Result := <<"view unpublished " + a_node.content_type>>
		end

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_node: detachable CMS_NODE
			l_nid, l_rev: INTEGER_64
			edit_response: NODE_FORM_RESPONSE
			view_response: NODE_VIEW_RESPONSE
			l_is_published: BOOLEAN
			l_is_denied: BOOLEAN
		do
			if req.percent_encoded_path_info.ends_with ("/edit") then
				check valid_url: req.percent_encoded_path_info.starts_with ("/node/") end
				create edit_response.make (req, res, api, node_api)
				edit_response.execute
			elseif req.percent_encoded_path_info.ends_with ("/delete")  then
				check valid_url: req.percent_encoded_path_info.starts_with ("/node/") end
				create edit_response.make (req, res, api, node_api)
				edit_response.execute
			elseif req.percent_encoded_path_info.ends_with ("/trash")  then
				check valid_url: req.percent_encoded_path_info.starts_with ("/node/") end
				create edit_response.make (req, res, api, node_api)
				edit_response.execute
			elseif req.percent_encoded_path_info.ends_with ("/revision") then
				do_revisions (req, res)
--			elseif req.percent_encoded_path_info.ends_with ("/add_child/page") then
--					-- Add child node
--				l_nid := node_id_path_parameter (req)
--				if l_nid > 0 then
--						-- create a new child node with node id `l_id' as parent.
--					create_new_node (req, res)
--				else
--					send_not_found (req, res)
--				end
			else
					-- Display existing node
				l_nid := node_id_path_parameter (req)
				if l_nid > 0 then
					if
						attached {WSF_STRING} req.query_parameter ("revision") as p_rev and then
						p_rev.value.is_integer_64
					then
						l_rev := p_rev.value.to_integer_64
					end
					l_node := node_api.node (l_nid)
					if l_node /= Void then
						l_is_published := l_node.is_published
						if
							l_rev > 0 and then
							l_rev < l_node.revision
						then
							if node_api.has_permission_for_action_on_node ("view revisions", l_node, api.user) then
								l_node := node_api.revision_node (l_nid, l_rev)
							else
								l_is_denied := True
							end
						end
					end
					if l_is_denied then
						send_access_denied (req, res)
					elseif l_node = Void then
						send_not_found (req, res)
					else
						if l_is_published then
							create view_response.make (req, res, api, node_api)
							view_response.set_node (l_node)
							view_response.set_revision (l_rev)
							view_response.execute
						elseif
							attached api.user as l_user and then
							(	node_api.is_author_of_node (l_user, l_node)
								or else (
									api.user_has_permissions (l_user, view_unpublished_permissions (l_node))
								)
							)
						then
							create view_response.make (req, res, api, node_api)
							view_response.set_node (l_node)
							view_response.set_revision (l_rev)
							view_response.execute
						else
							send_access_denied_to_unpublished_node (req, res, l_node)
						end
					end
				else
--					redirect_to (req.absolute_script_url ("/node/"), res) -- New node.
--					send_bad_request (req, res)
					create_new_node (req, res)
				end
			end
		end

	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			edit_response: NODE_FORM_RESPONSE
			preview_response: NODE_PREVIEW_RESPONSE
		do
			fixme ("Refactor code: extract methods: edit_node and add_node")
			if req.percent_encoded_path_info.ends_with ("/edit") then
				create edit_response.make (req, res, api, node_api)
				edit_response.execute
			elseif
				req.percent_encoded_path_info.ends_with ("/preview")
				or else req.percent_encoded_path_info.starts_with ("/node/preview")
			then
				create preview_response.make (req, res, api, node_api)
				preview_response.execute
			elseif req.percent_encoded_path_info.ends_with ("/delete") then
				if
					attached {WSF_STRING} req.form_parameter ("op") as l_op and then
					l_op.value.same_string ("Delete")
				then
					do_delete (req, res)
				else
					send_bad_request (req, res)
				end
			elseif req.percent_encoded_path_info.ends_with ("/trash") then
				if attached {WSF_STRING} req.form_parameter ("op") as l_op then
					if l_op.is_case_insensitive_equal ("Trash") then
						do_trash (req, res)
					elseif l_op.is_case_insensitive_equal ("Restore") then
						do_restore (req, res)
					else
						send_bad_request (req, res)
					end
				else
					send_bad_request (req, res)
				end
			elseif req.percent_encoded_path_info.starts_with ("/node/add/") then
				create edit_response.make (req, res, api, node_api)
				edit_response.execute
			elseif req.percent_encoded_path_info.ends_with ("/add_child/page") then
				create edit_response.make (req, res, api, node_api)
				edit_response.execute
			else
				to_implement ("REST API")
				send_not_implemented ("REST API not yet implemented", req, res)
			end
		end

	do_put (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		do
			to_implement ("REST API")
			send_not_implemented ("REST API not yet implemented", req, res)
		end

	process_node_creation (req: WSF_REQUEST; res: WSF_RESPONSE; a_user: CMS_USER)
		do
			to_implement ("REST API")
			send_not_implemented ("REST API not yet implemented", req, res)
		end

feature {NONE} -- Trash:Restore

	do_trash (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Trash a node, soft delete.
		do
			if attached api.user as l_user then
				if attached {WSF_STRING} req.path_parameter ("id") as l_id then
					if
						l_id.is_integer and then
						attached node_api.node (l_id.integer_value) as l_node
					then
						if node_api.has_permission_for_action_on_node ("trash", l_node, l_user) then
							node_api.trash_node (l_node)
							res.send (create {CMS_REDIRECTION_RESPONSE_MESSAGE}.make (req.absolute_script_url ("")))
						else
							send_access_denied (req, res)
								-- send_not_authorized ?
						end
					else
						do_error (req, res, l_id)
					end
				else
					(create {INTERNAL_SERVER_ERROR_CMS_RESPONSE}.make (req, res, api)).execute
				end
			else
				send_access_denied (req, res)
			end
		end

	do_delete (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Delete a node from the database.
		local
			l_source: STRING
		do
			if attached api.user as l_user then
				if attached {WSF_STRING} req.path_parameter ("id") as l_id then
					if
						l_id.is_integer and then
						attached {CMS_NODE} node_api.node (l_id.integer_value) as l_node
					then
						if node_api.has_permission_for_action_on_node ("delete", l_node, l_user) then
							node_api.delete_node (l_node)
							l_source := node_api.node_path (l_node)
							api.unset_path_alias (l_source, api.location_alias (l_source))
							res.send (create {CMS_REDIRECTION_RESPONSE_MESSAGE}.make (req.absolute_script_url ("")))
						else
							send_access_denied (req, res)
								-- send_not_authorized ?
						end
					else
						do_error (req, res, l_id)
					end
				else
					(create {INTERNAL_SERVER_ERROR_CMS_RESPONSE}.make (req, res, api)).execute
				end
			else
				send_access_denied (req, res)
			end
		end

	do_restore (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Restore a node: From {CMS_NODE_API}.trashed to {CMS_NODE_API}.not_published.
		do
			if attached api.user as l_user then
				if attached {WSF_STRING} req.path_parameter ("id") as l_id then
					if
						l_id.is_integer and then
						attached node_api.node (l_id.integer_value) as l_node
					then
						if node_api.has_permission_for_action_on_node ("restore", l_node, l_user) then
							node_api.restore_node (l_node)
							res.send (create {CMS_REDIRECTION_RESPONSE_MESSAGE}.make (req.absolute_script_url ("/" + node_api.node_path (l_node))))
						else
							send_access_denied (req, res)
								-- send_not_authorized ?
						end
					else
						do_error (req, res, l_id)
					end
				else
					(create {INTERNAL_SERVER_ERROR_CMS_RESPONSE}.make (req, res, api)).execute
				end
			else
				send_access_denied (req, res)
			end
		end

	do_revisions (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Display revisions of a node.
		local
			r: GENERIC_VIEW_CMS_RESPONSE
			b: STRING
			n: CMS_NODE
		do
			if attached {WSF_STRING} req.path_parameter ("id") as l_id then
				if
					l_id.is_integer and then
					attached node_api.node (l_id.integer_value) as l_node
				then
					if node_api.has_permission_for_action_on_node ("view revisions", l_node, api.user) then
						create r.make (req, res, api)
						create b.make_empty
						b.append ("<ul>")
						across
							node_api.node_revisions (l_node) as ic
						loop
							n := ic.item
							b.append ("<li>")
							b.append ("<a href=%"")
							b.append (r.url (node_api.node_path (n) + "?revision=" + n.revision.out, Void))
							b.append ("%">")
							if n.revision = l_node.revision then
								b.append ("Current ")
							else
								b.append ("Revision")
							end
							b.append (" #")
							b.append (n.revision.out)
							b.append (" : ")
							b.append (api.formatted_date_time_yyyy_mm_dd__hh_min_ss (n.modification_date))
							b.append ("</a>")
							if attached n.editor as l_editor then
								if n.revision = 1 then
									b.append (" created by ")
								else
									b.append (" edited by ")
								end
								b.append (r.link (r.user_profile_name (l_editor), "user/" + l_editor.id.out, Void))
							end
							if attached n.author as l_author and then not l_author.same_as (n.editor) then
								b.append (" (owner: ")
								b.append (r.link (r.user_profile_name (l_author), "user/" + l_author.id.out, Void))
								b.append (")")
							end
							if node_api.has_permission_for_action_on_node ("edit revisions", l_node, api.user) then
								b.append (" (<a href=%"")
								b.append (r.url (node_api.node_path (n) + "/edit?revision=" + n.revision.out, Void))
								b.append ("%">edit</a>)")
							end
							b.append ("</li>")
						end
						b.append ("</ul>")
						r.set_title ("Revisions for " + html_encoded (l_node.title))
						r.set_main_content (b)
						r.execute
					else
						send_access_denied (req, res)
							-- send_not_authorized ?
					end
				else
					do_error (req, res, l_id)
				end
			else
				(create {INTERNAL_SERVER_ERROR_CMS_RESPONSE}.make (req, res, api)).execute
			end
		end

feature -- Error

	do_error (req: WSF_REQUEST; res: WSF_RESPONSE; a_id: detachable WSF_STRING)
			-- Handling error.
		local
			l_page: CMS_RESPONSE
		do
			create {GENERIC_VIEW_CMS_RESPONSE} l_page.make (req, res, api)
			l_page.set_value (req.absolute_script_url (req.percent_encoded_path_info), "request")
			if a_id /= Void and then a_id.is_integer then
					-- resource not found
				l_page.set_value ("404", "code")
				l_page.set_status_code (404)
			else
					-- bad request
				l_page.set_value ("400", "code")
				l_page.set_status_code (400)
			end
			l_page.execute
		end

	send_access_denied_to_unpublished_node (req: WSF_REQUEST; res: WSF_RESPONSE; a_node: CMS_NODE)
			-- Forbidden response.
		do
			send_custom_access_denied ("This content is NOT published!", view_unpublished_permissions (a_node), req, res)
		end

feature {NONE} -- Node

	create_new_node (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			edit_response: NODE_FORM_RESPONSE
		do
			if req.percent_encoded_path_info.starts_with_general ("/node/") then
				create edit_response.make (req, res, api, node_api)
				edit_response.execute
			elseif req.is_get_request_method then
				redirect_to (req.absolute_script_url ("/node/"), res)
			else
				send_bad_request (req, res)
			end
		end
end
