note
	description: "Summary description for {BASIC_AUTH_LOGOFF_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	BASIC_AUTH_LOGOFF_HANDLER

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
		local
			l_page: CMS_RESPONSE
		do
			api.logger.put_information (generator + ".do_get Processing basic auth logoff", Void)
			if attached req.query_parameter ("prompt") as l_prompt then
				(create {CMS_GENERIC_RESPONSE}).new_response_unauthorized (req, res)
			else
				create {GENERIC_VIEW_CMS_RESPONSE} l_page.make (req, res, api)
				l_page.set_status_code ({HTTP_STATUS_CODE}.unauthorized)
				l_page.execute
			end
		end

end
