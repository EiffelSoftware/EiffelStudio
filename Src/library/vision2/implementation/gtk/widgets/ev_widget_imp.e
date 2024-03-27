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
			y_position
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

feature {NONE} -- Initialization

	make
			-- Show non window widgets.
			-- Initialize default options, colors and sizes.
			-- Connect action sequences to GTK signals.
		do
			Precursor {EV_PICK_AND_DROPABLE_IMP}
			{GTK2}.gtk_widget_set_redraw_on_allocate (c_object, False)
			set_is_initialized (True)
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
		local
			l_app_imp: like app_implementation
		do
			if not {GTK}.gtk_is_window (c_object) then
					-- Window resize events are connected separately
				l_app_imp := app_implementation
				l_app_imp.gtk_marshal.signal_connect (c_object, l_app_imp.size_allocate_event_string, agent (l_app_imp.gtk_marshal).on_size_allocate_intermediate (internal_id, ?, ?, ?, ?), l_app_imp.gtk_marshal.size_allocate_translate_agent, False)
			end
		end

	init_dpi_changed_actions (a_dpi_changed_actions: like dpi_changed_actions)
			-- Initialize `a_dpi_changed_actions' accordingly to the current widget.
		do
		end


	init_file_drop_actions (a_file_drop_actions: like file_drop_actions)
			-- <Precursor>
		do
		end


feature {EV_WINDOW_IMP, EV_INTERMEDIARY_ROUTINES, EV_ANY_I, EV_APPLICATION_IMP} -- Implementation

	on_key_event (a_key: detachable EV_KEY; a_key_string: detachable STRING_32; a_key_press: BOOLEAN)
			-- Used for key event actions sequences.
		do
			if a_key_press then
				if a_key /= Void and then key_press_actions_internal /= Void then
					key_press_actions_internal.call ([a_key])
				end
				if key_press_string_actions_internal /= Void then
					if a_key_string /= Void then
						key_press_string_actions_internal.call ([a_key_string])
					end
				end
			else
				if a_key /= Void then
					if key_release_actions_internal /= Void then
						key_release_actions_internal.call ([a_key])
					end
				end
			end
		end

	on_size_allocate (a_x, a_y, a_width, a_height: INTEGER)
			-- Gtk_Widget."size-allocate" happened.
		do
			if a_width /= previous_width or else a_height /= previous_height then
				previous_width := a_width.to_integer_16
				previous_height := a_height.to_integer_16
				if resize_actions_internal /= Void then
					resize_actions_internal.call (app_implementation.gtk_marshal.dimension_tuple (a_x, a_y, a_width, a_height))
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
				if focus_in_actions_internal /= Void then
					focus_in_actions_internal.call (Void)
				end
			else
				if app_implementation.focus_out_actions_internal /= Void then
					app_implementation.focus_out_actions.call ([attached_interface])
				end
				if focus_out_actions_internal /= Void then
					focus_out_actions_internal.call (Void)
				end
			end
		end

	on_pointer_enter_leave (a_pointer_enter: BOOLEAN)
			-- Called from pointer enter leave intermediary agents when the mouse pointer either enters or leaves `Current'.
		do
			if a_pointer_enter then
					-- The mouse pointer has entered `Current'.
				if pointer_enter_actions_internal /= Void then
					pointer_enter_actions_internal.call (Void)
				end
			else
					-- The mouse pointer has left `Current'.
				if pointer_leave_actions_internal /= Void then
					pointer_leave_actions_internal.call (Void)
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
					if mouse_wheel_actions_internal /= Void then
						mouse_wheel_actions_internal.call ([mouse_wheel_delta])
					end
				elseif a_button = 5 and mouse_wheel_delta > 0 then
						-- This is for scrolling down
					if app_implementation.mouse_wheel_actions_internal /= Void then
						app_implementation.mouse_wheel_actions.call ([attached_interface, -mouse_wheel_delta])
					end
					if mouse_wheel_actions_internal /= Void then
						mouse_wheel_actions_internal.call ([-mouse_wheel_delta])
					end
				end

				if a_button >= 1 and then a_button <= 3 then
					if a_type = {GTK}.GDK_BUTTON_PRESS_ENUM then
						if app_implementation.pointer_button_press_actions_internal /= Void then
							app_implementation.pointer_button_press_actions.call ([attached_interface, a_button, a_screen_x, a_screen_y])
						end
						if pointer_button_press_actions_internal /= Void then
							pointer_button_press_actions_internal.call (t)
						end
					elseif a_type = {GTK}.GDK_2BUTTON_PRESS_ENUM then
						if app_implementation.pointer_double_press_actions_internal /= Void then
							app_implementation.pointer_double_press_actions.call ([attached_interface, a_button, a_screen_x, a_screen_y])
						end
						if pointer_double_press_actions_internal /= Void then
							pointer_double_press_actions_internal.call (t)
						end
					end
				end
			else
					-- We have a button release event
				if a_button >= 1 and a_button <= 3 then
					if app_implementation.pointer_button_release_actions_internal /= Void then
						app_implementation.pointer_button_release_actions.call ([attached_interface, a_button, a_screen_x, a_screen_y])
					end
					if pointer_button_release_actions_internal /= Void then
						pointer_button_release_actions_internal.call (t)
					end
				end
			end
		end

feature -- Access

	parent: detachable EV_CONTAINER
			-- Container widget that contains `Current'.
			-- (Void if `Current' is not in a container)
		local
			a_par_imp: detachable EV_CONTAINER_IMP
		do
			a_par_imp := parent_imp
			if a_par_imp /= Void then
				Result := a_par_imp.interface
			end
		end

feature -- Status setting

	hide
			-- Request that `Current' not be displayed even when its parent is.
		do
			{GTK}.gtk_widget_hide (c_object)
		end

feature -- Element change

	set_minimum_width (a_minimum_width: INTEGER)
			-- Set the minimum horizontal size to `a_minimum_width'.
		local
			l_height: INTEGER
			l_viewport_parent: detachable EV_VIEWPORT_IMP
			l_fixed_parent: detachable EV_FIXED_IMP
		do
			{GOBJECT}.g_object_get_integer (c_object, height_request_string.item, $l_height)
			{GTK2}.gtk_widget_set_minimum_size (c_object, a_minimum_width, l_height)

				-- If the parent is a fixed or scrollable area we need to update the item size.
			l_viewport_parent ?= parent_imp
			if l_viewport_parent /= Void then
				l_viewport_parent.set_item_width (a_minimum_width.max (width))
			else
				l_fixed_parent ?= parent_imp
				if l_fixed_parent /= Void then
					l_fixed_parent.set_item_width (attached_interface, a_minimum_width.max (width))
				end
			end
		end

	set_minimum_height (a_minimum_height: INTEGER)
			-- Set the minimum vertical size to `a_minimum_height'.
		local
			l_width: INTEGER
			l_viewport_parent: detachable EV_VIEWPORT_IMP
			l_fixed_parent: detachable EV_FIXED_IMP
		do
			{GOBJECT}.g_object_get_integer (c_object, width_request_string.item, $l_width)
			{GTK2}.gtk_widget_set_minimum_size (c_object, l_width, a_minimum_height)

				-- If the parent is a fixed or scrollable area we need to update the item size.
			l_viewport_parent ?= parent_imp
			if l_viewport_parent /= Void then
				l_viewport_parent.set_item_height (a_minimum_height.max (height))
			else
				l_fixed_parent ?= parent_imp
				if l_fixed_parent /= Void then
					l_fixed_parent.set_item_height (attached_interface, a_minimum_height.max (height))
				end
			end
		end

	set_minimum_size (a_minimum_width, a_minimum_height: INTEGER)
			-- Set the minimum horizontal size to `a_minimum_width'.
			-- Set the minimum vertical size to `a_minimum_height'.
		local
			l_viewport_parent: detachable EV_VIEWPORT_IMP
			l_fixed_parent: detachable EV_FIXED_IMP
		do
			{GTK2}.gtk_widget_set_minimum_size (c_object, a_minimum_width, a_minimum_height)

				-- If the parent is a fixed or scrollable area we need to update the item size.
			l_viewport_parent ?= parent_imp
			if l_viewport_parent /= Void then
				l_viewport_parent.set_item_size (a_minimum_width.max (width), a_minimum_height.max (height))
			else
				l_fixed_parent ?= parent_imp
				if l_fixed_parent /= Void then
					l_fixed_parent.set_item_size (attached_interface, a_minimum_width.max (width), a_minimum_height.max (height))
				end
			end
		end

	reset_minimum_width
			-- Reset the minimum width.
		local
			v: INTEGER
		do
			{GOBJECT}.g_object_get_integer (c_object, height_request_string.item, $v)
			{GTK2}.gtk_widget_set_minimum_size (c_object, -1, v)
		end

	reset_minimum_height
			-- Reset the minimum height.
		local
			v: INTEGER
		do
			{GOBJECT}.g_object_get_integer (c_object, height_request_string.item, $v)
			{GTK2}.gtk_widget_set_minimum_size (c_object, v, -1)
		end

	reset_minimum_size
			-- Reset the minimum size (width and height).
		do
			{GTK2}.gtk_widget_set_minimum_size (c_object, -1, -1)
		end

feature -- Measurement

	x_position: INTEGER
			-- Horizontal offset relative to parent `x_position'.
			-- Unit of measurement: screen pixels.
		local
			a_fixed_imp: detachable EV_FIXED_IMP
		do
			a_fixed_imp ?= parent_imp
			if a_fixed_imp /= Void then
				Result := a_fixed_imp.x_position_of_child (Current)
			else
				Result := Precursor {EV_PICK_AND_DROPABLE_IMP}
			end
		end

	y_position: INTEGER
			-- Vertical offset relative to parent `y_position'.
			-- Unit of measurement: screen pixels.
		local
			a_fixed_imp: detachable EV_FIXED_IMP
		do
			a_fixed_imp ?= parent_imp
			if a_fixed_imp /= Void then
				Result := a_fixed_imp.y_position_of_child (Current)
			else
				Result := Precursor {EV_PICK_AND_DROPABLE_IMP}
			end
		end

feature {EV_ANY_I} -- Implementation

	refresh_now
			-- Flush any pending redraws due for `Current'.
		do
			if {GTK}.gtk_widget_struct_window (c_object) /= default_pointer then
				{GTK2}.gdk_window_process_updates (
					{GTK}.gtk_widget_struct_window (c_object),
					False
				)
			end
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
				l_window := {GTK}.gtk_widget_struct_window (c_object)
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
			if previously_set_pointer_style = Void and then attached pointer_style as l_pointer_style then
				internal_set_pointer_style (l_pointer_style)
			end
		end

	on_widget_unmapped
			-- `Current' has been unmapped from the screen
		do
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
					a_child_list := {GTK}.gtk_container_children (a_c_object)
					l := a_child_list
				until
					l = NULL
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
					a_child_list := {GTK}.gtk_container_children (a_c_object)
					l := a_child_list
				until
					l = NULL
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
