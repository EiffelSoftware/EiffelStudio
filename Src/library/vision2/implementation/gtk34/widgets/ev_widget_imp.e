note
	description:
		"Eiffel Vision widget. GTK implementation.%N%
		%See ev_widget.e"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			make,
			destroy,
			x_position,
			y_position,
			width, height,
			real_minimum_width,
			real_minimum_height
		end

	EV_SENSITIVE_IMP
		redefine
			interface
		end

	EV_COLORIZABLE_IMP
		redefine
			interface
		end

	EV_WIDGET_ACTION_SEQUENCES_I
		export
			{EV_INTERMEDIARY_ROUTINES}
				focus_in_actions_internal,
				focus_out_actions_internal,
				pointer_motion_actions_internal,
				pointer_button_release_actions,
				pointer_leave_actions,
				pointer_leave_actions_internal,
				pointer_enter_actions_internal
		end

	EV_DOCKABLE_SOURCE_IMP
		redefine
			interface
		end

	EV_BUILDER

feature {NONE} -- Initialization

	make
			-- Show non window widgets.
			-- Initialize default options, colors and sizes.
			-- Connect action sequences to GTK signals.
		do
			Precursor {EV_PICK_AND_DROPABLE_IMP}
			{GTK2}.gtk_widget_set_redraw_on_allocate (c_object, False)
			set_is_initialized (True)

			init_gtk_allocate_event_signal_connection (c_object)
			init_gtk_mapping_signal_connection (c_object)

			debug ("gtk_name")
				update_gtk_name
			end
		end

	initialize_file_drop (a_widget: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				GtkTargetEntry target_entry[1];
				target_entry[0].target = "STRING";
				target_entry[0].flags = 0;
				target_entry[0].info = 0;
			
				guint n_targets = G_N_ELEMENTS (target_entry);
				
				gtk_drag_dest_set (
					(GtkWidget*) $a_widget,
					GTK_DEST_DEFAULT_MOTION | GTK_DEST_DEFAULT_HIGHLIGHT | GTK_DEST_DEFAULT_DROP,
					target_entry,
					n_targets,
					GDK_ACTION_COPY|GDK_ACTION_MOVE|GDK_ACTION_LINK
				);
			]"
		end

feature -- Event handling

	init_resize_actions (a_resize_actions: like resize_actions)
			-- <Precursor>
		do
			-- TODO
		end

	init_dpi_changed_actions (a_dpi_changed_actions: like dpi_changed_actions)
			-- Initialize `a_dpi_changed_actions' accordingly to the current widget.
		do
			-- TODO
		end

	init_file_drop_actions (a_file_drop_actions: like file_drop_actions)
			-- <Precursor>
		do
		end

feature {EV_WINDOW_IMP, EV_INTERMEDIARY_ROUTINES, EV_ANY_I, EV_APPLICATION_IMP} -- Implementation

	init_gtk_allocate_event_signal_connection (a_c_object: POINTER)
		require
			not a_c_object.is_default_pointer
		local
			l_app_imp: like app_implementation
		do
			if not {GTK}.gtk_is_window (a_c_object) then
					-- Window resize events are connected separately
				l_app_imp := app_implementation
				real_signal_connect (a_c_object,
						{EV_GTK_EVENT_STRINGS}.size_allocate_event_name,
						agent (l_app_imp.gtk_marshal).on_size_allocate_event (internal_id, ?))
			end
		end

	init_gtk_mapping_signal_connection (a_c_object: POINTER)
		require
			not a_c_object.is_default_pointer
		local
			l_app_imp: like app_implementation
		do
			l_app_imp := app_implementation
				-- TODO: potential optimization connect only unmap , once the widget was mapped once
			real_signal_connect_after (a_c_object,
					{EV_GTK_EVENT_STRINGS}.map_event_name,
					agent (l_app_imp.gtk_marshal).on_widget_mapped_signal_intermediary (c_object))
			real_signal_connect_after (a_c_object,
					{EV_GTK_EVENT_STRINGS}.unmap_event_name,
					agent (l_app_imp.gtk_marshal).on_widget_unmapped_signal_intermediary (c_object))
		end

	on_key_event (a_key: detachable EV_KEY; a_key_string: detachable STRING_32; a_key_press: BOOLEAN)
			-- Used for key event actions sequences.
		do
			if a_key_press then
				if
					a_key /= Void and then
					attached key_press_actions_internal as l_key_press_actions_internal
				then
					l_key_press_actions_internal.call ([a_key])
				end
				if
					attached key_press_string_actions_internal as l_key_press_string_actions_internal and then
					a_key_string /= Void
				then
					l_key_press_string_actions_internal.call ([a_key_string])
				end
			else
				if
					a_key /= Void and then
					attached key_release_actions_internal as l_key_release_actions_internal
				then
					l_key_release_actions_internal.call ([a_key])
				end
			end
		end

	on_size_allocate (a_x, a_y, a_width, a_height: INTEGER)
			-- Gtk_Widget."size-allocate" happened.
			-- See https://developer.gnome.org/gtk3/stable/GtkWidget.html#GtkWidget-size-allocate
		local
			l_x_y_offset: INTEGER
			l_x, l_y: INTEGER
		do
			if a_width /= previous_width or else a_height /= previous_height then
				debug ("gtk_sizing")
					print (attached_interface.debug_output + {STRING_32} ".on_size_allocate (x=" + a_x.out + ",y=" + a_y.out + ",w=" + a_width.out + ",h=" + a_height.out + ")%N")
				end
				if attached parent_imp as l_parent_imp then
					l_x_y_offset := l_parent_imp.internal_x_y_offset
				end
				l_x := a_x - l_x_y_offset
				l_y := a_y - l_x_y_offset

				previous_width := a_width.to_integer_16
				previous_height := a_height.to_integer_16
				if
					attached resize_actions_internal as l_resize_actions and then
					not l_resize_actions.is_empty
				then
					l_resize_actions.call (app_implementation.gtk_marshal.dimension_tuple (l_x, l_y, a_width, a_height))
				end
			end
			if attached parent_imp as l_parent_imp then
				l_parent_imp.child_has_resized (Current)
			end
		end

	on_focus_changed (a_has_focus: BOOLEAN)
			-- Called from focus intermediary agents when focus for `Current' has changed.
			-- if `a_has_focus' then `Current' has just received focus.
		do
			if a_has_focus then
				if app_implementation.focus_in_actions_internal /= Void then
					app_implementation.focus_in_actions.call ([attached_interface])
				end
				if attached focus_in_actions_internal as l_focus_in_actions_internal then
					l_focus_in_actions_internal.call (Void)
				end
			else
				if app_implementation.focus_out_actions_internal /= Void then
					app_implementation.focus_out_actions.call ([attached_interface])
				end
				if attached focus_out_actions_internal as l_focus_out_actions_internal then
					l_focus_out_actions_internal.call (Void)
				end
			end
		end

	on_pointer_enter_leave (a_pointer_enter: BOOLEAN)
			-- Called from pointer enter leave intermediary agents when the mouse pointer either enters or leaves `Current'.
		do
			debug ("gtk_name")
				update_gtk_name
			end
			if a_pointer_enter then
					-- The mouse pointer has entered `Current'.
				if attached pointer_enter_actions_internal as l_pointer_enter_actions_internal then
					l_pointer_enter_actions_internal.call (Void)
				end
			else
					-- The mouse pointer has left `Current'.
				if attached pointer_leave_actions_internal as l_pointer_leave_actions_internal then
					l_pointer_leave_actions_internal.call (Void)
				end
			end
		end

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	call_button_event_actions (
			a_type: INTEGER;
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)

			-- Call pointer_button_press_actions or pointer_double_press_actions
			-- depending on event type in first position of `event_data'.
			--| GTK sends both GDK_BUTTON_PRESS and GDK_2BUTTON_PRESS events
			--| when a handler is attached to "button-press-event".
			--| We attach the signal to this switching feature to look at the
			--| event type and pass the event data to the appropriate action
			--| sequence.
		local
			t : TUPLE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE,
				INTEGER, INTEGER]
			mouse_wheel_delta: INTEGER
		do
			t := [a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure,
				a_screen_x, a_screen_y]
				-- Mouse Wheel implementation.
			if a_type /= {GTK}.GDK_BUTTON_RELEASE_ENUM then
					-- A button press must have occurred
				if a_type = {GTK}.GDK_BUTTON_PRESS_ENUM then
					mouse_wheel_delta := 1
				elseif a_type = {GTK}.GDK_2BUTTON_PRESS_ENUM then
					mouse_wheel_delta := 1
				elseif a_type = {GTK}.GDK_3BUTTON_PRESS_ENUM then
					mouse_wheel_delta := 1
				end
				if a_button = 4 and mouse_wheel_delta > 0 then
						-- This is for scrolling up
					if app_implementation.mouse_wheel_actions_internal /= Void then
						app_implementation.mouse_wheel_actions.call ([attached_interface, mouse_wheel_delta])
					end
					if attached mouse_wheel_actions_internal as l_mouse_wheel_actions_internal then
						l_mouse_wheel_actions_internal.call ([mouse_wheel_delta])
					end
				elseif a_button = 5 and mouse_wheel_delta > 0 then
						-- This is for scrolling down
					if app_implementation.mouse_wheel_actions_internal /= Void then
						app_implementation.mouse_wheel_actions.call ([attached_interface, -mouse_wheel_delta])
					end
					if attached mouse_wheel_actions_internal as l_mouse_wheel_actions_internal then
						l_mouse_wheel_actions_internal.call ([-mouse_wheel_delta])
					end
				end

				if a_button >= 1 and then a_button <= 3 then
					if a_type = {GTK}.GDK_BUTTON_PRESS_ENUM then
						if app_implementation.pointer_button_press_actions_internal /= Void then
							app_implementation.pointer_button_press_actions.call ([attached_interface, a_button, a_screen_x, a_screen_y])
						end
						if attached pointer_button_press_actions_internal as l_pointer_button_press_actions_internal then
							l_pointer_button_press_actions_internal.call (t)
						end
					elseif a_type = {GTK}.GDK_2BUTTON_PRESS_ENUM then
						if app_implementation.pointer_double_press_actions_internal /= Void then
							app_implementation.pointer_double_press_actions.call ([attached_interface, a_button, a_screen_x, a_screen_y])
						end
						if attached pointer_double_press_actions_internal as l_pointer_double_press_actions_internal then
							l_pointer_double_press_actions_internal.call (t)
						end
					end
				end
			else
					-- We have a button release event
				if a_button >= 1 and a_button <= 3 then
					if app_implementation.pointer_button_release_actions_internal /= Void then
						app_implementation.pointer_button_release_actions.call ([attached_interface, a_button, a_screen_x, a_screen_y])
					end
					if attached pointer_button_release_actions_internal as l_pointer_button_release_actions_internal then
						l_pointer_button_release_actions_internal.call (t)
					end
				end
			end
		end

feature -- Access

	parent: detachable EV_CONTAINER
			-- Container widget that contains `Current'.
			-- (Void if `Current' is not in a container)
		do
			if attached parent_imp as l_par_imp then
				Result := l_par_imp.interface
			end
		end

feature -- Status setting

	hide
			-- Request that `Current' not be displayed even when its parent is.
		do
				-- With GTK3, when a widget is hidden, the *width and *height queries
				-- does not return anymore the previous size.
				-- To keep existing behavior and size information
				-- record them in associated (size and minimum size) attributes.
			hidden_width := width
			hidden_height := height

			hidden_minimum_width := minimum_width
			hidden_minimum_height := minimum_height
			{GTK}.gtk_widget_hide (c_object)
		end

	hidden_width,
	hidden_height: INTEGER

	hidden_minimum_width,
	hidden_minimum_height: INTEGER

	width: INTEGER
		do
			Result := Precursor
			if not is_show_requested then
					-- With gtk3/4, when a widget is hidden, the width is 0
					-- while previously (gtk2) it was keeping the previous value
				if Result <= 0 and hidden_width > 0 then
					Result := hidden_width
				end
			end
		end

	height: INTEGER
		do
			Result := Precursor
			if not is_show_requested then
					-- With gtk3/4, when a widget is hidden, the height is 0
					-- while previously (gtk2) it was keeping the previous value
				if Result <= 0 and hidden_height > 0 then
					Result := hidden_height
				end
			end
		end

	real_minimum_width: INTEGER
		do
			Result := Precursor
			if not is_show_requested then
					-- With gtk3/4, when a widget is hidden, the minimum width is 0
					-- while previously (gtk2) it was keeping the previous value
				if Result <= 0 and hidden_minimum_width > 0 then
					Result := hidden_minimum_width
				end
			end
		end

	real_minimum_height: INTEGER
		do
			Result := Precursor
			if not is_show_requested then
					-- With gtk3/4, when a widget is hidden, the minimum height is 0
					-- while previously (gtk2) it was keeping the previous value				
				if Result <= 0 and hidden_minimum_height > 0 then
					Result := hidden_minimum_height
				end
			end
		end

feature -- Element change

	set_minimum_width (a_minimum_width: INTEGER)
			-- Set the minimum horizontal size to `a_minimum_width'.
		do
			debug ("gtk_sizing")
				print (generating_type.name_32 + {STRING_32} ".set_minimum_width (w=" + a_minimum_width.out + ")%N")
			end

			{GTK2}.gtk_widget_set_minimum_size (c_object, a_minimum_width, height_request)

				-- If the parent is a fixed or scrollable area we need to update the item size.
			if attached {EV_VIEWPORT_IMP} parent_imp as l_viewport_parent then
				l_viewport_parent.set_item_width (a_minimum_width.max (minimum_width))
			elseif attached {EV_FIXED_IMP} parent_imp as l_fixed_parent then
				l_fixed_parent.set_item_width (attached_interface, a_minimum_width.max (minimum_width))
			end
		end

	set_minimum_height (a_minimum_height: INTEGER)
			-- Set the minimum vertical size to `a_minimum_height'.
		do
			debug ("gtk_sizing")
				print (generating_type.name_32 + {STRING_32} ".set_minimum_height (h=" + a_minimum_height.out + ")%N")
			end

			{GTK2}.gtk_widget_set_minimum_size (c_object, width_request, a_minimum_height)

				-- If the parent is a fixed or scrollable area we need to update the item size.
			if attached {EV_VIEWPORT_IMP} parent_imp as l_viewport_parent then
				l_viewport_parent.set_item_height (a_minimum_height.max (minimum_height))
			elseif attached {EV_FIXED_IMP} parent_imp as l_fixed_parent then
				l_fixed_parent.set_item_height (attached_interface, a_minimum_height.max (minimum_height))
			end
		end

	set_minimum_size (a_minimum_width, a_minimum_height: INTEGER)
			-- Set the minimum size to `a_minimum_width` x `a_minimum_height`.
		do
			debug ("gtk_sizing")
				print (generating_type.name_32 + {STRING_32} ".set_minimum_size (w=" + a_minimum_width.out + ",h=" + a_minimum_height.out + ")%N")
			end
			{GTK2}.gtk_widget_set_minimum_size (c_object, a_minimum_width, a_minimum_height)

				-- If the parent is a fixed or scrollable area we need to update the item size.
			if attached {EV_VIEWPORT_IMP} parent_imp as l_viewport_parent then
				l_viewport_parent.set_item_size (a_minimum_width.max (minimum_width), a_minimum_height.max (minimum_height))
			elseif attached {EV_FIXED_IMP} parent_imp as l_fixed_parent then
				l_fixed_parent.set_item_size (attached_interface, a_minimum_width.max (minimum_width), a_minimum_height.max (minimum_height))
			end
		end

	set_widget_size_allocation (a_width, a_height: INTEGER)
			-- Set widget size at the GTK level using size allocate
			-- not the "minimize size" related to "width-request"  and " height-request".
		local
			l_c_object: POINTER
			l_alloc: POINTER
		do
			debug ("gtk_sizing")
				print (attached_interface.debug_output + {STRING_32} ".set_widget_size (w=" + a_width.out + ",h=" + a_height.out + ")%N")
			end
			l_c_object := c_object
			l_alloc := l_alloc.memory_alloc ({GTK}.c_gtk_allocation_struct_size)
			{GTK}.gtk_widget_get_allocation (l_c_object, l_alloc)
			{GTK}.set_gtk_allocation_struct_width (l_alloc, a_width)
			{GTK}.set_gtk_allocation_struct_height (l_alloc, a_height)

			check positive_width: a_width >= 0 end
			check positive_height: a_height >= 0 end

			{GTK2}.gtk_widget_size_allocate (l_c_object, l_alloc)
			l_alloc.memory_free
			{GTK}.gtk_container_check_resize (l_c_object)
		end

feature -- Measurement

	x_position: INTEGER
			-- Horizontal offset relative to parent `x_position'.
			-- Unit of measurement: screen pixels.
		do
			if attached {EV_FIXED_IMP} parent_imp as l_fixed then
				Result := l_fixed.x_position_of_child (Current)
			else
				Result := Precursor {EV_PICK_AND_DROPABLE_IMP}
			end
		end

	y_position: INTEGER
			-- Vertical offset relative to parent `y_position'.
			-- Unit of measurement: screen pixels.
		do
			if attached {EV_FIXED_IMP} parent_imp as l_fixed then
				Result := l_fixed.y_position_of_child (Current)
			else
				Result := Precursor {EV_PICK_AND_DROPABLE_IMP}
			end
		end

feature {EV_ANY_I} -- Implementation

	refresh_now
			-- Flush any pending redraws due for `Current'.
		do
			if {GTK}.gtk_widget_get_window (c_object) /= default_pointer then
				-- FIXME JV: gdk_window_process_updates has been deprecated since version 3.22 and should not be used in newly-written code.
				--		{GTK2}.gdk_window_process_updates ({GTK}.gtk_widget_get_window (c_object), False)
				-- 		https://stackoverflow.com/questions/34912757/how-do-you-force-a-screen-refresh-in-gtk-3-8
				{GTK}.gtk_widget_queue_draw (c_object)
				process_pending_events
			end
		end

	process_pending_events
		do
			app_implementation.process_pending_events_on_default_context
		end

feature {EV_CONTAINER_IMP} -- Implementation

	set_parent_imp (a_container_imp: detachable EV_CONTAINER_IMP)
			-- Set `parent_imp' to `a_container_imp'.
		do
			parent_imp := a_container_imp
		end

feature {EV_ANY_IMP, EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Implementation

	destroy
			-- Destroy `Current'
		local
			l_window: POINTER
		do
			if not is_destroyed then
					-- Remove previously set pointer.
				l_window := {GTK}.gtk_widget_get_window (c_object)
				if l_window /= default_pointer then
					{GTK}.gdk_window_set_cursor (l_window, default_pointer)
				end
				if attached parent_imp as l_parent_imp then
					l_parent_imp.attached_interface.prune_all (attached_interface)
				end
				Precursor {EV_PICK_AND_DROPABLE_IMP}
			end
		end

	parent_imp: detachable EV_CONTAINER_IMP
			-- Container widget that contains `Current'.
			-- (Void if `Current' is not in a container)

feature {EV_INTERMEDIARY_ROUTINES, EV_APPLICATION_IMP} -- Implementation

	on_widget_mapped
			-- `Current' has been mapped on to the screen.
		do
				-- Make sure that the pointer style is correctly set when the widget is mapped.
				-- This is needed for gtkwidgets that have not yet been realized.
			if
				attached pointer_style as l_pointer_style and then
				previously_set_pointer_style /= l_pointer_style
			then
				internal_set_pointer_style (l_pointer_style)
			end
		end

	on_widget_unmapped
			-- `Current' has been unmapped from the screen
		do
			previously_set_pointer_style := Void
		end

feature {EV_WIDGET_I} -- Implementation

	internal_x_y_offset: INTEGER
			-- Internal offset added to x/y coordinates of children.
		do
				-- Redefined by GtkLayout containers.
			Result := 0
		end

feature {NONE} -- Implementation

	propagate_foreground_color_internal (a_color: EV_COLOR; a_c_object: POINTER)
			-- Propagate `a_color' to the foreground color of `a_c_object's children.
		local
			l: POINTER
			child: POINTER
			fg: detachable EV_COLOR
			a_child_list: POINTER
		do
			if {GTK}.gtk_is_container (a_c_object) then
				from
					fg := a_color
					a_child_list := {GTK}.gtk_container_get_children (a_c_object)
					l := a_child_list
				until
					l.is_default_pointer
				loop
					child := {GTK}.glist_struct_data (l)
					real_set_foreground_color (child, fg)
					if {GTK}.gtk_is_container (child) then
						propagate_foreground_color_internal (fg, child)
					end
					l := {GTK}.glist_struct_next (l)
				end
				{GTK}.g_list_free (a_child_list)
			else
				real_set_foreground_color (a_c_object, fg)
			end
		end

	propagate_background_color_internal (a_color: EV_COLOR; a_c_object: POINTER)
			-- Propagate `a_color' to the background color of `a_c_object's children.
		local
			l: POINTER
			child: POINTER
			bg: detachable EV_COLOR
			a_child_list: POINTER
		do
			if
				{GTK}.gtk_is_container (a_c_object)
			then
				from
					bg := a_color
					a_child_list := {GTK}.gtk_container_get_children (a_c_object)
					l := a_child_list
				until
					l.is_default_pointer
				loop
					child := {GTK}.glist_struct_data (l)
					real_set_background_color (child, bg)
					if {GTK}.gtk_is_container (child) then
						propagate_background_color_internal (bg, child)
					end
					l := {GTK}.glist_struct_next (l)
				end
				{GTK}.g_list_free (a_child_list)
			else
				real_set_background_color (a_c_object, bg)
			end
		end

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	call_draw_actions (a_cairo_context: POINTER)
			-- Call the expose actions for the drawing area.
		do
			-- Redefined by descendents.
		end

feature {NONE} -- Implementation

	set_box_child_expandable (a_parent_box, a_child: POINTER; flag: BOOLEAN)
			-- Set whether `child' expands to fill available spare space.
		local
			old_expand, fill, pad, pack_type: INTEGER
		do
			{GTK}.gtk_box_query_child_packing (
				a_parent_box,
				a_child,
				$old_expand,
				$fill,
				$pad,
				$pack_type
			)
			{GTK}.gtk_box_set_child_packing (
				a_parent_box,
				a_child,
				flag,
				fill.to_boolean,
				pad,
				pack_type
			)
		end

feature {EV_APPLICATION_IMP} -- Implementation

	previous_width, previous_height: INTEGER_16
			-- Dimensions during last "size-allocate".

feature {EV_ANY, EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	interface: detachable EV_WIDGET note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_WIDGET_IMP
