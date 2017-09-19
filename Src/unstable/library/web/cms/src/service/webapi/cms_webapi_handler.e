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
--			create {MD_WEBAPI_RESPONSE} Result.make (req, res, api)
			create {JSON_WEBAPI_RESPONSE} Result.make (req, res, api)
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
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
