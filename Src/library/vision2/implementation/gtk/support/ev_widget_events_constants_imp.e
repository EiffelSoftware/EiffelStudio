--| FIXME NOT_REVIEWED this file has not been reviewed
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

	show_id: INTEGER is 19
			-- The widget has been displayed.

	hide_id: INTEGER is 20
			-- The widget has been hidden.

feature -- Events for windows

	resize_event_id: INTEGER is 21
			-- The widget has been resized.

	close_event_id: INTEGER is 22
			-- The widget has been closed.

	move_event_id: INTEGER is 23
			-- The widget has been moved.

feature -- Event for buttons

	clicked_id: INTEGER is 24
			-- The button has been clicked

	toggled_id: INTEGER is 25
			-- The button has been clicked

feature -- Event for items

	select_id: INTEGER is 26
			-- The item has been selected/activated

	deselect_id: INTEGER is 27
			-- The item has been deselected/deactivated

	collapse_id: INTEGER is 28
			-- The user has collapsed a subtree

	expand_id: INTEGER is 29
			-- The user has expanded a subtree

feature -- Event for items, text fields and combo boxes

	activate_id: INTEGER is 30
			-- the "Return" button has been pressed

feature -- Event for notebooks

	switch_page_id: INTEGER is 31
			-- a page is switched in the notebook
 
feature -- Event for lists and combo boxes

	selection_changed_id: INTEGER is 32
			-- the selection has changed

	select_child_id: INTEGER is 33
			-- the selection has changed

	unselect_child_id: INTEGER is 34
			-- the selection has changed

feature -- Event for ctrees

	tree_select_row_id: INTEGER is 35
			-- an item has been selected

	tree_unselect_row_id: INTEGER is 36
			-- an item has been unselected

	tree_expand_id: INTEGER is 37
			-- an item has been expanded

	tree_collapse_id: INTEGER is 38
			-- an item has been collapsed
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
feature -- Event for multi column lists

	select_row_id: INTEGER is 39
			-- a row of the column list has been selected
 
	unselect_row_id: INTEGER is 40
			-- a row of the column list has been unselected

	click_column_id: INTEGER is 41
			-- a column of the column list has been clicked

feature -- Event for text components and combo boxes
	changed_id: INTEGER is 42
			-- the selection has changed
 
feature -- Event for selection dialog

	ok_clicked_id: INTEGER is 43
			-- `ok' button has been clicked.
 
	cancel_clicked_id: INTEGER is 44
			-- `cancel' button has been clicked.
 
	help_clicked_id: INTEGER is 45
			-- `help' button has been clicked.
			-- Event only for color selection dialog.
 
feature -- Event for rich texts

	insert_text_id: INTEGER is 46
			-- Text has been inserted.

	delete_text_id: INTEGER is 47
			-- Text has been inserted.

feature -- Event for scrollbars, spin buttons and range (GtkScale)

	value_changed_id: INTEGER is 48
			-- The scrollbar has been moved.

feature -- Event for three tool bar toggle button events

	toggled_on_off_id: INTEGER is 49
			-- The button has been `toggled'

	toggled_on_id: INTEGER is 50
			-- The button has been `selected'

	toggled_off_id: INTEGER is 51
			-- The button has been `unselected'

	radio_toggle_id: INTEGER is 52
			-- A toolbar radio button has been `unselected'

feature -- Upper constants value

	command_count: INTEGER is 52
			-- Number of different events

end -- class EV_WIDGET_EVENTS_CONSTANTS_IMP


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

