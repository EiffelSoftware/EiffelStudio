indexing
	description: "Objects that test EV_PASSWORD_FIELD."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PASSWORD_FIELD_VALIDATE_ENTRY_TEST

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
			create password_field
			password_field.set_minimum_width (200)
			password_field.return_actions.extend (agent validate_password_field)
			vertical_box.extend (password_field)
			
			widget := vertical_box
		end
		
	validate_password_field is
			-- Check password is correct, and perform necessary
			-- processing.
		do
			if password_field.text.is_equal ("apple") then
				password_count := password_count + 1
				set_label_text
			end
		end
		
	set_label_text is
			-- Display password prompt on `prompt_label', and the number of times
			-- a correct password has been entered.
		do
			prompt_label.set_text ("Password correctly entered " +
				password_count.out + " times.%NPlease enter %"apple%" and press return")
		end

feature {NONE} -- Implementation

	password_field: EV_PASSWORD_FIELD
	
	password_count: INTEGER
	
	prompt_label: EV_LABEL

end -- class PASSWORD_FIELD_VALIDATE_ENTRY_TEST
