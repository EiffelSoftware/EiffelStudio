class EVENT_CONSTANTS	

feature -- Event labels
	
	Button_click_label: STRING is "Button clicked"
	Change_label: STRING is "Change"
	Close_label: STRING is "Close"
	Column_click_label: STRING is "Column clicked"
	Deselect_label: STRING is "Deselect"
	Destroy_label: STRING is "Destroy widget"
	Double_click_label: STRING is "Destroy widget"
	Entered_label: STRING is "Entered"
	Enter_notify_label: STRING is "Enter notify"
	Event_label: STRING is "Event"
	Filter_label: STRING is "Filter"
	Get_focus_label: STRING is "Get focus"
	Help_label: STRING is "Help"
	Input_label: STRING is "Input"
	Key_press_label: STRING is "Key pressed"
	Key_release_label: STRING is "Key released"
	Leave_notify_label: STRING is "Leave notify"
	Lose_focus_label: STRING is "Lose focus"
	Motion_notify_label: STRING is "Motion notify"
	Mouse1_dbl_click_label: STRING is "Double clik button 1"
	Mouse1_motion_label: STRING is "Motion button 1"
	Mouse1_press_label: STRING is "Button 1 pressed"
	Mouse1_release_label: STRING is "Button 1 released"
	Mouse2_dbl_click_label: STRING is "Double clik button 2"
	Mouse2_motion_label: STRING is "Motion button 2"
	Mouse2_press_label: STRING is "Button 2 pressed"
	Mouse2_release_label: STRING is "Button 2 released"
	Mouse3_dbl_click_label: STRING is "Double clik button 3"
	Mouse3_motion_label: STRING is "Motion button 3"
	Mouse3_press_label: STRING is "Button 3 pressed"
	Mouse3_release_label: STRING is "Button 3 released"
	Move_label: STRING is "Move"
	Ok_label: STRING is "Ok"
	Paint_label: STRING is "Paint"
	Resize_label: STRING is "Resize"
	Return_label: STRING is "Return key pressed"
--	Scr_t_modify_label: STRING is "Text modify"
--	Scr_t_motion_label: STRING is "Text motion"
	Select_label: STRING is "Select"
	Selection_label: STRING is "Selection"
	Subtree_label: STRING is "Subtree"
	Switch_label: STRING is "Switch page"
	Toggle_label: STRING is "Toggle"
--	Value_changed_label: STRING is "Value changed"
	
feature -- Event Catalog labels

	General_label: STRING is "General"
	Button_label: STRING is "Button"
	Drawing_label: STRING is "Drawing area"
	List_label: STRING is "Scrolled list"
	Mouse_label: STRING is "Mouse"

feature -- Event identifiers
-- Important note: DO NOT MODIFY the id values
-- since they are used for store and retrieval
-- of events for build projects.

	select_ev_id: INTEGER is 1
	deselect_ev_id: INTEGER is 2
	subtree_ev_id: INTEGER is 3
	double_click_ev_id: INTEGER is 4

	destroy_ev_id: INTEGER is 5
	get_focus_ev_id: INTEGER is 6
	lose_focus_ev_id: INTEGER is 7
	key_press_ev_id: INTEGER is 8
	key_release_ev_id: INTEGER is 9
	enter_notify_ev_id: INTEGER is 10
	motion_notify_ev_id: INTEGER is 11
	leave_notify_ev_id: INTEGER is 12
	mouse1_press_ev_id: INTEGER is 13
	mouse2_press_ev_id: INTEGER is 14
	mouse3_press_ev_id: INTEGER is 15
	mouse1_release_ev_id: INTEGER is 16
	mouse2_release_ev_id: INTEGER is 17
	mouse3_release_ev_id: INTEGER is 18
	mouse1_motion_ev_id: INTEGER is 19
	mouse2_motion_ev_id: INTEGER is 20
	mouse3_motion_ev_id: INTEGER is 21
	mouse1_dbl_click_ev_id: INTEGER is 22
	mouse2_dbl_click_ev_id: INTEGER is 23
	mouse3_dbl_click_ev_id: INTEGER is 24

	click_ev_id: INTEGER is 25
	toggle_ev_id: INTEGER is 26

	selection_ev_id: INTEGER is 27
	column_click_ev_id: INTEGER is 28

	paint_ev_id: INTEGER is 29
	resize_ev_id: INTEGER is 30

	switch_ev_id: INTEGER is 31

	move_ev_id: INTEGER is 32
	close_ev_id: INTEGER is 33

	change_ev_id: INTEGER is 34
	return_ev_id: INTEGER is 35
--	text_modified_ev_id: INTEGER is 36
--	text_motion_ev_id: INTEGER is 37

end -- class EVENT_CONSTANTS

