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

	IDENTIFIED
		undefine
			is_equal,
			copy
		end

	EV_C_UTIL

	EV_APPLICATION_ACTION_SEQUENCES_IMP

	EXECUTION_ENVIRONMENT
		rename
			launch as ee_launch
		end

create 
	make
	
feature {NONE} -- Initialization
	
	make (an_interface: like interface) is
			-- Set up the callback marshal and initialize GTK+.
		local
			locale_str: STRING
		do
			base_make (an_interface)

			--put ("display_ip:0", "DISPLAY")
			-- This line may be uncommented to allow for display redirection to another machine.
			
			create locale_str.make_from_c (feature {EV_GTK_EXTERNALS}.gtk_set_locale)
			
			gtk_init
			feature {EV_GTK_EXTERNALS}.gdk_rgb_init
			
			enable_ev_gtk_log (0)
			-- 0 = No messages, 1 = Gtk Log Messages, 2 = Gtk Log Messages with Eiffel exception.
			feature {EV_GTK_EXTERNALS}.gdk_set_show_events (False)
		
			feature {EV_GTK_EXTERNALS}.gtk_widget_set_default_colormap (feature {EV_GTK_EXTERNALS}.gdk_rgb_get_cmap)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_set_default_visual (feature {EV_GTK_EXTERNALS}.gdk_rgb_get_visual)

			tooltips := feature {EV_GTK_EXTERNALS}.gtk_tooltips_new
			set_tooltip_delay (500)
			create window_oids.make
			
			-- Initialize the marshal object.
			create gtk_marshal
		end
		
	a_timeout_imp: EV_TIMEOUT_IMP
			-- Timeout used to call post_launch_actions

	launch is
			-- Display the first window, set up the post_launch_actions,
			-- and start the event loop.
		do
			a_timeout_imp ?= (create {EV_TIMEOUT}).implementation
			a_timeout_imp.interface.actions.extend (agent (interface.post_launch_actions).call (empty_tuple))
			a_timeout_imp.set_interval_kamikaze (0)


			internal_idle_actions.not_empty_actions.extend (
				agent connect_internal_idle_actions
			)
			internal_idle_actions.empty_actions.extend (
				agent disconnect_internal_idle_actions
			)
			if not internal_idle_actions.is_empty then
				connect_internal_idle_actions
			end
			interface.idle_actions.not_empty_actions.extend (
				agent internal_idle_actions.extend (idle_actions_agent)
			)
			interface.idle_actions.empty_actions.extend (
				agent internal_idle_actions.prune_all (idle_actions_agent)
			)
			if not interface.idle_actions.is_empty then
				internal_idle_actions.extend (idle_actions_agent)
			end
			
			if gtk_maj_ver = 1 and then gtk_min_ver <= 2 and then gtk_mic_ver < 8 then
				print ("This application is designed for Gtk 1.2.8 and above, your current version is 1.2." + gtk_mic_ver.out + " and may cause some unexpected behavior%N")
			end
			is_in_gtk_main := True
			feature {EV_GTK_EXTERNALS}.gtk_main
			is_in_gtk_main := False
			
			-- Unhook marshal object.
			gtk_marshal.destroy
			is_destroyed := True
		end
		
feature {EV_ANY_IMP} -- Access
		
	gtk_marshal: EV_GTK_CALLBACK_MARSHAL
		-- Marshal object for all gtk signal emission event handling.

feature -- Access

	ctrl_pressed: BOOLEAN is
			-- Is ctrl key currently pressed?
		do
			Result := (keyboard_modifier_mask.bit_and (feature {EV_GTK_EXTERNALS}.gdk_control_mask_enum)).to_boolean
		end

	alt_pressed: BOOLEAN is
			-- Is alt key currently pressed?
		do
			Result := (keyboard_modifier_mask.bit_and (feature {EV_GTK_EXTERNALS}.gdk_mod1_mask_enum)).to_boolean
		end

	shift_pressed: BOOLEAN is
			-- Is shift key currently pressed?
		do
			Result := (keyboard_modifier_mask.bit_and (feature {EV_GTK_EXTERNALS}.gdk_shift_mask_enum)).to_boolean
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

	process_events is
			-- Process any pending events.
			--| Pass control to the GUI toolkit so that it can
			--| handle any events that may be in its queue.
		local
			main_not_running: INTEGER
		do
			-- We do not want nested loops of process events.
			if not processing_events then
				from
					processing_events := True
				until 
					feature {EV_GTK_EXTERNALS}.gtk_events_pending = 0
				loop
					main_not_running := feature {EV_GTK_EXTERNALS}.gtk_main_iteration_do (False)
				end
				processing_events := False
			end
		end
		
	processing_events: BOOLEAN
		-- Is process_events in the middle of execution?

	sleep (msec: INTEGER) is
			-- Wait for `msec' milliseconds and return.
		do
			usleep (msec * 1000)
		end

	destroy is
			-- End the application.
		do
			feature {EV_GTK_EXTERNALS}.gtk_main_quit
			is_destroyed := True
		end

feature -- Status report

	tooltip_delay: INTEGER
			-- Time in milliseconds before tooltips pop up.

feature -- Status setting

	set_tooltip_delay (a_delay: INTEGER) is
			-- Set `tooltip_delay' to `a_delay'.
		do
			tooltip_delay := a_delay
			feature {EV_GTK_EXTERNALS}.gtk_tooltips_set_delay (tooltips, a_delay)
		end

feature {EV_PICK_AND_DROPABLE_IMP} -- Pick and drop

	pnd_target_from_gdk_window (
		a_gdk_window: POINTER;
		a_x, a_y: INTEGER
		): EV_PICK_AND_DROPABLE is
		require
			a_gdk_window_not_void: a_gdk_window /= NULL
		local
			cur: CURSOR
			imp: EV_PICK_AND_DROPABLE_IMP
			row_imp: EV_PND_DEFERRED_ITEM
			trg: EV_PICK_AND_DROPABLE
		do
			cur := pnd_targets.cursor
			from
				pnd_targets.start
			until
				pnd_targets.after or Result /= Void
			loop
				trg ?= id_object (pnd_targets.item)
				if trg = Void or else trg.is_destroyed then
					--| FIXME Unsensitive widgets should not be droppable.
					pnd_targets.forth
					-- If Void or destroyed then it will be removed on the next pick.
				else
					imp ?= trg.implementation
					if imp = Void then
						row_imp ?= trg.implementation
						check
							imp_not_void: row_imp /= Void
						end
						if
							row_imp.parent_widget_is_displayed and then
							row_imp.pointer_over_widget (a_gdk_window, a_x, a_y)
						then
							Result := trg
						end
					elseif imp.is_displayed and then not imp.internal_non_sensitive
					and then imp.pointer_over_widget (a_gdk_window, a_x, a_y) then
						Result := trg
					end				
					pnd_targets.forth
				end
			end
			pnd_targets.go_to (cur)
		end

	on_pick (a_pebble: ANY) is
			-- Called by EV_PICK_AND_DROPABLE_IMP.start_transport
		local
			cur: CURSOR
			trg: EV_PICK_AND_DROPABLE
			i: INTEGER
		do
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
			--| Do nothing, for future implementation
		end

feature {EV_ANY_IMP} -- Implementation

	tooltips: POINTER
			-- Reference to GtkTooltips object.
			
	empty_tuple: TUPLE is
			-- Tuple optimization to prevent object recreation
		once
			Result := []
		end

feature -- Implementation

	is_in_docking: BOOLEAN
		-- Is application currently in docking?
	
	enable_is_in_docking is
			-- Set is_in_docking to True.
		do
			is_in_docking := True
		end
		
	disable_is_in_docking is
			-- Set is_in_docking to False.
		do
			is_in_docking := False
		end

	is_in_gtk_main: BOOLEAN
			-- Is execution currently in gtk_main?

	internal_idle_actions_connection_id: INTEGER
			-- GTK connection handle.

	idle_actions_agent: PROCEDURE [ACTION_SEQUENCE [TUPLE []], TUPLE []] is
			-- Agent for interface.idle_actions.call ([])
		do
			if idle_actions_agent_internal = Void then
				idle_actions_agent_internal :=
					agent (interface.idle_actions).call (empty_tuple)
			end
			Result := idle_actions_agent_internal
		end

	idle_actions_agent_internal: PROCEDURE [ACTION_SEQUENCE [TUPLE []], TUPLE []]

	connect_internal_idle_actions is
		do
			if internal_idle_actions_connection_id = 0 then
				internal_idle_actions_connection_id :=
					gtk_marshal.c_ev_gtk_callback_marshal_idle_connect (
						agent internal_idle_actions.call (empty_tuple) 
					)
			end
		ensure
			internal_idle_actions_connection_id_positive:
				internal_idle_actions_connection_id > 0
		end

	disconnect_internal_idle_actions is
		do
			if internal_idle_actions_connection_id /= 0 then
					feature {EV_GTK_EXTERNALS}.gtk_idle_remove (internal_idle_actions_connection_id)
					internal_idle_actions_connection_id := 0
			end
		end

	keyboard_modifier_mask: INTEGER is
			-- Mask representing current keyboard modifiers state.
		local
			temp_mask, temp_x, temp_y: INTEGER
			temp_ptr: POINTER
		do
			temp_ptr := feature {EV_GTK_EXTERNALS}.gdk_window_get_pointer (default_pointer, $temp_x, $temp_y, $temp_mask)
			Result := temp_mask
		end
		
feature {EV_ANY_I, EV_FONT_IMP} -- Implementation

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
			Result := feature {EV_GTK_EXTERNALS}.gtk_widget_struct_window (default_gtk_window)
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
		once
			temp_style := feature {EV_GTK_EXTERNALS}.gtk_widget_struct_style (default_gtk_window)
			Result := feature {EV_GTK_EXTERNALS}.gdk_font_struct_ascent (feature {EV_GTK_EXTERNALS}.gtk_style_get_font (temp_style)) + 1
		end
		
	default_font_ascent: INTEGER is
			--
		local
			temp_style: POINTER
		once
			temp_style := feature {EV_GTK_EXTERNALS}.gtk_widget_struct_style (default_gtk_window)
			Result := feature {EV_GTK_EXTERNALS}.gdk_font_struct_ascent (feature {EV_GTK_EXTERNALS}.gtk_style_get_font (temp_style))
		end
		
	default_font_descent: INTEGER is
			--
		local
			temp_style: POINTER
		once
			temp_style := feature {EV_GTK_EXTERNALS}.gtk_widget_struct_style (default_gtk_window)
			Result := feature {EV_GTK_EXTERNALS}.gdk_font_struct_descent (feature {EV_GTK_EXTERNALS}.gtk_style_get_font (temp_style))
		end
		
	default_translate: FUNCTION [ANY, TUPLE [INTEGER, POINTER], TUPLE] is		
		once
			Result := agent gtk_marshal.gdk_event_to_tuple
		end
		
	bg_color: POINTER is
			-- Default allocated background color.
		local
			a_success: BOOLEAN
		once
			Result := feature {EV_GTK_EXTERNALS}.c_gdk_color_struct_allocate
			a_success := feature {EV_GTK_EXTERNALS}.gdk_colormap_alloc_color (feature {EV_GTK_EXTERNALS}.gdk_rgb_get_cmap, Result, False, True)
		end
		
	fg_color: POINTER is
			-- Default allocate foreground color.
		local
			a_success: BOOLEAN
		once
			Result := feature {EV_GTK_EXTERNALS}.c_gdk_color_struct_allocate
			feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_red (Result, 65535)
			feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_green (Result, 65535)
			feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_blue (Result, 65535)
			a_success := feature {EV_GTK_EXTERNALS}.gdk_colormap_alloc_color (feature {EV_GTK_EXTERNALS}.gdk_rgb_get_cmap, Result, False, True)
		end
		
feature -- External implementation

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
		
	gtk_maj_ver: INTEGER is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			"gtk_major_version"
		end

	gtk_min_ver: INTEGER is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			"gtk_minor_version"
		end
		
	gtk_mic_ver: INTEGER is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			"gtk_micro_version"
		end
		

invariant
	window_oids_not_void: is_usable implies window_oids /= void
	tooltips_not_void: tooltips /= NULL
	idle_actions_agent_not_void: is_usable implies idle_actions_agent /= void

end -- class EV_APPLICATION_IMP

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

