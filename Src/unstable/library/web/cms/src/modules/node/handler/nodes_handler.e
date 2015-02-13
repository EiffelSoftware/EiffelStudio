note
	description: "Summary description for {NODES_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	NODES_HANDLER

inherit
	CMS_NODE_HANDLER

	WSF_URI_HANDLER
		rename
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
			-- Execute request handler
		do
			execute_methods (req, res)
		end

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_page: CMS_RESPONSE
		do
				-- At the moment the template is hardcoded, but we can
				-- get them from the configuration file and load them into
				-- the setup class.
			create {GENERIC_VIEW_CMS_RESPONSE} l_page.make (req, res, api)
			l_page.add_variable (node_api.nodes, "nodes")
			l_page.execute
		end
end
