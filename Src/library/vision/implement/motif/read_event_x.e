indexing

	description:
		"Creation of Context data from X events.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class READ_EVENT_X 

inherit

	MEL_EVENT_CONSTANTS
		export
			{NONE} all
		end
	
feature {NONE} -- Initialization

	create_context_data (widget_oui: WIDGET; event: MEL_EVENT): CONTEXT_DATA is
			-- Create a context data for the current action.
		require
			non_void_widget_oui: widget_oui /= Void;
			non_void_event: event /= Void
		local
			type: INTEGER
		do
			type := event.type;
			if type = ButtonPress then
				Result := button_press_data (widget_oui, event)
			elseif type = ButtonRelease then
				Result := button_release_data (widget_oui, event)
			elseif type = CirculateNotify then
				Result := circulate_notify_data (widget_oui, event)
			elseif type = CirculateRequest then
				Result := circulate_request_data (widget_oui, event)
			elseif type = ClientMessage then
				Result := client_message_data (widget_oui)
			elseif type = ColormapNotify then
				Result := colormap_notify_data (widget_oui)
			elseif type = ConfigureNotify then
				Result := configure_notify_data (widget_oui, event)
			elseif type = ConfigureRequest then
				Result := configure_request_data (widget_oui, event)
			elseif type = CreateNotify then
				Result := create_notify_data (widget_oui)
			elseif type = DestroyNotify then
				Result := destroy_notify_data (widget_oui)
			elseif type = EnterNotify then
				Result := enter_notify_data (widget_oui)
			elseif type = Expose then
				Result := expose_data (widget_oui, event)
			elseif type = FocusIn then
				Result := focus_in_data (widget_oui)
			elseif type = FocusOut then
				Result := focus_out_data (widget_oui)
			elseif type = GraphicsExpose then
				Result := graphics_expose_data (widget_oui)
			elseif type = GravityNotify then
				Result := gravity_notify_data (widget_oui)
			elseif type = KeymapNotify then
				Result := keymap_notify_data (widget_oui)
			elseif type = KeyPress then
				Result := key_press_data (widget_oui, event)
			elseif type = KeyRelease then
				Result := key_release_data (widget_oui, event)
			elseif type = LeaveNotify then
				Result := leave_notify_data (widget_oui)
			elseif type = MapNotify then
				Result := map_notify_data (widget_oui)
			elseif type = MappingNotify then
				Result := mapping_notify_data (widget_oui)
			elseif type = MapRequest then
				Result := map_request_data (widget_oui)
			elseif type = MotionNotify then
				Result := motion_notify_data (widget_oui, event)
			elseif type = NoExpose then
				Result := no_expose_data (widget_oui)
			elseif type = PropertyNotify then
				Result := property_notify_data (widget_oui)
			elseif type = ReparentNotify then
				Result := reparent_notify_data (widget_oui)
			elseif type = ResizeRequest then
				Result := resize_request_data (widget_oui)
			elseif type = SelectionClear then
				Result := selection_clear_data (widget_oui)
			elseif type = SelectionNotify then
				Result := selection_notify_data (widget_oui)
			elseif type = SelectionRequest then
				Result := selection_request_data (widget_oui)
			elseif type = UnmapNotify then
				Result := unmap_notify_data (widget_oui)
			elseif type = VisibilityNotify then
				Result := visible_notify_data (widget_oui)
			else
				!! Result.make (widget_oui)
			end
		end;

feature {NONE} -- Implementation

	buttons_state (state: INTEGER): BUTTONS is
			-- State of buttons when the event occurs
		local
			i: INTEGER
		do
			!! Result.make (5);
			Result.put (and_masks (state, Button1Mask), 1);
			Result.put (and_masks (state, Button2Mask), 2);
			Result.put (and_masks (state, Button3Mask), 3);
			Result.put (and_masks (state, Button4Mask), 4);
			Result.put (and_masks (state, Button5Mask), 5);
		end;

	modifiers_state (state: INTEGER): KEYBOARD is
			-- State of modifier keys
		local
			i: INTEGER;
			mod: ARRAY [BOOLEAN]
		do
			!! Result.make (5);
			Result.set_shift_pressed (and_masks (state, ShiftMask));
			Result.set_control_pressed (and_masks (state, ControlMask));
			Result.set_lock_pressed (and_masks (state, LockMask));
			mod := Result.modifiers;
			mod.put (and_masks (state, Mod1Mask), 1);
			mod.put (and_masks (state, Mod2Mask), 2);
			mod.put (and_masks (state, Mod3Mask), 3);
			mod.put (and_masks (state, Mod4Mask), 4);
			mod.put (and_masks (state, Mod5Mask), 5);
		end;

	button_press_data (widget_oui: WIDGET; event: MEL_EVENT): BTPRESS_DATA is
			-- Create a context for `ButtonPress' event.
		local
			e: MEL_BUTTON_EVENT
		do
			e ?= event;
			!!Result.make (widget_oui, e.x, e.y, e.x_root, e.y_root, e.button_number, 
					buttons_state (e.state), modifiers_state (e.state))
		end;

	button_release_data (widget_oui: WIDGET; event: MEL_EVENT): BUTREL_DATA is
			-- Create a context for `ButtonRelease' event.
		local
			e: MEL_BUTTON_EVENT	
		do
			e ?= event;
			!!Result.make (widget_oui, e.x, e.y, e.x_root, e.y_root, e.button_number, 
					buttons_state (e.state), modifiers_state (e.state))
		end;

	circulate_notify_data (widget_oui: WIDGET; event: MEL_EVENT): CIRCNOT_DATA is
			-- Create a context for `CirculateNotify' event.
		local
			e: MEL_CIRCULATE_EVENT	
		do
			e ?= event;
			!! Result.make (widget_oui, e.is_place_on_top)
		end;

	circulate_request_data (widget_oui: WIDGET; event: MEL_EVENT): CIRCREQ_DATA is
			-- Create a context for `CirculateRequest' event.
		local
			e: MEL_CIRCULATE_REQUEST_EVENT	
		do
			e ?= event;
			!!Result.make (widget_oui, e.is_place_on_top)
		end;

	client_message_data (widget_oui: WIDGET): MESSAGE_DATA is
			-- Create a context for `ClientMessage' event.
		do
			!! Result.make (widget_oui)
		end;

	colormap_notify_data (widget_oui: WIDGET): CLRMAP_DATA is
			-- Create a context for `ColormapNotify' event.
		do
			!! Result.make (widget_oui)
		end; 

	configure_notify_data (widget_oui: WIDGET; event: MEL_EVENT): CONFNOT_DATA is
			-- Create a context for `ConfigureNotify' event.
		local
			e: MEL_CONFIGURE_EVENT
		do
			e ?= event;
			!! Result.make (widget_oui, e.x, e.y, e.width, e.height, e.border_width)
		end;

	configure_request_data (widget_oui: WIDGET; event: MEL_EVENT): CONFREQ_DATA is
			-- Create a context for `ConfigureRequest' event.
		local
			e: MEL_CONFIGURE_REQUEST_EVENT
		do
			!! Result.make (widget_oui, e.x, e.y, e.width, e.height, e.border_width)
		end;

	create_notify_data (widget_oui: WIDGET): CREATE_DATA is
		do
			!! Result.make (widget_oui)
		end;

	destroy_notify_data (widget_oui: WIDGET): DESTROY_DATA is
		do
			!! Result.make (widget_oui)
		end;

	enter_notify_data (widget_oui: WIDGET): ENTER_DATA is
		do
			!! Result.make (widget_oui)
		end; 

	expose_data (widget_oui: WIDGET; event: MEL_EVENT): EXPOSE_DATA is
		local
			clip: CLIP;
			coord: COORD_XY;
			count: INTEGER;
			e: MEL_EXPOSE_EVENT
		do
			e ?= event;
			!!coord;
			coord.set (e.x, e.y);
			!!clip;
			clip.set (coord, e.width, e.height);
			!!Result.make (widget_oui, clip, e.count);
		end;

	focus_in_data (widget_oui: WIDGET): FOCUSIN_DATA is
		do
			!! Result.make (widget_oui)
		end;

	focus_out_data (widget_oui: WIDGET): FOCSOUT_DATA is
		do
			!! Result.make (widget_oui)
		end;

	graphics_expose_data (widget_oui: WIDGET): GRAPEXP_DATA is
		do
			!! Result.make (widget_oui)
		end; 

	gravity_notify_data (widget_oui: WIDGET): GRAVNOT_DATA is
		do
			!! Result.make (widget_oui)
		end;

	key_press_data (widget_oui: WIDGET; event: MEL_EVENT): KYPRESS_DATA is
		local
			e: MEL_KEY_EVENT
		do
			e ?= event;
			!! Result.make (widget_oui, 
					e.keycode, 
					e.string,
					modifiers_state (e.state));
		end;

	key_release_data (widget_oui: WIDGET; event: MEL_EVENT): KEYREL_DATA is
		local
			e: MEL_KEY_EVENT
		do
			e ?= event;
			!! Result.make (widget_oui, 
					e.keycode, 
					e.string,
					modifiers_state (e.state))
		end; 

	keymap_notify_data (widget_oui: WIDGET): KEYMAP_DATA is
		do
			!! Result.make (widget_oui)
		end;

	leave_notify_data (widget_oui: WIDGET): LEAVE_DATA is
		do
			!! Result.make (widget_oui)
		end;

	map_notify_data (widget_oui: WIDGET): MAPNOT_DATA is
		do
			!! Result.make (widget_oui)
		end;

	map_request_data (widget_oui: WIDGET): MAPREQ_DATA is
		do
			!! Result.make (widget_oui)
		end;

	mapping_notify_data (widget_oui: WIDGET): MAPPING_DATA is
		do
			!! Result.make (widget_oui)
		end;

	motion_notify_data (widget_oui: WIDGET; event: MEL_EVENT): MOTNOT_DATA is
		local
			e: MEL_MOTION_EVENT
		do
			e ?= event;
			!! Result.make (widget_oui,
					e.x, e.y, e.x_root, e.y_root,
					buttons_state (e.state))
		end;

	no_expose_data (widget_oui: WIDGET): NOEXP_DATA is
		do
			!! Result.make (widget_oui)
		end;

	property_notify_data (widget_oui: WIDGET): PROPERT_DATA is
		do
			!! Result.make (widget_oui)
		end;

	reparent_notify_data (widget_oui: WIDGET): REPAREN_DATA is
		do
			!! Result.make (widget_oui)
		end;

	resize_request_data (widget_oui: WIDGET): RESIZE_DATA is
		do
			!! Result.make (widget_oui)
		end;

	selection_clear_data (widget_oui: WIDGET): SELCLR_DATA is
		do
			!! Result.make (widget_oui)
		end;

	selection_notify_data (widget_oui: WIDGET): SELNOT_DATA is
		do
			!! Result.make (widget_oui)
		end;

	selection_request_data (widget_oui: WIDGET): SELREQ_DATA is
		do
			!! Result.make (widget_oui)
		end;

	unmap_notify_data (widget_oui: WIDGET): UNMAP_DATA is
		do
			!! Result.make (widget_oui)
		end; 

	visible_notify_data (widget_oui: WIDGET): VISIBLE_DATA is
		do
			!! Result.make (widget_oui)
		end

end -- class READ_EVENT_X

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
