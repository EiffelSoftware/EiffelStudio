indexing
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

	on_pointer_motion (a_motion_tuple: TUPLE [INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]) is
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

	pointer_motion_actions_internal: EV_POINTER_MOTION_ACTION_SEQUENCE is
		deferred
		end

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Implementation

	call_button_event_actions (
			a_type: INTEGER;
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		is
		deferred
		end

feature {NONE} -- Implementation

	enable_capture is
			-- Grab all the mouse and keyboard events.
		local
			i: INTEGER
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
--				top_level_window_imp.grab_keyboard_and_mouse
				App_implementation.disable_debugger
				i := {EV_GTK_EXTERNALS}.gdk_pointer_grab (
					{EV_GTK_EXTERNALS}.gtk_widget_struct_window (event_widget),
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
				i := {EV_GTK_EXTERNALS}.gdk_keyboard_grab ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (event_widget), True, 0)
			end
		end

	disable_capture is
			-- Ungrab all the mouse and keyboard events.
			--| Used by pick and drop.
		do
			if has_capture then
				{EV_GTK_EXTERNALS}.gtk_grab_remove (event_widget)
				{EV_GTK_EXTERNALS}.gdk_pointer_ungrab (
					0 -- guint32 time
				)
				{EV_GTK_EXTERNALS}.gdk_keyboard_ungrab (0) -- guint32 time
				App_implementation.enable_debugger
				App_implementation.set_captured_widget (Void)
			end
		end

	has_capture: BOOLEAN is
			-- Does Current have the keyboard and mouse event capture?
		do
			Result := {EV_GTK_EXTERNALS}.gtk_object_struct_flags (event_widget) & {EV_GTK_EXTERNALS}.GTK_HAS_GRAB_ENUM = {EV_GTK_EXTERNALS}.GTK_HAS_GRAB_ENUM or else
			{EV_GTK_EXTERNALS}.gtk_object_struct_flags (c_object) & {EV_GTK_EXTERNALS}.GTK_HAS_GRAB_ENUM = {EV_GTK_EXTERNALS}.GTK_HAS_GRAB_ENUM
		end

feature -- Implementation

	enable_transport is
			-- Activate pick/drag and drop mechanism.
 		do
			is_transport_enabled := True
		end

	disable_transport is
			-- Deactivate pick/drag and drop mechanism.
		do
			is_transport_enabled := False
		ensure then
			is_transport_disabled: not is_transport_enabled
		end

	pre_pick_steps (a_x, a_y, a_screen_x, a_screen_y: INTEGER) is
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
		end

	is_dockable: BOOLEAN is
			-- Is `Current' dockable?
		deferred
		end

	set_to_drag_and_drop: BOOLEAN is
			-- Set `Current' to drag and drop mode.
		do
			Result := mode_is_drag_and_drop
		end

	able_to_transport (a_button: INTEGER): BOOLEAN is
			-- Is `Current' able to initiate transport with `a_button'.
		do
			Result := (mode_is_drag_and_drop and then a_button = 1 and then not is_dockable) or
				(mode_is_pick_and_drop and then a_button = 3)
		end

	on_mouse_button_event (
			a_type: INTEGER;
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		is
			-- Handle mouse button events.
		local
			app_imp: EV_APPLICATION_IMP
			l_cursor: EV_POINTER_STYLE
			l_top_level_window_imp: EV_WINDOW_IMP
			l_call_events: BOOLEAN
			l_dockable_source: EV_DOCKABLE_SOURCE_IMP
			l_current: ANY
		do
			l_call_events := True
			app_imp := app_implementation
			l_top_level_window_imp := top_level_window_imp
			if l_top_level_window_imp /= Void then
				if a_type = {EV_GTK_EXTERNALS}.gdk_button_press_enum and then not app_imp.is_in_transport then
					if is_dockable and then a_button = 1 then
						l_dockable_source ?= Current
						l_dockable_source.start_dragable_filter (a_type, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
						l_call_events := False
					elseif able_to_transport (a_button) then
							-- Retrieve/calculate pebble
						call_pebble_function (a_x, a_y, a_screen_x, a_screen_y)
						if pebble /= Void then
							if
								able_to_transport (a_button)
							then
								pre_pick_steps (a_x, a_y, a_screen_x, a_screen_y)
								if drop_actions_internal /= Void and then drop_actions_internal.accepts_pebble (pebble) then
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
								enable_capture
								l_call_events := False
							elseif ready_for_pnd_menu (a_button) then
								app_imp.target_menu (pebble).show
								l_call_events := False
							end
						end
					end
				else
					l_current := Current
					if a_type = {EV_GTK_EXTERNALS}.gdk_button_press_enum and then app_imp.pick_and_drop_source = l_current then
						end_transport (a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
						l_call_events := False
					end
					l_dockable_source ?= l_current
					if l_dockable_source /= Void and then a_type = {EV_GTK_EXTERNALS}.gdk_button_release_enum then
						if l_dockable_source.awaiting_movement or else app_imp.docking_source = l_current then
							if app_imp.docking_source = l_current then
								l_call_events := False
							end
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
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		is
			-- Initialize a pick and drop transport.
		do
			check
				do_not_call: False
			end
		end

	ready_for_pnd_menu (a_button: INTEGER): BOOLEAN is
			-- Will `Current' display a menu with button `a_button'.
		do
			Result := mode_is_target_menu and a_button = 3
		end

	end_transport (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- End a pick and drop transport.
		local
			target: EV_ABSTRACT_PICK_AND_DROPABLE
			l_pebble_tuple: TUPLE [like pebble]
			app_imp: EV_APPLICATION_IMP
		do
			disable_capture
			app_imp := app_implementation
			erase_rubber_band
			if not is_destroyed then
				if pointer_style /= Void then
					internal_set_pointer_style (pointer_style)
				else
						-- Reset the cursors.
					{EV_GTK_EXTERNALS}.gdk_window_set_cursor ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (visual_widget), NULL)
				end
			end

				-- Make sure 'in_transport' returns False before firing any drop actions.
			App_imp.on_drop (pebble)

				-- Call appropriate action sequences
			l_pebble_tuple := [pebble]
			if
				able_to_transport (a_button)
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

	post_drop_steps (a_button: INTEGER)  is
			-- Steps to perform once an attempted drop has happened.
		do
			App_implementation.set_x_y_origin (0, 0)
			if pebble_function /= Void then
				pebble_function.clear_last_result
				pebble := Void
			end
		end

	draw_rubber_band is
			-- Draw a segment between initial pick point and `destination'.
		local
			app_imp: EV_APPLICATION_IMP
		do
			app_imp := app_implementation
			if rubber_band_is_drawn then
					-- Undraw previous rubber band if any
				pnd_screen.draw_segment (app_imp.x_origin, app_imp.y_origin, app_imp.old_pointer_x, app_imp.old_pointer_y)
			end
			App_imp.set_old_pointer_x_y_origin (pointer_x, pointer_y)
			pnd_screen.draw_segment (app_imp.x_origin, app_imp.y_origin, app_imp.old_pointer_x, app_imp.old_pointer_y)
			rubber_band_is_drawn := True
		end

	erase_rubber_band is
			-- Erase previously drawn rubber band.
		local
			app_imp: EV_APPLICATION_IMP
		do
			app_imp := app_implementation
			if rubber_band_is_drawn then
				pnd_screen.draw_segment (app_imp.x_origin, app_imp.y_origin, app_imp.old_pointer_x, app_imp.old_pointer_y)
				rubber_band_is_drawn := False
			end
		end

	pnd_screen: EV_SCREEN is
			-- Screen object used for drawing PND transport line
		once
			create Result
			Result.enable_dashed_line_style
			Result.set_foreground_color ((create {EV_STOCK_COLORS}).white)
			Result.set_invert_mode
		end

	real_pointed_target: EV_PICK_AND_DROPABLE is
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

	create_drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Create and initialize `drop_actions' for `Current'
		do
			create Result
			interface.init_drop_actions (Result)
		end

	pointer_position: EV_COORDINATE is
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

indexing
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

