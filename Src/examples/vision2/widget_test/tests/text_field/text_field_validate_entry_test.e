indexing
	description: "Objects that test EV_TEXT_FIELD."
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_FIELD_VALIDATE_ENTRY_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			vertical_box: EV_VERTICAL_BOX
		do
			create vertical_box
			create prompt_label
			set_label_text
			vertical_box.extend (prompt_label)
			create text_field
			text_field.set_minimum_width (200)
			text_field.return_actions.extend (agent validate_text_field)
			vertical_box.extend (text_field)
			
			widget := vertical_box
		end

feature {NONE} -- Implementation
		
	validate_text_field is
			-- Check password is correct, and perform necessary
			-- processing.
		do
			if text_field.text.is_equal ("banana") then
				input_count := input_count + 1
				set_label_text
			end
		end
		
	set_label_text is
			-- Display password prompt on `prompt_label' with the
			-- number of times a correct password has been entered.
		do
			prompt_label.set_text ("Correctly entered " +
				input_count.out + " times.%NPlease enter %"banana%" and press return")
		end

	text_field: EV_TEXT_FIELD
		-- Widget that test is to be performed on.
	
	input_count: INTEGER
		-- Counter signifying the number of times a correct password
		-- has been entered.
	
	prompt_label: EV_LABEL
		-- Label showing information about password and the number of
		-- times that correct password has been entered.

end -- class TEXT_FIELD_VALIDATE_ENTRY_TEST
