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
			temp_string, previous_gtk_rc_files: STRING
			temp_int: INTEGER
		do
			base_make (an_interface)
			create C
	
			-- Set Debug mode from environment variable.
			temp_string := get ("ISE_GTK_DEBUG")
			if temp_string /= Void then
				temp_int := temp_string.to_integer
			end
			
			--| FIXME IEK Do not continue running system if gtk version is less than 1.2.8
			if temp_int = 1 or temp_int = 2 then
				print (
					"Vision2 GTK Debug Mode, Gtk version = " +
					gtk_maj_ver.out + "." + gtk_min_ver.out + "."+ gtk_mic_ver.out + "%N"
				)
				(create {EV_C_UTIL}).enable_ev_gtk_log (temp_int)
				C.gdk_set_show_events (True)	
			else
				(create {EV_C_UTIL}).enable_ev_gtk_log (0)
				C.gdk_set_show_events (False)
			end

			--| FIXME IEK
			-- Only load rc file if system is ec.
			-- Check argument zero to compare execution paths.
			temp_string := get ("ISE_EIFFEL")
			previous_gtk_rc_files := get ("GTK_RC_FILES")
			put (temp_string + "/eifinit/bench/spec/gtk/studiorc", "GTK_RC_FILES")			
			
			C.gtk_rc_parse (eiffel_to_c ("studiorc"));
			if previous_gtk_rc_files /= Void then
				put (previous_gtk_rc_files, "GTK_RC_FILES")
			end
			gtk_init
			C.gdk_rgb_init
		
			C.gtk_widget_set_default_colormap (C.gdk_rgb_get_cmap)
			C.gtk_widget_set_default_visual (C.gdk_rgb_get_visual)

			tooltips := C.gtk_tooltips_new
			set_tooltip_delay (500)
			create window_oids.make
			
			-- Initialize the marshal object.
			create gtk_marshal
		end

	launch is
			-- Display the first window, set up the post_launch_actions,
			-- and start the event loop.
		do
			gtk_marshal.c_ev_gtk_callback_marshal_delayed_agent_call (
				0,
				agent (interface.post_launch_actions).call ([])
			)
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
			is_in_gtk_main := True
			C.gtk_main
			is_in_gtk_main := False
			
			-- Unhook marshal object.
			gtk_marshal.destroy
			is_destroyed := True
		end
		
	gtk_marshal: EV_GTK_CALLBACK_MARSHAL
		-- Marshal object for all gtk signal emission event handling.

feature -- Access

	ctrl_pressed: BOOLEAN is
			-- Is ctrl key currently pressed?
		do
			Result := (keyboard_modifier_mask.bit_and (C.gdk_control_mask_enum)).to_boolean
		end

	alt_pressed: BOOLEAN is
			-- Is alt key currently pressed?
		do
			Result := (keyboard_modifier_mask.bit_and (C.gdk_mod1_mask_enum)).to_boolean
		end

	shift_pressed: BOOLEAN is
			-- Is shift key currently pressed?
		do
			Result := (keyboard_modifier_mask.bit_and (C.gdk_shift_mask_enum)).to_boolean
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
			from
			until 
				C.gtk_events_pending = 0
			loop
				main_not_running := C.gtk_main_iteration_do (False)
				check
					main_running: main_not_running = 0
				end
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
			C.gtk_main_quit
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
			C.gtk_tooltips_set_delay (tooltips, a_delay)
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
			row_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
			trg: EV_PICK_AND_DROPABLE
		do
			cur := pnd_targets.cursor
			from
				pnd_targets.start
			until
				pnd_targets.after or Result /= Void
			loop
				trg ?= id_object (pnd_targets.item)
				if trg = Void or trg.is_destroyed then
					pnd_targets.prune_all (pnd_targets.item)
				else
					imp ?= trg.implementation
					if imp = Void then
						row_imp ?= trg.implementation
						check
							imp_not_void: row_imp /= Void
						end
						if
							(row_imp.parent_imp /= Void and then row_imp.parent_imp.is_displayed) and then
							row_imp.pointer_over_widget (a_gdk_window, a_x, a_y)
						then
							Result := trg
						end
					elseif imp.is_displayed and then imp.pointer_over_widget (a_gdk_window, a_x, a_y) then
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
			imp: EV_ANY_IMP
			trg: EV_PICK_AND_DROPABLE
		do
			cur := pnd_targets.cursor
			from
				pnd_targets.start
			until
				pnd_targets.after
			loop
				trg ?= id_object (pnd_targets.item)
				if trg = Void or else trg.is_destroyed then
					pnd_targets.prune_all (pnd_targets.item)
				else
					if
						trg.drop_actions.accepts_pebble (a_pebble)
					then
						imp ?= trg.implementation
						if imp /= Void then
							C.gtk_widget_set_state
								(imp.c_object, C.Gtk_state_prelight_enum)
							C.gtk_widget_draw (imp.c_object, NULL)
						end
					end
					pnd_targets.forth
				end
			end
			pnd_targets.go_to (cur)
			interface.pick_actions.call ([a_pebble])
		end
		
	on_drop (a_pebble: ANY) is
			-- Called by EV_PICK_AND_DROPABLE_IMP.end_transport
		local
			cur: CURSOR
			imp: EV_ANY_IMP
			trg: EV_PICK_AND_DROPABLE
		do
			cur := pnd_targets.cursor
			from
				pnd_targets.start
			until
				pnd_targets.after
			loop
				trg ?= id_object (pnd_targets.item)
				if trg = Void then
					pnd_targets.prune_all (pnd_targets.item)
				else
					if
						trg.drop_actions.accepts_pebble (a_pebble)
					then
						imp ?= trg.implementation
						if imp /= Void then
							C.gtk_widget_set_state
								(imp.c_object, C.Gtk_state_normal_enum)
							C.gtk_widget_draw (imp.c_object, NULL)
						end
					end
					pnd_targets.forth
				end
			end
			pnd_targets.go_to (cur)
		end

feature {EV_ANY_IMP} -- Implementation

	tooltips: POINTER
			-- Reference to GtkTooltips object.

feature -- Implementation

	is_in_gtk_main: BOOLEAN
			-- Is execution currently in gtk_main?

	C: EV_C_EXTERNALS
			-- Access to C externals.

	internal_idle_actions_connection_id: INTEGER
			-- GTK connection handle.

	idle_actions_agent: PROCEDURE [ACTION_SEQUENCE [TUPLE []], TUPLE []] is
			-- Agent for interface.idle_actions.call ([])
		do
			if idle_actions_agent_internal = Void then
				idle_actions_agent_internal :=
					agent (interface.idle_actions).call ([])
			end
			Result := idle_actions_agent_internal
		end

	idle_actions_agent_internal: PROCEDURE [ACTION_SEQUENCE [TUPLE []], TUPLE []]

	connect_internal_idle_actions is
		do
			if internal_idle_actions_connection_id = 0 then
				internal_idle_actions_connection_id :=
					gtk_marshal.c_ev_gtk_callback_marshal_idle_connect (
						agent internal_idle_actions.call ([]) 
					)
			end
		ensure
			internal_idle_actions_connection_id_positive:
				internal_idle_actions_connection_id > 0
		end

	disconnect_internal_idle_actions is
		do
			if internal_idle_actions_connection_id /= 0 then
					C.gtk_idle_remove (internal_idle_actions_connection_id)
					internal_idle_actions_connection_id := 0
			end
		end

	keyboard_modifier_mask: INTEGER is
			-- Mask representing current keyboard modifiers state.
		local
			temp_mask, temp_x, temp_y: INTEGER
			temp_ptr: POINTER
		do
			temp_ptr := C.gdk_window_get_pointer (default_pointer, $temp_x, $temp_y, $temp_mask)
			Result := temp_mask
		end
		
feature -- External implementation

	usleep (micro_seconds: INTEGER) is
		external
			"C | <unistd.h>"
		end
	
	gtk_init is
		external
			"C [macro <gtk/gtk.h>]"
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
	c_externals_object_not_void: C /= Void
	tooltips_not_void: tooltips /= NULL
	idle_actions_agent_not_void: idle_actions_agent /= void

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

