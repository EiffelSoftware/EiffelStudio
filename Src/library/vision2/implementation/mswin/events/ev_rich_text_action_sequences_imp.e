indexing
	description:
		"Action sequences for EV_RICH_TEXT_IMP."
	keywords: "event, action, sequence"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	 EV_RICH_TEXT_ACTION_SEQUENCES_IMP

inherit
	EV_RICH_TEXT_ACTION_SEQUENCES_I

feature -- Event handling

	create_caret_move_actions: EV_INTEGER_ACTION_SEQUENCE is
			-- Create a caret move action sequence.
		do
			create Result
		end
		
	create_selection_change_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a selection change action sequence.
		do
			create Result
		end
		
	create_file_access_actions: EV_INTEGER_ACTION_SEQUENCE is
			-- Create a file access action sequence.
		do
			create Result
		end
		

end

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

