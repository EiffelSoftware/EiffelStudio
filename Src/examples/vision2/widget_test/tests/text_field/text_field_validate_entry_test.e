indexing
	description: "Objects that test EV_PASSWORD_FIELD."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_FIELD_VALIDATE_ENTRY_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

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
			-- Display password prompt on `prompt_label', and the number of times
			-- a correct password has been entered.
		do
			prompt_label.set_text ("Correctly entered " +
				input_count.out + " times.%NPlease enter %"banana%" and press return")
		end

feature {NONE} -- Implementation

	text_field: EV_TEXT_FIELD
	
	input_count: INTEGER
	
	prompt_label: EV_LABEL

end -- class TEXT_FIELD_VALIDATE_ENTRY_TEST
