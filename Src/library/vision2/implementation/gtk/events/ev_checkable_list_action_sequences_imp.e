indexing
	description: "Action sequences for EV_CHECKABLE_LIST"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHECKABLE_LIST_ACTION_SEQUENCES_IMP

inherit
	EV_CHECKABLE_LIST_ACTION_SEQUENCES_I

feature -- Event handling

	create_check_actions: EV_LIST_ITEM_CHECK_ACTION_SEQUENCE is
			-- Create a select action sequence.
		do
			create Result
		end

	create_uncheck_actions: EV_LIST_ITEM_CHECK_ACTION_SEQUENCE is
			-- Create an uncheck action sequence.
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
