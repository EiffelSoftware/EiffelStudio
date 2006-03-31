indexing
	description: "Error that the library target has not been defined."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_LIBTAR

inherit
	CONF_ERROR_PARSE
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create is
			-- Create.
		do
			message := "The defined library target could not be found."
		end

end
