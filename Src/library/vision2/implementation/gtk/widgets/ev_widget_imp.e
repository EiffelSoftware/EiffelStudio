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

	EV_SENSITIVE_IMP
		redefine
			interface
		end

	EV_COLORIZABLE_IMP
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
				connect_signal_to_actions (
					signal_name,
					actions,
					default_translate
				)
				i := i + 1
			end

				--| "configure-event" only happens for windows,
				--| so we connect to the "size-allocate" function.

			if C.gtk_is_window (c_object) then
				signal_connect (
					"configure-event",
					~on_size_allocate,
					Default_translate
				)
			else
				signal_connect (
					"size-allocate",
					~on_size_allocate,
					~size_allocate_translate
				)
			end
				--| "button-press-event" is a special case, see below.
			interface.pointer_button_press_actions.not_empty_actions.extend (
				~connect_button_press_switch
			)
			interface.pointer_double_press_actions.not_empty_actions.extend (
				~connect_button_press_switch
			)
			if not interface.pointer_button_press_actions.empty or
				not interface.pointer_double_press_actions.empty then
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
			if a_type = C.GDK_BUTTON_PRESS_ENUM then
				interface.pointer_button_press_actions.call (t)
			else -- a_type = C.GDK_2BUTTON_PRESS_ENUM
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
			c_parent: POINTER
			Result_imp: EV_CONTAINER_IMP
			agg_cell: EV_AGGREGATE_CELL
		do
			from
				c_parent := c_object
			until
				Result /= Void or c_parent = NULL
			loop
				c_parent := C.gtk_widget_struct_parent (c_parent)
				if c_parent /= NULL then
					Result_imp ?= eif_object_from_c (c_parent)
					if Result_imp /= Void then
						Result := Result_imp.interface
					end
				end
			end

			agg_cell ?= Result
			if agg_cell /= Void then
				Result := agg_cell.real_parent
				check
					real_parent_not_void: Result /= Void
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
			elseif parent /= Void
				then Result := x_position + parent.screen_x
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
			elseif parent /= Void then
				Result := y_position + parent.screen_y
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
			Result := (
				(C.gtk_object_struct_flags (c_object)
				// C.GTK_MAPPED_ENUM) \\ 2
			) = 1
		end

	has_focus: BOOLEAN is
			-- Does widget have the keyboard focus?
		do
			--| Shift to put bit in least significant place then take mod 2.
			Result := (
				(C.gtk_object_struct_flags (c_object)
				// C.GTK_HAS_FOCUS_ENUM) \\ 2
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
				C.GDK_BUTTON_RELEASE_MASK_ENUM +
				C.GDK_BUTTON_PRESS_MASK_ENUM +
				C.GDK_BUTTON_MOTION_MASK_ENUM +
				C.GDK_POINTER_MOTION_HINT_MASK_ENUM +
				C.GDK_POINTER_MOTION_MASK_ENUM,
				NULL,                      -- GdkWindow* confine_to 
				NULL,                      -- GdkCursor *cursor
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
		do
			--| FIXME Implement me now!!!!!!
			--pointer_style := a_cursor
			--if ((C.gtk_object_struct_flags (c_object)
			--		// C.GTK_REALIZED_ENUM) \\ 2
			--	) = 0
			--then
			--	C.gtk_widget_realize (c_object)
			--end
			--cursor_imp ?= a_cursor.implementation
			--C.gdk_window_set_cursor (
			--	C.gtk_widget_struct_window (c_object),
			--	cursor_imp.c_object
			--)

			--if cursor_imp.code /= 0 then
				--| FIXME
			--	create pointer_style--.make_with_code (cursor_imp.code)
			--else
			--	create pointer_style--.make_with_pixmap (cursor_imp.pixmap)
			--end
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

feature {NONE} -- Implementation

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
					interface.resize_actions.call ([a_x, a_y, a_width, a_height])
					last_width := a_width
					last_height := a_height
				end
				in_resize_event := False
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


feature {EV_ANY_I} -- Implementation

	interface: EV_WIDGET

	enable_motion_notify (widg: POINTER) is
		external
			"C (GtkWidget *) | %"gtk_eiffel.h%""
		end

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
--| Revision 1.68  2000/06/07 17:27:35  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
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
