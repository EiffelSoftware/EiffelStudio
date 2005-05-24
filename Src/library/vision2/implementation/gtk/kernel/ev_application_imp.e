indexing
	description: 
		"EiffelVision application, GTK+ implementation."
	status: "See notice at end of class"
	keywords: "application"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	EV_APPLICATION_IMP
	
inherit
	EV_APPLICATION_I
			export
				{EV_PICK_AND_DROPABLE_IMP} captured_widget
			end
		
	EV_GTK_DEPENDENT_APPLICATION_IMP

create 
	make
	
feature {NONE} -- Initialization

	gtk_is_launchable: BOOLEAN
		-- Is Gtk launchable?
	
	make (an_interface: like interface) is
			-- Set up the callback marshal and initialize GTK+.
		local
			locale_str: STRING
		do
			base_make (an_interface)

			--put ("localhost:0", "DISPLAY")
				-- This line may be uncommented to allow for display redirection to another machine for debugging purposes
			
			create locale_str.make_from_c ({EV_GTK_EXTERNALS}.gtk_set_locale)
			
			gtk_is_launchable := gtk_init_check
			if
				gtk_is_launchable
			then
				gtk_dependent_initialize
				
				enable_ev_gtk_log (0)
					-- 0 = No messages, 1 = Gtk Log Messages, 2 = Gtk Log Messages with Eiffel exception.
				{EV_GTK_EXTERNALS}.gdk_set_show_events (False)
			
				{EV_GTK_EXTERNALS}.gtk_widget_set_default_colormap ({EV_GTK_EXTERNALS}.gdk_rgb_get_cmap)
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_set_default_visual ({EV_GTK_EXTERNALS}.gdk_rgb_get_visual)
	
				tooltips := {EV_GTK_EXTERNALS}.gtk_tooltips_new
				set_tooltip_delay (500)
				create window_oids.make
				
					-- Initialize the marshal object.
				create gtk_marshal
				
					-- Initialize the dependent routines object
				create gtk_dependent_routines
					-- Uncomment for Gtk 2.x only
				--feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_set_debug_updates (True)		
			else
				-- We are unable to launch the gtk toolkit, probably due to a DISPLAY issue.
				print ("EiffelVision application could not launch, check DISPLAY environment variable%N")
				(create {EXCEPTIONS}).die (0)
			end
		end

	launch is
			-- Display the first window, set up the post_launch_actions,
			-- and start the event loop.
		do
			gtk_dependent_launch_initialize
			main_loop			
				-- Unhook marshal object.
			gtk_marshal.destroy				
		end	
		
	main_loop is
			-- Our main loop		
		local
			main_running: BOOLEAN
			gdk_event: POINTER
			post_launch_actions_called: BOOLEAN
			events_pending: INTEGER
		do
			from
			until 
				is_destroyed
			loop
				events_pending := {EV_GTK_EXTERNALS}.gtk_events_pending
				gdk_event := {EV_GTK_EXTERNALS}.gdk_event_get
				if gdk_event /= default_pointer or else events_pending > 0 then
					if gdk_event /= default_pointer then
						--print ("Gdk event type = " + feature {EV_GTK_EXTERNALS}.gdk_event_any_struct_type (gdk_event).out + "%N")
						{EV_GTK_EXTERNALS}.gtk_main_do_event (gdk_event)
						{EV_GTK_EXTERNALS}.gdk_event_free (gdk_event)
					else
						main_running := {EV_GTK_EXTERNALS}.g_main_iteration (False)
					end
				else
						-- There are no more events to handle so we must be in an idle state, therefore call idle actions.
						-- All pending resizing has been performed at this point.
					if not post_launch_actions_called and then events_pending = 0 then
						interface.post_launch_actions.call (Void)
						post_launch_actions_called := True
					end
					if internal_idle_actions.count > 0 or else
						(idle_actions_internal /= Void and idle_actions_internal.count > 0) then
							call_idle_actions
					else
								-- Block loop by running a gmain loop iteration with blocking enabled.
						main_running := {EV_GTK_EXTERNALS}.g_main_iteration (True)
					end
				end				
			end
		end
		
feature {EV_ANY_IMP} -- Access
		
	gtk_marshal: EV_GTK_CALLBACK_MARSHAL
		-- Marshal object for all gtk signal emission event handling.

	gtk_dependent_routines: EV_GTK_DEPENDENT_ROUTINES
		-- Object used for exporting gtk version dependent routines to independent implementation
		
	call_idle_actions is
			-- Execute idle actions
		do
				-- Call the opo idle actions first, when the list is empty we call the normal idle actions
			internal_idle_actions.call (Void)
			if idle_actions_internal /= Void then
				idle_actions_internal.call (Void)
			end
		end

feature -- Access

	ctrl_pressed: BOOLEAN is
			-- Is ctrl key currently pressed?
		do
			Result := (keyboard_modifier_mask.bit_and ({EV_GTK_EXTERNALS}.gdk_control_mask_enum)).to_boolean
		end

	alt_pressed: BOOLEAN is
			-- Is alt key currently pressed?
		do
			Result := (keyboard_modifier_mask.bit_and ({EV_GTK_EXTERNALS}.gdk_mod1_mask_enum)).to_boolean
		end

	shift_pressed: BOOLEAN is
			-- Is shift key currently pressed?
		do
			Result := (keyboard_modifier_mask.bit_and ({EV_GTK_EXTERNALS}.gdk_shift_mask_enum)).to_boolean
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
		
	key_constants: EV_KEY_CONSTANTS is
		once
			create Result	
		end

feature -- Basic operation

	process_events_until_stopped is
			-- Process all events until one event is received 
			-- by `widget'.
		local
			main_not_running: INTEGER
		do
			from
				stop_processing_requested := False
			until 
				stop_processing_requested
			loop
					-- We want blocking enabled to avoid 100% CPU time when there is no events to be processed.
				main_not_running := {EV_GTK_EXTERNALS}.gtk_main_iteration_do (True)
			end
		end
		
	stop_processing is
			-- Exit `process_events_until_stopped'.
		local
			temp_str: EV_GTK_C_STRING
		do
				-- Set flag for 'process_events_until_stopped' to exit.
			stop_processing_requested := True
				-- Send a message to our hidden window to fire up 'process_events_until_stopped' loop.
			temp_str := "hide"
			{EV_GTK_EXTERNALS}.gtk_signal_emit_by_name (default_gtk_window, temp_str.item)
		end

	process_events is
			-- Process any pending events.
			--| Pass control to the GUI toolkit so that it can
			--| handle any events that may be in its queue.
		local
			main_not_running: INTEGER
		do
			from
			until 
				{EV_GTK_EXTERNALS}.gtk_events_pending = 0
			loop
					main_not_running := {EV_GTK_EXTERNALS}.gtk_main_iteration_do (False)
						-- We only want to process the current events so we don't want any blocking.
			end
		end

	sleep (msec: INTEGER) is
			-- Wait for `msec' milliseconds and return.
		do
			usleep (msec * 1000)
		end

	destroy is
			-- End the application.
		do
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

	on_pick (a_pebble: ANY) is
			-- Called by EV_PICK_AND_DROPABLE_IMP.start_transport
		local
			cur: CURSOR
			trg: EV_PICK_AND_DROPABLE
			i: INTEGER
		do
			enable_is_in_transport
			cur := pnd_targets.cursor
			from
				pnd_targets.start
			until
				pnd_targets.after
			loop
				trg ?= id_object (pnd_targets.item)
				if trg = Void or else trg.is_destroyed then
					i := pnd_targets.index
					pnd_targets.remove
					pnd_targets.go_i_th (i)
				else
					pnd_targets.forth
				end
			end
			if pnd_targets.valid_cursor (cur) then
				pnd_targets.go_to (cur)
			end
			interface.pick_actions.call ([a_pebble])
		end
		
	on_drop (a_pebble: ANY) is
			-- Called by EV_PICK_AND_DROPABLE_IMP.end_transport
		do
			disable_is_in_transport
		end

feature {EV_ANY_IMP} -- Implementation

	tooltips: POINTER
			-- Reference to GtkTooltips object.

feature -- Implementation

	is_in_transport: BOOLEAN
		-- Is application currently in transport (either PND or docking)?

	enable_is_in_transport is
			-- Set `is_in_transport' to True.
		require
			not_in_transport: not is_in_transport
		do
			is_in_transport := True
		end
		
	disable_is_in_transport is
			-- Set `is_in_transport' to False.
		require
			in_transport: is_in_transport
		do
			is_in_transport := False
		end

	keyboard_modifier_mask: INTEGER is
			-- Mask representing current keyboard modifiers state.
		local
			temp_mask, temp_x, temp_y: INTEGER
			temp_ptr: POINTER
		do
			temp_ptr := {EV_GTK_EXTERNALS}.gdk_window_get_pointer (default_pointer, $temp_x, $temp_y, $temp_mask)
			Result := temp_mask
		end

	enable_debugger is
			-- Enable the Eiffel debugger
		do
			set_debug_mode (1)
		end

	disable_debugger is
			-- Disable the Eiffel debugger
		do
			set_debug_mode (0)
		end
		
feature {EV_ANY_I, EV_FONT_IMP, EV_STOCK_PIXMAPS_IMP} -- Implementation

	default_gtk_window: POINTER is
			-- Pointer to a default GtkWindow.
		once
			Result := default_window_imp.c_object
			window_oids.prune_all (Default_window_imp.object_id)
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
			--
		once
			Result ?= default_window.implementation
		end
		
	default_font_height: INTEGER is
			--
		local
			temp_style: POINTER
		do
			temp_style := {EV_GTK_EXTERNALS}.gtk_widget_struct_style (default_gtk_window)
			Result := {EV_GTK_EXTERNALS}.gdk_font_struct_ascent ({EV_GTK_EXTERNALS}.gtk_style_get_font (temp_style))
		end
		
	default_font_ascent: INTEGER is
			--
		local
			temp_style: POINTER
		do
			temp_style := {EV_GTK_EXTERNALS}.gtk_widget_struct_style (default_gtk_window)
			Result := {EV_GTK_EXTERNALS}.gdk_font_struct_ascent ({EV_GTK_EXTERNALS}.gtk_style_get_font (temp_style))
		end
		
	default_font_descent: INTEGER is
			--
		local
			temp_style: POINTER
		do
			temp_style := {EV_GTK_EXTERNALS}.gtk_widget_struct_style (default_gtk_window)
			Result := {EV_GTK_EXTERNALS}.gdk_font_struct_descent ({EV_GTK_EXTERNALS}.gtk_style_get_font (temp_style))
		end
		
	default_translate: FUNCTION [ANY, TUPLE [INTEGER, POINTER], TUPLE] is		
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

feature {NONE} -- External implementation

	set_debug_mode (a_mode: INTEGER) is
			-- Set the value of run time value `debug_mode' to turn Eiffel debugger on or off
		require
			valid_mode: a_mode = 0 or a_mode = 1
		external
			"C use %"ev_any_imp.h%""
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

invariant
	window_oids_not_void: is_usable implies window_oids /= void
	tooltips_not_void: tooltips /= default_pointer

end -- class EV_APPLICATION_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

