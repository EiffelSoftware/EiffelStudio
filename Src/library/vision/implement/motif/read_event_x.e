

indexing

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class READ_EVENT_X 

inherit

	EVENT_HDL
		export
			{NONE} all
		end;

	READ_EVENT_R_X
		export
			{NONE} all
		end
	
feature {NONE}

	buttons_state: BUTTONS is
			-- State of buttons when the event occurs
		
		local
			i: INTEGER
		do
			!!Result.make (5);
			from
				i := 1
			until
				i > 5
			loop
				Result.put (c_event_button_state (i) , i);
				i := i+1
			end
		end;

	modifiers_state: KEYBOARD is
			-- State of modifier keys
		
		local
			i: INTEGER
		do
			!!Result.make (5);
			Result.set_shift_pressed (c_event_shift_state );
			Result.set_control_pressed (c_event_control_state );
			Result.set_lock_pressed (c_event_lock_state );
			from
				i := 1
			until
				i > 5
			loop
				Result.modifiers.put (c_event_modifier_state (i) , i);
				i := i+1
			end
		end;

	button_press_data (widget_oui: WIDGET): BTPRESS_DATA is
			-- Create a context for `ButtonPress' event.
		
		do
			!!Result.make (widget_oui, 
							c_event_x_relative, 
							c_event_y_relative, 
							c_event_x_pointer, 
							c_event_y_pointer, 
							c_event_button, 
							buttons_state,
							modifiers_state)
		end;

	button_release_data (widget_oui: WIDGET): BUTREL_DATA is
			-- Create a context for `ButtonRelease' event.
			
		do
					!!Result.make (widget_oui, c_event_x_relative, 
								c_event_y_relative, 
								c_event_x_pointer, 
								c_event_y_pointer, 
								c_event_button, 
								buttons_state,
								modifiers_state)
		end;

	clik_time: INTEGER;
			-- last button press

	click_threshold: INTEGER_REF is
			-- time granted for clicking
		once
			!! Result;
			Result.set_item (200)
		end;

	set_click_threshold (time: INTEGER) is
			-- time is in millisecond, default is 200 ms
		do
			click_threshold.set_item (time)
		end;

	get_time: INTEGER is
			-- time the event occured
		do
			Result :=  c_event_time
		end;

	get_multi_click_time: INTEGER is
		do
			Result := click_threshold.item
		end;

	set_multi_click_time (time: INTEGER) is
		do
			set_click_threshold (time)
		end;

	button_click_data (widget_oui: WIDGET): BUTCLICK_DATA is
			-- Create a context for `ButtonClick' event.
		do
			!!Result.make (widget_oui, c_event_x_relative,
					c_event_y_relative,
					c_event_x_pointer,
					c_event_y_pointer,
					c_event_button,
					buttons_state)
		end;

	circulate_notify_data (widget_oui: WIDGET): CIRCNOT_DATA is
			-- Create a context for `CirculateNotify' event.
			
		do
			!!Result.make (widget_oui, c_event_place_on_top )
		end;

	circulate_request_data (widget_oui: WIDGET): CIRCREQ_DATA is
			-- Create a context for `CirculateRequest' event.
			
		do
			!!Result.make (widget_oui, c_event_place_on_top )
		end;

	client_message_data (widget_oui: WIDGET): MESSAGE_DATA is
			-- Create a context for `ClientMessage' event.
		do
			!!Result.make (widget_oui)
		end;

	colormap_notify_data (widget_oui: WIDGET): CLRMAP_DATA is
			-- Create a context for `ColormapNotify' event.
		do
			!!Result.make (widget_oui)
		end; 

	configure_notify_data (widget_oui: WIDGET): CONFNOT_DATA is
			-- Create a context for `ConfigureNotify' event.
			
		do
			!!Result.make (widget_oui, 
							c_event_x, 
							c_event_y, 
							c_event_width, 
							c_event_height, 
							c_event_border_width)
		end;

	configure_request_data (widget_oui: WIDGET): CONFREQ_DATA is
			-- Create a context for `ConfigureRequest' event.
			
		do
			!!Result.make (widget_oui, 
							c_event_x, 
							c_event_y, 
							c_event_width, 
							c_event_height, 
							c_event_border_width)
		end;

	
feature 

	create_context_data (widget_oui: WIDGET): CONTEXT_DATA is
			-- Create a context data for the current action.
		
		do
			inspect
				get_event_type
			when ButtonPress then
				clik_time := get_time;		
				Result := button_press_data (widget_oui)
			when ButtonRelease then
				if (get_time - clik_time < click_threshold.item) then
					Result := button_click_data (widget_oui)
				else	
					Result := button_release_data (widget_oui)
				end
			when CirculateNotify then
				Result := circulate_notify_data (widget_oui)
			when CirculateRequest then
				Result := circulate_request_data (widget_oui)
			when ClientMessage then
				Result := client_message_data (widget_oui)
			when ColormapNotify then
				Result := colormap_notify_data (widget_oui)
			when ConfigureNotify then
				Result := configure_notify_data (widget_oui)
			when ConfigureRequest then
				Result := configure_request_data (widget_oui)
			when CreateNotify then
				Result := create_notify_data (widget_oui)
			when DestroyNotify then
				Result := destroy_notify_data (widget_oui)
			when EnterNotify then
				Result := enter_notify_data (widget_oui)
			when Expose then
				Result := expose_data (widget_oui)
			when FocusIn then
				Result := focus_in_data (widget_oui)
			when FocusOut then
				Result := focus_out_data (widget_oui)
			when GraphicsExpose then
				Result := graphics_expose_data (widget_oui)
			when GravityNotify then
				Result := gravity_notify_data (widget_oui)
			when KeymapNotify then
				Result := keymap_notify_data (widget_oui)
			when KeyPress then
				Result := key_press_data (widget_oui)
			when KeyRelease then
				Result := key_release_data (widget_oui)
			when LeaveNotify then
				Result := leave_notify_data (widget_oui)
			when MapNotify then
				Result := map_notify_data (widget_oui)
			when MappingNotify then
				Result := mapping_notify_data (widget_oui)
			when MapRequest then
				Result := map_request_data (widget_oui)
			when MotionNotify then
				Result := motion_notify_data (widget_oui)
			when NoExpose then
				Result := no_expose_data (widget_oui)
			when PropertyNotify then
				Result := property_notify_data (widget_oui)
			when ReparentNotify then
				Result := reparent_notify_data (widget_oui)
			when ResizeRequest then
				Result := resize_request_data (widget_oui)
			when SelectionClear then
				Result := selection_clear_data (widget_oui)
			when SelectionNotify then
				Result := selection_notify_data (widget_oui)
			when SelectionRequest then
				Result := selection_request_data (widget_oui)
			when UnmapNotify then
				Result := unmap_notify_data (widget_oui)
			when VisibilityNotify then
				Result := visible_notify_data (widget_oui)
			else
			end
		end;

	
feature {NONE}

	create_notify_data (widget_oui: WIDGET): CREATE_DATA is
			--
		do
			!!Result.make (widget_oui)
		end;

	destroy_notify_data (widget_oui: WIDGET): DESTROY_DATA is
			--
		do
			!!Result.make (widget_oui)
		end;

	enter_notify_data (widget_oui: WIDGET): ENTER_DATA is
			--
		do
		end; 

	expose_data (widget_oui: WIDGET): EXPOSE_DATA is
			--
		
		local
			clip: CLIP;
			coord: COORD_XY
		do
			!!coord;
			coord.set (c_event_clip_x, c_event_clip_y);
			!!clip;
			clip.set (coord, c_event_clip_width, c_event_clip_height);
			!!Result.make (widget_oui, clip)
		end;

	focus_in_data (widget_oui: WIDGET): FOCUSIN_DATA is
			--
		do
		end;

	focus_out_data (widget_oui: WIDGET): FOCSOUT_DATA is
			--
		do
		end;

	graphics_expose_data (widget_oui: WIDGET): GRAPEXP_DATA is
			--
		do
		end; 

	gravity_notify_data (widget_oui: WIDGET): GRAVNOT_DATA is
			--
		do
		end;

	key_press_data (widget_oui: WIDGET): KYPRESS_DATA is
			--
		do
			--!!Result.make (widget_oui, c_event_keypress_code, c_event_keypress_string, modifiers_state);
		end;

	key_release_data (widget_oui: WIDGET): KEYREL_DATA is
			--
			
			do
					!!Result.make (widget_oui, c_event_keypress_code, c_event_keypress_string, modifiers_state)
		end; 

	keymap_notify_data (widget_oui: WIDGET): KEYMAP_DATA is
			--
		do
		end;

	leave_notify_data (widget_oui: WIDGET): LEAVE_DATA is
			--
		do
		end;

	map_notify_data (widget_oui: WIDGET): MAPNOT_DATA is
			--
		do
		end;

	map_request_data (widget_oui: WIDGET): MAPREQ_DATA is
			--
		do
		end;

	mapping_notify_data (widget_oui: WIDGET): MAPPING_DATA is
			--
		do
		end;

	motion_notify_data (widget_oui: WIDGET): MOTNOT_DATA is
			--
		do
		end;

	no_expose_data (widget_oui: WIDGET): NOEXP_DATA is
			--
		do
		end;

	property_notify_data (widget_oui: WIDGET): PROPERT_DATA is
			--
		do
		end;

	reparent_notify_data (widget_oui: WIDGET): REPAREN_DATA is
			--
		do
		end;

	resize_request_data (widget_oui: WIDGET): RESIZE_DATA is
			--
		do
		end;

	selection_clear_data (widget_oui: WIDGET): SELCLR_DATA is
			--
		do
		end;

	selection_notify_data (widget_oui: WIDGET): SELNOT_DATA is
			--
		do
		end;

	selection_request_data (widget_oui: WIDGET): SELREQ_DATA is
			--
		do
		end;

	unmap_notify_data (widget_oui: WIDGET): UNMAP_DATA is
			--
		do
		end; 

	visible_notify_data (widget_oui: WIDGET): VISIBLE_DATA is
			--
		do
		end

feature {NONE} -- External features

	c_event_time: INTEGER is
		external
			"C"
		end;

	c_get_multi_click_time (display :POINTER): INTEGER is
		external
			"C"
		end;

	c_set_multi_click_time (display: POINTER; time: INTEGER) is
		external
			"C"
		end;

	c_event_button_state (num: INTEGER): BOOLEAN is
		external
			"C"
		end;

	c_event_keypress_string: STRING is
		external
			"C"
		end; 

	c_event_keypress_code: INTEGER is
		external
			"C"
		end;

	c_event_clip_height: INTEGER is
		external
			"C"
		end;

	c_event_clip_width: INTEGER is
		external
			"C"
		end;

	c_event_clip_y: INTEGER is
		external
			"C"
		end;

	c_event_clip_x: INTEGER is
		external
			"C"
		end;

	get_event_type: INTEGER is
		external
			"C"
		end;

	c_event_border_width: INTEGER is
		external
			"C"
		end;

	c_event_height: INTEGER is
		external
			"C"
		end;

	c_event_width: INTEGER is
		external
			"C"
		end;

	c_event_y: INTEGER is
		external
			"C"
		end; 

	c_event_x: INTEGER is
		external
			"C"
		end;

	c_event_place_on_top: BOOLEAN is
		external
			"C"
		end;

	c_event_button: INTEGER is
		external
			"C"
		end; 

	c_event_y_relative: INTEGER is
		external
			"C"
		end;

	c_event_x_relative: INTEGER is
		external
			"C"
		end;

	c_event_y_pointer: INTEGER is
		external
			"C"
		end; 

	c_event_x_pointer: INTEGER is
		external
			"C"
		end; 

	c_event_modifier_state (num: INTEGER): BOOLEAN is
		external
			"C"
		end; 

	c_event_lock_state: BOOLEAN is
		external
			"C"
		end; 

	c_event_control_state: BOOLEAN is
		external
			"C"
		end; 

	c_event_shift_state: BOOLEAN is
		external
			"C"
		end; 

end


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
