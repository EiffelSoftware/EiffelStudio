indexing
	description: "Error for a corrupt metadata cache."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_METADATA_CORRUPT

inherit
	CONF_ERROR
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create is
			-- Create.
		do
			text := "Metadata cache corrupt!"
		end


feature -- Access

	text: STRING;

end
