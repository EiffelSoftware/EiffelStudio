note
	description: "Summary description for {CMS_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_HANDLER

inherit
	WSF_URI_HANDLER
		rename
			execute as execute_uri
		undefine
			new_mapping
		end

	WSF_URI_TEMPLATE_HANDLER
		rename
			execute as execute_uri_template
		end

	WSF_STARTS_WITH_HANDLER
		rename
			execute as execute_starts_with
		undefine
			new_mapping
		end

create
	make

feature {NONE} -- Initialization

	make (e: like action)
		do
			action := e
		end

	action: PROCEDURE [ANY, TUPLE [req: WSF_REQUEST; res: WSF_RESPONSE]]

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			action.call ([req, res])
		end

	execute_uri (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			execute (req, res)
		end

	execute_uri_template (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			execute_uri (req, res)
		end

	execute_starts_with (a_start_path: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			execute_uri (req, res)
		end

end
