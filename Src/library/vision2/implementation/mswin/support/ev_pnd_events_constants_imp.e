indexing
	description: "This class is used by EV_PND_SOURCE_IMP. It gives%
				% the identifications of the different events%
				% that can occur. It is a class of constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PND_EVENTS_CONSTANTS_IMP

feature -- General events for pick and drop sources

	Cmd_button_one_press: INTEGER is 4
			-- The first button of the mouse is pressed

	Cmd_button_two_press: INTEGER is 5
			-- The second button of the mouse is pressed

	Cmd_button_three_press: INTEGER is 6
			-- The third button of the mouse is pressed

	Cmd_button_one_release: INTEGER is 7
			-- The first button of the mouse is released

	Cmd_button_two_release: INTEGER is 8
			-- The second button of the mouse is released

	Cmd_button_three_release: INTEGER is 9
			-- The third button of the mouse is released

	Cmd_motion_notify: INTEGER is 10
			-- The pointer of the mouse moved inside the widget

end -- class EV_PND_EVENTS_CONSTANTS_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

