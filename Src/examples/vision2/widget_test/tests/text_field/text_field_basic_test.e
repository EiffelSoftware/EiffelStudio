indexing
	description: "Objects that test EV_PASSWORD_FIELD."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_FIELD_BASIC_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			create text_field.make_with_text ("An EV_TEXT_FIELD")
			text_field.set_minimum_width (200)
			
			widget := text_field
		end
		
feature {NONE} -- Implementation

	text_field: EV_TEXT_FIELD

end -- class TEXT_FIELD_BASIC_TEST
