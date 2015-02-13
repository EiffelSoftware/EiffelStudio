note
	description: "Summary description for {BASIC_AUTH_LOGIN_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	BASIC_AUTH_LOGIN_HANDLER

inherit
	CMS_HANDLER

	WSF_URI_HANDLER
		rename
			execute as uri_execute,
			new_mapping as new_uri_mapping
		end

	WSF_FILTER


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
			execute_next (req, res)
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
			if attached {STRING_32} current_user_name (req) as l_user then
				(create {CMS_GENERIC_RESPONSE}).new_response_redirect (req, res, req.absolute_script_url("/"))
			else
				(create {CMS_GENERIC_RESPONSE}).new_response_authenticate (req, res)
			end
		end


end
