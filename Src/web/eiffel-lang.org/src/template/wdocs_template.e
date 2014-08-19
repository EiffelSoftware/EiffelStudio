note
	description: "Summary description for {WDOCS_TEMPLATE}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WDOCS_TEMPLATE

feature -- Rendering

	xhtml (req: WSF_REQUEST; a_values: STRING_TABLE [detachable ANY]): STRING
		deferred
		end

end
