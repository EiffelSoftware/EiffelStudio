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

	new_webapi_response (req: WSF_REQUEST; res: WSF_RESPONSE): HM_WEBAPI_RESPONSE
		do
--			create {MD_WEBAPI_RESPONSE} Result.make (req, res, api)
			create {JSON_WEBAPI_RESPONSE} Result.make (req, res, api)
		end

	new_wepapi_error_response (msg: detachable READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE): HM_WEBAPI_RESPONSE
		do
			Result := new_webapi_response (req, res)
			if msg /= Void then
				Result.add_string_field ("error", msg)
			else
				Result.add_string_field ("error", "True")
			end
		end

	send_not_found (m: detachable READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			rep: HM_WEBAPI_RESPONSE
		do
			if m /= Void then
				rep := new_wepapi_error_response (m, req, res)
			else
				rep := new_wepapi_error_response ("Not found", req, res)
			end
			rep.set_status_code ({HTTP_STATUS_CODE}.not_found)
			rep.execute
		end

	send_access_denied (m: detachable READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			rep: HM_WEBAPI_RESPONSE
		do
			if m /= Void then
				rep := new_wepapi_error_response (m, req, res)
			else
				rep := new_wepapi_error_response ("Access denied", req, res)
			end
			rep.set_status_code ({HTTP_STATUS_CODE}.user_access_denied)
			rep.execute
		end

	send_bad_request (m: detachable READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			rep: HM_WEBAPI_RESPONSE
		do
			if m /= Void then
				rep := new_wepapi_error_response (m, req, res)
			else
				rep := new_wepapi_error_response ("Bad request", req, res)
			end
			rep.set_status_code ({HTTP_STATUS_CODE}.bad_request)
			rep.execute
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
