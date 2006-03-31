indexing
	description: "Error that a library target has overset_error (an_error: CONF_ERROR)"
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_LIBOVER

inherit
	CONF_ERROR_PARSE
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create is
			-- Create.
		do
			message := "Library target has overrides."
		end

end
