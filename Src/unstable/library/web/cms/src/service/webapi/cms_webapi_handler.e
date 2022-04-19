note
	description: "[
			Objects that ...
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_WEBAPI_HANDLER

inherit
	WSF_HANDLER

	CMS_API_ACCESS

	CMS_ENCODERS

	REFACTORING_HELPER

feature {NONE} -- Initialization

	make (a_api: CMS_API)
			-- Initialize Current handler with `a_api'.
		do
			api := a_api
		end

feature -- API Service

	api: CMS_API

feature -- Factory

	new_response (req: WSF_REQUEST; res: WSF_RESPONSE): HM_WEBAPI_RESPONSE
		do
			create {JSON_WEBAPI_RESPONSE} Result.make (req, res, api)
		end

	new_signed_response (a_key: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE): HM_WEBAPI_RESPONSE
		do
			create {SIGNED_JSON_WEBAPI_RESPONSE} Result.make (a_key, req, res, api)
		end

	new_error_response (msg: detachable READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE): like new_response
		do
			Result := new_response (req, res)
			Result.set_status_code ({HTTP_STATUS_CODE}.bad_request)
			if msg /= Void then
				Result.add_string_field ("error", msg)
			else
				Result.add_string_field ("error", "True")
			end
			Result.add_self (req.request_uri)
		end

	new_not_found_error_response (m: detachable READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE): like new_response
		do
			if m = Void then
				Result := new_error_response ("Not Found", req, res)
			else
				Result := new_error_response (m, req, res)
			end
			Result.set_status_code ({HTTP_STATUS_CODE}.not_found)
		end

	new_permissions_access_denied_error_response (perms: ITERABLE [READABLE_STRING_GENERAL]; a_mesg: detachable READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE): like new_response
		local
			m: STRING_32
			n: INTEGER
		do
			if a_mesg /= Void then
				create m.make_from_string_general (a_mesg)
				m.append_character ('%N')
			else
				create m.make (20)
			end
			m.append_string_general ("Permissions: ")
			n := m.count
			across
				perms as ic
			loop
				if m.count > n then
					m.append (",")
				end
				m.append_string_general (ic.item)
			end
			Result := new_access_denied_error_response (m, req, res)
		end

	new_access_denied_error_response (m: detachable READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE): like new_response
		do
			if m = Void then
				Result := new_error_response ("Access denied", req, res)
			else
				Result := new_error_response (m, req, res)
			end
			Result.set_status_code ({HTTP_STATUS_CODE}.user_access_denied)
		end

	new_bad_request_error_response (m: detachable READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE): like new_response
		do
			if m = Void then
				Result := new_error_response ("Bad request", req, res)
			else
				Result := new_error_response (m, req, res)
			end
			Result.set_status_code ({HTTP_STATUS_CODE}.bad_request)
		end

feature {NONE} -- Builder

	add_user_links_to (u: CMS_USER; rep: HM_WEBAPI_RESPONSE)
		do
			rep.add_link ("account", "user/" + u.id.out, rep.api.webapi_path ("/user/" + u.id.out))
		end

note
	copyright: "2011-2022, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
