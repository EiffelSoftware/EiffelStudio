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
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

