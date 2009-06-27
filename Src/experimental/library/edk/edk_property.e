note
	description: "Summary description for {EDK_PROPERTY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EDK_PROPERTY

inherit
	ANY
		redefine
			default_create
		end


feature -- Initialization

	default_create
		do
			name := once ""
		end

feature -- Access

	name: IMMUTABLE_STRING_8
		-- Property name (set when properly registered)

	is_read_only: BOOLEAN
			-- Is `Current' read-only?
		do

		end

end
