indexing
	description: "Intermediary routines between gtk and eiffel."
	date: "$Date$"
	revision: "$Revision$"


class
	EV_INTERMEDIARY_ROUTINES

inherit
	IDENTIFIED
		undefine
			copy, is_equal
		end
		
	ANY
	
feature {EV_ANY_IMP} -- Timeout intermediary agent routine

	on_timeout_intermediary (a_object_id: INTEGER) is
			-- Timeout has occurred.
		local
			a_timeout_imp: EV_TIMEOUT_IMP
		do
			a_timeout_imp ?= eif_id_object (a_object_id)
			if a_timeout_imp /= Void and then not a_timeout_imp.is_destroyed then
				-- Timeout may possibly have been gc'ed.
				a_timeout_imp.call_timeout_actions
			end
		end
		
	on_timeout_kamikaze_intermediary (a_object_id: INTEGER) is
			-- Kamikaze Timeout has occurred.
		local
			a_timeout_imp: EV_TIMEOUT_IMP
		do
			a_timeout_imp ?= eif_id_object (a_object_id)
			if a_timeout_imp /= Void and then not a_timeout_imp.is_destroyed then
				-- Timeout may possibly have been gc'ed.
				a_timeout_imp.call_timeout_actions
			end
		end

feature {EV_ANY_IMP} -- Notebook intermediary agent routines

	on_notebook_page_switch_intermediary (a_c_object: POINTER; a_tuple: TUPLE [INTEGER]) is
			-- Notebook page is switched
		local
			a_notebook_imp: EV_NOTEBOOK_IMP
		do
			a_notebook_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_notebook_imp.page_switch (a_tuple)
		end

feature {EV_ANY_IMP} -- Toolbar intermediary agent routines

	on_tool_bar_radio_button_activate (a_c_object: POINTER) is
			-- Toolbar button activated
		local
			a_tool_bar_radio_button_imp: EV_TOOL_BAR_RADIO_BUTTON_IMP
		do
			a_tool_bar_radio_button_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_tool_bar_radio_button_imp.on_activate
		end

	toolbar_button_select_actions_intermediary (a_c_object: POINTER) is
			-- Intermediary agent for toolbar button select action
		local
			a_toolbar_button_imp: EV_TOOL_BAR_BUTTON_IMP
		do
			a_toolbar_button_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_toolbar_button_imp.select_actions_internal.call (empty_tuple)
		end

feature {EV_ANY_IMP} -- Drawing Area intermediary agent routines

	on_drawing_area_event_intermediary (a_c_object: POINTER; a_event_number: INTEGER) is
			-- Drawing area focus lost or gained
		local
			a_drawing_area_imp: EV_DRAWING_AREA_IMP
		do
			a_drawing_area_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			inspect
				a_event_number
			when 1 then		
				a_drawing_area_imp.set_focus
			when 2 then
				a_drawing_area_imp.lose_focus
			end
		end

	create_expose_actions_intermediary (a_c_object: POINTER; x, y, width, height: INTEGER) is
			-- Area needs to be redrawn
		local
			a_drawing_area_imp: EV_DRAWING_AREA_IMP
		do
			a_drawing_area_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			if a_drawing_area_imp /= Void then
				a_drawing_area_imp.call_expose_actions (x, y, width, height)
			end
		end

feature {EV_ANY_IMP} -- Gauge intermediary agent routines

	on_gauge_value_changed_intermediary (a_c_object: POINTER) is
			-- Gauge value changed
		local
			a_gauge_imp: EV_GAUGE_IMP
		do
			a_gauge_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_gauge_imp.value_changed_handler			
		end

feature {EV_ANY_IMP} -- Key Event intermediary agent routines

	on_key_event_intermediary (a_c_object: POINTER; a_key: EV_KEY; a_key_string: STRING; a_key_press: BOOLEAN) is
			-- Key event
		local
			a_widget: EV_WIDGET_IMP
		do
			a_widget ?= c_get_eif_reference_from_object_id (a_c_object)
			if a_widget /= Void then
				a_widget.on_key_event (a_key, a_key_string, a_key_press)
			end
		end

feature {EV_ANY_IMP} -- List and list item intermediary agent routines
		
	on_list_item_list_key_pressed_intermediary (a_c_object: POINTER; a_key: EV_KEY; a_key_string: STRING; a_key_press: BOOLEAN) is
			-- List item selected
		local
			a_list_item_list: EV_LIST_ITEM_LIST_IMP
		do
			a_list_item_list ?= c_get_eif_reference_from_object_id (a_c_object)
			a_list_item_list.on_key_pressed (a_key, a_key_string, a_key_press)
		end
		
	on_list_item_list_item_clicked_intermediary (a_c_object: POINTER) is
			-- List item clicked
		local
			a_list_item_list: EV_LIST_ITEM_LIST_IMP
		do
			a_list_item_list ?= c_get_eif_reference_from_object_id (a_c_object)
			a_list_item_list.on_item_clicked
		end

	list_proximity_intermediary (a_c_object: POINTER; in_out_flag: BOOLEAN) is
			-- Pointer entered or left
		local
			a_list_imp: EV_LIST_IMP
		do
			a_list_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_list_imp.set_is_out (in_out_flag)
		end

	on_list_focus_intermediary (a_c_object: POINTER; in_out_flag: BOOLEAN) is
			-- Focus gained or lost
		local
			a_list_imp: EV_LIST_IMP
		do
			a_list_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			if in_out_flag then
				a_list_imp.attain_focus
			else
				a_list_imp.lose_focus
			end
		end

	mcl_event_intermediary (a_c_object: POINTER; a_event_number: INTEGER; a_tup_int: TUPLE [INTEGER]) is
			-- Multi-column list event
		local
			a_mcl_imp: EV_MULTI_COLUMN_LIST_IMP
		do
			a_mcl_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			inspect
				a_event_number
			when 1 then		
				a_mcl_imp.select_callback (a_tup_int)
			when 2 then
				a_mcl_imp.deselect_callback (a_tup_int)
			when 3 then
				a_mcl_imp.column_click_callback (a_tup_int)
			when 4 then
				a_mcl_imp.column_resize_callback (a_tup_int)
			end
		end

	list_item_select_callback_intermediary (a_c_object: POINTER; n_args: INTEGER; args: POINTER) is
			-- Item select callback
		local
			l_list_item_list: EV_LIST_ITEM_LIST_IMP
		do
			l_list_item_list ?= c_get_eif_reference_from_object_id (a_c_object)
			l_list_item_list.select_callback (n_args, args)
		end
		
	list_item_check_intermediary (a_c_object: POINTER) is
			-- List item check button callback
		local
			l_list_item_imp: EV_LIST_ITEM_IMP
		do
			l_list_item_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			l_list_item_imp.check_callback
		end

	list_item_deselect_callback_intermediary (a_c_object: POINTER; n_args: INTEGER; args: POINTER) is
			-- Item deselect callback
		local
			l_list_item_list: EV_LIST_ITEM_LIST_IMP
		do
			l_list_item_list ?= c_get_eif_reference_from_object_id (a_c_object)
			if not l_list_item_list.is_destroyed then
				l_list_item_list.deselect_callback (n_args, args)
			end
		end
		
	list_clicked_intermediary (a_c_object: POINTER) is
			-- List clicked
		local
			l_list_item_list: EV_LIST_ITEM_LIST_IMP
		do
			l_list_item_list ?= c_get_eif_reference_from_object_id (a_c_object)
			l_list_item_list.on_list_clicked
		end
		
	list_key_pressed_intermediary (a_c_object: POINTER; ev_key: EV_KEY; a_key_string: STRING; a_key_press: BOOLEAN) is
			-- Key pressed in list
		local
			l_list_item_list: EV_LIST_ITEM_LIST_IMP
		do
			l_list_item_list ?= c_get_eif_reference_from_object_id (a_c_object)
			l_list_item_list.on_key_pressed (ev_key, a_key_string, a_key_press)
		end
		
	list_item_clicked_intermediary (a_c_object: POINTER) is
			-- List item clicked
		local
			l_list_item_list: EV_LIST_ITEM_LIST_IMP
		do
			l_list_item_list ?= c_get_eif_reference_from_object_id (a_c_object)
			l_list_item_list.on_item_clicked ()
		end

	mcl_start_transport_filter_intermediary (a_c_object: POINTER; a_type: INTEGER; a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is	
			-- Intermediary agent for a multi column list pnd transport event
		local
			mcl_imp: EV_MULTI_COLUMN_LIST_IMP
		do
			mcl_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			mcl_imp.start_transport_filter (a_type, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
		end

feature {EV_ANY_IMP} -- Widget intermediary agent routines

	on_size_allocate_intermediate (a_c_object: POINTER; a_x, a_y, a_width, a_height: INTEGER) is
			-- Size allocate happened on widget
		local
			a_widget: EV_WIDGET_IMP
		do
			a_widget ?= c_get_eif_reference_from_object_id (a_c_object)
			if a_widget /= Void then
				a_widget.on_size_allocate (a_x, a_y, a_width, a_height)
			end	
		end

	widget_focus_in_intermediary (a_c_object: POINTER) is
			-- Focus in
		local
			a_widget: EV_WIDGET_IMP
		do
			a_widget ?= c_get_eif_reference_from_object_id (a_c_object)
			if a_widget /= Void then
				a_widget.on_focus_changed (True)
			end
		end
		
	widget_focus_out_intermediary (a_c_object: POINTER) is
			-- Focus out
		local
			a_widget: EV_WIDGET_IMP
		do
			a_widget ?= c_get_eif_reference_from_object_id (a_c_object)
			if a_widget /= Void then
				a_widget.on_focus_changed (False)
			end
		end	

feature {EV_ANY_IMP} -- Text component intermediary agent routines
		
	text_component_change_intermediary (a_c_object: POINTER) is
			-- Changed
		local
			a_text_component_imp: EV_TEXT_COMPONENT_IMP
		do
			a_text_component_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_text_component_imp.on_change_actions
		end
		
	text_field_return_intermediary (a_c_object: POINTER) is
			-- Return
		local
			a_text_field_imp: EV_TEXT_FIELD_IMP
		do
			a_text_field_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_text_field_imp.return_actions_internal.call (Empty_tuple)
		end	 	
		
feature {EV_ANY_IMP} -- Button intermediary agent routines	
		
	button_select_intermediary (a_c_object: POINTER) is
			-- Selected
		local
			a_button_imp: EV_BUTTON_IMP
		do
			a_button_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			if a_button_imp.select_actions_internal /= Void then
				a_button_imp.select_actions_internal.call (Empty_tuple)
			end
		end
		
	connect_button_press_switch_intermediary (a_c_object: POINTER) is
			-- Connect button switch 
		local
			a_widget: EV_WIDGET_IMP
		do
			a_widget ?= c_get_eif_reference_from_object_id (a_c_object)
			a_widget.connect_button_press_switch
		end	
		
	button_press_switch_intermediary (a_c_object: POINTER; a_type: INTEGER;	a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER) is
			--  Call to switch between type of button press event
		local
			a_widget: EV_WIDGET_IMP
		do
			a_widget ?= c_get_eif_reference_from_object_id (a_c_object)
			a_widget.button_press_switch 
				(a_type, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
		end
		
feature {EV_ANY_IMP} -- Combo box intermediary agent routines

	on_combo_box_dropdown_unmapped (a_c_object: POINTER) is
			-- Button released
		local
			a_combo_box_imp: EV_COMBO_BOX_IMP
		do
			a_combo_box_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_combo_box_imp.launch_select_actions
		end

feature {EV_ANY_IMP} -- Window intermediary agent routines
		
	on_window_close_request (a_c_object: POINTER) is
			-- Close requested
		local
			a_window_imp: EV_WINDOW_IMP
		do
			a_window_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			check
				a_window_imp_not_void: a_window_imp /= Void
			end
			a_window_imp.call_close_request_actions
		end
		
	on_widget_show (a_c_object: POINTER) is
			-- Widget has been shown
		local
			a_widget_imp: EV_WIDGET_IMP
		do
			a_widget_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			check
				a_widget_imp_not_void: a_widget_imp /= Void
			end
			a_widget_imp.on_widget_mapped
		end
	
feature {EV_ANY_IMP} -- Tree intermediary agent routines	
	
	on_tree_event_intermediary (a_c_object: POINTER; a_event_number: INTEGER; a_tree_item: POINTER) is
			-- Tree event
		local
			a_tree_imp: EV_TREE_IMP
		do
			a_tree_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			inspect
				a_event_number
			when 1 then		
				a_tree_imp.select_callback (a_tree_item)
			when 2 then
				a_tree_imp.deselect_callback (a_tree_item)
			when 3 then
				a_tree_imp.expand_callback (a_tree_item)
			when 4 then
				a_tree_imp.collapse_callback (a_tree_item)
			end
		end

	tree_start_transport_filter_intermediary (a_c_object: POINTER; a_type: INTEGER; a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE;	a_screen_x, a_screen_y: INTEGER) is
			-- Start of pick and drop transport
		local
			tree_imp: EV_TREE_IMP
		do
			tree_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			tree_imp.start_transport_filter (a_type, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
		end	

feature {EV_ANY_IMP} -- Menu intermediary agent routines

	menu_item_activate_intermediary (a_c_object: POINTER) is
			-- Item activated
		local
			a_menu_item_imp: EV_MENU_ITEM_IMP
		do
			a_menu_item_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			if a_menu_item_imp.parent_imp /= Void then
				a_menu_item_imp.on_activate
			end
		end

feature {EV_ANY_IMP} -- Pick and Drop intermediary agent routines

	start_drag_filter_intermediary (a_c_object: POINTER; a_type: INTEGER; a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Start filtering out double-click events
		local
			a_pick_and_dropable_imp: EV_WIDGET_IMP
		do
			a_pick_and_dropable_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_pick_and_dropable_imp.start_dragable_filter (a_type, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
		end

	start_transport_filter_intermediary (a_c_object: POINTER; a_type: INTEGER; a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Start filtering out double-click events
		local
			a_pick_and_dropable_imp: EV_PICK_AND_DROPABLE_IMP
		do
			a_pick_and_dropable_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_pick_and_dropable_imp.start_transport_filter (a_type, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
		end

	end_transport_filter_intermediary (a_c_object: POINTER; a_type, a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- End filtering out of double-click events
		local
			a_pick_and_dropable_imp: EV_PICK_AND_DROPABLE_IMP
		do
			a_pick_and_dropable_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_pick_and_dropable_imp.end_transport_filter (a_type, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
		end
		
	end_transport_intermediary (a_c_object: POINTER ;a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- End pick and drop transport
		local
			a_pick_and_dropable_imp: EV_PICK_AND_DROPABLE_IMP
		do
			a_pick_and_dropable_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_pick_and_dropable_imp.end_transport (a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
		end
		
	temp_execute_intermediary (a_c_object: POINTER; a_x, a_y: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Executed when pebble is being moved
		local
			a_pick_and_dropable_imp: EV_PICK_AND_DROPABLE_IMP
		do
			a_pick_and_dropable_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_pick_and_dropable_imp.temp_execute (a_x, a_y, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
		end
		
	signal_emit_stop_intermediary (a_c_object: POINTER; signal: STRING) is
			-- Emit stop signal 
		local
			a_cs: C_STRING
			a_pick_and_dropable_imp: EV_PICK_AND_DROPABLE_IMP
		do
			create a_cs.make (signal)
			a_pick_and_dropable_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.signal_emit_stop_by_name (a_c_object, a_cs.item)
		end

	add_grab_cb_intermediary (a_c_object: POINTER) is
			-- Disconnect callback that called us and enable capture
		local
			a_pick_and_dropable_imp: EV_PICK_AND_DROPABLE_IMP
		do
			a_pick_and_dropable_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_pick_and_dropable_imp.add_grab_cb
		end

feature {EV_ANY_IMP} -- Pointer intermediary agent routines	

	pointer_motion_action_intermediary (a_c_object: POINTER; a_x, a_y: INTEGER;
		a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Pointer motion
		local
			widget: EV_WIDGET_IMP
		do
			widget ?= c_get_eif_reference_from_object_id (a_c_object)
			widget.pointer_motion_actions_internal.call 
				([a_x, a_y, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y])
		end

	pointer_button_release_action_intermediary (a_c_object: POINTER; a_x, a_y, a_button: INTEGER;
		a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Pointer button released
		local
			widget: EV_WIDGET_IMP
		do
			widget ?= c_get_eif_reference_from_object_id (a_c_object)
			widget.pointer_button_release_actions.call 
				([a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y])
		end
		
	pointer_leave_action_intermediary (a_c_object: POINTER) is
			-- Pointer left
		local
			widget: EV_WIDGET_IMP
		do
			widget ?= c_get_eif_reference_from_object_id (a_c_object)
			widget.pointer_leave_actions_internal.call (empty_tuple)
		end
		
	pointer_enter_actions_intermediary (a_c_object: POINTER) is
			-- Pointer entered
		local
			widget: EV_WIDGET_IMP
		do
			widget ?= c_get_eif_reference_from_object_id (a_c_object)
			widget.pointer_enter_actions_internal.call (empty_tuple)
		end
		
feature {EV_ANY_IMP} -- Dialog intermediary agent routines			
		
	color_dialog_on_ok_intermediary (a_c_object: POINTER) is
			-- Color dialog ok
		local
			a_color_dialog_imp: EV_COLOR_DIALOG_IMP
		do
			a_color_dialog_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_color_dialog_imp.on_ok
		end
		
	color_dialog_on_cancel_intermediary (a_c_object: POINTER) is
			-- Color dialog cancel
		local
			a_color_dialog_imp: EV_COLOR_DIALOG_IMP
		do
			a_color_dialog_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_color_dialog_imp.on_cancel
		end
	
	directory_dialog_on_ok_intermediary (a_c_object: POINTER) is
			-- Directory dialog ok
		local
			a_directory_dialog_imp: EV_DIRECTORY_DIALOG_IMP
		do
			a_directory_dialog_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_directory_dialog_imp.on_ok
		end	
		
	directory_dialog_on_cancel_intermediary (a_c_object: POINTER) is
			-- Directory dialog cancel
		local
			a_directory_dialog_imp: EV_DIRECTORY_DIALOG_IMP
		do
			a_directory_dialog_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_directory_dialog_imp.on_cancel
		end	
		
	file_dialog_on_ok_intermediary (a_c_object: POINTER) is
			-- File dialog ok
		local
			a_file_dialog_imp: EV_FILE_DIALOG_IMP
		do
			a_file_dialog_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_file_dialog_imp.on_ok
		end	
		
	file_dialog_on_cancel_intermediary (a_c_object: POINTER) is
			-- File dialog cancel
		local
			a_file_dialog_imp: EV_FILE_DIALOG_IMP
		do
			a_file_dialog_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_file_dialog_imp.on_cancel
		end	
	
	font_dialog_on_ok_intermediary (a_c_object: POINTER) is
			-- Font dialog ok
		local
			a_font_dialog_imp: EV_FONT_DIALOG_IMP
		do
			a_font_dialog_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_font_dialog_imp.on_ok
		end	
	
	font_dialog_on_cancel_intermediary (a_c_object: POINTER) is
			-- Font dialog cancel
		local
			a_font_dialog_imp: EV_FONT_DIALOG_IMP
		do
			a_font_dialog_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_font_dialog_imp.on_cancel
		end	

feature {EV_ANY_IMP} -- Accelerator intermediary agent routines

	accelerator_actions_internal_intermediary (a_c_object: POINTER) is
			-- Intermediary agent for accelerator show action
		local
			a_accelerator_imp: EV_ACCELERATOR_IMP
		do
			a_accelerator_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_accelerator_imp.actions_internal.call (empty_tuple)
		end

feature {EV_GTK_CALLBACK_MARSHAL, EV_ANY_IMP} -- Tuple optimizations

	empty_tuple: TUPLE is
		once
			Result := []
		end

feature {EV_ANY_IMP} -- Externals

	frozen c_get_eif_reference_from_object_id (a_c_object: POINTER): EV_ANY_IMP is
			-- Get Eiffel object from `a_c_object'.
		external
			"C (GtkWidget*): EIF_REFERENCE | %"ev_any_imp.h%""
		alias
			"c_ev_any_imp_get_eif_reference_from_object_id"
		end

end -- class EV_INTERMEDIARY_ROUTINES

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

