indexing
	description: "Error for old versions."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_VERSION

inherit
	CONF_ERROR_PARSE
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create is
			-- Create.
		do
			message := "Config file format version missmatch."
		end

end
