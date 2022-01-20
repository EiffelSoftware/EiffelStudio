note
	description: "Summary description for {CMS_BASIC_AUTH_LOGIN_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_BASIC_AUTH_LOGIN_HANDLER

inherit
	CMS_HANDLER

	WSF_URI_HANDLER
		rename
			execute as uri_execute,
			new_mapping as new_uri_mapping
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
			-- Execute request handler.
		do
			execute_methods (req, res)
		end

	uri_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler.
		do
			execute_methods (req, res)
		end

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		do
			api.logger.put_information (generator + ".do_get Processing basic auth login", Void)
			if api.user_is_authenticated then
				if attached api.destination_location (req) as l_uri then
					redirect_to (req.absolute_script_url (secured_url_content (l_uri)), res)
				else
					redirect_to (req.absolute_script_url ("/"), res)
				end
			else
				send_basic_authentication_challenge (Void, res)
			end
		end

feature -- Helpers

	send_basic_authentication_challenge (a_realm: detachable READABLE_STRING_8; res: WSF_RESPONSE)
		do
			res.send (create {CMS_UNAUTHORIZED_RESPONSE_MESSAGE}.make_with_basic_auth_challenge (a_realm))
		end

end
