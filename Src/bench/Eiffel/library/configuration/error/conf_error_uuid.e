indexing
	description: "Invalid uuid"
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_UUID

inherit
	CONF_ERROR_PARSE
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create is
			-- Create.
		do
			message := "Invalid uuid."
		end

end
