indexing
	description:
		"Eiffel Vision widget. GTK implementation.%N%
		%See ev_widget.e"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_WIDGET_IMP 
        
inherit
	EV_WIDGET_I
		redefine
			interface
		end

	EV_PICK_AND_DROPABLE_IMP
		redefine
			interface,
			is_displayed
		end

	EV_ANY_IMP
		redefine
			interface
		end

	EV_SENSITIVE_IMP
		redefine
			interface
		end

	EV_COLORIZABLE_IMP
		redefine
			interface
		end

	EV_WIDGET_ACTION_SEQUENCES_IMP
		redefine
			interface
		end

feature {NONE} -- Initialization

	gdk_events_mask: INTEGER is
			-- Mask of all the gdk events the gdkwindow shall receive.
		do
			Result := C.GDK_EXPOSURE_MASK_ENUM +
			C.GDK_POINTER_MOTION_MASK_ENUM +
		--	C.GDK_BUTTON_MOTION_MASK_ENUM +
			C.GDK_BUTTON_PRESS_MASK_ENUM +
			C.GDK_BUTTON_RELEASE_MASK_ENUM +
			C.GDK_KEY_PRESS_MASK_ENUM +
			C.GDK_KEY_RELEASE_MASK_ENUM +
			C.GDK_ENTER_NOTIFY_MASK_ENUM +
			C.GDK_LEAVE_NOTIFY_MASK_ENUM +
			C.GDK_FOCUS_CHANGE_MASK_ENUM +
			C.GDK_VISIBILITY_NOTIFY_MASK_ENUM-- +
		--	C.GDK_PROXIMITY_IN_MASK_ENUM +
		--	C.GDK_PROXIMITY_OUT_MASK_ENUM
		end

	initialize_events is
		do
			if not gtk_widget_no_window (visual_widget) then
				C.gtk_widget_add_events (visual_widget, gdk_events_mask)
			end
		end

	gtk_widget_no_window (a_wid: POINTER): BOOLEAN is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			"GTK_WIDGET_NO_WINDOW"
		end

	initialize is
			-- Show non window widgets.
			-- Initialize default options, colors and sizes.
			-- Connect action sequences to GTK signals.
		do
			if not C.gtk_is_widget (c_object) then
				print ("not widget!! " + generating_type)
			end
			if
				C.gtk_is_widget (c_object) and not C.gtk_is_window (c_object)
			then
				C.gtk_widget_show (c_object)
			end

			initialize_events
			
			set_default_colors

				--| "configure-event" only happens for windows,
				--| so we connect to the "size-allocate" function.

			if C.gtk_is_window (c_object) then
				real_signal_connect (
					c_object,
					"configure-event",
					~on_size_allocate,
					Default_translate
				)
			else
				real_signal_connect (
					c_object,
					"size-allocate",
					~on_size_allocate,
					~size_allocate_translate
				)
			end

			real_signal_connect (visual_widget, "key_press_event", ~on_key_event, ~key_event_translate)
			real_signal_connect (visual_widget, "key_release_event", ~on_key_event, ~key_event_translate)
				--| "button-press-event" is a special case, see below.
			pointer_button_press_actions.not_empty_actions.extend (
				~connect_button_press_switch
			)
			pointer_double_press_actions.not_empty_actions.extend (
				~connect_button_press_switch
			)
			if not pointer_button_press_actions.is_empty or
				not pointer_double_press_actions.is_empty then
				connect_button_press_switch
			end
			is_initialized := True
		end

	Signal_map_signal_name: INTEGER is 1

	Signal_map_actions: INTEGER is 2

	button_press_switch (
			a_type: INTEGER;
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		is
			-- Call pointer_button_press_actions or pointer_double_press_actions
			-- depending on event type in first position of `event_data'.
			--| GTK sends both GDK_BUTTON_PRESS and GDK_2BUTTON_PRESS events
			--| when a handler is attached to "button-press-event".
			--| We attach the signal to this switching feature to look at the
			--| event type and pass the event data to the approptiate action
			--| sequence.
		require
			button_or_2button_event:
				a_type = C.GDK_BUTTON_PRESS_ENUM or
				a_type = C.GDK_2BUTTON_PRESS_ENUM
		local
			t : TUPLE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE,
				INTEGER, INTEGER]
		do
			t := [a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure,
				a_screen_x, a_screen_y]
			if a_type = C.GDK_BUTTON_PRESS_ENUM and not is_transport_enabled then
				if pointer_button_press_actions_internal /= Void then
					pointer_button_press_actions_internal.call (t)
				end
			elseif a_type = C.GDK_2BUTTON_PRESS_ENUM then
				if pointer_double_press_actions_internal /= Void then
					pointer_double_press_actions_internal.call (t)
				end
			end
        	end

	button_press_switch_is_connected: BOOLEAN
			-- Is `button_press_switch' connected to its event source.

	connect_button_press_switch is
			-- Connect `button_press_switch' to its event sources.
			--| See comment in `button_press_switch' above.
		do
			if not button_press_switch_is_connected then
				signal_connect (
					"button-press-event",
					~button_press_switch,
					default_translate
				)
				button_press_switch_is_connected := True
			end
		end

feature -- Access

	parent: EV_CONTAINER is
			-- Container widget that contains `Current'.
			-- (Void if `Current' is not in a container)
			--| Search back up through GtkWidget->parent to find a GtkWidget
			--| with an EV_ANY_IMP attached.
		local
			a_par_imp: EV_CONTAINER_IMP
		do
			a_par_imp := parent_imp
			if a_par_imp /= Void then
				Result := a_par_imp.interface
			end
		end

	pointer_position: EV_COORDINATE is
			-- Position of the screen pointer relative to `Current'.
		local
			x, y, s: INTEGER
			child: POINTER
		do
			child := C.gdk_window_get_pointer (
				C.gtk_widget_struct_window (c_object),
				$x, $y, $s
			)
			create Result.set (x, y)
		end

	pointer_style: EV_CURSOR
			-- Cursor displayed when the pointer is over this widget.


	popup_menu: EV_MENU
			-- Menu popped up when button 3 is pressed on widget.

	screen_x: INTEGER is
			-- Horizontal offset relative to screen.
		local
			wind: EV_WINDOW_IMP
		do 
			wind ?= Current
			if wind /= Void then
				Result := x_position
			elseif parent_imp /= Void
				then Result := x_position + parent_imp.screen_x
			end
		end

	screen_y: INTEGER is
			-- Vertical offset relative to screen. 
		local 
			wind: EV_WINDOW_IMP 
		do 
			wind ?= Current
			if wind /= Void then
				Result := y_position
			elseif parent_imp /= Void then
				Result := y_position + parent_imp.screen_y
			end
		end
	
feature -- Status report

	is_show_requested: BOOLEAN is
			-- Will `Current' be displayed when its parent is?
			-- See also `is_displayed'.
		do
			--| Shift to put bit in least significant place then take mod 2.
			Result := (
				(C.gtk_object_struct_flags (c_object)
				// C.GTK_VISIBLE_ENUM) \\ 2
			) = 1
		end

	is_displayed: BOOLEAN is
			-- Is `Current' visible on the screen?
		do
			--| Shift to put bit in least significant place then take mod 2.
			Result := ((
				(C.gtk_object_struct_flags (c_object)
				// C.GTK_MAPPED_ENUM) \\ 2)
			) = 1
		end

	has_focus: BOOLEAN is
			-- Does widget have the keyboard focus?
		do
			Result := gtk_widget_has_focus (visual_widget)
		end
		
	has_capture: BOOLEAN is
			-- Has capture?
		do
			--| Shift to put bit in least significant place then take mod 2.
			Result := ((
				(C.gtk_object_struct_flags (visual_widget)
				// C.GTK_HAS_GRAB_ENUM) \\ 2)
			) = 1
		end

feature -- Status setting

	hide is
			-- Request that `Current' not be displayed even when its parent is.
		local
			sa_par_imp: EV_SPLIT_AREA_IMP
		do
			C.gtk_widget_hide (c_object)
			sa_par_imp ?= parent_imp
			if sa_par_imp /= Void then
				sa_par_imp.update_child_visibility (Current)
			end
		end
	
	show is
			-- Request that `Current' be displayed when its parent is.
		local
			sa_par_imp: EV_SPLIT_AREA_IMP
		do
			C.gtk_widget_show_now (c_object)
			sa_par_imp ?= parent_imp
			if sa_par_imp /= Void then
				sa_par_imp.update_child_visibility (Current)
			end
		end

	set_focus is
			-- Grab keyboard focus.
		do
			C.gtk_widget_grab_focus (visual_widget)
		end

	enable_capture is
			-- Grab all the mouse and keyboard events.
			--| Used by pick and drop.
		local
			i: INTEGER
		do
			C.gtk_grab_add (visual_widget)
			i := C.gdk_pointer_grab (
				C.gtk_widget_struct_window (visual_widget),
				1, -- gint owner_events
				C.GDK_BUTTON_RELEASE_MASK_ENUM +
				C.GDK_BUTTON_PRESS_MASK_ENUM +
				C.GDK_BUTTON_MOTION_MASK_ENUM +
				--C.GDK_POINTER_MOTION_HINT_MASK_ENUM +
				C.GDK_POINTER_MOTION_MASK_ENUM,
				NULL,                      -- GdkWindow* confine_to 
				NULL,                      -- GdkCursor *cursor
				0)                                    -- guint32 time
			end

	disable_capture is
			-- Ungrab all the mouse and keyboard events.
			--| Used by pick and drop.
		do
			C.gtk_grab_remove (visual_widget)
			C.gdk_pointer_ungrab (
				0 -- guint32 time
			) 
		end

feature -- Element change

	set_pointer_style (a_cursor: like pointer_style) is
			-- Assign `a_cursor' to `pointer_style'.
		local
			--a_cursor_imp: EV_PIXMAP_IMP
			--src_pixmap, dest_bitmap, mask_ptr: POINTER
		do
			pointer_style := clone (a_cursor)
			--print ("%Nset pointer style needs implementing%N")
			--a_cursor_imp ?= a_cursor.implementation
			--check
			--	a_cursor_imp_not_void: a_cursor_imp /= Void
			--end
			--dest_bitmap := C.gdk_pixmap_new (NULL, a_cursor_imp.width, a_cursor_imp.height, 1)
			--C.gtk_pixmap_get (a_cursor_imp.gtk_pixmap, NULL, $src_pixmap)
			--C.gdk_draw_pixmap (
			--	dest_bitmap,
			--	C.gtk_style_struct_white_gc (C.gtk_widget_struct_style (a_cursor_imp.gtk_pixmap)),
			--	src_pixmap,
			--	0, -- xsrc
			--	0, -- ysrc
			--	0, -- xdest
			--	0, -- ydest
			--	a_cursor_imp.width,
			--	a_cursor_imp.height
			--)
		end
		
	internal_set_pointer_style (a_cursor: like pointer_style) is
			-- Assign `a_cursor' to `pointer_style', used for PND
		do
			--| FIXME Needs implementing to use set_pointer_style
		end
		
	set_minimum_width (a_minimum_width: INTEGER) is
			-- Set the minimum horizontal size to `a_minimum_width'.
		do
			set_minimum_size (a_minimum_width, minimum_height.max (1))
		end

	set_minimum_height (a_minimum_height: INTEGER) is
			-- Set the minimum vertical size to `a_minimum_height'.
		do
			set_minimum_size (minimum_width.max (1), a_minimum_height)
		end

	set_minimum_size (a_minimum_width, a_minimum_height: INTEGER) is
			-- Set the minimum horizontal size to `a_minimum_width'.
			-- Set the minimum vertical size to `a_minimum_height'.
		do
			if widget_in_fixed then
				fixed_minimum_height := 0
				fixed_minimum_width := 0
				widget_in_fixed := False
			end				
			C.gtk_widget_set_usize (c_object, a_minimum_width, a_minimum_height)
		end

	set_popup_menu (a_menu: EV_MENU) is
			-- Pop up `a_menu' when button 3 is pressed on widget.
		do
			check
				to_be_implemented: False
			end
		--	popup_menu := a_menu
		--	C.gtk_signal_connect_object (
		--		c_object, ~show_popup_menu, popup_menu)
		end

	remove_popup_menu is
			-- Do not pop up the menu.
		do
			check
				to_be_implemented: False
			end
		--	popup_menu := Void
		end

feature -- Measurement

	--| FIXME x/y_position needs testing.
	
	x_position: INTEGER is
			-- Horizontal offset relative to parent `x_position'.
			-- Unit of measurement: screen pixels.
		local
			a_aux_info: POINTER
			tmp_struct_x: INTEGER
		do
			Result := C.gtk_allocation_struct_x (
				C.gtk_widget_struct_allocation (c_object)
			)
			a_aux_info := aux_info_struct
			if a_aux_info /= NULL then
				tmp_struct_x := C.gtk_widget_aux_info_struct_x (a_aux_info)
				if tmp_struct_x >= 0 then
					Result := tmp_struct_x
				end
			end
		end

	y_position: INTEGER is
			-- Vertical offset relative to parent `y_position'.
			-- Unit of measurement: screen pixels.
		local
			a_aux_info: POINTER
			tmp_struct_y: INTEGER
		do
			Result := C.gtk_allocation_struct_y (
				C.gtk_widget_struct_allocation (c_object)
			)
			a_aux_info := aux_info_struct
			if a_aux_info /= NULL then
				tmp_struct_y := C.gtk_widget_aux_info_struct_y (a_aux_info)
				if tmp_struct_y >= 0 then
					Result := tmp_struct_y
				end
			end
		end	

	width: INTEGER is
			-- Horizontal size measured in pixels.
		do
			Result := C.gtk_allocation_struct_width (
				C.gtk_widget_struct_allocation (c_object)
			).max (minimum_width)
		end

	height: INTEGER is
			-- Vertical size measured in pixels.
		do
			Result := C.gtk_allocation_struct_height (
				C.gtk_widget_struct_allocation (c_object)
			).max (minimum_height)
		end
	
 	minimum_width: INTEGER is
			-- Minimum horizontal size in pixels.
		local
			gr: POINTER
		do
			if not widget_in_fixed then
				gr := C.c_gtk_requisition_struct_allocate
				C.gtk_widget_size_request (c_object, gr)
				Result := C.gtk_requisition_struct_width (gr)
				C.c_gtk_requisition_struct_free (gr)
			else
				Result := fixed_minimum_width
			end
		end

	minimum_height: INTEGER is
			-- Minimum vertical size in pixels.
		local
			gr: POINTER
		do
			if not widget_in_fixed then
				gr := C.c_gtk_requisition_struct_allocate
				C.gtk_widget_size_request (c_object, gr)
				Result := C.gtk_requisition_struct_height (gr)
				C.c_gtk_requisition_struct_free (gr)
			else
				Result := fixed_minimum_height
			end
		end

feature {EV_FIXED_IMP} -- Implementation

	fixed_minimum_height: INTEGER

	fixed_minimum_width: INTEGER

	widget_in_fixed: BOOLEAN

	set_fixed_size (a_width, a_height: INTEGER) is
			-- Set the size within EV_FIXED without appearing to alter min size.
		do
			fixed_minimum_height := minimum_height
			fixed_minimum_width := minimum_width
			widget_in_fixed := True
			C.gtk_widget_set_usize (c_object, a_width, a_height)
		end

feature {EV_ANY_I} -- Implementation

	reset_minimum_size is
			-- Reset all values to defaults.
		do
			set_minimum_size (minimum_width, minimum_height)
		end
				
feature {NONE} -- Implementation

	cursor_signal_tag: INTEGER
		-- Tag returned from Gtk used to disconnect `enter-notify' signal

feature {EV_WINDOW_IMP} -- Implementation

	default_key_processing_blocked (a_key: EV_KEY): BOOLEAN is
			-- Used for drawing area to keep focus on all keys.
		do
			Result := False
		end

feature {NONE} -- Externals

	gtk_widget_set_flags (a_widget: POINTER; a_flag: INTEGER) is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			"GTK_WIDGET_SET_FLAGS"
		end

	gtk_widget_unset_flags (a_widget: POINTER; a_flag: INTEGER) is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			"GTK_WIDGET_UNSET_FLAGS"
		end

feature {NONE} -- Implementation

	parent_imp: EV_CONTAINER_IMP is
			-- Container widget that contains `Current'.
			-- (Void if `Current' is not in a container)
			--| Search back up through GtkWidget->parent to find a GtkWidget
			--| with an EV_ANY_IMP attached.
		local
			c_parent: POINTER
		do
			from
				c_parent := c_object
			until
				Result /= Void or c_parent = NULL
			loop
				c_parent := C.gtk_widget_struct_parent (c_parent)
				if c_parent /= NULL then
					Result ?= eif_object_from_c (c_parent)
				end
			end
		end

	top_level_window_imp: EV_WINDOW_IMP is
		local
			wind_ptr: POINTER
		do
			wind_ptr := C.gtk_widget_get_toplevel (c_object)
			if wind_ptr /= NULL then
				Result ?= eif_object_from_c (wind_ptr)
			end
		end

	aux_info_struct: POINTER is
		do
			Result := C.gtk_object_get_data (
				c_object,
				eiffel_to_c ("gtk-aux-info")
			)
		end

	size_allocate_translate (n: INTEGER; p: POINTER): TUPLE is
			-- Convert GtkAllocation to tuple.
		local
			gtk_alloc: POINTER
		do
			gtk_alloc := gtk_value_pointer (p)
			Result := [
				C.gtk_allocation_struct_x (gtk_alloc),
				C.gtk_allocation_struct_y (gtk_alloc),
				C.gtk_allocation_struct_width (gtk_alloc),
				C.gtk_allocation_struct_height (gtk_alloc)
			]
		end

	on_size_allocate (a_x, a_y, a_width, a_height: INTEGER) is
			-- Gtk_Widget."size-allocate" happened.
		do
			--| FIXME VB 05/11/2000
			--| Temporary implementation.
			if not in_resize_event then
				in_resize_event := True
				if last_width /= a_width or else last_height /= a_height then
					if resize_actions_internal /= Void then
						resize_actions_internal.call ([a_x, a_y, a_width, a_height])
					end
					last_width := a_width
					last_height := a_height
				end
				in_resize_event := False
			end
		end

	key_event_translate (n: INTEGER; p: POINTER): TUPLE is
			-- Convert GdkEventKey to tuple.
		local
			keyval: INTEGER
			gdkeventkey: POINTER
			a_key_string: STRING
			key: EV_KEY
			a_key_press: BOOLEAN
		do
			gdkeventkey := gtk_value_pointer (p)
			if C.gdk_event_key_struct_type (gdkeventkey) = C.gdk_key_press_enum then
				a_key_press := True
				create a_key_string.make (0)
				a_key_string.from_c (C.gdk_event_key_struct_string (gdkeventkey))
			end
			keyval := C.gdk_event_key_struct_keyval (gdkeventkey)
			if valid_gtk_code (keyval) then
				create key.make_with_code (key_code_from_gtk (keyval))
			end
			
			Result := [key, a_key_string, a_key_press]
		end

feature {EV_WINDOW_IMP} -- Implementation

	on_key_event (a_key: EV_KEY; a_key_string: STRING; a_key_press: BOOLEAN) is
			-- Used for key event actions sequences.
		local
			temp_key_string: STRING
		do
			if a_key_press then
				-- The event is a key press event.
				if a_key /= Void and then key_press_actions_internal /= Void then
					key_press_actions_internal.call ([a_key])
				end
				if key_press_string_actions_internal /= Void then
					temp_key_string := a_key_string
					if a_key /= Void then
						if a_key.out.count /= 1 and not a_key.is_numpad then
							temp_key_string := ""
						end
						if a_key.code = a_key.Key_space then
							temp_key_string := " "
						end
					end
					key_press_string_actions_internal.call ([temp_key_string])
				end
			else
				-- The event is a key release event.
				if a_key /= Void and then key_release_actions_internal /= Void then
					key_release_actions_internal.call ([a_key])
				end
			end
		end

feature {NONE} -- Implementation

	gtk_widget_has_focus (a_c_object: POINTER): BOOLEAN is
			-- Does `a_c_object' have the focus.
		do
				--| Shift to put bit in least significant place then take mod 2.
			if a_c_object /= NULL then
				Result := ((
					(C.gtk_object_struct_flags (a_c_object)
					// C.GTK_HAS_FOCUS_ENUM) \\ 2) 
				) = 1
			end
		end
		
	update_child_requisition (a_child: POINTER) is
			-- Force the event loop to update the requistion of `a_child'.
		local
			temp_int: INTEGER
		do
				if is_displayed then
					temp_int := C.gtk_main_iteration_do (False)
				end
		end

	propagate_foreground_color_internal (a_color: EV_COLOR; a_c_object: POINTER) is
			-- Propagate `a_color' to the foreground color of `a_c_object's children.
		local
			l: POINTER
			child: POINTER
			fg: EV_COLOR
		do
			if
				C.gtk_is_container (a_c_object)
			then
				from
					fg := a_color
					l := C.gtk_container_children (a_c_object)
				until
					l = NULL
				loop
					child := C.glist_struct_data (l)
					real_set_foreground_color (child, fg)
					if C.gtk_is_container (child) then
						propagate_foreground_color_internal (fg, child)
					end
					l := C.glist_struct_next (l) 
				end
			else
				real_set_foreground_color (a_c_object, fg)
			end
		end
		
	propagate_background_color_internal (a_color: EV_COLOR; a_c_object: POINTER) is
			-- Propagate `a_color' to the background color of `a_c_object's children.
		local
			l: POINTER
			child: POINTER
			bg: EV_COLOR
		do
			if
				C.gtk_is_container (a_c_object)
			then
				from
					bg := a_color
					l := C.gtk_container_children (a_c_object)
				until
					l = NULL
				loop
					child := C.glist_struct_data (l)
					real_set_background_color (child, bg)
					if C.gtk_is_container (child) then
						propagate_background_color_internal (bg, child)
					end
					l := C.glist_struct_next (l) 
				end
			else
				real_set_background_color (a_c_object, bg)
			end
		end
		
	last_width, last_height: INTEGER
			-- Dimenions during last "size-allocate".

	in_resize_event: BOOLEAN
			-- Is `interface.resize_actions' being executed?

	set_bounds (a_x, a_y, a_width, a_height: INTEGER) is
			-- Set horizontal offset relative to parent `x_position'.
			-- Set vertical offset relative to parent `y_position'.
			-- Set the horizontal size to `a_width'.
			-- Set the vertical size to `a_height'.
		require
			a_width_positive_or_zero: a_width >= 0
			a_height_positive_or_zero: a_height >= 0
		local
			alloc_struct: POINTER
		do
			alloc_struct := C.c_gtk_allocation_struct_allocate
			C.set_gtk_allocation_struct_x (alloc_struct, a_x)
			C.set_gtk_allocation_struct_y (alloc_struct, a_y)
 			C.set_gtk_allocation_struct_width (alloc_struct, a_width)
			C.set_gtk_allocation_struct_height (alloc_struct, a_height)
			C.gtk_widget_size_allocate (c_object, alloc_struct)
			C.c_gtk_allocation_struct_free (alloc_struct)
		ensure
			x_position_assigned: x_position = a_x
			y_position_assigned: y_position = a_y
			width_assigned: width = minimum_width or else width = a_width
			height_assigned: height = minimum_height or else height = a_height
		end

feature {EV_ANY_I} -- Contract Support

	parent_is_sensitive: BOOLEAN is
		local
			a_par: EV_CONTAINER_IMP
		do
			a_par := parent_imp
			Result := a_par.is_sensitive
		end

	has_parent: BOOLEAN is
		do
			Result := parent_imp /= Void
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_WIDGET

end -- class EV_WIDGET_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.74  2001/06/29 22:22:54  king
--| Removed redundant queue_resize
--|
--| Revision 1.73  2001/06/21 22:32:59  king
--| Added update_child_requisition feature
--|
--| Revision 1.72  2001/06/19 16:58:05  king
--| Commented out unneeded event masks
--|
--| Revision 1.71  2001/06/14 20:14:29  king
--| Not calling key action sequence if key is void
--|
--| Revision 1.70  2001/06/14 18:25:26  rogers
--| Renamed EV_COORDINATES to EV_COORDINATE.
--|
--| Revision 1.69  2001/06/07 23:08:05  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.54.2.75  2001/06/05 22:44:16  king
--| Using clone instead of copy
--|
--| Revision 1.54.2.74  2001/06/04 17:21:35  rogers
--| We now use copy instead of ev_clone.
--|
--| Revision 1.54.2.73  2001/05/24 00:34:42  king
--| Updated width height functions
--|
--| Revision 1.54.2.72  2001/05/18 18:14:39  king
--| Refactored focus, key and color code
--|
--| Revision 1.54.2.71  2001/05/15 23:17:44  king
--| Removed reference to aggregate widget
--|
--| Revision 1.54.2.70  2001/05/10 22:16:21  king
--| Added hack for split area item widget hide show
--|
--| Revision 1.54.2.69  2001/04/27 21:33:00  king
--| Redefining is_displayed
--|
--| Revision 1.54.2.68  2001/04/26 19:01:21  king
--| Commented out unused locals
--|
--| Revision 1.54.2.67  2001/04/18 19:40:31  king
--| Using is_show_requested instead of is_displayed for width and height
--|
--| Revision 1.54.2.66  2001/04/12 16:14:15  king
--| Fixed gdk unknown window bug, removed key error message
--|
--| Revision 1.54.2.65  2001/03/13 20:24:46  etienne
--| (Gauthier) Now checks the aux-info struct in `x_position' and `y_position' not to override
--| previous result with an error value.
--|
--| Revision 1.54.2.64  2001/01/29 21:12:34  rogers
--| Added internal_set_pointer_style.
--|
--| Revision 1.54.2.63  2000/12/15 19:54:29  king
--| Commented out debug event messages
--|
--| Revision 1.54.2.62  2000/12/15 19:40:00  king
--| Changed .empty to .is_empty
--|
--| Revision 1.54.2.61  2000/11/20 18:23:30  king
--| Accounted for is_keypad name change
--|
--| Revision 1.54.2.59  2000/11/03 23:32:21  king
--| Formatting
--|
--| Revision 1.54.2.58  2000/11/02 19:58:47  etienne
--| Corrected a bug in `button_press_switch'.
--|
--| Revision 1.54.2.57  2000/11/01 01:12:38  andrew
--| Implemented a parent_imp to avoid cat calls due to interface indirection
--|
--| Revision 1.54.2.56  2000/10/27 16:54:40  manus
--| Removed undefinition of `set_default_colors' since now the one from EV_COLORIZABLE_IMP is
--| deferred.
--| However, there might be a problem with the definition of `set_default_colors' in the following
--| classes:
--| - EV_TITLED_WINDOW_IMP
--| - EV_WINDOW_IMP
--| - EV_TEXT_COMPONENT_IMP
--| - EV_LIST_ITEM_LIST_IMP
--| - EV_SPIN_BUTTON_IMP
--|
--| Revision 1.54.2.55  2000/10/25 23:14:34  king
--| Corrected button actions sequence calling
--|
--| Revision 1.54.2.54  2000/10/17 23:11:04  king
--| Corrected pointer style error output
--|
--| Revision 1.54.2.53  2000/10/10 22:51:13  king
--| Implemented set_pointer_style to satisfy postcond
--|
--| Revision 1.54.2.52  2000/10/10 21:27:51  king
--| Fixed has_focus
--|
--| Revision 1.54.2.51  2000/10/09 17:58:00  oconnor
--| added has_capture
--|
--| Revision 1.54.2.50  2000/09/13 21:17:46  king
--| Formatting
--|
--| Revision 1.54.2.49  2000/09/12 23:14:36  king
--| Added top_level_window
--|
--| Revision 1.54.2.48  2000/09/12 19:04:52  king
--| Removed focus flag setting
--|
--| Revision 1.54.2.47  2000/09/11 22:22:03  oconnor
--| Try to get position the old way before using the aux-info struct as
--| it seems not to be present for non windows.
--|
--| Revision 1.54.2.46  2000/09/06 23:18:44  king
--| Reviewed
--|
--| Revision 1.54.2.45  2000/09/05 23:37:23  king
--| Altered export clause of on_key_event
--|
--| Revision 1.54.2.44  2000/09/05 21:47:34  king
--| Added custom key event translation/execution routines
--|
--| Revision 1.54.2.43  2000/08/29 21:41:13  king
--| Removed keyboard masks from enable capture
--|
--| Revision 1.54.2.42  2000/08/29 00:23:01  king
--| Implemented handling for key_press_string_actions
--|
--| Revision 1.54.2.41  2000/08/28 21:48:31  king
--| Added keyboard masks to enable_capture
--|
--| Revision 1.54.2.40  2000/08/28 21:28:28  king
--| Changed set_focus to use visual_widget
--|
--| Revision 1.54.2.39  2000/08/28 16:34:31  king
--| event_widget->visual_widget
--|
--| Revision 1.54.2.38  2000/08/25 17:12:00  king
--| events mask now using all events enum
--|
--| Revision 1.54.2.37  2000/08/23 00:33:01  king
--| Added property flag setting macro externals
--|
--| Revision 1.54.2.36  2000/08/15 20:33:41  king
--| Added sensitive contract support features
--|
--| Revision 1.54.2.35  2000/08/09 18:44:49  oconnor
--| removed use of bit_or, not avalible in 4.5
--|
--| Revision 1.54.2.34  2000/08/08 00:03:12  oconnor
--| Redefined set_default_colors to do nothing in EV_COLORIZABLE_IMP.
--|
--| Revision 1.54.2.33  2000/08/03 23:16:59  king
--| Using internal pointer_*_press_actions
--|
--| Revision 1.54.2.32  2000/07/31 18:57:27  king
--| Removed unused local variables
--|
--| Revision 1.54.2.31  2000/07/24 21:36:06  oconnor
--| inherit action sequences _IMP class
--|
--| Revision 1.54.2.30  2000/06/28 00:45:37  king
--| Event grabbing now on event_widget instead of c_object
--|
--| Revision 1.54.2.29  2000/06/27 23:42:45  king
--| Using event_widget instead of c_object for event connection
--|
--| Revision 1.54.2.28  2000/06/23 19:12:09  king
--| Reimplemented x/y_position, moved aux_info_struct up from window_imp
--|
--| Revision 1.54.2.27  2000/06/21 22:43:21  king
--| Altered min size features for compatability with ev_fixed item sizing
--|
--| Revision 1.54.2.26  2000/06/15 22:15:29  king
--| Changed event error comment
--|
--| Revision 1.54.2.25  2000/06/15 20:40:06  king
--| Added printout message for widgets with no corresponding gdkwindow
--|
--| Revision 1.54.2.24  2000/06/15 19:04:40  king
--| Abstracted event masking function so it can be redefined to do nothing for radio buts
--|
--| Revision 1.54.2.23  2000/06/14 23:14:49  king
--| Added code to initialize event mask
--|
--| Revision 1.54.2.22  2000/06/14 00:44:21  king
--| Removed enable_motion_notify
--|
--| Revision 1.54.2.21  2000/06/13 23:59:22  king
--| Added default gdk_events_mask function
--|
--| Revision 1.54.2.20  2000/05/25 00:34:40  king
--| Removed reference to cursor code
--|
--| Revision 1.54.2.19  2000/05/17 19:30:39  king
--| Corrected signal connection for window resizing in initialize
--|
--| Revision 1.54.2.18  2000/05/17 18:16:08  brendel
--| Corrected configure-event connection for windows.
--|
--| Revision 1.54.2.17  2000/05/17 18:10:47  king
--| Corrected on_size_allocate
--|
--| Revision 1.54.2.16  2000/05/17 18:06:02  king
--| Commented out pointer style setting, connecting configure event for window
--|
--| Revision 1.54.2.15  2000/05/15 22:12:54  king
--| Made enums uppercase
--|
--| Revision 1.54.2.14  2000/05/13 00:04:10  king
--| Converted to new EV_CONTAINABLE class
--|
--| Revision 1.54.2.13  2000/05/12 19:03:26  king
--| Now inheriting EV_COLORIZABLE_IMP
--|
--| Revision 1.54.2.12  2000/05/11 19:33:25  king
--| Integrated ev_sensitive
--|
--| Revision 1.54.2.11  2000/05/11 15:45:08  brendel
--| Replaced size-allocate implementation with improved, but still not
--| final implementation.
--|
--| Revision 1.54.2.10  2000/05/10 23:02:58  king
--| Integrated inital tooltipable changes
--|
--| Revision 1.54.2.9  2000/05/09 19:11:01  brendel
--| Attempt to connect to resize actions. Succeeded, but calls that change
--| sizes in handler cause stack overflows.
--|
--| Revision 1.54.2.8  2000/05/07 03:51:42  manus
--| Cosmetics (replaced spaces by a tabulation)
--|
--| Revision 1.54.2.7  2000/05/04 18:34:47  king
--| Made compilable with new cursor changes
--|
--| Revision 1.54.2.6  2000/05/03 22:12:18  pichery
--| Removed some obsolete features
--|
--| Revision 1.54.2.5  2000/05/03 19:08:44  oconnor
--| mergred from HEAD
--|
--| Revision 1.67  2000/05/02 18:55:26  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.66  2000/04/04 21:00:34  oconnor
--| updated signal connection for new marshaling scheme
--|
--| Revision 1.65  2000/03/24 02:20:40  oconnor
--| use new not_empty_actions from ACTION_SEQUENCE
--|
--| Revision 1.64  2000/03/21 00:12:37  king
--| Added code for parent to deal with aggregate cell
--|
--| Revision 1.63  2000/03/17 18:24:09  rogers
--| Added screen_x and _screen_y using the old implementation taken directly
--| from EV_WIDGET_I.
--|
--| Revision 1.62  2000/03/15 23:32:35  king
--| Added code in set_pointer_style to set pointer_style attribute
--|
--| Revision 1.61  2000/03/15 22:46:38  king
--| Uncommented pointer_style external call
--|
--| Revision 1.60  2000/03/01 18:05:25  king
--| Removed XXXX
--|
--| Revision 1.59  2000/02/22 18:39:37  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.58  2000/02/22 16:19:10  brendel
--| Added features to show popup menu.
--| Not yet implemented.
--|
--| Revision 1.57  2000/02/16 03:38:41  oconnor
--| connected resize action sequence
--|
--| Revision 1.56  2000/02/14 11:40:30  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.54.2.2.2.57  2000/02/04 04:25:36  oconnor
--| released
--|
--| Revision 1.54.2.2.2.56  2000/02/03 23:27:31  brendel
--| Commented out setting of cursor until it is implemented.
--|
--| Revision 1.54.2.2.2.55  2000/01/29 02:41:29  brendel
--| Changed reference of EV_CURSOR.cursor with EV_CURSOR.c_object.
--|
--| Revision 1.54.2.2.2.54  2000/01/28 21:18:25  brendel
--| Added `tooltip', `set_tooltip', `remove_tooltip'.
--|
--| Revision 1.54.2.2.2.53  2000/01/27 19:29:38  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.54.2.2.2.52  2000/01/26 16:51:00  oconnor
--| removed ugly hack
--|
--| Revision 1.54.2.2.2.51  2000/01/25 18:04:17  oconnor
--| temporary capture hack
--|
--| Revision 1.54.2.2.2.50  2000/01/25 00:20:09  oconnor
--| removed old command stuff, use action sequences
--|
--| Revision 1.54.2.2.2.49  2000/01/22 01:33:24  oconnor
--| fixed sizing glitch
--|
--| Revision 1.54.2.2.2.48  2000/01/21 19:07:27  king
--| Changed capture features from set 2 enable, and release to disable
--|
--| Revision 1.54.2.2.2.47  1999/12/17 23:17:20  oconnor
--| update for new names from EV_COLOR
--|
--| Revision 1.54.2.2.2.46  1999/12/15 04:34:15  oconnor
--| formatting, removed widget_source
--|
--| Revision 1.54.2.2.2.45  1999/12/15 03:59:51  oconnor
--| use weak refs for global PND list
--|
--| Revision 1.54.2.2.2.44  1999/12/15 00:21:40  oconnor
--| name change in GTK externals _malloc -> _allocate
--|
--| Revision 1.54.2.2.2.43  1999/12/14 18:57:26  oconnor
--| rename POINT->COORDINATES for pointer_position
--|
--| Revision 1.54.2.2.2.42  1999/12/14 18:07:43  oconnor
--| implemented feature pointer_position
--|
--| Revision 1.54.2.2.2.41  1999/12/14 16:52:55  oconnor
--| renamed EV_PND_SOURCE -> EV_PICK_AND_DROPABLE
--|
--| Revision 1.54.2.2.2.40  1999/12/13 20:01:32  oconnor
--| fixed button_press_switch for new attribute format from marshal
--|
--| Revision 1.54.2.2.2.39  1999/12/09 19:06:23  oconnor
--| adjust pointer_button_switch for new pointer button event data
--|
--| Revision 1.54.2.2.2.38  1999/12/09 18:17:37  oconnor
--| removed set_parent, fixed set_capture to compile
--|
--| Revision 1.54.2.2.2.37  1999/12/09 02:32:28  oconnor
--| king: redid set_capture in Eiffel (was C), added  enable_motion_notify
--|
--| Revision 1.54.2.2.2.36  1999/12/09 00:53:39  oconnor
--| Rearranged button_press_switch and fixed double connection bug.
--| Removed inheritance of GTK_ENUMS, it sould be accessed through C.xxx
--|
--| Revision 1.54.2.2.2.35  1999/12/08 22:21:24  brendel
--| Removed local const declararations because they clash with
--| inheritance of GTK_ENUMS in EV_DRAWABLE_IMP.
--|
--| Revision 1.54.2.2.2.34  1999/12/08 17:42:28  oconnor
--| removed more inherited externals
--|
--| Revision 1.54.2.2.2.33  1999/12/07 19:07:56  brendel
--| Changed minor compilor errors.
--|
--| Revision 1.54.2.2.2.32  1999/12/07 18:56:16  brendel
--| Changed implementation of width and height to make it more compact.
--| Improved contracts on set_bounds.
--|
--| Revision 1.54.2.2.2.31  1999/12/07 18:27:41  oconnor
--| added obsolete tags
--|
--| Revision 1.54.2.2.2.30  1999/12/07 18:22:05  oconnor
--| Missing from last log message:
--| Fixed comments and lines longer than 80 chars.
--| Reimplemented set_pointer_style in Eiffel (was in C).
--|
--| Revision 1.54.2.2.2.29  1999/12/07 18:20:28  oconnor
--| ev_widget_imp.e
--|
--| Revision 1.54.2.2.2.28  1999/12/07 04:09:30  oconnor
--| added switch (router) to send click and double click to correct place
--|
--| Revision 1.54.2.2.2.27  1999/12/05 03:07:27  oconnor
--| fixed [pre|high]light calculation
--|
--| Revision 1.54.2.2.2.26  1999/12/05 00:38:10  oconnor
--| Fixed feature call on void target in parent
--| fixed event map misalignment,
--| fixed  incorrect C struct interaction in real_set_*_color
--|
--| Revision 1.54.2.2.2.25  1999/12/04 18:59:16  oconnor
--| moved externals into EV_C_EXTERNALS, accessed through EV_ANY_IMP.C
--|
--| Revision 1.54.2.2.2.24  1999/12/03 20:28:14  brendel
--| I seem to have removed a line.
--|
--| Revision 1.54.2.2.2.23  1999/12/03 18:58:57  oconnor
--| split set_*_color (color)  into real_set_*_color (c_object, color) to
--|  allow use from elsewhere
--|
--| Revision 1.54.2.2.2.22  1999/12/03 07:48:10  oconnor
--| fixed gaggle of typos
--|
--| Revision 1.54.2.2.2.21  1999/12/03 05:04:28  oconnor
--| improved comments, moved some C functions into Eiffel
--|
--| Revision 1.54.2.2.2.20  1999/12/03 04:08:29  brendel
--| Added is_initialized:=True
--|
--| Revision 1.54.2.2.2.19  1999/12/03 02:33:57  brendel
--| Changed to new color creation procedure with reals ranging from 0 to 1.
--|
--| Revision 1.54.2.2.2.18  1999/12/03 00:50:33  brendel
--| Changed intialize to make it compile. Added external gtk_widget_has_focus
--| because it is not in GEL.
--|
--| Revision 1.54.2.2.2.17  1999/12/02 23:35:51  brendel
--| Changed color to a_color in set_*_color.
--|
--| Revision 1.54.2.2.2.16  1999/12/02 23:13:39  brendel
--| Uncommented gtk_has_focus. Changed cur to a_cursor in set_pointer_style.
--|
--| Revision 1.54.2.2.2.15  1999/12/02 22:25:21  brendel
--| Commented out features that are now in EV_WINDOW_IMP.
--|
--| Revision 1.54.2.2.2.14  1999/12/02 21:01:31  oconnor
--| added gtk_widget_show for non window widgets
--| factorised signal connection
--|
--| Revision 1.54.2.2.2.13  1999/12/02 20:12:17  brendel
--| Accidentally removed `set_minimum_*'. Restored that.
--|
--| Revision 1.54.2.2.2.12  1999/12/02 19:55:11  brendel
--| Implemented new event system.
--| Changed to comply with EV_WIDGET_I. This includes ordering and changing
--| comments.
--| Removed `set_*' where it applies to geometry. x, y, width, height and
--| set_*_resizable.
--|
--| Revision 1.54.2.2.2.11  1999/12/02 08:02:27  oconnor
--| Changed set color features to pass 16 bit values to C externals.
--| Was wrongly passing 8 bit values.
--|
--| Revision 1.54.2.2.2.10  1999/12/01 22:06:00  oconnor
--| set_cursor is now set_pointer_style
--|
--| Revision 1.54.2.2.2.9  1999/12/01 21:50:39  brendel
--| Applied new color class (red_8_bit, etc) and added declarations for
--| external macro's since they are not in GEL.
--|
--| Revision 1.54.2.2.2.8  1999/12/01 20:51:51  oconnor
--| removed obsolete commands
--|
--| Revision 1.54.2.2.2.7  1999/12/01 20:28:26  oconnor
--| x is now x_position
--|
--| Revision 1.54.2.2.2.6  1999/12/01 17:37:11  oconnor
--| migrating to new externals
--|
--| Revision 1.54.2.2.2.5  1999/12/01 01:02:32  brendel
--| Rearranged externals to GEL or EV_C_GTK. Modified some features that
--| relied on specific things like return value BOOLEAN instead of INTEGER.
--|
--| Revision 1.54.2.2.2.4  1999/11/30 23:01:09  oconnor
--| redefine interface to be of type EV_WIDGET
--| reimplement parent to query GTk for parent rather than storing parent
--| in attribute
--|
--| Revision 1.54.2.2.2.3  1999/11/29 17:29:56  brendel
--| Uncommented event connection statement in initialize.
--|
--| Revision 1.54.2.2.2.2  1999/11/24 22:48:06  brendel
--| Just managed to compile figure cluster example.
--|
--| Revision 1.54.2.2.2.1  1999/11/24 17:29:50  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.48.2.6  1999/11/23 02:09:10  oconnor
--| added experimental event action sequence for button press
--|
--| Revision 1.48.2.5  1999/11/17 01:53:02  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.48.2.4  1999/11/09 16:53:15  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.48.2.3  1999/11/04 23:10:27  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.48.2.2  1999/11/02 17:20:03  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
