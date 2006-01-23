indexing
	description: "Objects that test EV_PASSWORD_FIELD."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PASSWORD_FIELD_VALIDATE_ENTRY_TEST

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
			-- Display password prompt on `prompt_label' with the
			-- number of times a correct password has been entered.
		do
			prompt_label.set_text ("Password correctly entered " +
				password_count.out + " times.%NPlease enter %"apple%" and press return")
		end

feature {NONE} -- Implementation

	password_field: EV_PASSWORD_FIELD
		-- Widget that test is to be performed on.
	
	password_count: INTEGER
		-- Counter for number of correct passwords entered.
	
	prompt_label: EV_LABEL;
		-- Label to show information on about passwords entered.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class PASSWORD_FIELD_VALIDATE_ENTRY_TEST
