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

	Gdk_events_mask: INTEGER is
			-- Mask of all the gdk events the gdkwindow shall receive.
		once
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
				C.gtk_widget_add_events (visual_widget, Gdk_events_mask)
			end
		end

	initialize is
			-- Show non window widgets.
			-- Initialize default options, colors and sizes.
			-- Connect action sequences to GTK signals.
		local
			connect_button_press_switch_agent: PROCEDURE [EV_GTK_CALLBACK_MARSHAL, TUPLE[]]
			on_key_event_intermediary_agent: PROCEDURE [EV_GTK_CALLBACK_MARSHAL, TUPLE [EV_KEY, STRING, BOOLEAN]]
		do
			if not C.gtk_is_widget (c_object) then
				print ("not widget!! " + generating_type)
			end
			if C.gtk_is_widget (c_object) and not C.gtk_is_window (c_object) then
				C.gtk_widget_show (c_object)
			end
			initialize_events	
			set_default_colors
				--| "configure-event" only happens for windows,
				--| so we connect to the "size-allocate" function.
			if C.gtk_is_window (c_object) then
				real_signal_connect (c_object, "configure-event", agent on_size_allocate, Default_translate)
			else
				real_signal_connect (c_object, "size-allocate", agent gtk_marshal.on_size_allocate_intermediate (c_object, ?, ?, ?, ?), size_allocate_translate_agent)
			end
	
			on_key_event_intermediary_agent := agent gtk_marshal.on_key_event_intermediary (c_object, ?, ?, ?)
			real_signal_connect (visual_widget, "key_press_event", on_key_event_intermediary_agent, key_event_translate_agent)
			real_signal_connect (visual_widget, "key_release_event", on_key_event_intermediary_agent, key_event_translate_agent)
				--| "button-press-event" is a special case, see below.
				
			connect_button_press_switch_agent := agent gtk_marshal.connect_button_press_switch_intermediary (c_object)
			pointer_button_press_actions.not_empty_actions.extend (connect_button_press_switch_agent)
			pointer_double_press_actions.not_empty_actions.extend (connect_button_press_switch_agent)
			if not pointer_button_press_actions.is_empty or not pointer_double_press_actions.is_empty then
				connect_button_press_switch
			end
			is_initialized := True
		end

	button_press_switch_is_connected: BOOLEAN
			-- Is `button_press_switch' connected to its event source.
		
feature {EV_WINDOW_IMP, EV_GTK_CALLBACK_MARSHAL} -- Implementation

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
						if a_key.code = app_implementation.Key_constants.Key_space then
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
		
	connect_button_press_switch is
			-- Connect `button_press_switch' to its event sources.
			--| See comment in `button_press_switch' above.
		do
			if not button_press_switch_is_connected then
				signal_connect ("button-press-event", agent gtk_marshal.button_press_switch_intermediary (c_object, ?, ?, ?, ?, ?, ?, ?, ?, ?), default_translate)
				button_press_switch_is_connected := True
			end
		end
	
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
			--| event type and pass the event data to the appropriate action
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
			child := C.gdk_window_get_pointer (C.gtk_widget_struct_window (c_object), $x, $y, $s)
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
			if parent_imp /= Void then
				wind ?= parent_imp
				if wind /= Void then
					Result := wind.inner_screen_x
				else
					Result := parent_imp.screen_x
				end
				Result := Result + x_position
			end
		end

	screen_y: INTEGER is
			-- Vertical offset relative to screen. 
		local 
			wind: EV_WINDOW_IMP 
		do 
			if parent_imp /= Void then
				wind ?= parent_imp
				if wind /= Void then
					Result := wind.inner_screen_y
				else
					Result := parent_imp.screen_y
				end
				Result := Result + y_position
			end
		end
	
feature -- Status report

	is_show_requested: BOOLEAN is
			-- Will `Current' be displayed when its parent is?
			-- See also `is_displayed'.
		do
			Result := has_struct_flag (C.GTK_VISIBLE_ENUM)
			check
				Result = (((C.gtk_object_struct_flags (c_object)// C.GTK_VISIBLE_ENUM) \\ 2) = 1)
			end
		end

	is_displayed: BOOLEAN is
			-- Is `Current' visible on the screen?
		do
			Result := has_struct_flag (C.GTK_MAPPED_ENUM)
			check
				Result = ((((C.gtk_object_struct_flags (c_object)// C.GTK_MAPPED_ENUM) \\ 2)) = 1)
			end
		end

	has_focus: BOOLEAN is
			-- Does widget have the keyboard focus?
		do
			Result := gtk_widget_has_focus (visual_widget)
		end
		
	has_capture: BOOLEAN is
			-- Has capture?
		do
			Result := has_struct_flag (C.GTK_HAS_GRAB_ENUM)
			check
				Result = (((
					(C.gtk_object_struct_flags (visual_widget)
					// C.GTK_HAS_GRAB_ENUM) \\ 2)
				) = 1)
			end
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
				NULL,						-- GdkWindow* confine_to 
				NULL,						-- GdkCursor *cursor
				0)							-- guint32 time
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
		--		c_object, agent show_popup_menu, popup_menu)
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
			Result := C.gtk_allocation_struct_x (C.gtk_widget_struct_allocation (c_object))
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
			Result := C.gtk_allocation_struct_y (C.gtk_widget_struct_allocation (c_object))
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

	has_struct_flag (a_flag: INTEGER): BOOLEAN is
			-- Has this widget the flag `a_flag' in struct_flags?
		do
				--| Shift to put bit in least significant place then take mod 2.
			Result := (((C.gtk_object_struct_flags (visual_widget) // a_flag) \\ 2)) = 1
		end

	cursor_signal_tag: INTEGER
			-- Tag returned from Gtk used to disconnect `enter-notify' signal

feature {EV_WINDOW_IMP} -- Implementation

	default_key_processing_blocked (a_key: EV_KEY): BOOLEAN is
			-- Used for drawing area to keep focus on all keys.
		do
			Result := False
		end

feature {EV_CONTAINER_IMP} -- Implementation

	set_parent_imp (a_container_imp: EV_CONTAINER_IMP) is
			-- Set `parent_imp' to `a_container_imp'.
		do
			parent_imp := a_container_imp
		end
		
feature {NONE} -- Implementation

	--| IEK Reimplemented as an attribute to keep an explicit reference on parent container.
	--| This coupling prevents the container from being unnecessarily disposed when the
	--| parent container interface is not referenced from Eiffel and is unparented.
	--| This unnecessary disposal would inturn force gtk to destroy `c_object'.
	parent_imp: EV_CONTAINER_IMP-- is
			-- Container widget that contains `Current'.
			-- (Void if `Current' is not in a container)
			--| Search back up through GtkWidget->parent to find a GtkWidget
			--| with an EV_ANY_IMP attached.
--		local
--			c_parent: POINTER
--		do
--			from
--				c_parent := c_object
--			until
--				Result /= Void or c_parent = NULL
--			loop
--				c_parent := C.gtk_widget_struct_parent (c_parent)
--				if c_parent /= NULL then
--					Result ?= eif_object_from_c (c_parent)
--				end
--			end
--		end

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

feature {NONE} -- Agent functions.

	key_event_translate_agent: FUNCTION [EV_GTK_CALLBACK_MARSHAL, TUPLE [INTEGER, POINTER], TUPLE] is
			-- 
		once
			Result := agent gtk_marshal.key_event_translate
		end
		
	size_allocate_translate_agent: FUNCTION [EV_GTK_CALLBACK_MARSHAL, TUPLE [INTEGER, POINTER], TUPLE] is
			-- 
		once
			Result := agent gtk_marshal.size_allocate_translate
		end

feature {NONE} -- Implementation

	gtk_widget_has_focus (a_c_object: POINTER): BOOLEAN is
			-- Does `a_c_object' have the focus.
		do
				--| Shift to put bit in least significant place then take mod 2.
			if a_c_object /= NULL then
				Result := has_struct_flag (C.GTK_HAS_FOCUS_ENUM)
				check
					Result = ((((C.gtk_object_struct_flags (a_c_object) // C.GTK_HAS_FOCUS_ENUM) \\ 2)) = 1)
				end
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
			if C.gtk_is_container (a_c_object) then
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

	gtk_widget_no_window (a_wid: POINTER): BOOLEAN is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			"GTK_WIDGET_NO_WINDOW"
		end

end -- class EV_WIDGET_IMP

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

