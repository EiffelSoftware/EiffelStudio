note
	description: "CMS Handler for wdocs page resource."
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_PAGE_HANDLER

inherit
	CMS_HANDLER
		rename
			make as make_api
		end

--	WSF_URI_HANDLER
--		rename
--			new_mapping as new_uri_mapping
--		end

	WSF_URI_TEMPLATE_HANDLER
		rename
			new_mapping as new_uri_template_mapping
		end

	WSF_RESOURCE_HANDLER_HELPER
		redefine
			do_get
		end

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization	

	make (a_api: CMS_API)
			-- Initialize Current handler with `a_api'.
		do
			make_api (a_api)
		end

feature -- execute

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute_methods (req, res)
		end

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		do
			(create {HOME_CMS_RESPONSE}.make (req, res, api)).execute
		end

end
