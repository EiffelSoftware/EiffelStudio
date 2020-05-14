note
	description: "[
			CMS Response API to send predefined CMS Response.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_RESPONSE_API

create
	make

feature {NONE} -- Initialization

	make (a_api: CMS_API)
		do
			cms_api := a_api
		end

	cms_api: CMS_API

feature -- Response helpers

	send_access_denied (a_message: detachable READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Forbidden response with custom message `a_message`.
		local
			r: FORBIDDEN_ERROR_CMS_RESPONSE
		do
			create r.make (req, res, cms_api)
			impl_response_execute (r, a_message)
		end

	send_permissions_access_denied (a_message: detachable READABLE_STRING_8; a_perms: detachable ITERABLE [READABLE_STRING_8]; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Forbidden response with custom message `a_message` and associated permissions `a_perms`.
		local
			r: FORBIDDEN_ERROR_CMS_RESPONSE
		do
			if a_perms = Void then
				create r.make (req, res, cms_api)
			else
				create r.make_with_permissions (req, res, cms_api, a_perms)
			end
			impl_response_execute (r, a_message)
		end

	send_not_found (a_message: detachable READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Send via `res' a not found response.
		do
			impl_response_execute (create {NOT_FOUND_ERROR_CMS_RESPONSE}.make (req, res, cms_api), a_message)
		end

	send_bad_request (a_message: detachable READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Send via `res' a bad request response.
		do
			impl_response_execute (create {BAD_REQUEST_ERROR_CMS_RESPONSE}.make (req, res, cms_api), a_message)
		end

	send_not_implemented (a_message: detachable READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Send via `res' a not implemented response.
		do
			impl_response_execute (create {NOT_IMPLEMENTED_ERROR_CMS_RESPONSE}.make (req, res, cms_api), a_message)
		end

feature {NONE} -- Implementation

	impl_response_execute (a_response: CMS_RESPONSE; a_message: detachable READABLE_STRING_8)
		do
			if a_message /= Void then
				a_response.set_main_content (a_message.to_string_8)
			end
			a_response.execute
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
