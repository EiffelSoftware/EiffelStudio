--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		" This class is used by EV_WIDGET_IMP. It gives%
		% the identifications of the different events%
		% that can occur. It is a class of constants"
	note: " The gap in the numbers correspond to the pick%
		% and drop events EV_PND_EVENTS_CONSTANTS_IMP."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WIDGET_EVENTS_CONSTANTS_IMP

feature -- General events for widgets

	Cmd_button_one_dblclk: INTEGER is 1
			-- The first button of the mouse is double-clicked

	Cmd_button_two_dblclk: INTEGER is 2
			-- The second button of the mouse is double-clicked

	Cmd_button_three_dblclk: INTEGER is 3
			-- The third button of the mouse is double-clicked

	Cmd_key_press: INTEGER is 11
			-- A key of the keyboard is pressed

	Cmd_key_release: INTEGER is 12
			-- A key of the keyboard is released

	Cmd_enter_notify: INTEGER is 13
			-- The pointer of the mouse entered the widget

	Cmd_leave_notify: INTEGER is 14
			-- The pointer of the mouse leaved the widget

	Cmd_destroy: INTEGER is 15
			-- The widget is destroyed

	Cmd_get_focus: INTEGER is 16
			-- The widget gets the focus.

	Cmd_lose_focus: INTEGER is 17
			-- The widget looses the focus.

feature -- Events for buttons

	Cmd_click: INTEGER is 18
			-- The button widget is clicked

	Cmd_toggle: INTEGER is 19
			-- The 2 state button change its state

feature -- Events for list and mc-list
	
	Cmd_select: INTEGER is 20
			-- The list has been selected.

	Cmd_unselect: INTEGER is 21
			-- The list has been unselected.

	Cmd_column_click: INTEGER is 22
			-- The user double clicked on an item

feature -- Events for windows

	Cmd_size: INTEGER is 23
			-- The window has been resized

	Cmd_close: INTEGER is 24
			-- The window has been closed

	Cmd_move: INTEGER is 25
			-- The window has moved

feature -- Event for drawing area

--	Cmd_size: INTEGER is 26
--			-- The drawing has been resized

	Cmd_paint: INTEGER is 27
			-- The drawing need to be repainted.

feature -- Event for text_components

--	Cmd_selection: INTEGER is 28
			-- The text inside the component is modified by the
			-- user

	Cmd_activate: INTEGER is 29
			-- The text inside the componant is going to be
			-- update after a change of the user.

	Cmd_change: INTEGER is 30
			-- The text in the text container have changed.

feature -- Event for the gauge

	Cmd_gauge: INTEGER is 31
			-- The value has been changed by the user.

feature -- Event for notebook

	Cmd_switch: INTEGER is 32
			-- The user has switch between two pages of a notebook.

feature -- Event for rich text

	Cmd_insert_text: INTEGER is 33
			-- The user inserts a character

	Cmd_delete_text: INTEGER is 34
			-- The user deletes a character to the left of the current position

	Cmd_delete_right_character: INTEGER is 35
			-- The user deletes a character to the right of the current position

	Cmd_undo: INTEGER is 36
			-- The user wants to undo a command

	Cmd_redo: INTEGER is 37
			-- The user wants to redo a command

	Cmd_paste: INTEGER is 38
			-- The user wants to redo a command

feature -- Event for text editor

	Cmd_indent_lines: INTEGER is 39
			-- The user wants to indent the selected lines

	Cmd_deindent_lines: INTEGER is 40
			-- The user wants to deindent the selected lines

	Cmd_comment_lines: INTEGER is 41
			-- The user wants to comment the selected lines

	Cmd_decomment_lines: INTEGER is 42
			-- The user wants to decomment the selected lines
	
feature -- Upper constants value

	command_count: INTEGER is 42
			-- Number of different events.

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.13  2000/02/14 11:40:42  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.12.6.2  2000/01/27 19:30:17  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.12.6.1  1999/11/24 17:30:23  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.12.2.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
