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
			s: STRING
		do
			if attached {WSF_STRING} req.path_parameter ("id") as p_nid then
				s := p_nid.value
				if s.is_integer_64 then
					Result := s.to_integer_64
				end
			end
		end

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_node: detachable CMS_NODE
			l_nid: INTEGER_64
			edit_response: NODE_FORM_RESPONSE
			view_response: NODE_VIEW_RESPONSE
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
			else
					-- Display existing node
				l_nid := node_id_path_parameter (req)
				if l_nid > 0 then
					l_node := node_api.node (l_nid)
					if
						l_node /= Void and then l_node.is_published
					then
						create view_response.make (req, res, api, node_api)
						view_response.set_node (l_node)
						view_response.execute
					else
						send_not_found (req, res)
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
		do
			fixme ("Refactor code: extract methods: edit_node and add_node")
			if req.percent_encoded_path_info.ends_with ("/edit") then
				create edit_response.make (req, res, api, node_api)
				edit_response.execute
			elseif req.percent_encoded_path_info.ends_with ("/delete") then
				if
					attached {WSF_STRING} req.form_parameter ("op") as l_op and then
					l_op.value.same_string ("Delete")
				then
					do_delete (req, res)
				end
			elseif req.percent_encoded_path_info.ends_with ("/trash") then
				if
					attached {WSF_STRING} req.form_parameter ("op") as l_op and then
					l_op.value.same_string ("Trash")
				then
					do_trash (req, res)
				elseif
					attached {WSF_STRING} req.form_parameter ("op") as l_op and then
					l_op.value.same_string ("Restore")
				then
					do_restore (req, res)
				end
			elseif req.percent_encoded_path_info.starts_with ("/node/add/") then
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

	do_delete (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		do
			if attached current_user (req) as l_user then
				if attached {WSF_STRING} req.path_parameter ("id") as l_id then
					if
						l_id.is_integer and then
						attached node_api.node (l_id.integer_value) as l_node
					then
						if node_api.has_permission_for_action_on_node ("delete", l_node, current_user (req)) then
							node_api.delete_node (l_node)
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

	process_node_creation (req: WSF_REQUEST; res: WSF_RESPONSE; a_user: CMS_USER)
		do
			to_implement ("REST API")
			send_not_implemented ("REST API not yet implemented", req, res)
		end

feature {NONE} -- Trash:Restore

	do_trash (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Trash a node from the database.
		do
			if attached current_user (req) as l_user then
				if attached {WSF_STRING} req.path_parameter ("id") as l_id then
					if
						l_id.is_integer and then
						attached node_api.node (l_id.integer_value) as l_node
					then
						if node_api.has_permission_for_action_on_node ("trash", l_node, current_user (req)) then
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

	do_restore (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Restore a node: From {CMS_NODE_API}.trashed to {CMS_NODE_API}.not_published.
		do
			if attached current_user (req) as l_user then
				if attached {WSF_STRING} req.path_parameter ("id") as l_id then
					if
						l_id.is_integer and then
						attached node_api.node (l_id.integer_value) as l_node
					then
						if node_api.has_permission_for_action_on_node ("trash", l_node, current_user (req)) then
							node_api.restore_node (l_node)
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
