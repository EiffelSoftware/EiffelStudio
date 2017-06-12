note
	description: "[
		Handler for a CMS user in the CMS interface
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_USER_HANDLER

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
			s: STRING
		do
			if attached {WSF_STRING} req.path_parameter ("uid") as p_nid then
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
			view_response: CMS_USER_VIEW_RESPONSE
		do
			if api.has_permission ("view user") then
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
					send_bad_request (req, res)
				end
			else
				send_access_denied (req, res)
			end
		end

end
