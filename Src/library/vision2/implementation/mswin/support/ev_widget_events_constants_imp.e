indexing
	description: "This class is used by EV_WIDGET_IMP. It gives%
				% the identifications of the different events%
				% that can occur. It is a class of constants"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WIDGET_EVENTS_CONSTANTS_IMP

feature -- General events for widgets

	Cmd_button_one_press: INTEGER is 1
			-- The first button of the mouse is pressed

	Cmd_button_two_press: INTEGER is 2
			-- The second button of the mouse is pressed

	Cmd_button_three_press: INTEGER is 3
			-- The third button of the mouse is pressed

	Cmd_button_one_release: INTEGER is 4
			-- The first button of the mouse is released

	Cmd_button_two_release: INTEGER is 5
			-- The second button of the mouse is released

	Cmd_button_three_release: INTEGER is 6
			-- The third button of the mouse is released

	Cmd_button_one_dblclk: INTEGER is 7
			-- The first button of the mouse is double-clicked

	Cmd_button_two_dblclk: INTEGER is 8
			-- The second button of the mouse is double-clicked

	Cmd_button_three_dblclk: INTEGER is 9
			-- The third button of the mouse is double-clicked

	Cmd_key_press: INTEGER is 10
			-- A key of the keyboard is pressed

	Cmd_key_release: INTEGER is 11
			-- A key of the keyboard is released

	Cmd_motion_notify: INTEGER is 12
			-- The pointer of the mouse moved inside the widget

	Cmd_enter_notify: INTEGER is 13
			-- The pointer of the mouse entered the widget

	Cmd_leave_notify: INTEGER is 14
			-- The pointer of the mouse leaved the widget

	Cmd_expose: INTEGER is 15
			-- The widget is exposed after having been hidden
			-- by the user or behind a windows.

	Cmd_destroy: INTEGER is 16
			-- The widget is destroyed

feature -- Events for buttons

	Cmd_click: INTEGER is 17
			-- The button widget is clicked

	Cmd_toggle: INTEGER is 18
			-- The 2 state button change its state

feature -- Events for list

	Cmd_selection: INTEGER is 17
			-- The selection of the list has changed

	Cmd_dblclk: INTEGER is 18
			-- The user double clicked on an item

feature -- Event for text_components

--	Cmd_selection: INTEGER is 17
			-- The text inside the component is modified by the
			-- user

	Cmd_activate: INTEGER is 18
			-- The text inside the componant is going to be
			-- update after a change of the user.

end -- class EV_WIDGET_EVENTS_CONSTANTS_IMP

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
