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

	INTERNAL

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
			if temp_int = 1 or temp_int = 2 then
				print (
					"Gtk version = " +
					gtk_maj_ver.out + "." + gtk_min_ver.out + "."+ gtk_mic_ver.out + "%N"
				)
				(create {EV_C_UTIL}).enable_ev_gtk_log (temp_int)
				C.gdk_set_show_events (True)	
			else
				(create {EV_C_UTIL}).enable_ev_gtk_log (0)
				C.gdk_set_show_events (False)
			end

			temp_string := get ("ISE_EIFFEL")
			previous_gtk_rc_files := get ("GTK_RC_FILES")
			put (temp_string + "/eifinit/bench/spec/gtk/studiorc", "GTK_RC_FILES")			
			
			C.gtk_rc_parse (eiffel_to_c ("studiorc"));
			if previous_gtk_rc_files /= Void then
				put (previous_gtk_rc_files, "GTK_RC_FILES")
			end
			gtk_init
			C.gdk_rgb_init			
			c_ev_gtk_callback_marshal_init (Current, $marshal)
			C.gtk_widget_set_default_colormap (C.gdk_rgb_get_cmap)
			C.gtk_widget_set_default_visual (C.gdk_rgb_get_visual)

			tooltips := C.gtk_tooltips_new
			set_tooltip_delay (500)
			create window_oids.make
		end

	launch is
			-- Display the first window, set up the post_launch_actions,
			-- and start the event loop.
		do
			c_ev_gtk_callback_marshal_delayed_agent_call (
				0,
				(interface.post_launch_actions)~call ([])
			)
			internal_idle_actions.not_empty_actions.extend (
				~connect_internal_idle_actions
			)
			internal_idle_actions.empty_actions.extend (
				~disconnect_internal_idle_actions
			)
			if not internal_idle_actions.is_empty then
				connect_internal_idle_actions
			end
			interface.idle_actions.not_empty_actions.extend (
				internal_idle_actions~extend (idle_actions_agent)
			)
			interface.idle_actions.empty_actions.extend (
				internal_idle_actions~prune_all (idle_actions_agent)
			)
			if not interface.idle_actions.is_empty then
				internal_idle_actions.extend (idle_actions_agent)
			end
			is_in_gtk_main := True
			C.gtk_main
			is_in_gtk_main := False
			c_ev_gtk_callback_marshal_destroy
			is_destroyed := True
		end

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

feature {EV_TOOLTIPABLE_IMP} -- Implementation

	tooltips: POINTER
			-- Reference to GtkTooltips object.

feature -- Implementation

	f_of_tuple_type_id: INTEGER is
		once
			Result := dynamic_type (create {PROCEDURE [ANY, TUPLE [TUPLE]]})
		end

	marshal (action: PROCEDURE [ANY, TUPLE]; n_args: INTEGER; args: POINTER) is
			-- Call `action' with GTK+ event data from `args'.
			-- There are `n_args' GtkArg*s in `args'.
			-- Called by C funtion `c_ev_gtk_callback_marshal'.
		require
			action_not_void: action /= Void
			n_args_not_negative: n_args >= 0
			args_not_null: n_args > 0 implies args /= NULL
		do
			if
				type_conforms_to (dynamic_type (action), f_of_tuple_type_id) 
			then
				action.call ([[]])
			else
				action.call ([n_args, args])
			end
		end

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
					(interface.idle_actions)~call ([])
			end
			Result := idle_actions_agent_internal
		end

	idle_actions_agent_internal: PROCEDURE [ACTION_SEQUENCE [TUPLE []], TUPLE []]

	connect_internal_idle_actions is
		do
			if internal_idle_actions_connection_id = 0 then
				internal_idle_actions_connection_id :=
					c_ev_gtk_callback_marshal_idle_connect (
						internal_idle_actions~call ([]) 
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

	c_ev_gtk_callback_marshal_init (
		object: EV_APPLICATION_IMP; a_marshal: POINTER
		) is
			-- See ev_gtk_callback_marshal.c
		external
			"C | %"ev_gtk_callback_marshal.h%""
		end

	c_ev_gtk_callback_marshal_destroy
		is
			-- See ev_gtk_callback_marshal.c
		external
			"C | %"ev_gtk_callback_marshal.h%""
		end

	c_ev_gtk_callback_marshal_delayed_agent_call
				(a_delay: INTEGER; an_agent: PROCEDURE [ANY, TUPLE]) is
			-- Call `an_agent' after `a_delay'.
		external
			"C (gint, EIF_OBJECT) | %"gtk_eiffel.h%""
		end

	c_ev_gtk_callback_marshal_idle_connect
				(an_agent: PROCEDURE [ANY, TUPLE]): INTEGER is
			-- Call `an_agent' when idle.
		external
			"C (EIF_OBJECT): guint | %"gtk_eiffel.h%""
		end

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
--| Revision 1.37  2001/06/29 20:03:49  king
--| Added key_constants function
--|
--| Revision 1.36  2001/06/21 22:32:00  king
--| Added version externals
--|
--| Revision 1.35  2001/06/19 16:54:20  king
--| Added extra debug functionality
--|
--| Revision 1.34  2001/06/16 01:11:06  king
--| Integrated resource file handling
--|
--| Revision 1.33  2001/06/07 23:38:33  king
--| Updated font size init
--|
--| Revision 1.32  2001/06/07 23:08:03  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.13.4.33  2001/06/05 22:42:27  king
--| Updated env var comments
--|
--| Revision 1.13.4.32  2001/06/05 16:30:08  king
--| Added support for customized debug modes and default font size
--|
--| Revision 1.13.4.31  2001/06/05 01:32:52  king
--| Changed logging mode to off, needs updated to account for env var
--|
--| Revision 1.13.4.30  2001/06/04 19:45:11  king
--| Removed left alt right alt pressed
--|
--| Revision 1.13.4.29  2001/05/18 18:12:28  king
--| Removed is_destroyed code
--|
--| Revision 1.13.4.28  2001/04/27 21:30:40  king
--| Added is_destroyed protection and optimized real_pointer_over_target
--|
--| Revision 1.13.4.27  2001/04/26 18:43:25  king
--| Added code to ignore custom gtk theme
--|
--| Revision 1.13.4.26  2001/04/13 23:58:17  king
--| Removed useless line of code, added comment for font change
--|
--| Revision 1.13.4.25  2001/04/12 23:51:15  king
--| Beautified ugly default font by changing from 12 to 10 point
--|
--| Revision 1.13.4.24  2001/02/16 00:31:55  rogers
--| Replaced is_useable with is_usable.
--|
--| Revision 1.13.4.23  2001/02/15 18:39:27  king
--| Added GTK_ERROR debug clause to prevent unnecessary exceptions
--|
--| Revision 1.13.4.22  2001/02/15 18:09:11  rogers
--| Added temporary implementation of left_alt_pressed and right_alt_pressed.
--|
--| Revision 1.13.4.21  2000/12/18 08:53:24  manus
--| Removed possible conflicts with introduction of keyword `agent', instead removed
--| every occurences with `action.
--|
--| Revision 1.13.4.20  2000/12/15 19:39:58  king
--| Changed .empty to .is_empty
--|
--| Revision 1.13.4.19  2000/12/14 18:53:12  etienne
--| (IEK)  Corrected pre pick steps to avoid using destroyed objects
--|
--| Revision 1.13.4.18  2000/11/25 00:59:35  king
--| Implemented keyboard modifier functions
--|
--| Revision 1.13.4.17  2000/11/23 01:39:12  etienne
--| Made compilable
--|
--| Revision 1.13.4.16  2000/09/18 23:56:39  oconnor
--| call c_ev_gtk_callback_marshal_destroy at the end of launch
--|
--| Revision 1.13.4.15  2000/09/08 18:34:06  oconnor
--| dont barf when destroy is called from marshal
--|
--| Revision 1.13.4.14  2000/09/07 23:05:22  oconnor
--| Set the default visual and colormap to be that chosen by GtkRGB.
--| This ensures  that pixmaps will be compatible with other widgets
--| WRT color depth etc.
--|
--| Revision 1.13.4.13  2000/09/07 16:33:18  king
--| Accounted for removal of identified inheritance from _I
--|
--| Revision 1.13.4.12  2000/07/24 21:35:09  oconnor
--| inherit action sequences _IMP class
--|
--| Revision 1.13.4.11  2000/07/12 22:18:32  brendel
--| Moved `target_menu' up to _I.
--| Since _I now inherits IDENTIFIED, removed here.
--|
--| Revision 1.13.4.10  2000/06/22 02:07:17  oconnor
--| Removed in line creations that may have caused 4.5 to choke.
--|
--| Revision 1.13.4.9  2000/06/20 21:24:47  oconnor
--| simplified destroy
--|
--| Revision 1.13.4.8  2000/06/14 18:14:21  king
--| Converted to using implementation instead of interface references
--|
--| Revision 1.13.4.7  2000/06/14 17:58:47  oconnor
--| made f_of_tuple_type_id an attribute
--|
--| Revision 1.13.4.6  2000/06/14 00:35:09  oconnor
--| Fixed local/feature name clash.
--|
--| Revision 1.13.4.5  2000/06/14 00:19:42  oconnor
--| Updated for new EV_APPLICATION creation scheme.
--|
--| Revision 1.13.4.4  2000/05/25 00:27:05  king
--| Formatting
--|
--| Revision 1.13.4.3  2000/05/16 00:23:01  king
--| Removed resolved fixmes
--|
--| Revision 1.13.4.2  2000/05/10 23:02:55  king
--| Integrated inital tooltipable changes
--|
--| Revision 1.13.4.1  2000/05/03 19:08:37  oconnor
--| mergred from HEAD
--|
--| Revision 1.30  2000/05/02 18:55:21  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.29  2000/04/25 00:58:35  oconnor
--| added support of right click PND menus
--|
--| Revision 1.28  2000/04/20 18:15:13  brendel
--| Put comment on single line.
--|
--| Revision 1.27  2000/04/20 00:30:10  oconnor
--| fixed NOTIFY_ACTION_SEQUENCE call in marshaler
--|
--| Revision 1.26  2000/04/19 23:30:38  oconnor
--| removed reliance on c_gtk_init_toolkit
--|
--| Revision 1.25  2000/04/12 23:28:41  oconnor
--| fix for marshal calling actions sequences
--|
--| Revision 1.24  2000/04/04 21:01:57  oconnor
--| assumed funtionality previously in callback marshal
--|
--| Revision 1.23  2000/03/31 19:27:12  oconnor
--| added C.gdk_rgb_init
--|
--| Revision 1.22  2000/03/31 19:09:08  king
--| Rename pebble_over_widget -> pointer_over_widget
--|
--| Revision 1.21  2000/03/30 19:32:36  king
--| Temporarily removed prelight support from PND as mcl row is not a widget
--|
--| Revision 1.20  2000/03/24 02:21:14  oconnor
--| rewrote idle handling using new kamikaze agents
--|
--| Revision 1.18  2000/03/22 21:59:27  king
--| Added pebble_over_widget functionality
--|
--| Revision 1.17  2000/03/21 23:55:48  brendel
--| c -> cur
--|
--| Revision 1.16  2000/03/21 23:49:51  oconnor
--| added pnd_target_from_gdk_window stub for PND
--|
--| Revision 1.15  2000/02/22 18:39:35  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.14  2000/02/14 11:40:27  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.13.6.23  2000/02/11 04:49:14  oconnor
--| attached GTK+ exception system to Eiffel
--|
--| Revision 1.13.6.22  2000/02/04 04:20:42  oconnor
--| released
--|
--| Revision 1.13.6.21  2000/01/28 21:16:58  brendel
--| Added feature `tooltip_delay'.
--|
--| Revision 1.13.6.20  2000/01/27 19:29:27  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.13.6.19  2000/01/26 18:08:51  brendel
--| Added feature `sleep'.
--|
--| Revision 1.13.6.18  2000/01/25 03:19:53  brendel
--| Removed old accelerator features.
--|
--| Revision 1.13.6.17  2000/01/21 00:04:03  oconnor
--| added idle_connect to wrap c_ev_gtk_callback_marshal_idle_connect
--|
--| Revision 1.13.6.16  2000/01/20 23:49:12  oconnor
--| added connection of idle actions
--|
--| Revision 1.13.6.15  2000/01/20 04:13:11  oconnor
--| fixed broken pnd start/end loops that were non-terminal
--|
--| Revision 1.13.6.14  1999/12/16 09:17:28  oconnor
--| fix destruction of application sequence
--|
--| Revision 1.13.6.13  1999/12/15 05:21:11  oconnor
--| formatting
--|
--| Revision 1.13.6.12  1999/12/15 03:58:46  oconnor
--| use weak refs for global PND list
--|
--| Revision 1.13.6.11  1999/12/15 00:35:51  oconnor
--| .drop_actions.accepts_data is now .drop_actions.accepts_pebble
--|
--| Revision 1.13.6.10  1999/12/14 16:52:54  oconnor
--| renamed EV_PND_SOURCE -> EV_PICK_AND_DROPABLE
--|
--| Revision 1.13.6.9  1999/12/13 19:46:06  oconnor
--| added on_pick and on_drop to do target prelighting
--|
--| Revision 1.13.6.8  1999/12/08 01:47:14  oconnor
--| added delayed agent calls to facilitate post launch actions.
--|
--| Revision 1.13.6.7  1999/12/07 20:46:35  oconnor
--| revised layout and comments
--|
--| Revision 1.13.6.6  1999/12/04 18:59:12  oconnor
--| moved externals into EV_C_EXTERNALS, accessed through EV_ANY_IMP.C
--|
--| Revision 1.13.6.5  1999/12/01 16:09:54  oconnor
--| oops, main_not_running is int not bool
--|
--| Revision 1.13.6.4  1999/12/01 00:27:06  oconnor
--| added check of return value from gtk_main_iteration_do
--|
--| Revision 1.13.6.3  1999/12/01 00:09:51  brendel
--| Changes externals to GEL and added dummy return value.
--|
--| Revision 1.13.6.2  1999/11/30 23:55:12  oconnor
--| added process events
--|
--| Revision 1.13.6.1  1999/11/24 17:29:44  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.13.2.5  1999/11/18 03:39:08  oconnor
--| added callback_marshal
--|
--| Revision 1.13.2.4  1999/11/04 23:08:38  oconnor
--| reorganised
--|
--| Revision 1.13.2.3  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
