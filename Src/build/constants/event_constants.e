class EVENT_CONSTANTS	

feature -- Event labels
	
	Apply_label: STRING is "Apply";
	Button_activate_label: STRING is "Activate";
	Button_arm_label: STRING is "Arm";
	Button_release_label: STRING is "Release";
	Cancel_label: STRING is "Cancel";
	Changed_label: STRING is "Changed";
	Entered_label: STRING is "Entered";
	Event_label: STRING is "Event";
	Expose_label: STRING is "Expose";
	Filter_label: STRING is "Filter";
	Help_label: STRING is "Help";
	Input_label: STRING is "Input";
	Key_press_label: STRING is "Key press";
	Key_release_label: STRING is "Key release";
	Key_return_label: STRING is "Return key";
	Mouse1d_label: STRING is "Button 1 down";
	Mouse1u_label: STRING is "Button 1 up";
	Mouse2d_label: STRING is "Button 2 down";
	Mouse2u_label: STRING is "Button 2 up";
	Mouse3d_label: STRING is "Button 3 down";
	Mouse3u_label: STRING is "Button 3 up";
	Mouse_enter_label: STRING is "Mouse enter";
	Mouse_leave_label: STRING is "Mouse leave";
	Mouse_motion1_label: STRING is "Motion Button1";
	Mouse_motion2_label: STRING is "Motion Button2";
	Mouse_motion3_label: STRING is "Motion Button3";
	Move_label: STRING is "Move";
	Ok_label: STRING is "Ok";
	Pointer_motion_label: STRING is "Pointer motion";
	Resize_label: STRING is "Resize";
	Scr_t_modify_label: STRING is "Text modify";
	Scr_t_motion_label: STRING is "Text motion";
	Selection_label: STRING is "Selection";
	Translation_label: STRING is "Translation";
	Value_changed_label: STRING is "Value changed";
	Widget_destroy_label: STRING is "Widget Destroy";
	
feature -- Event Catalog labels

	General_label: STRING is "General";
	Button_label: STRING is "Button";
	Drawing_label: STRING is "Drawing area";
	List_label: STRING is "Scrolled list";
	Mouse_label: STRING is "Mouse";

feature -- Event identifiers
-- Important note: DO NOT MODIFY the id values
-- since they are used for store and retrieval
-- of events for build projects.

	but_act_ev_id: INTEGER is 1;
	but_arm_ev_id: INTEGER is 2;
	but_rel_ev_id: INTEGER is 3;
	expose_ev_id: INTEGER is 4;
	input_ev_id: INTEGER is 5;
	key_press_ev_id: INTEGER is 6;
	key_release_ev_id: INTEGER is 7;
	key_return_ev_id: INTEGER is 8;
	mouse1d_ev_id: INTEGER is 9;
	mouse1u_ev_id: INTEGER is 10;
	mouse2d_ev_id: INTEGER is 11;
	mouse2u_ev_id: INTEGER is 12;
	mouse3d_ev_id: INTEGER is 13;
	mouse3u_ev_id: INTEGER is 14;
	mouse_enter_ev_id: INTEGER is 15;
	mouse_leave_ev_id: INTEGER is 16;
	mouse_mot1_ev_id: INTEGER is 17;
	mouse_mot2_ev_id: INTEGER is 18;
	mouse_mot3_ev_id: INTEGER is 19;
	move_ev_id: INTEGER is 20;
	pointer_motion_ev_id: INTEGER is 21;
	resize_ev_id: INTEGER is 22;
	selection_ev_id: INTEGER is 23;
	text_modified_ev_id: INTEGER is 24;
	text_motion_ev_id: INTEGER is 25;
	value_changed_ev_id: INTEGER is 26;
	widget_dest_ev_id: INTEGER is 27;

end
