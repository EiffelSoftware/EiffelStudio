indexing
	description: "Objects that test EV_PASSWORD_FIELD."
	date: "$Date$"
	revision: "$Revision$"

class
	PASSWORD_FIELD_BASIC_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			create password_field
			password_field.set_minimum_width (200)
			
			widget := password_field
		end
		
feature {NONE} -- Implementation

	password_field: EV_PASSWORD_FIELD
		-- Widget that test is to be performed on.

end -- class PASSWORD_FIELD_BASIC_TEST
