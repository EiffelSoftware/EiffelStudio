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

	user_path_parameter (req: WSF_REQUEST): detachable CMS_USER
			-- User id (uid or username) passed as path parameter for request `req'.
		local
			s: READABLE_STRING_GENERAL
			l_uid: INTEGER_64
		do
			if attached {WSF_STRING} req.path_parameter ("uid") as p_nid then
				s := p_nid.value
				if s.is_integer_64 then
					l_uid := s.to_integer_64
					if l_uid > 0 then
						Result := api.user_api.user_by_id (l_uid)
					end
				else
					Result := api.user_api.user_by_name (s)
				end
			end
		end

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_user: detachable CMS_USER
		do
			if api.has_permission ("view users") then
				l_user := user_path_parameter (req)
					-- Display existing node
				if
					l_user /= Void
				then
					(create {CMS_USER_VIEW_RESPONSE}.make_with_user (l_user, req, res, api)).execute
				else
					send_not_found (req, res)
				end
			else
				send_access_denied (req, res)
			end
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
