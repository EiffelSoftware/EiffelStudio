indexing
	description: "Objects that provide access to constants loaded from files."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DIALOG_CONSTANTS

--inherit
--	EB_DIALOG_CONSTANTS_IMP

-- Perform any constant redefinitions in this class.

feature -- Dummy

	initialize_constants is
		do
		end

feature -- Access

	close_string: STRING is "Close"
			-- `Result' is STRING constant named `close_string'.

	small_padding: INTEGER is 4
			-- `Result' is INTEGER constant named small_padding.

	default_button_width: INTEGER is 80
			-- `Result' is INTEGER constant named default_button_width.

	tiny_padding: INTEGER is 2
			-- `Result' is INTEGER constant named tiny_padding.
	
end -- class EB_DIALOG_CONSTANTS
