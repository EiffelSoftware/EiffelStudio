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
			interface
		end

	EV_ANY_IMP
		redefine
			interface
		end

feature {NONE} -- Initialization	

	initialize is
			-- Show non window widgets.
			-- Initialize default options, colors and sizes.
			-- Connect action sequences to GTK signals.
		local
			signal_name: STRING
			actions: ACTION_SEQUENCE [TUPLE]
			signal_map: ARRAY [TUPLE [STRING, ACTION_SEQUENCE [TUPLE]]]
			i: INTEGER
		do
			if
				C.gtk_is_widget (c_object) and not C.gtk_is_window (c_object)
			then
				C.gtk_widget_show (c_object)
			end
			set_default_colors
			signal_map := <<
			["motion-notify-event",  interface.pointer_motion_actions],
			["button-release-event", interface.pointer_button_release_actions],
			["enter-notify-event",   interface.pointer_enter_actions],
			["leave-notify-event",   interface.pointer_leave_actions],
			["proximity-in-event",   interface.proximity_in_actions],
			["proximity-out-event",  interface.proximity_out_actions],
			["focus-in-event",       interface.focus_in_actions],
			["focus-out-event",      interface.focus_out_actions],
			["key-press-event",      interface.key_press_actions],
			["key-release-event",    interface.key_release_actions]
			>>
			from
				i := signal_map.lower
			until
				i > signal_map.upper
			loop
				signal_name ?= signal_map.item (i).item (Signal_map_signal_name)
				actions ?= signal_map.item (i).item (Signal_map_actions)
				connect_signal_to_actions (signal_name, actions)
				i := i + 1
			end

				--| "button-press-event" is a special case, see below.
			interface.pointer_button_press_actions.set_source_connection_agent (
				~connect_button_press_switch
			)

			interface.pointer_double_press_actions.set_source_connection_agent (
				~connect_button_press_switch
			)
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
				a_type = C.Gdk_button_press_enum or
				a_type = C.Gdk_2button_press_enum
		local
			t : TUPLE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE,
				INTEGER, INTEGER]
		do
			t := [a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure,
				a_screen_x, a_screen_y]
			if a_type = C.Gdk_button_press_enum then
				interface.pointer_button_press_actions.call (t)
			else -- a_type = C.Gdk_2button_press_enum
				interface.pointer_double_press_actions.call (t)
			end
        end

	button_press_switch_is_connected: BOOLEAN
			-- Is `button_press_switch' connected to its event source.

	connect_button_press_switch is
			-- Connect `button_press_switch' to its event sources.
			--| See comment in `button_press_switch' above.
		do
			if not button_press_switch_is_connected then
				signal_connect ( "button-press-event", ~button_press_switch)
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
			c_parent: POINTER
			Result_imp: EV_CONTAINER_IMP
		do
			from
				c_parent := c_object
			until
				Result /= Void or c_parent = Default_pointer
			loop
				c_parent := C.gtk_widget_struct_parent (c_parent)
				if c_parent /= Default_pointer then
					Result_imp ?= eif_object_from_c (c_parent)
					if Result_imp /= Void then
						Result := Result_imp.interface
					end
				end
			end
		end

	pointer_position: EV_COORDINATES is
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

	background_color: EV_COLOR is
			-- Color of face.
		local
			color: POINTER
		do
			check
				normal_color_at_head_of_array: C.Gtk_state_normal_enum = 0 
					--| GtkStyle has GdkColor bg[5] with 5 background colors
					--| for the 5 gtk states, since normal state is at the 
					--| front we just treat is as: GdkColor* bg_state_normal
			end
			color := C.gtk_style_struct_bg (
				C.gtk_widget_struct_style (c_object)
			)
			create Result
			Result.set_rgb_with_16_bit (
				C.gdk_color_struct_red (color),
				C.gdk_color_struct_green (color),
				C.gdk_color_struct_blue (color)
			)
		end

	foreground_color: EV_COLOR is
			-- Color of foreground features like text.
		local
			color: POINTER
		do
			check
				normal_color_at_head_of_array: C.Gtk_state_normal_enum = 0 
					--| See `background_color'
			end
			color := C.gtk_style_struct_fg (
				C.gtk_widget_struct_style (c_object)
			)
			create Result
			Result.set_rgb_with_16_bit (
				C.gdk_color_struct_red (color),
				C.gdk_color_struct_green (color),
				C.gdk_color_struct_blue (color)
			)
		end

	tooltip: STRING
			-- Text displayed when user moves mouse over widget.

feature -- Status report

	is_sensitive: BOOLEAN is
			-- Does `Current' respond to user input events.
		do
			--| Shift to put bit in least significant place then take mod 2.
			Result := (
				(C.gtk_object_struct_flags (c_object)
				// C.Gtk_sensitive_enum) \\ 2
			) = 1
		end

	is_show_requested: BOOLEAN is
			-- Will `Current' be displayed when its parent is?
			-- See also `is_displayed'.
		do
			--| Shift to put bit in least significant place then take mod 2.
			Result := (
				(C.gtk_object_struct_flags (c_object)
				// C.Gtk_visible_enum) \\ 2
			) = 1
		end

	is_displayed: BOOLEAN is
			-- Is `Current' visible on the screen?
		do
			--| Shift to put bit in least significant place then take mod 2.
			Result := (
				(C.gtk_object_struct_flags (c_object)
				// C.Gtk_mapped_enum) \\ 2
			) = 1
		end

	has_focus: BOOLEAN is
			-- Does widget have the keyboard focus?
		do
			--| Shift to put bit in least significant place then take mod 2.
			Result := (
				(C.gtk_object_struct_flags (c_object)
				// C.Gtk_has_focus_enum) \\ 2
			) = 1
		end

feature -- Status setting

	hide is
			-- Request that `Current' not be displayed even when its parent is.
		do
			C.gtk_widget_hide (c_object)
		end
	
	show is
			-- Request that `Current' be displayed when its parent is.
		do
			C.gtk_widget_show (c_object)
		end

	set_focus is
			-- Grab keyboard focus.
		do
			C.gtk_widget_grab_focus (c_object)
		end

	enable_sensitive is
			-- Enable sensitivity to user input events.
		do
			C.gtk_widget_set_sensitive (c_object, True)
		end

	disable_sensitive is
			-- Disable sensitivity to user input events.
		do
			C.gtk_widget_set_sensitive (c_object, False)
		end

	enable_capture is
			-- Grab all the mouse and keyboard events.
			--| Used by pick and drop.
		local
			i: INTEGER
		do
			C.gtk_grab_add (c_object)
			i := C.gdk_pointer_grab (
				C.gtk_widget_struct_window (c_object),
				1,                                    -- gint owner_events
				C.Gdk_button_release_mask_enum +
				C.Gdk_button_press_mask_enum +
				C.Gdk_button_motion_mask_enum +
				C.Gdk_pointer_motion_hint_mask_enum +
				C.Gdk_pointer_motion_mask_enum,
				Default_pointer,                      -- GdkWindow* confine_to 
				Default_pointer,                      -- GdkCursor *cursor
				0)                                    -- guint32 time
			end

	disable_capture is
			-- Ungrab all the mouse and keyboard events.
			--| Used by pick and drop.
		do
			C.gtk_grab_remove (c_object)
			C.gdk_pointer_ungrab (
				0 -- guint32 time
			) 
		end

feature -- Element change

	set_pointer_style (a_cursor: like pointer_style) is
			-- Assign `a_cursor' to `pointer_style'.
		local
			cursor_imp: EV_CURSOR_IMP
		do
			pointer_style := a_cursor
			if ((C.gtk_object_struct_flags (c_object)
					// C.Gtk_realized_enum) \\ 2
				) = 0
			then
				C.gtk_widget_realize (c_object)
			end
			cursor_imp ?= a_cursor.implementation
		--	C.gdk_window_set_cursor (
		--		C.gtk_widget_struct_window (c_object),
		--		cursor_imp.c_object
		--	)
		end

	set_background_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `foreground_color'
		do
			real_set_background_color (c_object, a_color)
		end

	real_set_background_color (a_c_object: POINTER; a_color: EV_COLOR) is
			-- Implementation of `set_background_color'
			-- Used also by classes that inherit EV_WIDGET_IMP but not
			-- EV_WIDGET. (eg EV_PIXMAPABLE_IMP)
			--| Check that the color is not already set.
			--| Copy the existing GtkStyle, modifiy it	
			--| and set it back into the widget.
			--| (See gtk/docs/styles.txt)
		local
			style: POINTER
			color: POINTER
			r, g, b, nr, ng, nb, m: INTEGER
		do
			style := C.gtk_widget_struct_style (a_c_object)
			color := C.gtk_style_struct_bg (a_c_object)
			r := a_color.red_16_bit
			g := a_color.green_16_bit
			b := a_color.blue_16_bit
			if
				C.gdk_color_struct_red (color) /= r or else
				C.gdk_color_struct_green (color) /= g or else
				C.gdk_color_struct_blue (color) /= b
			then
				m := a_color.Max_16_bit
				style := C.gtk_style_copy (style)
					--| Set normal state color.
				color := C.gtk_style_struct_bg (style)
					 + (C.Gtk_state_normal_enum * C.c_gdk_color_struct_size)
				C.set_gdk_color_struct_red (color, r)
				C.set_gdk_color_struct_green (color, g)
				C.set_gdk_color_struct_blue (color, b)
					--| Set active state color.
				color := C.gtk_style_struct_bg (style)
					 + (C.Gtk_state_active_enum * C.c_gdk_color_struct_size)
				nr := (r * Highlight_scale).rounded
				ng := (g * Highlight_scale).rounded
				nb := (b * Highlight_scale).rounded
				if nr < 0 then nr := 0 end
				if ng < 0 then ng := 0 end
				if nb < 0 then nb := 0 end
				C.set_gdk_color_struct_red (color, nr)
				C.set_gdk_color_struct_green (color, ng)
				C.set_gdk_color_struct_blue (color, nb)
					--| Set prelight state color.
				color := C.gtk_style_struct_bg (style)
					 + (C.Gtk_state_prelight_enum * C.c_gdk_color_struct_size)
				nr := (r * Prelight_scale).rounded
				ng := (g * Prelight_scale).rounded
				nb := (b * Prelight_scale).rounded
				if nr > m then nr := m end
				if ng > m then ng := m end
				if nb > m then nb := m end
				C.set_gdk_color_struct_red (color, nr)
				C.set_gdk_color_struct_green (color, ng)
				C.set_gdk_color_struct_blue (color, nb)
					--| Set selected state color to reverse.
				color := C.gtk_style_struct_bg (style)
					 + (C.Gtk_state_selected_enum * C.c_gdk_color_struct_size)
				nr := m - r;
				ng := m - g;
				nb := m - b//2;
				C.set_gdk_color_struct_red (color, nr)
				C.set_gdk_color_struct_green (color, ng)
				C.set_gdk_color_struct_blue (color, nb)
					--| Don't touch insensitive state color
					--| (C.Gtk_state_insensitive_enum)

				C.gtk_widget_set_style (a_c_object, style)
				C.gtk_style_unref (style)
			end
		end

	set_foreground_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `foreground_color'
		do
			real_set_foreground_color (c_object, a_color)
		end

	real_set_foreground_color (a_c_object: POINTER; a_color: EV_COLOR) is
			-- Implementation of `set_background_color'
			-- Used also by classes that inherit EV_WIDGET_IMP but not
			-- EV_WIDGET. (eg EV_PIXMAPABLE_IMP)
			--| Check that the color is not already set.
			--| Copy the existing GtkStyle, modifiy it	
			--| and set it back into the widget.
			--| (See gtk/docs/styles.txt)
		local
			style: POINTER
			color: POINTER
			r, g, b, m: INTEGER
		do
			style := C.gtk_widget_struct_style (a_c_object)
			color := C.gtk_style_struct_fg (a_c_object)
			r := a_color.red_16_bit
			g := a_color.green_16_bit
			b := a_color.blue_16_bit
			if
				C.gdk_color_struct_red (color) /= r or else
				C.gdk_color_struct_green (color) /= g or else
				C.gdk_color_struct_blue (color) /= b
			then
				m := a_color.Max_16_bit
				style := C.gtk_style_copy (style)
					--| Set normal state color.
				color := C.gtk_style_struct_fg (style)
					 + (C.Gtk_state_normal_enum * C.c_gdk_color_struct_size)
				C.set_gdk_color_struct_red (color, r)
				C.set_gdk_color_struct_green (color, g)
				C.set_gdk_color_struct_blue (color, b)
					--| Set active state color.
				color := C.gtk_style_struct_fg (style)
					 + (C.Gtk_state_active_enum * C.c_gdk_color_struct_size)
				C.set_gdk_color_struct_red (color, r)
				C.set_gdk_color_struct_green (color, g)
				C.set_gdk_color_struct_blue (color, b)
					--| Set prelight state color.
				color := C.gtk_style_struct_fg (style)
					 + (C.Gtk_state_prelight_enum * C.c_gdk_color_struct_size)
				C.set_gdk_color_struct_red (color, r)
				C.set_gdk_color_struct_green (color, g)
				C.set_gdk_color_struct_blue (color, b)
					--| Set selected state color to reverse.
				color := C.gtk_style_struct_fg (style)
					 + (C.Gtk_state_selected_enum * C.c_gdk_color_struct_size)
				C.set_gdk_color_struct_red (color, m - r)
				C.set_gdk_color_struct_green (color, m - g)
				C.set_gdk_color_struct_blue (color, m - b)
					--| Don't touch insensitive state color
					--| (Gtk_state_insensitive_enum)

				C.gtk_widget_set_style (a_c_object, style)
				C.gtk_style_unref (style)
			end
		end

	set_minimum_width (a_minimum_width: INTEGER) is
			-- Set the minimum horizontal size to `a_minimum_width'.
		do
			set_minimum_size (a_minimum_width, minimum_height.max(1))
		end

	set_minimum_height (a_minimum_height: INTEGER) is
			-- Set the minimum vertical size to `a_minimum_height'.
		do
			set_minimum_size (minimum_width.max(1), a_minimum_height)
		end

	set_minimum_size (a_minimum_width, a_minimum_height: INTEGER) is
			-- Set the minimum horizontal size to `a_minimum_width'.
			-- Set the minimum vertical size to `a_minimum_height'.
		do
			C.gtk_widget_set_usize (c_object, a_minimum_width, a_minimum_height)
		end
	
	set_tooltip (a_text: STRING) is
			-- Set `tooltip' to `a_text'.
		local
			app_imp: EV_APPLICATION_IMP
	        do
			tooltip := clone (a_text)
			app_imp ?= (create {EV_ENVIRONMENT}).application.implementation
			C.gtk_tooltips_set_tip (app_imp.tooltips, c_object,
				eiffel_to_c (a_text), Default_pointer)
		end

	remove_tooltip is
			-- Set `tooltip' to `Void'.
		local
			app_imp: EV_APPLICATION_IMP
	        do
			tooltip := Void
			app_imp ?= (create {EV_ENVIRONMENT}).application.implementation
			C.gtk_tooltips_set_tip (app_imp.tooltips, c_object,
				Default_pointer, Default_pointer)
		end

feature -- Measurement
	
	x_position: INTEGER is
			-- Horizontal offset relative to parent `x_position'.
			-- Unit of measurement: screen pixels.
		do
			Result := C.gtk_allocation_struct_x (
				C.gtk_widget_struct_allocation (c_object)
			)
		end

	y_position: INTEGER is
			-- Vertical offset relative to parent `y_position'.
			-- Unit of measurement: screen pixels.
		do
			Result := C.gtk_allocation_struct_y (
				C.gtk_widget_struct_allocation (c_object)
			)
		end	

	width: INTEGER is
			-- Horizontal size measured in pixels.
		do
			if is_displayed then
				Result := C.gtk_allocation_struct_width (
					C.gtk_widget_struct_allocation (c_object)
				).max (minimum_width)
			else
				Result := minimum_width
			end
		end

	height: INTEGER is
			-- Vertical size measured in pixels.
		do
			if is_displayed then
				Result := C.gtk_allocation_struct_height (
					C.gtk_widget_struct_allocation (c_object)
				).max (minimum_height)
			else
				Result := minimum_height
			end
		end
	
 	minimum_width: INTEGER is
			-- Minimum horizontal size in pixels.
		local
			gr: POINTER
		do
			gr := C.c_gtk_requisition_struct_allocate
			C.gtk_widget_size_request (c_object, gr)
			Result := C.gtk_requisition_struct_width (gr)
			C.c_gtk_requisition_struct_free (gr)
		end	

	minimum_height: INTEGER is
			-- Minimum vertical size in pixels.
		local
			gr: POINTER
		do
			gr := C.c_gtk_requisition_struct_allocate
			C.gtk_widget_size_request (c_object, gr)
			Result := C.gtk_requisition_struct_height (gr)
			C.c_gtk_requisition_struct_free (gr)
		end	

feature {NONE} -- Implementation

	cursor_signal_tag: INTEGER
		-- Tag returned from Gtk used to disconnect `enter-notify' signal

	Prelight_scale: REAL is 1.0909488
		-- Prelight color is this much lighter than `background_color'.

	Highlight_scale: REAL is 0.90912397
		-- Highlight color is this much darker than `background_color'.

feature {NONE} -- Implementation

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


feature {EV_ANY_I} -- Implementation

	interface: EV_WIDGET

	enable_motion_notify (widg: POINTER) is
		external
			"C (GtkWidget *) | %"gtk_eiffel.h%""
		end

feature -- Obsolete

	--| FIXME This is more like a strange-features-graveyard than
	--| a real obsolete feature classification, but most of it can
	--| really be removed whenever convenient.

	parent_imp: EV_CONTAINER_IMP is
		obsolete
			"use parent.implementation"
		local
			p: EV_CONTAINER
		do	
			p ?= parent
			if p /= Void then
				Result ?= p.implementation
			end
		end

	set_insensitive (flag: BOOLEAN) is obsolete "use disable_sensitive"
			-- Set current widget in insensitive mode if
			-- `flag'. This means that any events with an
			-- event type of KeyPress, KeyRelease,
			-- ButtonPress, ButtonRelease, MotionNotify,
			-- EnterNotify, LeaveNotify, FocusIn or
			-- FocusOut will not be dispatched to current
			-- widget and to all its children.  Set it to
			-- sensitive mode otherwise.
		do
			C.gtk_widget_set_sensitive (c_object, not flag)
		end

	set_horizontal_resize (flag: BOOLEAN) is
			-- Adapt `resize_type' to `flag'.
		obsolete
			"dont use it"
		do
		--	if flag then
		--		if vertical_resizable then
		--			resize_type := 3
		--		else
		--			resize_type := 1
		--		end
		--	else
		--		if vertical_resizable then
		--			resize_type := 2
		--		else
		--			resize_type := 0
		--		end				
		--	end
		--	if parent.implementation /= Void then
		--		--FIXME parent_imp.child_packing_changed (Current)
		--	end
		end

	set_vertical_resize (flag: BOOLEAN) is
			-- Adapt `resize_type' to `flag'.
		obsolete
			"dont use it"
		do
		--	if flag then
		--		if horizontal_resizable then
		--			resize_type := 3
		--	else
		--			resize_type := 2
		--		end
		--	else
		--		if horizontal_resizable then
		--			resize_type := 1
		--		else
		--			resize_type := 0
		--		end				
		--	end
		--	if parent.implementation /= Void then
		--		--FIXME parent_imp.child_packing_changed (Current)
		--	end
		end

	dimensions_set (new_width, new_height: INTEGER): BOOLEAN is
		-- Check if the dimensions of the widget are set to 
		-- the values given or the minimum values possible 
		-- for that widget.
		-- XXXXXXXXXXXXXXXXXXXXXX fix
		obsolete "dont use it"
		do
                --       Result := (width = new_width or else width = minimum_width or else (not shown and width = 1)) and then
                  --               (height = new_height or else height = minimum_height or else (not shown and height = 1))
                 --      Result := True
		end		

	minimum_dimensions_set (new_width, new_height: INTEGER): BOOLEAN is
			-- Check if the dimensions of the widget are set to 
			-- the values given or the minimum values possible 
			-- for that widget.
			-- On gtk, when the widget is not shown, the result is 0
		obsolete "dont use it"
		do 
		--	Result := (c_gtk_widget_minimum_size_set (c_object, new_width, new_height) = 1) or else
		--		(not shown and then (minimum_width = 0 and minimum_height = 0))
		end		

	position_set (new_x, new_y: INTEGER): BOOLEAN is
			-- Check if the dimensions of the widget are set to 
			-- the values given or the minimum values possible 
			-- for that widget.
 			-- On gtk, when the widget is not shown, the result is -1
		obsolete "dont use it"
		do
		--	Result := (c_gtk_widget_position_set (c_object, new_x, new_y) = 1) or else
		--		(not shown and then (x_position = - 1 and y_position = - 1))
		end
-- Now in EV_WINDOW_IMP:

--	set_position (a_x, a_y: INTEGER) is
--			-- Set horizontal offset to parent to `a_x'.
--			-- Set vertical offset to parent to `a_y'.
--		do
--			gtk_widget_set_uposition (c_object, a_x, a_y)
--		end

--	set_size (a_width, a_height: INTEGER) is
--			-- Set the horizontal size to `a_width'.
--			-- Set the vertical size to `a_height'.
--		do
--			c_gtk_widget_set_size (c_object, a_width, a_height)
--		end

	resize_type: INTEGER is
			-- How the widget resize itself in the cell
			-- 0 : no resizing, the widget move
			-- 1 : only the width changes
			-- 2 : only the height changes
			-- 3 : both width and height change
		obsolete "dont use it"
		do
			check false end
		end	

end -- class EV_WIDGET_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
