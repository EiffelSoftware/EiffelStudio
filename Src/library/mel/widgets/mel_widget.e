indexing

	description: 
			"Abstact notion of windowed widgets which %
			%represents the Core widget class in Motif.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_WIDGET

inherit

	MEL_CORE_RESOURCES
		export
			{NONE} all
		end;

	MEL_RECT_OBJ;

	MEL_DRAWABLE
		rename
			identifier as window
		end

creation
	make_from_existing

feature -- Access

	window: POINTER is
			-- Associated window
		do
			Result := xt_window (screen_object)
		ensure then
			valid_result: realized implies Result /= default_pointer
		end;

	is_valid: BOOLEAN is
			-- Is Current widget valid?
		do
			Result := not is_destroyed
		end;

	event_command (a_mask: INTEGER): MEL_COMMAND_EXEC is
			-- Command set for the xt event `a_mask'
		local
			cb: like callbacks;
			a_key: MEL_CALLBACK_KEY
		do
			cb := callbacks;
			if cb /= Void then
				!! a_key.make_xt_event (a_mask);
				Result := cb.item (a_key)
			end
		end;

	translation_command (a_translation: STRING): MEL_COMMAND_EXEC is
			-- Command set for the translation action `a_translation'
		require
			translation_not_void: a_translation /= Void
		local
			cb: like callbacks;
			a_key: MEL_TRANSLATION
		do
			cb := callbacks;
			if cb /= Void then
				!! a_key.make_no_adopted (a_translation);
				Result := cb.item (a_key)
			end
		end;

feature -- Status Report

	is_mapped_when_managed: BOOLEAN is
			-- Becomes Current visible as soon as it is both realized and managed?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNmappedWhenManaged)
		end;

	background, background_color: MEL_PIXEL is
			-- Color used for the background
		require
			exists: not is_destroyed
		do
			Result := get_xt_pixel (Current, XmNbackground)
		ensure
			background_color_created: Result /= Void and then Result.is_valid;
			Result_has_same_display: Result.same_display (display);
			Result_is_shared: Result.is_shared
		end;

	background_pixmap: MEL_PIXMAP is
			-- Background pixmap
		require
			exists: not is_destroyed
		do
			Result := get_xt_pixmap (Current, XmNbackgroundPixmap)
		ensure
			valid_Result: Result /= Void and then Result.is_valid;
			Result_has_same_display: Result.same_display (display);
			Result_is_shared: Result.is_shared
		end;

	depth: INTEGER is
			-- Number of bits allowed for each pixel
		do
			Result := get_xt_int (screen_object, XmNdepth)
		end;

feature -- Status setting

	set_background, set_background_color (a_color: MEL_PIXEL) is
			-- Set `background' and `background_color' to `a_color'.
		require
			exists: not is_destroyed;
			valid_color: a_color /= Void and then a_color.is_valid;
			same_display: a_color.same_display (display)
		do
			set_xt_pixel (screen_object, XmNbackground, a_color)
		ensure
			background_color_set: background_color.is_equal (a_color);
			background_set: background.is_equal (a_color)
		end;

	set_background_pixmap (a_pixmap: MEL_PIXMAP) is
			-- Set `background_pixmap' to `a_pixmap'.
		require
			exists: not is_destroyed;
			valid_pixmap: a_pixmap /= Void and then a_pixmap.is_valid;
			same_depth: depth = a_pixmap.depth;
			same_display: a_pixmap.same_display (display)
		do
			set_xt_pixmap (screen_object, XmNbackgroundPixmap, a_pixmap)
		ensure
			background_pixmap_set: background_pixmap.is_equal (a_pixmap)
		end;

	propagate_event is
			-- Propagate event to direct ancestor if no action
			-- is specified for event.
		require
			widget_realized: realized
		do
			x_propagate_event (screen_object, True)
		end;

	set_no_event_propagation is
			-- Don't propagate event to direct ancestor.
		require
			widget_realized: realized
		do
			x_propagate_event (screen_object, False)
		end;

	map_when_managed is
			-- Set `is_mapped_when_managed' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNmappedWhenManaged, True)
		ensure
			is_mapped_when_managed: is_mapped_when_managed 
		end;

	no_map_when_managed is
			-- Set `is_mapped_when_managed' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNmappedWhenManaged, False)
		ensure
			not_mapped_when_managed: not is_mapped_when_managed 
		end;

feature -- Transformation

	lower is
			-- Lower Current in the stacking order.
		require
			exists: not is_destroyed
		do
			if window /= default_pointer then
				x_lower_window (screen.display.handle, window)
			end
		end;

	raise is
			-- Raise Current to the top of the stacking order.
		require
			exists: not is_destroyed
		do
			if window /= default_pointer then
				x_raise_window (screen.display.handle, window)
			end
		end;

feature -- Miscellaneous

	update_colors is
			-- Update the colors (top_shadow, bottom_shadow,
			-- select_color ...) if necessary using `background_color'.
		require
			exists: not is_destroyed;
			background_color_not_void: background_color /= Void
		do
			xm_change_color (screen_object, background_color.identifier)
		end;

feature -- Element change

	set_event_handler (a_mask: INTEGER; a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed when event callback
			-- with `a_mask' is invoked.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
			-- (All masks are defined in class `MEL_EVENT_MASK_CONSTANTS')
		require
			exists: not is_destroyed;
			a_mask_not_void: a_mask /= 0;
			command_not_void: a_command /= Void
		local
			a_command_exec: MEL_COMMAND_EXEC;
			a_key: MEL_CALLBACK_KEY
		do
			!! a_key.make_xt_event (a_mask);
			!! a_command_exec.make (a_command, an_argument);
			if add_to_callbacks (a_command_exec, a_key) then
				c_add_event_handler (screen_object, a_mask)
			end
		ensure
			command_set: command_set (event_command (a_mask),
					a_command, an_argument)
		end;

	set_translation (a_translation: STRING; a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed when `a_translation' occurs.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
			-- `a_translation' is specified with Xtoolkit convention.
			-- An existing translation for `a_translation' will be overriden.
		require
			exists: not is_destroyed;
			non_void_a_translation: a_translation /= Void
		local
			a_command_exec: MEL_COMMAND_EXEC;
			a_key: MEL_TRANSLATION;
            cb: like callbacks
			ext_string: ANY
		do
			!! a_key.make (a_translation);
			!! a_command_exec.make (a_command, an_argument);
            cb := callbacks;
            if cb = Void then
                !! cb.make (1);
                callbacks := cb;
                cb.put (a_command_exec, a_key);
				ext_string := a_key.xt_translation_string.to_c;
				c_set_override_translations (screen_object, $ext_string)
            elseif cb.has (a_key) then
                cb.replace (a_command_exec, a_key)
            else
                cb.put (a_command_exec, a_key)
				ext_string := a_key.xt_translation_string.to_c;
				c_set_override_translations (screen_object, $ext_string)
			end
		ensure
			command_set: command_set (translation_command (a_translation),
					a_command, an_argument)
		end;

	define_cursor (a_cursor: MEL_SCREEN_CURSOR) is
			-- Define the cursor to be displayed to `a_cursor' if not
			-- Void. Otherwize, if `a_cursor' is Void then have
			-- the parent's cursor displayed in the Current window.
		require
			valid_cursor: a_cursor /= Void implies a_cursor.is_valid;
			same_display: a_cursor /= Void implies a_cursor.same_display (display)	
		local
			cursor_id, w: POINTER
		do
			w := window;
			if w /= default_pointer then
					-- If widget was not realized then it doesn't
					-- have a window.
				if a_cursor /= Void then
					cursor_id := a_cursor.identifier
				end
				x_define_cursor (xt_display (screen_object), w, cursor_id)
			end
		end;

	grab_pointer (a_cursor: MEL_SCREEN_CURSOR) is
			-- Actively grab the pointer. Display `a_cursor' if it is
			-- not void. Otherwize, keep the current cursor.
			-- (Grab both the mouse and the keyboard events).
		require
			widget_realized: realized;
			valid_cursor: a_cursor /= Void implies a_cursor.is_valid
		local
			cursor_id: POINTER
		do
			if a_cursor /= Void then
				cursor_id := a_cursor.identifier
			end;
			xt_grab_pointer (screen_object, cursor_id)
		end;

	next_event (a_mask: INTEGER): MEL_EVENT is
			-- Retrieve the next event with mask `a_mask' in the 
			-- queue for Current widget and remove it from the queue
			-- (Return immediately if event is not found)
			-- Masks are defined in MEL_EVENT_MASK_CONSTANTS
		require	
			realized: realized
		local
			ms: MEL_CALLBACK_STRUCT
		do
			if x_check_window_event (display.handle, window,
				a_mask, global_xevent_ptr)  then
				if global_xevent_ptr /= default_pointer then
					!! ms.make_event_only (global_xevent_ptr);
					Result := ms.event
				end
			end
		end;

feature -- Removal

	remove_event_handler (a_mask: INTEGER) is
			-- Remove the command for event callback with `a_mask'.
			-- (All masks are defined in class `MEL_EVENT_MASK_CONSTANTS')
		require
			exists: not is_destroyed;
			a_mask_not_null: a_mask /= 0;
		local
			a_key: MEL_CALLBACK_KEY;
			ext_string: ANY
		do
			!! a_key.make_xt_event (a_mask);
			if remove_from_callbacks (a_key) then
				c_remove_event_handler (screen_object, a_mask)
			end;
		ensure
			removed: event_command (a_mask) = Void
		end;

	remove_translation (a_translation: STRING) is
			-- Remove the callback for `a_translation'.
		require
			exists: not is_destroyed;
			non_void_a_translation: a_translation /= Void;
		local
			a_key: MEL_TRANSLATION;
			ext_string: ANY
		do
			!! a_key.make_no_adopted (a_translation);
			if remove_from_callbacks (a_key) then
				ext_string := a_key.xt_translation_null_string.to_c;
				c_set_override_translations (screen_object, $ext_string)
			end;
		ensure
			removed: translation_command (a_translation) = Void
		end;

	undefine_cursor is
			-- Sets the cursor to Current window to its parent's
			-- cursor.
		local
			w: POINTER
		do
			w := window;
			if w /= default_pointer then
				x_undefine_cursor (xt_display (screen_object), w)
			end
		end;

	ungrab_pointer is
			-- Release the pointer from an active grab.
		require
			widget_realized: realized
		do
			xt_ungrab_pointer (screen_object, Current_time)
		end;

feature {NONE} -- Implementation

	display_handle: POINTER is
			-- Associated C handle for the display
		do  
			Result := display.handle
		end

feature {NONE} -- External features

	c_set_override_translations (scr_obj: POINTER; a_trans: POINTER) is
		external
			"C"
		end;

	c_add_event_handler (scr_obj: POINTER; mask: INTEGER) is
		external
			"C"
		end;

	c_remove_event_handler (scr_obj: POINTER; mask: INTEGER) is
		external
			"C"
		end;

	x_propagate_event (scr_obj: POINTER; c_bool: BOOLEAN) is
		external
			"C"
		end;

	xt_grab_pointer (display_ptr: POINTER; cursor: POINTER) is
		external
			"C"
		end;

	x_define_cursor (display_ptr: POINTER; a_window: POINTER; cursor: POINTER) is
		external
			"C (Display *, Window, Cursor) | <X11/Xlib.h>"
		alias
			"XDefineCursor"
		end;

	x_check_window_event (display_ptr: POINTER; a_window: POINTER; 
				an_event_mask: INTEGER; event_ptr: POINTER): BOOLEAN is
		external
			"C (Display *, Window, long, XEvent *): Bool | <X11/Xlib.h>"
		alias
			"XCheckWindowEvent"
		end;

	x_undefine_cursor (display_ptr: POINTER; a_window: POINTER) is
		external
			"C (Display *, Window) | <X11/Xlib.h>"
		alias
			"XUndefineCursor"
		end;

	xt_ungrab_pointer (w: POINTER; time: INTEGER) is
		external
			"C (Widget, Time) | <X11/Intrinsic.h>"
		alias
			"XtUngrabPointer"
		end;

	x_lower_window (display_ptr: POINTER; a_window: POINTER) is
		external
			"C (Display *, Window) | <X11/Xlib.h>"
		alias
			"XLowerWindow"
		end;

	x_raise_window (display_ptr: POINTER; a_window: POINTER) is
		external
			"C (Display *, Window) | <X11/Xlib.h>"
		alias
			"XRaiseWindow"
		end;

	global_xevent_ptr: POINTER is
		external
			"C [macro %"mel.h%"]: XEvent *"
		end;

end -- class MEL_WIDGET


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
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

