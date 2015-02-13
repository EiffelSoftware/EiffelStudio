note
	description: "Summary description for {NODE_HANDLER}."
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

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_page: CMS_RESPONSE
		do
				-- Existing node
			if attached {WSF_STRING} req.path_parameter ("id") as l_id then
				if
					l_id.is_integer and then
					attached node_api.node (l_id.value.to_integer_64) as l_node
				then
					create {GENERIC_VIEW_CMS_RESPONSE} l_page.make (req, res, api)
					l_page.add_variable (l_node, "node")
					l_page.execute
				else
					do_error (req, res, l_id)
				end
			else
					-- Factory
				new_node (req, res)
			end
		end

	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			u_node: CMS_NODE
		do
			to_implement ("Check user permissions!!!")
			if attached current_user (req) as l_user then
				if attached {WSF_STRING} req.path_parameter ("id") as l_id then
					if
						l_id.is_integer and then
						attached node_api.node (l_id.value.to_integer_64) as l_node
					then
						if attached {WSF_STRING} req.form_parameter ("method") as l_method then
							if l_method.is_case_insensitive_equal ("DELETE") then
								do_delete (req, res)
							elseif l_method.is_case_insensitive_equal ("PUT") then
								do_put (req, res)
							else
								(create {INTERNAL_SERVER_ERROR_CMS_RESPONSE}.make (req, res, api)).execute
							end
						end
					else
						do_error (req, res, l_id)
					end
				else
						-- New node
					create u_node.make ("", "", "")
					update_node_from_data_form (req, u_node)
					u_node.set_author (l_user)
					node_api.new_node (u_node)
					(create {CMS_GENERIC_RESPONSE}).new_response_redirect (req, res, req.absolute_script_url (""))
				end
			else
				(create {CMS_GENERIC_RESPONSE}).new_response_unauthorized (req, res)
			end
		end

	do_put (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		do

			if attached current_user (req) as l_user then
				if attached {WSF_STRING} req.path_parameter ("id") as l_id then
					if
						l_id.is_integer and then
						attached node_api.node (l_id.value.to_integer_64) as l_node
					then
						update_node_from_data_form (req, l_node)
						l_node.set_author (l_user)
						node_api.update_node (l_node)
						(create {CMS_GENERIC_RESPONSE}).new_response_redirect (req, res, req.absolute_script_url (""))
					else
						do_error (req, res, l_id)
					end
				else
					(create {INTERNAL_SERVER_ERROR_CMS_RESPONSE}.make (req, res, api)).execute
				end
			else
				(create {CMS_GENERIC_RESPONSE}).new_response_unauthorized (req, res)
			end
		end

	do_delete (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		do
			if attached current_user_name (req) then
				if attached {WSF_STRING} req.path_parameter ("id") as l_id then
					if
						l_id.is_integer and then
						attached node_api.node (l_id.integer_value) as l_node
					then
						node_api.delete_node (l_node)
						(create {CMS_GENERIC_RESPONSE}).new_response_redirect (req, res, req.absolute_script_url (""))
					else
						do_error (req, res, l_id)
					end
				else
					(create {INTERNAL_SERVER_ERROR_CMS_RESPONSE}.make (req, res, api)).execute
				end
			else
				(create {CMS_GENERIC_RESPONSE}).new_response_unauthorized (req, res)
			end
		end

feature -- Error

	do_error (req: WSF_REQUEST; res: WSF_RESPONSE; a_id: WSF_STRING)
			-- Handling error.
		local
			l_page: CMS_RESPONSE
		do
			create {GENERIC_VIEW_CMS_RESPONSE} l_page.make (req, res, api)
			l_page.add_variable (req.absolute_script_url (req.path_info), "request")
			if a_id.is_integer then
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

	new_node (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_page: CMS_RESPONSE
		do
			if attached current_user_name (req) then
				create {GENERIC_VIEW_CMS_RESPONSE} l_page.make (req, res, api)
				l_page.execute
			else
				(create {CMS_GENERIC_RESPONSE}).new_response_unauthorized (req, res)
			end
		end

feature -- {NONE} Form data

	update_node_from_data_form (req: WSF_REQUEST; a_node: CMS_NODE)
			-- Extract request form data and build a object
			-- Node
		do
			if attached {WSF_STRING} req.form_parameter ("title") as l_title then
				a_node.set_title (l_title.value)
			end
			if attached {WSF_STRING} req.form_parameter ("summary") as l_summary then
				a_node.set_summary (l_summary.value)
			end
			if attached {WSF_STRING} req.form_parameter ("content") as l_content then
				a_node.set_content (l_content.value)
			end
		end

end
