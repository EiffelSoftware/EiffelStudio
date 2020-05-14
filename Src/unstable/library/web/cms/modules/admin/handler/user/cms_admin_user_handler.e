note
	description: "[
		Administration handler for a CMS user in the CMS interface
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_ADMIN_USER_HANDLER

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

	user_id_path_parameter (req: WSF_REQUEST): INTEGER_64
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
			l_user: detachable CMS_USER
			l_uid: INTEGER_64
			edit_response: CMS_ADMIN_USER_FORM_RESPONSE
			view_response: CMS_ADMIN_USER_VIEW_RESPONSE
		do
			if api.has_permission ("admin users") then
				if req.percent_encoded_path_info.ends_with_general ("/edit") then
					check valid_url: req.percent_encoded_path_info.starts_with_general (api.administration_path ("/user/")) end
					create edit_response.make (req, res, api)
					edit_response.execute
				elseif req.percent_encoded_path_info.ends_with_general ("/delete")  then
					check valid_url: req.percent_encoded_path_info.starts_with_general (api.administration_path ("/user/")) end
					create edit_response.make (req, res, api)
					edit_response.execute
				else
						-- Display existing node
					l_uid := user_id_path_parameter (req)
					if l_uid > 0 then
						l_user := api.user_api.user_by_id (l_uid)
						if
							l_user /= Void
						then
							create view_response.make (req, res, api)
							view_response.execute
						else
							send_not_found (req, res)
						end
					else
						create_new_user (req, res)
					end
				end
			else
				send_access_denied (req, res)
			end
		end


	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			edit_response: CMS_ADMIN_USER_FORM_RESPONSE
		do
			if api.has_permission ("admin users") then
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
				elseif req.percent_encoded_path_info.ends_with_general ("/add/user") then
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
						attached api.user_api.user_by_id (l_id.integer_value) as u_user
					then
						api.user_api.delete_user(u_user)
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


feature {NONE} -- New User

	create_new_user (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			edit_response: CMS_ADMIN_USER_FORM_RESPONSE
		do
			if req.percent_encoded_path_info.starts_with (api.administration_path ("/add/user")) then
				create edit_response.make (req, res, api)
				edit_response.execute
			else
				send_bad_request (req, res)
			end
		end

end
