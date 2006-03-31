indexing
	description: "Error if a library target has precompiles."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_LIBPRE

inherit
	CONF_ERROR_PARSE
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create is
			-- Create.
		do
			message := "Library target has a precompile."
		end

end
