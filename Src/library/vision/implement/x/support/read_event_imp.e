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

	create_context_data_from_event (widget_oui: WIDGET; event: MEL_EVENT): CONTEXT_DATA is
			-- Create a context data from the `event' information
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
			elseif type = Expose then
				Result := expose_data (widget_oui, event)
			elseif type = KeyPress then
				Result := key_press_data (widget_oui, event)
			elseif type = KeyRelease then
				Result := key_release_data (widget_oui, event)
			elseif type = MotionNotify then
				Result := motion_notify_data (widget_oui, event)
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

	motion_notify_data (widget_oui: WIDGET; event: MEL_EVENT): MOTNOT_DATA is
		local
			e: MEL_MOTION_EVENT
		do
			e ?= event;
			!! Result.make (widget_oui,
					e.x, e.y, e.x_root, e.y_root,
					buttons_state (e.state))
		end;

end -- class READ_EVENT_X


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

