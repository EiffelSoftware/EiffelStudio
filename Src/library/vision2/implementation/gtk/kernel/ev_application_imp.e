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

	EV_C_UTIL

	IDENTIFIED
		undefine
			is_equal,
			copy
		end

	INTERNAL

create 
	make
	
feature {NONE} -- Initialization
	
	make (an_interface: like interface) is
			-- Set up the callback marshal and initialize GTK+.
		do
			base_make (an_interface)
			(create {EV_C_UTIL}).enable_ev_gtk_log
			create C
			c_ev_gtk_callback_marshal_init (Current, $marshal)
			gtk_init
			C.gtk_rc_parse(eiffel_to_c ("gtkrc"));
			C.gdk_rgb_init
			tooltips := C.gtk_tooltips_new
			--| FIXME Check this:
			set_tooltip_delay (500)
			idle_actions_agent := (interface.idle_actions)~call ([])
		end

	launch is
			-- Display the first window, set up the post_launch_actions,
			-- and start the event loop.
		do
			interface.first_window.show
			add_root_window (interface.first_window)
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
			if not internal_idle_actions.empty then
				connect_internal_idle_actions
			end
			interface.idle_actions.not_empty_actions.extend (
				internal_idle_actions~extend (idle_actions_agent)
			)
			interface.idle_actions.empty_actions.extend (
				internal_idle_actions~prune_all (idle_actions_agent)
			)
			if not interface.idle_actions.empty then
				internal_idle_actions.extend (idle_actions_agent)
			end
			is_in_gtk_main := True
			C.gtk_main
			is_in_gtk_main := False
			is_destroyed := True
			destroy_just_called := True
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
			from
				root_windows.start
			variant
				root_windows.count
			until
				root_windows.after
			loop
				root_windows.item.destroy
				root_windows.start
			end
			is_destroyed := True
			destroy_just_called := True
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
			--| FIXME use this implementation instead!:
			--| Result := hash_table.item (a_gdk_window)
			--| FIXME IEK Mclist is comprised of multiple gdk windows.
			cur := pnd_targets.cursor
			from
				pnd_targets.start
			until
				pnd_targets.after or Result /= Void
			loop
				trg ?= id_object (pnd_targets.item)
				if trg = Void then
					pnd_targets.prune_all (pnd_targets.item)
				else
					imp ?= trg.implementation
					if imp = Void then
						row_imp ?= trg.implementation
						check
							imp_not_void: row_imp /= Void
						end
						if
							row_imp.pointer_over_widget (a_gdk_window, a_x, a_y)
						then
							Result := trg
						end
					elseif imp.pointer_over_widget (a_gdk_window, a_x, a_y) then
						Result := trg
					end				
				end
				pnd_targets.forth
			end
			pnd_targets.go_to (cur)
		end
	
	target_menu (a_pebble: ANY): EV_MENU is
			-- Menu of targets that accept `a_pebble'.
		local
			cur: CURSOR
			imp: EV_ANY_IMP
			trg: EV_PICK_AND_DROPABLE
		do
			create Result
			cur := pnd_targets.cursor
			from
				pnd_targets.start
			until
				pnd_targets.after
			loop
				trg ?= id_object (pnd_targets.item)
				if trg /= Void then
					if
						trg.drop_actions.accepts_pebble (a_pebble)
					then
						if trg.target_name /= Void then
							Result.extend (
								create {EV_MENU_ITEM}.make_with_text (
									trg.target_name
								)
							)
							Result.last.select_actions.extend (
								(trg.drop_actions)~call ([a_pebble])
							)
						end
					end
					pnd_targets.forth
				end
			end
			pnd_targets.go_to (cur)
			if Result.empty then
				Result.extend (create {EV_MENU_ITEM}.make_with_text ("empty"))
			end
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
				if trg = Void then
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

feature {EV_WINDOW_I} -- Root window management

	add_root_window (a_window: EV_WINDOW) is
			-- Add `a_window' to the `root_windows'.
		local
			w_imp: EV_WINDOW_IMP
		do
			root_windows.extend (a_window)
			w_imp ?= a_window.implementation
			w_imp.signal_connect (
				"destroy",
				~remove_root_window (a_window),
				Void
			)
		end

	remove_root_window (a_window: EV_WINDOW) is
			-- Remove `a_window' from `root_windows'
		do
			root_windows.start
			root_windows.prune_all (a_window)

			if (root_windows.empty) then
				if is_in_gtk_main then
					C.gtk_main_quit
				end
			end
		end

feature {EV_WIDGET_IMP} -- Implementation

	tooltips: POINTER
			-- Reference to GtkTooltips object.

feature -- Implementation

	marshal (agent: PROCEDURE [ANY, TUPLE]; n_args: INTEGER; args: POINTER) is
			-- Call `agent' with GTK+ event data from `args'.
			-- There are `n_args' GtkArg*s in `args'.
			-- Called by C funtion `c_ev_gtk_callback_marshal'.
		require
			agent_not_void: agent /= Void
			n_args_not_negative: n_args >= 0
			args_not_null: n_args > 0 implies args /= NULL
			--FIXME make this an attribut or somthign to make it faster
		local
			f_of_tuple_type_id: INTEGER
		do
			f_of_tuple_type_id := 
				dynamic_type (create {PROCEDURE [ANY, TUPLE [TUPLE]]})
			if
				type_conforms_to (dynamic_type (agent), f_of_tuple_type_id) 
			then
				agent.call ([[]])
			else
				agent.call ([n_args, args])
			end
		end

	is_in_gtk_main: BOOLEAN
			-- Is execution currently in gtk_main?

	C: EV_C_EXTERNALS
			-- Access to C externals.

	internal_idle_actions_connection_id: INTEGER
			-- GTK connection handle.

	idle_actions_agent: PROCEDURE [ACTION_SEQUENCE [TUPLE []], TUPLE []]
			-- Agent for interface.idle_actions.call ([])

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

feature -- External implementation

	c_ev_gtk_callback_marshal_init (
		object: EV_APPLICATION_IMP; a_marshal: POINTER
		) is
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

invariant
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
