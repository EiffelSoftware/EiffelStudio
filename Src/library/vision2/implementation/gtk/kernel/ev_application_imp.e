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

create 
	make
	
feature {NONE} -- Initialization
	
	make (an_interface: like interface) is
			-- Set up the callback marshal and initialize GTK+.
		do
			base_make (an_interface)
			(create {EV_C_UTIL}).enable_ev_gtk_log
			create C
			create ev_gtk_callback_marshal
			C.c_gtk_init_toolkit
			C.gdk_rgb_init
			tooltips := C.gtk_tooltips_new
			set_tooltip_delay (500) --| FIXME Check this.
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
				(interface.post_launch_actions)~call
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

	pnd_target_from_gdk_window (a_gdk_window: POINTER; a_x, a_y: INTEGER): EV_PICK_AND_DROPABLE is
		require
			a_gdk_window_not_void: a_gdk_window /= Default_pointer
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
						if row_imp.pointer_over_widget (a_gdk_window, a_x, a_y) then
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
						--| FIXME IEK No current prelight support for mcl rows.
						--imp ?= trg.implementation
						--check
						--	imp_not_void: imp /= Void
						--end
						--C.gtk_widget_set_state
						--	(imp.c_object, C.Gtk_state_prelight_enum)
						--C.gtk_widget_draw (imp.c_object, Default_pointer)
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
						--| FIXME IEK Mclist rows are not widgets.
						--imp ?= trg.implementation
						--check
						--	imp_not_void: imp /= Void
						--end
						--C.gtk_widget_set_state
						--	(imp.c_object, C.Gtk_state_normal_enum)
						--C.gtk_widget_draw (imp.c_object, Default_pointer)
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
			w_imp.signal_connect ("destroy", ~remove_root_window (a_window))
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

	ev_gtk_callback_marshal: EV_GTK_CALLBACK_MARSHAL
			-- Marshal responsible for directing signals from GTK.

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
						internal_idle_actions~call (?) 
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

invariant
	ev_gtk_callback_marshal_not_void: ev_gtk_callback_marshal /= Void
	c_externals_object_not_void: C /= Void
	tooltips_not_void: tooltips /= Default_pointer
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
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
