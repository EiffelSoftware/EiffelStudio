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
			if req.path_info.ends_with_general ("/edit") then
				check valid_url: req.path_info.starts_with_general ("/node/") end
				create edit_response.make (req, res, api, node_api)
				edit_response.execute
			else
					-- Display existing node
				l_nid := node_id_path_parameter (req)
				if l_nid > 0 then
					l_node := node_api.node (l_nid)
					if l_node /= Void then
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
			if req.path_info.ends_with_general ("/edit") then
				create edit_response.make (req, res, api, node_api)
				edit_response.execute
			elseif req.path_info.starts_with_general ("/node/add/") then
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
						if api.user_has_permission (l_user, "delete " + l_node.content_type) then
							node_api.delete_node (l_node)
							res.send (create {CMS_REDIRECTION_RESPONSE_MESSAGE}.make (req.absolute_script_url ("")))
						else
							send_access_denied (req, res)
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

feature -- Error

	do_error (req: WSF_REQUEST; res: WSF_RESPONSE; a_id: detachable WSF_STRING)
			-- Handling error.
		local
			l_page: CMS_RESPONSE
		do
			create {GENERIC_VIEW_CMS_RESPONSE} l_page.make (req, res, api)
			l_page.add_variable (req.absolute_script_url (req.path_info), "request")
			if a_id /= Void and then a_id.is_integer then
					-- resource not found
				l_page.add_variable ("404", "code")
				l_page.set_status_code (404)
			else
					-- bad request
				l_page.add_variable ("400", "code")
				l_page.set_status_code (400)
			end
			l_page.execute
		end

feature {NONE} -- Node

	create_new_node (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			edit_response: NODE_FORM_RESPONSE
		do
			if req.path_info.starts_with_general ("/node/") then
				create edit_response.make (req, res, api, node_api)
				edit_response.execute
			elseif req.is_get_request_method then
				redirect_to (req.absolute_script_url ("/node/"), res)
			else
				send_bad_request (req, res)
			end
		end

end
