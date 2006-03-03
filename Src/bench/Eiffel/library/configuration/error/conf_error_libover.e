indexing
	description: "Error that a library target has overset_error (an_error: CONF_ERROR)"
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_LIBOVER

inherit
	CONF_ERROR

feature -- Access

	text: STRING is "Library target has overrides."

end
