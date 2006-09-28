indexing
	description:
		"EiffelVision application, GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "application"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_APPLICATION_IMP

inherit
	EV_APPLICATION_I
		export
			{EV_INTERMEDIARY_ROUTINES}
				pointer_motion_actions_internal,
				pointer_button_press_actions_internal,
				pointer_double_press_actions_internal,
				pointer_button_release_actions_internal
			{EV_ANY_I, EV_INTERMEDIARY_ROUTINES}
				is_destroyed
		end

	EV_GTK_DEPENDENT_APPLICATION_IMP

	EV_GTK_EVENT_STRINGS

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Set up the callback marshal and initialize GTK+.
		local
			locale_str: STRING
		do
			base_make (an_interface)

--			if {EV_GTK_DEPENDENT_EXTERNALS}.g_mem_is_system_malloc then
--				{EV_GTK_DEPENDENT_EXTERNALS}.g_mem_set_vtable ({EV_GTK_EXTERNALS}.glib_mem_profiler_table)
--			end

--			put ("localhost:0", "DISPLAY")
				-- This line may be uncommented to allow for display redirection to another machine for debugging purposes

			create locale_str.make_from_c ({EV_GTK_EXTERNALS}.gtk_set_locale)

			gtk_is_launchable := gtk_init_check
			if
				gtk_is_launchable
			then
				initialize_threading
					-- Store the value of the debug mode.
				saved_debug_mode := debug_mode
				enable_ev_gtk_log (0)
					-- 0 = No messages, 1 = Gtk Log Messages, 2 = Gtk Log Messages with Eiffel exception.
				{EV_GTK_EXTERNALS}.gdk_set_show_events (False)

				{EV_GTK_EXTERNALS}.gtk_widget_set_default_colormap ({EV_GTK_EXTERNALS}.gdk_rgb_get_cmap)

				gtk_dependent_initialize
				create window_oids.make

				tooltips := {EV_GTK_EXTERNALS}.gtk_tooltips_new
				{EV_GTK_EXTERNALS}.object_ref (tooltips)
				{EV_GTK_EXTERNALS}.gtk_object_sink (tooltips)
				set_tooltip_delay (500)

				stored_display_data := [default_pointer, 0, 0, 0, 0, 0]
					-- Initialize display retrieval storage for use by motion actions.

					-- Initialize the marshal object.
				create gtk_marshal

					-- Initialize the dependent routines object
				create gtk_dependent_routines
					-- Uncomment for Gtk 2.x only
				--feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_set_debug_updates (True)

					-- We do not want X Errors to exit the system so we ignore them indefinitely.
				{EV_GTK_EXTERNALS}.gdk_error_trap_push
			else
				-- We are unable to launch the gtk toolkit, probably due to a DISPLAY issue.
				print ("EiffelVision application could not launch, check DISPLAY environment variable%N")
				die (0)
			end
		end

feature {NONE} -- Event loop

	 launch is
			-- Display the first window, set up the post_launch_actions,
			-- and start the event loop.
		do
			if gtk_is_launchable then
				from
					gtk_dependent_launch_initialize
					call_post_launch_actions
				until
					is_destroyed
				loop
					event_loop_iteration (True)
				end
					-- Unhook marshal object.
				gtk_marshal.destroy
			end
			--{EV_GTK_EXTERNALS}.g_mem_profile
		end

feature {EV_ANY_IMP} -- Implementation

	event_loop_iteration (a_relinquish_cpu: BOOLEAN) is
			-- Run a single iteration of the event loop.
			-- CPU will be relinquished if `a_relinquish_cpu'.
		local
			retried: BOOLEAN
		do
			if not retried then
				process_gdk_events
				if {EV_GTK_EXTERNALS}.events_pending then
						-- This handles remaining idle handling such as timeouts, internal gtk/gdk idles and expose events.
						{EV_GTK_EXTERNALS}.dispatch_events
				else
					if a_relinquish_cpu then
							-- Idle actions only need to be called just before CPU relinquishment.
						call_idle_actions
						relinquish_cpu_slice
					end
				end
			else
				on_exception_action (new_exception)
			end
		rescue
			retried := True
			retry
		end

	gtk_marshal: EV_GTK_CALLBACK_MARSHAL
		-- Marshal object for all gtk signal emission event handling.

	gtk_dependent_routines: EV_GTK_DEPENDENT_ROUTINES
		-- Object used for exporting gtk version dependent routines to independent implementation.

feature {EV_ANY_I} -- Implementation

	symbol_from_symbol_name (a_symbol_name: STRING): POINTER
			-- Return Symbol for symbol name `a_symbol_text'.
		local
			l_module: POINTER
			l_symbol_name: EV_GTK_C_STRING
			l_success: BOOLEAN
			l_result: POINTER
		do
			l_module := main_module
			if l_module /= default_pointer then
				l_symbol_name := a_symbol_name
				l_success := {EV_GTK_EXTERNALS}.g_module_symbol (l_module, l_symbol_name.item, $l_result)
				if l_success then
					Result := l_result
				end
			end
		end

feature {NONE} -- Implementation

	main_module: POINTER is
			-- Module representing `Current' application instance.
		do
			if {EV_GTK_EXTERNALS}.gtk_min_ver >= 6 and then {EV_GTK_EXTERNALS}.g_module_supported then
				Result := {EV_GTK_EXTERNALS}.g_module_open (default_pointer, 0)
			end
		end

feature -- Access

	ctrl_pressed: BOOLEAN is
			-- Is ctrl key currently pressed?
		do
			Result := keyboard_modifier_mask & {EV_GTK_EXTERNALS}.gdk_control_mask_enum = {EV_GTK_EXTERNALS}.gdk_control_mask_enum
		end

	alt_pressed: BOOLEAN is
			-- Is alt key currently pressed?
		do
			Result := keyboard_modifier_mask & {EV_GTK_EXTERNALS}.gdk_mod1_mask_enum = {EV_GTK_EXTERNALS}.gdk_mod1_mask_enum
		end

	shift_pressed: BOOLEAN is
			-- Is shift key currently pressed?
		do
			Result := keyboard_modifier_mask & {EV_GTK_EXTERNALS}.gdk_shift_mask_enum = {EV_GTK_EXTERNALS}.gdk_shift_mask_enum
		end

	window_oids: LINKED_LIST [INTEGER]
			-- Global list of window object ids.

	windows: LINEAR [EV_WINDOW] is
			-- Global list of windows.
		local
			cur: CURSOR
			w: EV_WINDOW_IMP
			id: IDENTIFIED
			l: LINKED_LIST [EV_WINDOW]
		do
			create id
			create l.make
			Result := l
			from
				cur := window_oids.cursor
				window_oids.start
			until
				window_oids.after
			loop
				w ?= id.id_object (window_oids.item)
				if w = Void or else w.is_destroyed then
					window_oids.prune_all (window_oids.item)
				else
					l.extend (w.interface)
					window_oids.forth
				end
			end
			window_oids.go_to (cur)
		end

feature -- Basic operation

	process_events_until_stopped is
			-- Process all events until one event is received
			-- by `widget'.
		do
			from
				stop_processing_requested := False
			until
				stop_processing_requested or else is_destroyed
			loop
				event_loop_iteration (True)
			end
		end

	process_events is
			-- Process all pending events and redraws.
		do
			event_loop_iteration (False)
		end

	process_graphical_events is
			-- Process all pending graphical events and redraws.
		do
			{EV_GTK_EXTERNALS}.gdk_window_process_all_updates
		end

	stop_processing is
			-- Exit `process_events_until_stopped'.
		do
				-- Set flag for 'process_events_until_stopped' to exit.
			stop_processing_requested := True
		end

	motion_tuple: TUPLE [x: INTEGER; y: INTEGER; x_tilt: DOUBLE; y_tilt: DOUBLE; pressure: DOUBLE; screen_x: INTEGER; screen_y: INTEGER; originating_x: INTEGER; originating_y: INTEGER] is
			-- Tuple optimizations
		once
			Result := [0, 0, 0.0, 0.0, 0.0, 0, 0, 0, 0]
		end

	process_key_event (a_gdk_event: POINTER) is
			-- Process key event `a_gdk_event'.
		require
			a_gdk_event_not_null: a_gdk_event /= default_pointer
		local
			l_stored_display_data: like stored_display_data
		do
			use_stored_display_data_for_keys := True
				-- Update the stored display data to avoid round trips for display key access.
			l_stored_display_data := stored_display_data
			l_stored_display_data.put_integer ({EV_GTK_EXTERNALS}.gdk_event_key_struct_state (a_gdk_event), 4)

			{EV_GTK_EXTERNALS}.gtk_main_do_event (a_gdk_event)

			use_stored_display_data_for_keys := False
		end

	process_button_event (a_gdk_event: POINTER) is
			-- Process button event `a_gdk_event'.
		require
			a_gdkevent_not_null: a_gdk_event /= default_pointer
		local
			l_pnd_item: EV_PICK_AND_DROPABLE_IMP
			l_gdk_window: POINTER
			l_stored_display_data: like stored_display_data
			l_any_imp: EV_ANY_IMP
			l_top_level_window_imp: EV_WINDOW_IMP
			l_popup_parent: EV_POPUP_WINDOW_IMP
			l_ignore_event: BOOLEAN
			l_grab_widget: POINTER
		do
			use_stored_display_data := True
			l_stored_display_data := stored_display_data
			l_stored_display_data.put_pointer ({EV_GTK_EXTERNALS}.gdk_event_button_struct_window (a_gdk_event), 1)
			l_stored_display_data.put_integer ({EV_GTK_EXTERNALS}.gdk_event_button_struct_x_root (a_gdk_event).truncated_to_integer, 2)
			l_stored_display_data.put_integer ({EV_GTK_EXTERNALS}.gdk_event_button_struct_y_root (a_gdk_event).truncated_to_integer, 3)
			l_stored_display_data.put_integer ({EV_GTK_EXTERNALS}.gdk_event_button_struct_state (a_gdk_event), 4)

			if captured_widget /= Void then
				l_pnd_item ?= captured_widget.implementation
			else
				l_gdk_window := l_stored_display_data.window
				if l_gdk_window /= default_pointer then
					l_pnd_item ?= gtk_widget_from_gdk_window (l_gdk_window)
				end
				l_grab_widget := {EV_GTK_EXTERNALS}.gtk_grab_get_current
				if l_grab_widget /= default_pointer then
						-- This may be a popup window with keyboard and mouse grab.
					l_any_imp ?= eif_object_from_gtk_object (l_grab_widget)
					if l_any_imp /= Void then
						l_popup_parent ?= l_any_imp
						if l_popup_parent /= Void and then l_pnd_item /= Void and then l_pnd_item.top_level_window_imp /= l_popup_parent then
							l_pnd_item := l_popup_parent
						end
					else
							-- A widget has the grab that is not under our control so we do not propagate button events.
						l_pnd_item := Void
					end
				end
			end

				-- This is used to prevent context menus in gtk widget such as GtkTextEntry from appearing in EV_POPUP_WINDOWS.
			if l_pnd_item /= Void then
				l_top_level_window_imp ?= l_pnd_item.top_level_window_imp
				l_popup_parent ?= l_top_level_window_imp

					-- We do not want to propagate if right clicking in a popup parent (for activation focus handling) unless PND is activated.
					-- or if the widget is insensitive or the top level window has a modal child.
				l_ignore_event :=
					l_popup_parent /= Void and then {EV_GTK_EXTERNALS}.gdk_event_button_struct_button (a_gdk_event) = 3 and then (l_pnd_item.pebble = Void and l_pnd_item.pebble_function = Void) or else
					not ({EV_GTK_EXTERNALS}.gtk_object_struct_flags (l_pnd_item.c_object) & {EV_GTK_EXTERNALS}.GTK_SENSITIVE_ENUM = {EV_GTK_EXTERNALS}.GTK_SENSITIVE_ENUM) or else
					l_top_level_window_imp /= Void and then l_top_level_window_imp.has_modal_window
			end

			if not l_ignore_event then
					-- Fire the gtk event first.
				{EV_GTK_EXTERNALS}.gtk_main_do_event (a_gdk_event)
				if l_pnd_item /= Void then
					l_pnd_item.on_mouse_button_event (
						{EV_GTK_EXTERNALS}.gdk_event_button_struct_type (a_gdk_event),
						{EV_GTK_EXTERNALS}.gdk_event_button_struct_x (a_gdk_event).truncated_to_integer,
						{EV_GTK_EXTERNALS}.gdk_event_button_struct_y (a_gdk_event).truncated_to_integer,
						{EV_GTK_EXTERNALS}.gdk_event_button_struct_button (a_gdk_event),
						0.5,
						0.5,
						0.5,
						{EV_GTK_EXTERNALS}.gdk_event_button_struct_x_root (a_gdk_event).truncated_to_integer,
						{EV_GTK_EXTERNALS}.gdk_event_button_struct_y_root (a_gdk_event).truncated_to_integer
					)
				end
			end

			use_stored_display_data := False
		end

	process_gdk_events is
			-- Process all current GDK events
		local
			gdk_event: POINTER
			event_widget, grab_widget: POINTER
			l_call_event, l_propagate_event, l_event_handled: BOOLEAN
			l_pnd_imp: EV_PICK_AND_DROPABLE_IMP
			l_widget_imp: EV_WIDGET_IMP
			l_top_level_window_imp: EV_WINDOW_IMP
			l_gtk_widget_imp: EV_GTK_WIDGET_IMP
			l_motion_tuple: TUPLE [INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]
			l_no_more_events: BOOLEAN
			i, l_widget_x, l_widget_y, l_screen_x, l_screen_y: INTEGER
		do
			from
				l_motion_tuple := motion_tuple
			until
				l_no_more_events
			loop
				gdk_event := {EV_GTK_EXTERNALS}.gdk_event_get
				if gdk_event /= default_pointer then
					event_widget := {EV_GTK_EXTERNALS}.gtk_get_event_widget (gdk_event)
					if event_widget /= default_pointer then
						l_call_event := True
						l_propagate_event := False
						grab_widget := {EV_GTK_EXTERNALS}.gtk_grab_get_current
						if grab_widget = default_pointer then
							grab_widget := event_widget
						end
						inspect
							{EV_GTK_EXTERNALS}.gdk_event_any_struct_type (gdk_event)
						when GDK_MOTION_NOTIFY then
							debug ("GDK_EVENT")
								print ("GDK_MOTION_NOTIFY")
							end
								-- Set up storage to avoid server roundtrips.
							use_stored_display_data := True
							l_screen_x := {EV_GTK_EXTERNALS}.gdk_event_motion_struct_x_root (gdk_event).truncated_to_integer
							l_screen_y := {EV_GTK_EXTERNALS}.gdk_event_motion_struct_y_root (gdk_event).truncated_to_integer
							l_widget_x := {EV_GTK_EXTERNALS}.gdk_event_motion_struct_x (gdk_event).truncated_to_integer
							l_widget_y := {EV_GTK_EXTERNALS}.gdk_event_motion_struct_Y (gdk_event).truncated_to_integer
							stored_display_data.put_pointer ({EV_GTK_EXTERNALS}.gdk_event_motion_struct_window (gdk_event), 1)
							stored_display_data.put_integer (l_screen_x, 2)
							stored_display_data.put_integer (l_screen_y, 3)
							stored_display_data.put_integer ({EV_GTK_EXTERNALS}.gdk_event_motion_struct_state (gdk_event), 4)
							stored_display_data.put_integer (l_widget_x, 5)
							stored_display_data.put_integer (l_widget_y, 6)

							l_call_event := False

							if
								captured_widget /= Void
							then
								l_pnd_imp ?= captured_widget.implementation
							else
								l_pnd_imp ?= gtk_widget_from_gdk_window (stored_display_data.window)
							end

							if l_pnd_imp /= Void then
								l_top_level_window_imp := l_pnd_imp.top_level_window_imp
								if l_top_level_window_imp = Void or else not l_top_level_window_imp.has_modal_window then
									{EV_GTK_EXTERNALS}.gtk_main_do_event (gdk_event)
								end
								if pointer_motion_actions_internal /= Void then
									l_widget_imp ?= l_pnd_imp
									if l_widget_imp /= Void then
											pointer_motion_actions_internal.call (
											[
												l_widget_imp.interface,
												l_screen_x,
												l_screen_y
											]
										)
									end
								end
								if {EV_GTK_EXTERNALS}.gtk_object_struct_flags (l_pnd_imp.c_object) & {EV_GTK_EXTERNALS}.GTK_SENSITIVE_ENUM = {EV_GTK_EXTERNALS}.GTK_SENSITIVE_ENUM then
									if {EV_GTK_EXTERNALS}.gtk_widget_struct_window (l_pnd_imp.visual_widget) /= {EV_GTK_EXTERNALS}.gdk_event_motion_struct_window (gdk_event) then
											-- If the event we received is not from the associating widget window then we remap its correct x and y values.
										i := {EV_GTK_EXTERNALS}.gdk_window_get_origin ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (l_pnd_imp.visual_widget), $l_widget_x, $l_widget_y)
										l_widget_x := l_screen_x - l_widget_x
										l_widget_y := l_screen_y - l_widget_y
									end
									l_motion_tuple.put_integer (l_widget_x, 1)
									l_motion_tuple.put_integer (l_widget_y, 2)
									l_motion_tuple.put_double (0.5, 3)
									l_motion_tuple.put_double (0.5, 4)
									l_motion_tuple.put_double (0.5, 5)
									l_motion_tuple.put_integer (l_screen_x, 6)
									l_motion_tuple.put_integer (l_screen_y, 7)
									l_pnd_imp.on_pointer_motion (l_motion_tuple)
								end
							end
							l_widget_imp := Void
							l_pnd_imp := Void
								-- Reset display data.
							use_stored_display_data := False
							update_display_data
						when GDK_BUTTON_PRESS then
							debug ("GDK_EVENT")
								print ("GDK_BUTTON_PRESS%N")
							end
							l_call_event := False
							process_button_event (gdk_event)
						when GDK_2BUTTON_PRESS then
							debug ("GDK_EVENT")
								print ("GDK_2BUTTON_PRESS%N")
							end
							l_call_event := False
							process_button_event (gdk_event)
						when GDK_3BUTTON_PRESS then
							debug ("GDK_EVENT")
								print ("GDK_3BUTTON_PRESS%N")
							end
							l_call_event := False
							process_button_event (gdk_event)
						when GDK_BUTTON_RELEASE then
							debug ("GDK_EVENT")
								print ("GDK_BUTTON_RELEASE%N")
							end
							l_call_event := False
							process_button_event (gdk_event)
						when GDK_SCROLL then
							debug ("GDK_EVENT")
								print ("GDK_SCROLL%N")
							end
							l_propagate_event := True
						when GDK_PROXIMITY_IN then
							debug ("GDK_EVENT")
								print ("GDK_PROXIMITY_IN%N")
							end
--							l_propagate_event := True
						when GDK_PROXIMITY_OUT then
							debug ("GDK_EVENT")
								print ("GDK_PROXIMITY_OUT%N")
							end
--							l_propagate_event := True
						when GDK_PROPERTY_NOTIFY then
							debug ("GDK_EVENT")
								print ("GDK_PROPERTY_NOTIFY%N")
							end
							l_propagate_event := True
						when GDK_EXPOSE then
								-- This is only called on gtk 1.2 as expose compression is
								-- performed in gdk with 2.x and above.
							debug ("GDK_EVENT")
								print ("GDK_EXPOSE%N")
							end
						when GDK_NO_EXPOSE then
							debug ("GDK_EVENT")
								print ("GDK_NO_EXPOSE%N")
							end
						when GDK_FOCUS_CHANGE then
							debug ("GDK_EVENT")
								print ("GDK_FOCUS_CHANGE%N")
							end
						when GDK_CONFIGURE then
							debug ("GDK_EVENT")
								print ("GDK_CONFIGURE%N")
							end
						when GDK_MAP then
							debug ("GDK_EVENT")
								print ("GDK_MAP%N")
							end
						when GDK_UNMAP then
							debug ("GDK_EVENT")
								print ("GDK_UNMAP%N")
							end
						when GDK_SELECTION_CLEAR then
							debug ("GDK_EVENT")
								print ("GDK_SELECTION_CLEAR%N")
							end
						when GDK_SELECTION_REQUEST then
							debug ("GDK_EVENT")
								print ("GDK_SELECTION_REQUEST%N")
							end
						when GDK_SELECTION_NOTIFY then
							debug ("GDK_EVENT")
								print ("GDK_SELECTION_NOTIFY%N")
							end
						when GDK_CLIENT_EVENT then
							debug ("GDK_EVENT")
								print ("GDK_CLIENT_EVENT%N")
							end
						when GDK_VISIBILITY_NOTIFY then
							debug ("GDK_EVENT")
								print ("GDK_VISIBILITY_NOTIFY%N")
							end
						when GDK_WINDOW_STATE then
							debug ("GDK_EVENT")
								print ("GDK_WINDOW_STATE%N")
							end
						when GDK_ENTER_NOTIFY then
							debug ("GDK_EVENT")
								print ("GDK_ENTER_NOTIFY%N")
							end
							l_call_event := False
							l_gtk_widget_imp ?= eif_object_from_gtk_object (event_widget)
							if l_gtk_widget_imp /= Void then
								l_top_level_window_imp := l_gtk_widget_imp.top_level_window_imp
								if l_top_level_window_imp = Void or else not l_top_level_window_imp.has_modal_window then
									{EV_GTK_EXTERNALS}.gtk_main_do_event (gdk_event)
								end
								l_gtk_widget_imp := Void
								l_top_level_window_imp := Void
							end
						when GDK_LEAVE_NOTIFY then
							debug ("GDK_EVENT")
								print ("GDK_LEAVE_NOTIFY%N")
							end
							l_call_event := False
							l_gtk_widget_imp ?= eif_object_from_gtk_object (event_widget)
							if l_gtk_widget_imp /= Void then
								l_top_level_window_imp := l_gtk_widget_imp.top_level_window_imp
								if l_top_level_window_imp = Void or else not l_top_level_window_imp.has_modal_window then
									{EV_GTK_EXTERNALS}.gtk_main_do_event (gdk_event)
								end
								l_gtk_widget_imp := Void
								l_top_level_window_imp := Void
							end
						when GDK_KEY_PRESS then
							debug ("GDK_EVENT")
								print ("GDK_KEY_PRESS%N")
							end
							l_call_event := False
							l_gtk_widget_imp ?= eif_object_from_gtk_object (event_widget)
							if l_gtk_widget_imp /= Void then
								l_top_level_window_imp := l_gtk_widget_imp.top_level_window_imp
								if l_top_level_window_imp = Void or else not l_top_level_window_imp.has_modal_window then
									process_key_event (gdk_event)
								end
								l_gtk_widget_imp := Void
								l_top_level_window_imp := Void
							end
						when GDK_KEY_RELEASE then
							debug ("GDK_EVENT")
								print ("GDK_KEY_RELEASE%N")
							end
							l_call_event := False
							l_gtk_widget_imp ?= eif_object_from_gtk_object (event_widget)
							if l_gtk_widget_imp /= Void then
								l_top_level_window_imp := l_gtk_widget_imp.top_level_window_imp
								if l_top_level_window_imp = Void or else not l_top_level_window_imp.has_modal_window then
									process_key_event (gdk_event)
								end
								l_gtk_widget_imp := Void
								l_top_level_window_imp := Void
							end
						when GDK_DELETE then
							debug ("GDK_EVENT")
								print ("GDK_DELETE%N")
							end
						when GDK_DESTROY then
							debug ("GDK_EVENT")
								print ("GDK_DESTROY%N")
							end
						when GDK_DRAG_ENTER then
							debug ("GDK_EVENT")
								print ("GDK_DRAG_ENTER")
							end
						when GDK_DRAG_LEAVE then
							debug ("GDK_EVENT")
								print ("GDK_DRAG_LEAVE")
							end
						when GDK_DRAG_MOTION then
							debug ("GDK_EVENT")
								print ("GDK_DRAG_MOTION")
							end
						when GDK_DRAG_STATUS then
							debug ("GDK_EVENT")
								print ("GDK_DRAG_STATUS")
							end
						when GDK_DROP_START then
							debug ("GDK_EVENT")
								print ("GDK_DROP_START")
							end
								-- Some text has been drag dropped on a widget.
							handle_dnd (gdk_event)
						when GDK_DROP_FINISHED then
							debug ("GDK_EVENT")
								print ("GDK_DROP_FINISHED")
							end
						when GDK_SETTING then
							debug ("GDK_SETTING")
								print ("GDK_SETTING")
						 	end
							l_call_event := False
							{EV_GTK_EXTERNALS}.gtk_main_do_event (gdk_event)
						else
							l_call_event := False
						end
						if l_call_event then
							if l_propagate_event then
								{EV_GTK_EXTERNALS}.gtk_propagate_event (grab_widget, gdk_event)
							else
								l_event_handled := {EV_GTK_EXTERNALS}.gtk_widget_event (event_widget, gdk_event)
							end
						end
					else
							--| Handle events not associated with a gtk widget.
						{EV_GTK_EXTERNALS}.gtk_main_do_event (gdk_event)
					end
					{EV_GTK_EXTERNALS}.gdk_event_free (gdk_event)
				else
					l_no_more_events := True
				end
			end
		end

	handle_dnd (a_event: POINTER) is
			-- Handle drag and drop event.
		local
			a_context: POINTER
			a_target_list: POINTER
			a_target: POINTER
			src_window, dest_window, a_selection, gtkwid: POINTER
			a_time: NATURAL_32
			prop_data: POINTER
			prop_type, prop_format, prop_length: INTEGER
			a_string: STRING_32
			l_file_list: LIST [STRING_32]
			l_success: BOOLEAN
			l_widget_imp: EV_WIDGET_IMP
			l_string, l_file: STRING_32
		do
			from
				a_context := {EV_GTK_EXTERNALS}.gdk_event_dnd_struct_context (a_event)
				src_window := {EV_GTK_EXTERNALS}.gdk_drag_context_struct_source_window (a_context)
				a_selection := {EV_GTK_EXTERNALS}.gdk_drag_get_selection (a_context)
				a_time := {EV_GTK_EXTERNALS}.gdk_event_dnd_struct_time (a_event)
				a_target_list := {EV_GTK_EXTERNALS}.gdk_drag_context_struct_targets (a_context)
				l_string := "STRING"
				l_file := "file://"
			until
				a_target_list = default_pointer
			loop
				a_target := {EV_GTK_EXTERNALS}.glist_struct_data (a_target_list)
				if a_target /= default_pointer then
						-- This is a target atom indicating the type of the drop.
					{EV_GTK_EXTERNALS}.gdk_selection_convert (src_window, a_selection, a_target, a_time)
					prop_length := {EV_GTK_EXTERNALS}.gdk_selection_property_get (src_window, $prop_data, $prop_type, $prop_format)
					if prop_data /= default_pointer then
						create a_string.make_from_c ({EV_GTK_EXTERNALS}.gdk_atom_name (a_target))
						if a_string.is_equal (l_string) then
							create a_string.make_from_c (prop_data)
							l_file_list := a_string.split ('%N')
							from
								l_file_list.start
							until
								l_file_list.after
							loop
								if l_file_list.item.substring_index (l_file, 1) = 1 then
									l_file_list.replace (l_file_list.item.substring (8, l_file_list.item.count))
									l_success := True
									l_file_list.forth
								else
									l_file_list.remove
								end
							end
						end
					end
				end
				a_target_list := {EV_GTK_EXTERNALS}.glist_struct_next (a_target_list)
			end
			if l_success then
				dest_window := {EV_GTK_EXTERNALS}.gdk_drag_context_struct_dest_window (a_context)
				if dest_window /= default_pointer then
					{EV_GTK_EXTERNALS}.gdk_window_get_user_data (dest_window, $gtkwid)
					if gtkwid /= default_pointer then
						l_widget_imp ?= eif_object_from_gtk_object (gtkwid)
						if
							l_widget_imp /= Void and then
							not l_widget_imp.is_destroyed and then
							l_widget_imp.file_drop_actions_internal /= Void
						then
							l_widget_imp.file_drop_actions.call ([l_file_list])
						end
					end
				end
			end
			{EV_GTK_EXTERNALS}.gdk_drop_finish (a_context, l_success, a_time)
		end


	GDK_NOTHING: INTEGER is -1
	GDK_DELETE: INTEGER is 0
	GDK_DESTROY: INTEGER is 1
	GDK_EXPOSE: INTEGER is 2
	GDK_MOTION_NOTIFY: INTEGER is 3
	GDK_BUTTON_PRESS: INTEGER is 4
	GDK_2BUTTON_PRESS : INTEGER is 5
	GDK_3BUTTON_PRESS: INTEGER is 6
	GDK_BUTTON_RELEASE: INTEGER is 7
	GDK_KEY_PRESS: INTEGER is 8
	GDK_KEY_RELEASE: INTEGER is 9
	GDK_ENTER_NOTIFY: INTEGER is 10
	GDK_LEAVE_NOTIFY: INTEGER is 11
	GDK_FOCUS_CHANGE: INTEGER is 12
	GDK_CONFIGURE: INTEGER is 13
	GDK_MAP: INTEGER is 14
	GDK_UNMAP: INTEGER is 15
	GDK_PROPERTY_NOTIFY: INTEGER is 16
	GDK_SELECTION_CLEAR: INTEGER is 17
	GDK_SELECTION_REQUEST: INTEGER is 18
	GDK_SELECTION_NOTIFY: INTEGER is 19
	GDK_PROXIMITY_IN: INTEGER is 20
	GDK_PROXIMITY_OUT: INTEGER is 21
	GDK_DRAG_ENTER: INTEGER is 22
	GDK_DRAG_LEAVE: INTEGER is 23
	GDK_DRAG_MOTION: INTEGER is 24
	GDK_DRAG_STATUS: INTEGER is 25
	GDK_DROP_START: INTEGER is 26
	GDK_DROP_FINISHED : INTEGER is 27
	GDK_CLIENT_EVENT: INTEGER is 28
	GDK_VISIBILITY_NOTIFY: INTEGER is 29
	GDK_NO_EXPOSE: INTEGER is 30
	GDK_SCROLL: INTEGER is 31
	GDK_WINDOW_STATE: INTEGER is 32
	GDK_SETTING: INTEGER is 33
	GDK_OWNER_CHANGE: INTEGER is 34
		-- GDK Event Type Constants

	sleep (msec: INTEGER) is
			-- Wait for `msec' milliseconds and return.
		do
			usleep (msec * 1000)
		end

	destroy is
			-- End the application.
		do
			{EV_GTK_EXTERNALS}.object_unref (tooltips)
			set_is_destroyed (True)
				-- This will exit our main loop
		end

feature -- Status report

	tooltip_delay: INTEGER
			-- Time in milliseconds before tooltips pop up.

feature -- Status setting

	set_tooltip_delay (a_delay: INTEGER) is
			-- Set `tooltip_delay' to `a_delay'.
		do
			tooltip_delay := a_delay
			if gtk_is_launchable then
				{EV_GTK_EXTERNALS}.gtk_tooltips_set_delay (tooltips, a_delay)
			end
		end

feature {EV_PICK_AND_DROPABLE_IMP} -- Pick and drop

	set_docking_source (a_source: EV_DOCKABLE_SOURCE_IMP) is
			-- Set `docking_source' to `a_source'.
		do
			internal_docking_source := a_source
		end

	on_pick (a_source: EV_PICK_AND_DROPABLE_IMP; a_pebble: ANY) is
			-- Called by EV_PICK_AND_DROPABLE_IMP.start_transport
		do
			internal_pick_and_drop_source := a_source
			interface.pick_actions.call ([a_pebble])
		end

	on_drop (a_pebble: ANY) is
			-- Called by EV_PICK_AND_DROPABLE_IMP.end_transport
		do
			internal_pick_and_drop_source := Void
		end

feature {EV_ANY_IMP} -- Implementation

	tooltips: POINTER
			-- Reference to GtkTooltips object.

feature -- Implementation

	is_in_transport: BOOLEAN is
			-- Is application currently in transport (either PND or docking)?
		do
			Result := pick_and_drop_source /= Void or else docking_source /= Void
		end

	pick_and_drop_source: EV_PICK_AND_DROPABLE_IMP
			-- Source of pick and drop if any.
		do
			Result := internal_pick_and_drop_source
		end

	docking_source: EV_DOCKABLE_SOURCE_IMP
			-- Source of docking if any.
		assign
			set_docking_source
		do
			Result := internal_docking_source
		end

	internal_pick_and_drop_source: like pick_and_drop_source
	internal_docking_source: like docking_source

	keyboard_modifier_mask: INTEGER is
			-- Mask representing current keyboard modifiers state.
		local
			l_display_data: like retrieve_display_data
		do
			if use_stored_display_data_for_keys then
					-- If we are inside a key event then we can directly query the key data.
				l_display_data := stored_display_data
			else
				l_display_data := retrieve_display_data
			end
			Result := l_display_data.mask
		end

	retrieve_display_data: TUPLE [window: POINTER; x, y: INTEGER; mask: INTEGER; originating_x, originating_y: INTEGER] is
			-- Retrieve mouse and keyboard data from the display.
		do
			if not use_stored_display_data then
					-- Update values with those from the X Server.
				update_display_data
			end
			Result := stored_display_data
		end

	update_display_data is
			-- Update stored values with current values.
		local
			temp_mask, temp_x, temp_y: INTEGER
			temp_ptr: POINTER
			l_stored_display_data: like stored_display_data
		do
			temp_ptr := {EV_GTK_EXTERNALS}.gdk_window_get_pointer (default_pointer, $temp_x, $temp_y, $temp_mask)
			l_stored_display_data := stored_display_data
			l_stored_display_data.put_pointer (temp_ptr, 1)
			l_stored_display_data.put_integer (temp_x, 2)
			l_stored_display_data.put_integer (temp_y, 3)
			l_stored_display_data.put_integer (temp_mask, 4)
			l_stored_display_data.put_integer (temp_x, 5)
			l_stored_display_data.put_integer (temp_y, 6)
		end

	use_stored_display_data: BOOLEAN
		-- Should prestored display data values be used when querying for display data.

	use_stored_display_data_for_keys: BOOLEAN
		-- Should prestored display data values be used when querying for key display data.

	stored_display_data: like retrieve_display_data
		-- Store for the previous call to 'retrieve_display_data'
		-- This is needed to avoid unnecessary roundtrips.

	enable_debugger is
			-- Enable the Eiffel debugger.
		do
			internal_set_debug_mode (saved_debug_mode)
		end

	disable_debugger is
			-- Disable the Eiffel debugger.
		do
			saved_debug_mode := debug_mode
			internal_set_debug_mode (0)
		end

feature {EV_ANY_I, EV_FONT_IMP, EV_STOCK_PIXMAPS_IMP, EV_INTERMEDIARY_ROUTINES} -- Implementation

	eif_object_from_gtk_object (a_gtk_object: POINTER): EV_ANY_IMP is
			-- Return the EV_ANY_IMP object from `a_gtk_object' if any.
		local
			gtkwid, l_null: POINTER
		do
			from
				gtkwid := a_gtk_object
			until
				Result /= Void or else gtkwid = l_null
			loop
				Result := {EV_ANY_IMP}.eif_object_from_c (gtkwid)
				gtkwid := {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (gtkwid)
			end
			if Result /= Void and then Result.interface.is_destroyed then
				Result := Void
			end
		end

	gtk_widget_imp_at_pointer_position: EV_GTK_WIDGET_IMP is
			-- Gtk Widget implementation at current mouse pointer position (if any)
		local
			a_x, a_y: INTEGER
			gdkwin, l_null: POINTER
		do
			gdkwin := {EV_GTK_EXTERNALS}.gdk_window_at_pointer ($a_x, $a_y)
			if gdkwin /= l_null then
				Result := gtk_widget_from_gdk_window (gdkwin)
			end
		end

	gtk_widget_from_gdk_window (a_gdk_window: POINTER): EV_GTK_WIDGET_IMP is
			-- Gtk Widget implementation from GdkWindow.
		local
			gtkwid, l_null: POINTER
		do
			{EV_GTK_EXTERNALS}.gdk_window_get_user_data (a_gdk_window, $gtkwid)
			if gtkwid /= l_null then
				Result ?= eif_object_from_gtk_object (gtkwid)
			end
		end

	gtk_is_launchable: BOOLEAN
		-- Is Gtk launchable?

	default_gtk_window: POINTER is
			-- Pointer to a default GtkWindow.
		once
			Result := default_window_imp.c_object
			window_oids.prune_all (Default_window_imp.object_id)
			default_window_imp.real_signal_connect (default_window_imp.c_object, "style-set", agent gtk_style_has_changed, Void)
		end

	gtk_style_has_changed is
			-- The current gtk style has changed.
		do
			-- This is called when the user externally changes the gtk style.
		end

	default_gdk_window: POINTER is
			-- Pointer to a default GdkWindow that may be used to
			-- access default visual information (color depth).
		do
			Result := {EV_GTK_EXTERNALS}.gtk_widget_struct_window (default_gtk_window)
		end

	default_window: EV_WINDOW is
			-- Default Window used for creation of agents and holder of clipboard widget.
		once
			create Result
		end

	default_window_imp: EV_WINDOW_IMP is
			-- Default window implementation.
		once
			Result ?= default_window.implementation
		end

	default_font_height: INTEGER is
			-- Default font height.
		local
			temp_style: POINTER
		do
			temp_style := {EV_GTK_EXTERNALS}.gtk_widget_struct_style (default_gtk_window)
			Result := {EV_GTK_EXTERNALS}.gdk_font_struct_ascent ({EV_GTK_EXTERNALS}.gtk_style_get_font (temp_style))
		end

	default_font_ascent: INTEGER is
			-- Default font ascent.
		local
			temp_style: POINTER
		do
			temp_style := {EV_GTK_EXTERNALS}.gtk_widget_struct_style (default_gtk_window)
			Result := {EV_GTK_EXTERNALS}.gdk_font_struct_ascent ({EV_GTK_EXTERNALS}.gtk_style_get_font (temp_style))
		end

	default_font_descent: INTEGER is
			-- Default font descent.
		local
			temp_style: POINTER
		do
			temp_style := {EV_GTK_EXTERNALS}.gtk_widget_struct_style (default_gtk_window)
			Result := {EV_GTK_EXTERNALS}.gdk_font_struct_descent ({EV_GTK_EXTERNALS}.gtk_style_get_font (temp_style))
		end

	default_translate: FUNCTION [ANY, TUPLE [INTEGER, POINTER], TUPLE] is
			-- Default Gdk event marshaller.
		once
			Result := agent gtk_marshal.gdk_event_to_tuple
		end

	fg_color: POINTER is
			-- Default allocated background color.
		local
			a_success: BOOLEAN
		once
			Result := {EV_GTK_EXTERNALS}.c_gdk_color_struct_allocate
			a_success := {EV_GTK_EXTERNALS}.gdk_colormap_alloc_color ({EV_GTK_EXTERNALS}.gdk_rgb_get_cmap, Result, False, True)
		end

	bg_color: POINTER is
			-- Default allocate foreground color.
		local
			a_success: BOOLEAN
		once
			Result := {EV_GTK_EXTERNALS}.c_gdk_color_struct_allocate
			{EV_GTK_EXTERNALS}.set_gdk_color_struct_red (Result, 65535)
			{EV_GTK_EXTERNALS}.set_gdk_color_struct_green (Result, 65535)
			{EV_GTK_EXTERNALS}.set_gdk_color_struct_blue (Result, 65535)
			a_success := {EV_GTK_EXTERNALS}.gdk_colormap_alloc_color ({EV_GTK_EXTERNALS}.gdk_rgb_get_cmap, Result, False, True)
		end

	reusable_color_struct: POINTER is
			-- Persistent GdkColorStruct
		once
			Result := {EV_GTK_EXTERNALS}.c_gdk_color_struct_allocate
		end

	reusable_rectangle_struct: POINTER is
			-- Persistent GdkColorStruct
		once
			Result := {EV_GTK_EXTERNALS}.c_gdk_rectangle_struct_allocate
		end

	c_string_from_eiffel_string (a_string: STRING_GENERAL): EV_GTK_C_STRING is
			-- Return a EV_GTK_C_STRING from`a_string'
			-- `Item' of result must not be freed by gtk.
			-- Result must only be used for temporary setting and should not be persistent.
		require
			a_string_not_void: a_string /= Void
		do
			if a_string.count > default_c_string_size then
					-- Create a new gtk C string to conserve memory.
				Result := a_string
			else
				Result := reusable_gtk_c_string
				Result.set_with_eiffel_string (a_string)
			end
		end

	reusable_gtk_c_string: EV_GTK_C_STRING is
			-- Persistent EV_GTK_C_STRING.
		once
			create Result.set_with_eiffel_string ("")
		end

feature {EV_PICK_AND_DROPABLE_IMP} -- Pnd Handling

	x_origin, y_origin: INTEGER
		-- Temp coordinate values for origin of Pick and Drop.

	set_x_y_origin (a_x_origin, a_y_origin: INTEGER) is
			-- Set `x_origin' and `y_origin' to `a_x_origin' and `a_y_origin' respectively.
		do
			x_origin := a_x_origin
			y_origin := a_y_origin
		end

	old_pointer_x,
	old_pointer_y: INTEGER
		-- Position of pointer on previous PND draw.

	set_old_pointer_x_y_origin (a_old_pointer_x, a_old_pointer_y: INTEGER) is
			-- Set PND pointer origins to `a_old_pointer_x' and `a_old_pointer_y'.
		do
			old_pointer_x := a_old_pointer_x
			old_pointer_y := a_old_pointer_y
		end

feature -- Thread Handling.

	initialize_threading is
			-- Initialize thread support.
		do
			if {PLATFORM}.is_thread_capable then
				if not {EV_GTK_EXTERNALS}.g_thread_supported then
					{EV_GTK_EXTERNALS}.g_thread_init
				end
				check
					threading_supported: {EV_GTK_EXTERNALS}.g_thread_supported
				end
					-- Initialize the recursive mutex.
				static_mutex := {EV_GTK_EXTERNALS}.new_g_static_rec_mutex
				{EV_GTK_EXTERNALS}.g_static_rec_mutex_init (static_mutex)
			end
		end

	lock is
			-- Lock the Mutex.
		do
			if {PLATFORM}.is_thread_capable then
				{EV_GTK_EXTERNALS}.g_static_rec_mutex_lock (static_mutex)
			end
		end

	try_lock: BOOLEAN is
			-- Try to see if we can lock, False means no lock could be attained
		do
			if {PLATFORM}.is_thread_capable then
				Result := {EV_GTK_EXTERNALS}.g_static_rec_mutex_trylock (static_mutex)
			else
					-- If we are not thread capable then always return true.
				Result := True
			end
		end

	unlock is
			-- Unlock the Mutex.
		do
			if {PLATFORM}.is_thread_capable then
				{EV_GTK_EXTERNALS}.g_static_rec_mutex_unlock (static_mutex)
			end
		end

feature {NONE} -- External implementation

	default_c_string_size: INTEGER is 1000
		-- Default size to set the reusable gtk C string.

	internal_set_debug_mode (a_debug_mode: INTEGER) is
			-- Set `debug_mode' to `a_debug_mode'.
		external
			"C inline use %"ev_any_imp.h%""
		alias
			"debug_mode = $a_debug_mode"
		end

	saved_debug_mode: INTEGER
		-- Debug mode before debugger was disabled

	debug_mode: INTEGER is
			-- State of debugger.
		external
			"C inline use %"ev_any_imp.h%""
		alias
			"debug_mode"
		end

	enable_ev_gtk_log (a_mode: INTEGER) is
			-- Connect GTK+ logging to Eiffel exception handler.
			-- `a_mode' = 0 means no log messages, 1 = messages, 2 = messages with exceptions.
		external
			"C (EIF_INTEGER) | %"ev_c_util.h%""
		end

	usleep (micro_seconds: INTEGER) is
		external
			"C | <unistd.h>"
		end

	gtk_init is
		external
			"C [macro <gtk/gtk.h>] | %"eif_argv.h%""
		alias
    		"gtk_init (&eif_argc, &eif_argv)"
		end

	gtk_init_check: BOOLEAN is
		external
			"C [macro <gtk/gtk.h>] | %"eif_argv.h%""
		alias
    		"gtk_init_check (&eif_argc, &eif_argv)"
		end

feature {NONE} -- Externals

	static_mutex: POINTER
		-- Pointer to the global static mutex

invariant
	window_oids_not_void: is_usable implies window_oids /= void
	tooltips_not_void: tooltips /= default_pointer

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




end -- class EV_APPLICATION_IMP

