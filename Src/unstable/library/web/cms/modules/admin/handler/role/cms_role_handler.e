note
	description: "[
		Handler for a CMS user in the CMS interface
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_ROLE_HANDLER

inherit
	CMS_HANDLER

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

	role_id_path_parameter (req: WSF_REQUEST): INTEGER_64
			-- User id passed as path parameter for request `req'.
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

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_role: detachable CMS_USER_ROLE
			l_uid: INTEGER_64
			edit_response: CMS_ROLE_FORM_RESPONSE
			view_response: CMS_ROLE_VIEW_RESPONSE
		do
			if api.has_permission ("admin roles") then
				if req.percent_encoded_path_info.ends_with_general ("/edit") then
					check valid_url: req.percent_encoded_path_info.starts_with_general (api.administration_path ("/role/")) end
					create edit_response.make (req, res, api)
					edit_response.execute
				elseif req.percent_encoded_path_info.ends_with_general ("/delete")  then
					check valid_url: req.percent_encoded_path_info.starts_with_general (api.administration_path ("/role/")) end
					create edit_response.make (req, res, api)
					edit_response.execute
				else
						-- Display existing node
					l_uid := role_id_path_parameter (req)
					if l_uid > 0 then
						l_role := api.user_api.user_role_by_id (l_uid.to_integer)
						if
							l_role /= Void
						then
							create view_response.make (req, res, api)
							view_response.execute
						else
							send_not_found (req, res)
						end
					else
						create_new_role (req, res)
					end
				end
			else
				send_access_denied (req, res)
			end
		end

	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			edit_response: CMS_ROLE_FORM_RESPONSE
		do
			if api.has_permission ("admin roles") then
				if req.percent_encoded_path_info.ends_with_general ("/edit") then
					create edit_response.make (req, res, api)
					edit_response.execute
				elseif req.percent_encoded_path_info.ends_with_general ("/delete") then
					if
						attached {WSF_STRING} req.form_parameter ("op") as l_op and then
						l_op.value.same_string ("Delete")
					then
						do_delete (req, res)
					end
				elseif req.percent_encoded_path_info.ends_with_general ("/add/role") then
					create edit_response.make (req, res, api)
					edit_response.execute
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

	do_delete (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		do
			if attached api.user as l_user then
				if attached {WSF_STRING} req.path_parameter ("id") as l_id then
					if
						l_id.is_integer and then
						attached api.user_api.user_role_by_id (l_id.integer_value) as l_role
					then
						api.user_api.delete_role (l_role)
						res.send (create {CMS_REDIRECTION_RESPONSE_MESSAGE}.make (req.absolute_script_url ("")))
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


feature {NONE} -- New role

	create_new_role (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			edit_response: CMS_ROLE_FORM_RESPONSE
		do
			if req.percent_encoded_path_info.starts_with_general (api.administration_path ("/add/role")) then
				create edit_response.make (req, res, api)
				edit_response.execute
			else
				send_bad_request (req, res)
			end
		end

end
