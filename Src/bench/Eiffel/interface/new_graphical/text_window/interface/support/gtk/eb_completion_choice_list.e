indexing
	description: "List containing feature or class completion possibilities."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_COMPLETION_CHOICE_LIST

inherit
	EV_LIST

feature -- Status Setting

	disable_default_key_processing is
			-- Disable OS default key processing
		do
				-- Disable user selection of string matching to prevent having to do this.
			implementation.disable_default_key_processing
		end		

end -- class EB_COMPLETION_CHOICE_LIST
