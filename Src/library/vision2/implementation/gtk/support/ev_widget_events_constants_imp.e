indexing
	description: "This class is used by EV_WIDGET_IMP. It gives%
				% the identifications of the different events%
				% that can occur. It is a class of constants"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WIDGET_EVENTS_CONSTANTS_IMP

feature -- General events for widgets

	button_one_press_event_id: INTEGER is 1
			-- button 1 of the mouse is pressed

	button_two_press_event_id: INTEGER is 2
			-- button 2 of the mouse is pressed

	button_three_press_event_id: INTEGER is 3
			-- button 3 of the mouse is pressed

	button_one_release_event_id: INTEGER is 4
			-- button 1 of the mouse is released

	button_two_release_event_id: INTEGER is 5
			-- button 2 of the mouse is released

	button_three_release_event_id: INTEGER is 6
			-- button 3 of the mouse is released

	button_one_double_click_event_id: INTEGER is 7
			-- button 1 of the mouse is double-clicked

	button_two_double_click_event_id: INTEGER is 8
			-- button 2 of the mouse is double-clicked

	button_three_double_click_event_id: INTEGER is 9
			-- button 3 of the mouse is double-clicked

	key_press_event_id: INTEGER is 10
			-- A key of the keyboard is pressed

	key_release_event_id: INTEGER is 11
			-- A key of the keyboard is released

	motion_notify_event_id: INTEGER is 12
			-- The pointer of the mouse moved inside the widget

	enter_notify_event_id: INTEGER is 13
			-- The pointer of the mouse entered the widget

	leave_notify_event_id: INTEGER is 14
			-- The pointer of the mouse leaved the widget

	destroy_id: INTEGER is 15
			-- The widget gets destroyed.

	focus_in_event_id: INTEGER is 16
			-- The widget gets the focus.

	focus_out_event_id: INTEGER is 17
			-- The widget loses the focus.

	expose_event_id: INTEGER is 18
			-- 

feature -- Events for windows

	resize_event_id: INTEGER is 19
			-- The widget has been resized.

	close_event_id: INTEGER is 20
			-- The widget has been closed.

	move_event_id: INTEGER is 21
			-- The widget has been moved.

feature -- Event for buttons

	clicked_id: INTEGER is 19
			-- The button has been clicked

	toggled_id: INTEGER is 20
			-- The button has been clicked

feature -- Event for items

	select_id: INTEGER is 19
			-- The item has been selected/activated

	deselect_id: INTEGER is 20
			-- The item has been deselected/deactivated

	collapse_id: INTEGER is 21
			-- The user has collapsed a subtree

	expand_id: INTEGER is 22
			-- The user has expanded a subtree

feature -- Event for items, text fields and combo boxes

	activate_id: INTEGER is 23
			-- the "Return" button has been pressed

feature -- Event for notebooks

	switch_page_id: INTEGER is 19
			-- a page is switched in the notebook
 
feature -- Event for lists, trees and combo boxes

	selection_changed_id: INTEGER is 19
			-- the selection has changed

feature -- Event for multi column lists

	select_row_id: INTEGER is 19
			-- a row of the column list has been selected
 
	unselect_row_id: INTEGER is 20
			-- a row of the column list has been unselected

	click_column_id: INTEGER is 21
			-- a column of the column list has been clicked

feature -- Event for text components and combo boxes

	changed_id: INTEGER is 19
			-- the selection has changed
 
feature -- Upper constants value

	command_count: INTEGER is 23
			-- Number of different events

end -- class EV_WIDGET_EVENTS_CONSTANTS_IMP
