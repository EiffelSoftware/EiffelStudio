note
	description:
		"Eiffel Vision pick and drop source, GTK implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "pick and drop, drag and drop, source, PND, DND"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PICK_AND_DROPABLE_IMP

inherit
	EV_GTK_WIDGET_IMP
		redefine
			interface
		end

	EV_PICK_AND_DROPABLE_I
		export
			{EV_INTERMEDIARY_ROUTINES}
				execute
		redefine
			interface
		end

	EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_IMP
		redefine
			create_drop_actions
		end

feature {EV_APPLICATION_IMP} -- Implementation

	on_pointer_motion (a_motion_tuple: TUPLE [INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER])
			-- Handle motion event for `Current'.
		local
			l_dockable_source: EV_DOCKABLE_SOURCE_IMP
			l_call_events: BOOLEAN
			l_current: ANY
		do
			l_call_events := True
			l_current := Current
			if app_implementation.pick_and_drop_source = l_current then
				execute (
					a_motion_tuple.integer_32_item (1),
					a_motion_tuple.integer_32_item (2),
					a_motion_tuple.double_item (3),
					a_motion_tuple.double_item (4),
					a_motion_tuple.double_item (5),
					a_motion_tuple.integer_32_item (6),
					a_motion_tuple.integer_32_item (7)
				)
				l_call_events := False
			elseif is_dockable then
				l_dockable_source ?= l_current
				if l_dockable_source.awaiting_movement or else app_implementation.docking_source = l_current then
					l_dockable_source.dragable_motion (
						a_motion_tuple.integer_32_item (1),
						a_motion_tuple.integer_32_item (2),
						a_motion_tuple.double_item (3),
						a_motion_tuple.double_item (4),
						a_motion_tuple.double_item (5),
						a_motion_tuple.integer_32_item (6),
						a_motion_tuple.integer_32_item (7)
					)
				end
				if app_implementation.docking_source = l_current then
					l_call_events := False
				end
			end
			if l_call_events and then pointer_motion_actions_internal /= Void then
				pointer_motion_actions_internal.call (a_motion_tuple)
			end
		end

	pointer_motion_actions_internal: EV_POINTER_MOTION_ACTION_SEQUENCE
		deferred
		end

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Implementation

	call_button_event_actions (
			a_type: INTEGER;
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		
		deferred
		end

feature {NONE} -- Implementation

	enable_capture
			-- Grab all the mouse and keyboard events.
		local
			l_interface: EV_WIDGET
			l_grab_widget: POINTER
		do
			if not has_capture then
					-- On Solaris, if a menu is selected, then `enable_capture' will not close the menu
					-- as GTK does on other platforms. Note that `gtk_menu_shell_cancel' will only
					-- work on GTK 2.4 or above, it is a no-op otherwise.
				l_grab_widget := {EV_GTK_EXTERNALS}.gtk_grab_get_current
				if l_grab_widget /= default_pointer then
					if {EV_GTK_EXTERNALS}.gtk_is_menu (l_grab_widget) then
						{EV_GTK_EXTERNALS}.gtk_menu_shell_cancel (l_grab_widget)
					end
				end
				if not has_focus then
					internal_set_focus
				end
				l_interface ?= interface
				app_implementation.set_captured_widget (l_interface)
				{EV_GTK_EXTERNALS}.gtk_grab_add (event_widget)
				if app_implementation.focused_popup_window /= top_level_window_imp then
					grab_keyboard_and_mouse
				end
				app_implementation.disable_debugger
			end
		end

	disable_capture
			-- Ungrab all the mouse and keyboard events.
			--| Used by pick and drop.
		do
			if has_capture then
				{EV_GTK_EXTERNALS}.gtk_grab_remove (event_widget)
				if app_implementation.focused_popup_window /= top_level_window_imp then
					release_keyboard_and_mouse
				end
				App_implementation.set_captured_widget (Void)
			end
			App_implementation.enable_debugger
		end

	has_capture: BOOLEAN
			-- Does Current have the keyboard and mouse event capture?
		do
			Result := App_implementation.captured_widget = interface or else app_implementation.pick_and_drop_source = Current
		end

	grab_keyboard_and_mouse
			-- Perform a global mouse and keyboard grab.
		local
			i: INTEGER
			l_gdk_window: POINTER
		do
			App_implementation.disable_debugger
			l_gdk_window := {EV_GTK_EXTERNALS}.gtk_widget_struct_window (event_widget)
			i := {EV_GTK_EXTERNALS}.gdk_pointer_grab (
				l_gdk_window,
				1,
				{EV_GTK_EXTERNALS}.gdk_button_release_mask_enum |
				{EV_GTK_EXTERNALS}.gdk_button_press_mask_enum |
				{EV_GTK_EXTERNALS}.gdk_pointer_motion_mask_enum |
				{EV_GTK_EXTERNALS}.gdk_pointer_motion_hint_mask_enum
				,
				null,
				null,
				0
			)
			i := {EV_GTK_EXTERNALS}.gdk_keyboard_grab (l_gdk_window, True, 0)
		end

	release_keyboard_and_mouse
			-- Release mouse and keyboard grab.
		do
			{EV_GTK_EXTERNALS}.gdk_pointer_ungrab (
				0 -- guint32 time
			)
			{EV_GTK_EXTERNALS}.gdk_keyboard_ungrab (0) -- guint32 time
			app_implementation.enable_debugger
		end

feature -- Implementation

	draw_rubber_band
			-- Erase previously drawn rubber band.
			-- Draw a rubber band between initial pick point and cursor.
		do
			app_implementation.draw_rubber_band
		end

	erase_rubber_band
			-- Erase previously drawn rubber band.
		do
			app_implementation.erase_rubber_band
		end

	enable_transport
			-- Activate pick/drag and drop mechanism.
 		do
			is_transport_enabled := True
		end

	disable_transport
			-- Deactivate pick/drag and drop mechanism.
		do
			is_transport_enabled := False
		ensure then
			is_transport_disabled: not is_transport_enabled
		end

	pre_pick_steps (a_x, a_y, a_screen_x, a_screen_y: INTEGER)
			-- Steps to perform before transport initiated.
		do
				-- Force any pending graphics calls.
			{EV_GTK_EXTERNALS}.gdk_flush
			update_pointer_style (pointed_target)
			app_implementation.on_pick (Current, pebble)
			if pick_actions_internal /= Void then
				pick_actions_internal.call ([a_x, a_y])
			end
			pointer_x := a_screen_x.to_integer_16
			pointer_y := a_screen_y.to_integer_16
			if pick_x = 0 and pick_y = 0 then
				App_implementation.set_x_y_origin (a_screen_x, a_screen_y)
			else
				if pick_x > width then
					pick_x := width.to_integer_16
				end
				if pick_y > height then
					pick_y := height.to_integer_16
				end
				App_implementation.set_x_y_origin (pick_x + (a_screen_x - a_x), pick_y + (a_screen_y - a_y))
			end
			modify_widget_appearance (True)
		end

	is_dockable: BOOLEAN
			-- Is `Current' dockable?
		deferred
		end

	set_to_drag_and_drop: BOOLEAN
			-- Set `Current' to drag and drop mode.
		do
			Result := mode_is_drag_and_drop
		end

	able_to_transport (a_button: INTEGER): BOOLEAN
			-- Is `Current' able to initiate transport with `a_button'.
		do
			Result := (mode_is_drag_and_drop and then a_button = 1 and then not is_dockable) or
				(mode_is_pick_and_drop and then a_button = 3 and then not mode_is_configurable_target_menu)
		end

	on_mouse_button_event (
			a_type: INTEGER;
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		
			-- Handle mouse button events.
		local
			app_imp: EV_APPLICATION_IMP
			l_top_level_window_imp: EV_WINDOW_IMP
			l_call_events: BOOLEAN
			l_dockable_source: EV_DOCKABLE_SOURCE_IMP
			l_current: ANY
			l_press: BOOLEAN
		do
			l_press := a_type /= {EV_GTK_EXTERNALS}.gdk_button_release_enum
			app_imp := app_implementation
			l_call_events := not app_imp.is_in_transport
			l_top_level_window_imp := top_level_window_imp
			if l_top_level_window_imp /= Void then
				if not app_imp.is_in_transport then
					if a_type = {EV_GTK_EXTERNALS}.gdk_button_press_enum and then is_dockable and then a_button = 1 then
						l_dockable_source ?= Current
						l_dockable_source.start_dragable_filter (a_type, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
					elseif (a_type = {EV_GTK_EXTERNALS}.gdk_button_release_enum and then able_to_transport (a_button)) or else ready_for_pnd_menu (a_button, l_press) then
						start_transport (a_x, a_y, a_button, l_press, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y, False)
						l_call_events := pebble = Void
							-- If a pick and drop has initiated then we dont want button events firing.
					end
				else
					l_current := Current
					if a_type = {EV_GTK_EXTERNALS}.gdk_button_release_enum and then app_imp.pick_and_drop_source = l_current then
						end_transport (a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
					end
					l_dockable_source ?= l_current
					if l_dockable_source /= Void and then a_type = {EV_GTK_EXTERNALS}.gdk_button_release_enum then
						if l_dockable_source.awaiting_movement or else app_imp.docking_source = l_current then
							l_dockable_source.end_dragable (a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
						end
					end
				end
				if l_call_events then
					call_button_event_actions (a_type, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
				end
			end
		end


	start_transport (
			a_x, a_y, a_button: INTEGER; a_press: BOOLEAN
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER; a_menu_only: BOOLEAN)
		
			-- Initialize a pick and drop transport.
		local
			l_configure_agent: PROCEDURE [ANY, TUPLE]
			l_pebble: like pebble
		do
			call_pebble_function (a_x, a_y, a_screen_x, a_screen_y)
			l_pebble := pebble
			reset_pebble_function
				-- We reset the pebble function immediately to avoid any 'memory leak' from calling the pebble function
				-- It is then re-set in the configure agent.
			if l_pebble /= Void then
				l_configure_agent := agent (a_pebble: like pebble; a_start_x, a_start_y, a_start_screen_x, a_start_screen_y: INTEGER)
				local
					l_cursor: EV_POINTER_STYLE
				do
					pebble := a_pebble
					enable_capture
					pre_pick_steps (a_start_x, a_start_y, a_start_screen_x, a_start_screen_y)
					if drop_actions_internal /= Void and then drop_actions_internal.accepts_pebble (a_pebble) then
							-- Set correct accept cursor if `Current' accepts its own pebble.
						if accept_cursor /= Void then
							l_cursor := accept_cursor
						else
							l_cursor := default_accept_cursor
						end
					else
							-- Set correct deny cursor
						if deny_cursor /= Void then
							l_cursor := deny_cursor
						else
							l_cursor := default_deny_cursor
						end
					end
					internal_set_pointer_style (l_cursor)
				end (l_pebble, a_x, a_y, a_screen_x, a_screen_y)
			end

			if ready_for_pnd_menu (a_button, a_press) then
				app_implementation.create_target_menu (a_x, a_y, a_screen_x, a_screen_y, pebble_source, l_pebble, l_configure_agent, a_menu_only)
			elseif l_configure_agent /= Void then
				l_configure_agent.call (Void)
			end
		end

	pebble_source: EV_PICK_AND_DROPABLE
			-- Source of `pebble', used for widgets with deferred PND implementation
			-- such as EV_TREE and EV_MULTI_COLUMN_LIST.
		do
			Result := interface
		end

	ready_for_pnd_menu (a_button: INTEGER; a_press: BOOLEAN): BOOLEAN
			-- Will `Current' display a menu with button `a_button'.
		do
			Result := ((mode_is_target_menu or else mode_is_configurable_target_menu) and a_button = 3) and then not a_press
		end

	end_transport (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- End a pick and drop transport.
		local
			target: EV_ABSTRACT_PICK_AND_DROPABLE
			l_pebble_tuple: TUPLE [like pebble]
			app_imp: EV_APPLICATION_IMP
		do
			disable_capture
			app_imp := app_implementation
			erase_rubber_band
			modify_widget_appearance (False)
			if not is_destroyed then
				if pointer_style /= Void then
					internal_set_pointer_style (pointer_style)
				else
						-- Reset the cursors.
					{EV_GTK_EXTERNALS}.gdk_window_set_cursor ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), default_pointer)
				end
			end
				-- Make sure 'in_transport' returns False before firing any drop actions.
			App_imp.on_drop (pebble)

				-- Call appropriate action sequences
			l_pebble_tuple := [pebble]
			if
				able_to_transport (a_button) or else ready_for_pnd_menu (a_button, False)
			then
				target := pointed_target
				if target /= Void and then target.drop_actions.accepts_pebble (pebble) then
					target.drop_actions.call (l_pebble_tuple)
					App_imp.drop_actions.call (l_pebble_tuple)
				else
					App_imp.cancel_actions.call (l_pebble_tuple)
				end
			else
				App_imp.cancel_actions.call (l_pebble_tuple)
			end

			if pick_ended_actions_internal /= Void then
				pick_ended_actions_internal.call ([target])
			end
			enable_transport
			post_drop_steps (a_button)
		end

	post_drop_steps (a_button: INTEGER)
			-- Steps to perform once an attempted drop has happened.
		do
			App_implementation.set_x_y_origin (0, 0)
			reset_pebble_function
		end

	real_pointed_target: EV_PICK_AND_DROPABLE
			-- Hole at mouse position
		local
			gdkwin: POINTER
			a_x, a_y: INTEGER
			a_wid_imp: EV_PICK_AND_DROPABLE_IMP
			a_pnd_deferred_item_parent: EV_PND_DEFERRED_ITEM_PARENT
			a_pnd_item: EV_PND_DEFERRED_ITEM
			l_app_imp: like app_implementation
		do
			l_app_imp := app_implementation
			if l_app_imp.use_stored_display_data then
					-- This will avoid a server roundtrip.
			else
				l_app_imp.update_display_data
			end
			gdkwin := l_app_imp.stored_display_data.window
			a_x := l_app_imp.stored_display_data.x
			a_y := l_app_imp.stored_display_data.y

			if gdkwin /= default_pointer then
				a_wid_imp ?= l_app_imp.gtk_widget_from_gdk_window (gdkwin)
				if
					a_wid_imp /= Void and then
					{EV_GTK_EXTERNALS}.gtk_object_struct_flags (a_wid_imp.c_object) & {EV_GTK_EXTERNALS}.GTK_SENSITIVE_ENUM = {EV_GTK_EXTERNALS}.GTK_SENSITIVE_ENUM and then
					not a_wid_imp.is_destroyed
				then
					if l_app_imp.pnd_targets.has (a_wid_imp.interface.object_id) then
						Result := a_wid_imp.interface
					end
					a_pnd_deferred_item_parent ?= a_wid_imp
					if a_pnd_deferred_item_parent /= Void then
							-- We need to explicitly search for PND deferred items
							-- A server roundtrip is needed to get the coordinates relative to the PND target parent..
						gdkwin := {EV_GTK_EXTERNALS}.gdk_window_get_pointer ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (a_wid_imp.c_object), $a_x, $a_y, default_pointer)
						a_pnd_item := a_pnd_deferred_item_parent.item_from_coords (a_x, a_y)
						if a_pnd_item /= Void and then l_app_imp.pnd_targets.has (a_pnd_item.interface.object_id) then
							Result := a_pnd_item.interface
						end
					end
				end
			end
		end

	create_drop_actions: EV_PND_ACTION_SEQUENCE
			-- Create and initialize `drop_actions' for `Current'
		do
			create Result
			interface.init_drop_actions (Result)
		end

	pointer_position: EV_COORDINATE
			-- Position of the screen pointer relative to `Current'.
		local
			x, y, s: INTEGER
			child: POINTER
		do
			child := {EV_GTK_EXTERNALS}.gdk_window_get_pointer ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), $x, $y, $s)
			create Result.set (x, y)
		end


feature {EV_ANY_I} -- Implementation

	interface: EV_PICK_AND_DROPABLE;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_PICK_AND_DROPABLE_IMP

