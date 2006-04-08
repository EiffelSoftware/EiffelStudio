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

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Implementation

	button_press_switch (
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
		do
			if not has_capture then
				App_implementation.disable_debugger
				if not has_focus then
					set_focus
				end
				l_interface ?= interface
				app_implementation.set_captured_widget (l_interface)
				{EV_GTK_EXTERNALS}.gtk_grab_add (event_widget)
				i := {EV_GTK_EXTERNALS}.gdk_pointer_grab (
					{EV_GTK_EXTERNALS}.gtk_widget_struct_window (event_widget),
					1,
					{EV_GTK_EXTERNALS}.gdk_button_release_mask_enum | {EV_GTK_EXTERNALS}.gdk_button_press_mask_enum | {EV_GTK_EXTERNALS}.gdk_pointer_motion_mask_enum,
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
			end
			App_implementation.set_captured_widget (Void)
		end

	has_capture: BOOLEAN is
			-- Does Current have the keyboard and mouse event capture?
		do
			Result := has_struct_flag (event_widget, {EV_GTK_EXTERNALS}.GTK_HAS_GRAB_ENUM) or else
				has_struct_flag (c_object, {EV_GTK_EXTERNALS}.GTK_HAS_GRAB_ENUM)
		end

feature -- Implementation

	enable_transport is
			-- Activate pick/drag and drop mechanism.
 		do
 			if not is_destroyed then
				is_transport_enabled := True
			end
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
			update_pointer_style (pointed_target)
			app_implementation.on_pick (pebble)
			if pick_actions_internal /= Void then
				pick_actions_internal.call ([a_x, a_y])
			end
			pointer_x := a_screen_x
			pointer_y := a_screen_y
			if pick_x = 0 and pick_y = 0 then
				App_implementation.set_x_y_origin (a_screen_x, a_screen_y)
			else
				if pick_x > width then
					pick_x := width
				end
				if pick_y > height then
					pick_y := height
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
			-- Filter out double click events.
		do
			if a_type /= {EV_GTK_EXTERNALS}.gdk_button_release_enum and then not App_implementation.is_in_transport and then able_to_transport (a_button) then
				start_transport (
					a_x,
					a_y,
					a_button,
					a_x_tilt,
					a_y_tilt,
					a_pressure,
					a_screen_x,
					a_screen_y
				)
			else
				if a_type = {EV_GTK_EXTERNALS}.gdk_button_press_enum and then app_implementation.is_in_transport and then app_implementation.captured_widget = interface then
					end_transport (a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
				else
					button_press_switch (a_type, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
				end
			end
		end

	start_transport (
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		is
			-- Initialize a pick and drop transport.
		local
			app_imp: EV_APPLICATION_IMP
			l_cursor: EV_CURSOR
		do
				-- Retrieve/calculate pebble
			call_pebble_function (a_x, a_y, a_screen_x, a_screen_y)
			if pebble /= Void then
				if
					able_to_transport (a_button)
				then
					app_imp := app_implementation
					pre_pick_steps (a_x, a_y, a_screen_x, a_screen_y)
					if drop_actions_internal /= Void and then drop_actions_internal.accepts_pebble (pebble) then
							-- Set correct accept cursor
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
				elseif ready_for_pnd_menu (a_button) then
					app_imp.target_menu (pebble).show
				end
			end
		end

	ready_for_pnd_menu (a_button: INTEGER): BOOLEAN is
			-- Will `Current' display a menu with button `a_button'.
		do
			Result := mode_is_target_menu and a_button = 3
		end

	signal_emit_stop (a_c_object: POINTER; a_signal: STRING_GENERAL) is
			-- Stop emission of signal `signal' on `a_c_object'.
		local
			a_cs: EV_GTK_C_STRING
		do
			a_cs := a_signal
			{EV_GTK_EXTERNALS}.signal_emit_stop_by_name (a_c_object, a_cs.item)
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
			if rubber_band_is_drawn then
				pnd_screen.draw_segment (app_imp.x_origin, app_imp.y_origin, app_imp.old_pointer_x, app_imp.old_pointer_y)
				rubber_band_is_drawn := False
			end
			if not is_destroyed then
				if pointer_style /= Void then
					internal_set_pointer_style (pointer_style)
				else
					-- Reset the cursors.
					{EV_GTK_EXTERNALS}.gdk_window_set_cursor ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), NULL)
					{EV_GTK_EXTERNALS}.gdk_window_set_cursor ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (event_widget), NULL)
				end
				{EV_GTK_EXTERNALS}.gtk_widget_queue_draw (c_object)
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

			if not is_destroyed then
				enable_transport
			end

			post_drop_steps (a_button)
		end

	post_drop_steps (a_button: INTEGER)  is
			-- Steps to perform once an attempted drop has happened.
		do
			App_implementation.set_x_y_origin (0, 0)
			last_pointed_target := Void
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
			gdkwin, gtkwid: POINTER
			a_x, a_y: INTEGER
			a_wid_imp: EV_PICK_AND_DROPABLE_IMP
			a_pnd_deferred_item_parent: EV_PND_DEFERRED_ITEM_PARENT
			a_row_imp: EV_PND_DEFERRED_ITEM
			l_app_imp: like app_implementation
		do
			l_app_imp := app_implementation
			gdkwin := {EV_GTK_EXTERNALS}.gdk_window_at_pointer ($a_x, $a_y)
			if gdkwin /= default_pointer then
				{EV_GTK_EXTERNALS}.gdk_window_get_user_data (gdkwin, $gtkwid)
				if gtkwid /= default_pointer then
					a_wid_imp ?= l_app_imp.eif_object_from_gtk_object (gtkwid)
				end
				if
					a_wid_imp /= Void and then
					has_struct_flag (a_wid_imp.c_object, {EV_GTK_EXTERNALS}.GTK_SENSITIVE_ENUM) and then
					not a_wid_imp.is_destroyed
				then
					if l_app_imp.pnd_targets.has (a_wid_imp.interface.object_id) then
						Result := a_wid_imp.interface
					end
					a_pnd_deferred_item_parent ?= a_wid_imp
					if a_pnd_deferred_item_parent /= Void then
							-- We need to explicitly search for PND deferred items
						a_row_imp := a_pnd_deferred_item_parent.row_from_y_coord (a_y)
						if a_row_imp /= Void and then l_app_imp.pnd_targets.has (a_row_imp.interface.object_id) then
							Result := a_row_imp.interface
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

feature {NONE} -- Implementation

	gdk_widget_no_window (a_widget: POINTER): BOOLEAN is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			"GTK_WIDGET_NO_WINDOW"
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

