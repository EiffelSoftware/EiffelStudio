indexing
	description: "Error if a library target has precompiles."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_LIBPRE

inherit
	CONF_ERROR

feature -- Access

	text: STRING is "Library target has a precompile."

end
