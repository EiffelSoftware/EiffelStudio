note
	description: "[
			Common interface for request handler specific to the CMS component.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_HANDLER

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

feature -- Response factory

	new_generic_response (req: WSF_REQUEST; res: WSF_RESPONSE): CMS_RESPONSE
		do
			create {GENERIC_VIEW_CMS_RESPONSE} Result.make (req, res, api)
		end

feature -- Response message helpers

	redirect_to (a_location: READABLE_STRING_8; res: WSF_RESPONSE)
			-- Send via `res' a redirection message for location `a_location'.			
		do
			res.redirect_now (a_location)
--			res.send (create {CMS_REDIRECTION_RESPONSE_MESSAGE}.make (a_location))
		end

	send_bad_request_message (res: WSF_RESPONSE)
			-- Send via `res' a bad request response.
		do
			res.send (create {CMS_CUSTOM_RESPONSE_MESSAGE}.make ({HTTP_STATUS_CODE}.bad_request))
		end

	send_not_found_message (res: WSF_RESPONSE)
			-- Send via `res' a bad request response.
		do
			res.send (create {CMS_CUSTOM_RESPONSE_MESSAGE}.make ({HTTP_STATUS_CODE}.not_found))
		end

	send_access_denied_message (res: WSF_RESPONSE)
			-- Send via `res' an access denied response.
		do
			res.send (create {CMS_FORBIDDEN_RESPONSE_MESSAGE}.make)
		end

feature -- Response helpers

	send_access_denied (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Forbidden response.
		do
			api.response_api.send_access_denied (Void, req, res)
		end

	send_custom_access_denied (a_message: detachable READABLE_STRING_8; a_perms: detachable ITERABLE [READABLE_STRING_8]; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Forbidden response with custom message `a_message`.
		do
			api.response_api.send_permissions_access_denied (a_message, a_perms, req, res)
		end

	send_not_found (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Send via `res' a not found response.
		do
			api.response_api.send_not_found (Void, req, res)
		end

	send_not_found_with_message (a_mesg: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Send via `res' a not found response.
		do
			api.response_api.send_not_found (a_mesg, req, res)
		end

	send_bad_request (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Send via `res' a bad request response.
		do
			api.response_api.send_bad_request (Void, req, res)
		end

	send_not_implemented (a_message: detachable READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Send via `res' a not implemented response.
		do
			api.response_api.send_not_implemented (a_message, req, res)
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
