indexing
	description: 
		"Eiffel Vision application. Implementation interface.%N%
		%See ev_application.e"
	status: "See notice at end of class"
	keywords: "application"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_APPLICATION_I

inherit
	EV_ANY_I
		redefine
			interface
		end

	EV_APPLICATION_ACTION_SEQUENCES_I
	
feature {EV_APPLICATION} -- Initialization
	
	initialize is
			-- Create pick and drop target list.
			-- Set F1 as default help key.
			-- Create default help engine.
		local
			f1_key: EV_KEY
		do
			create f1_key.make_with_code ((create {EV_KEY_CONSTANTS}).Key_f1)
			set_help_accelerator (create {EV_ACCELERATOR}.make_with_key_combination (f1_key, False, False, False))
			set_contextual_help_accelerator (create {EV_ACCELERATOR}.make_with_key_combination (f1_key, False, False, True))
			create {EV_SIMPLE_HELP_ENGINE} help_engine
			create pnd_targets.make
			create internal_idle_actions
			create once_idle_actions
			do_once_idle_actions_agent := ~do_once_idle_actions
			is_initialized := True
		end

	launch is
			-- Start the event loop.
		deferred
		end

feature -- Access

	pnd_targets: LINKED_LIST [INTEGER] 
			-- Global list of pick and drop target object ids.

	windows: LINEAR [EV_WINDOW] is
			-- Global list of windows.
		deferred
		end
		
	locked_window: EV_WINDOW
			-- Window currently locked. Void if no window 
			-- is currently locked.
			--
			-- See `{EV_WINDOW}.lock_update' for more details

	help_accelerator: EV_ACCELERATOR
			-- Accelerator that displays contextual help

	contextual_help_accelerator: EV_ACCELERATOR
			-- Accelerator that enables contextual help mode

	help_engine: EV_HELP_ENGINE
			-- Object that handle contextual help display requests

	clipboard: EV_CLIPBOARD is
			-- Native platform clipboard access.
		do
			if clipboard_internal = Void then
				create clipboard_internal
			end
			Result := clipboard_internal
		end

	ctrl_pressed: BOOLEAN is
			-- Is ctrl key currently pressed?
		deferred
		end

	shift_pressed: BOOLEAN is
			-- Is shift key currently pressed?
		deferred
		end

	alt_pressed: BOOLEAN is
			-- Is alt key currently pressed?
		deferred
		end

feature -- Element Change

	set_help_accelerator (an_accelerator: EV_ACCELERATOR) is
			-- Assign `an_accelerator' to `help_accelerator'
		require
			an_accelerator_not_void: an_accelerator /= Void
		do
			help_accelerator := an_accelerator
			if not help_accelerator.actions.has (help_handler_procedure) then
				help_accelerator.actions.extend (help_handler_procedure)
			end
		ensure
			help_accelerator_assigned: help_accelerator = an_accelerator
			help_accelerator_complete: help_accelerator.actions.has (help_handler_procedure)
		end

	set_contextual_help_accelerator (an_accelerator: EV_ACCELERATOR) is
			-- Assign `an_accelerator' to `contextual_help_accelerator'
		require
			an_accelerator_not_void: an_accelerator /= Void
		do
			contextual_help_accelerator := an_accelerator
			if not contextual_help_accelerator.actions.has (contextual_help_handler_procedure) then
				contextual_help_accelerator.actions.extend (contextual_help_handler_procedure)
			end
		ensure
			contextual_help_accelerator_assigned: contextual_help_accelerator = an_accelerator
			contextual_help_accelerator_complete: contextual_help_accelerator.actions.has (contextual_help_handler_procedure)
		end

	set_help_engine (an_engine:  EV_HELP_ENGINE) is
			-- Assign `an_engine' to `help_engine'
		require
			an_engine_not_void: an_engine /= Void
		do
			help_engine := an_engine
		ensure
			help_engine_set: help_engine = an_engine
		end

	set_locked_window (a_window: EV_WINDOW) is
			-- Set `locked_window' to `a_window'.
			--
			-- See `{EV_WINDOW}.lock_update' for more details
		do
			locked_window := a_window
		end

feature -- Basic operation

	process_events is
			-- Process any pending events.
			-- Pass control to the GUI toolkit so that it can
			-- handle any events that may be in its queue.
		deferred
		end

	sleep (msec: INTEGER) is
			-- Wait for `msec' milliseconds and return.
		require
			msec_non_negative: msec >= 0 
		deferred
		end

	enable_contextual_help is
			-- Change mouse cursor to help cursor
			-- Capture mouse input
			-- Send help context of widget under mouse cursor when left mouse button is pressed to help engine.
			-- Cancel contextual help mode when right mouse button is pressed.
		do
			if focused_widget /= Void then
				capture_widget := focused_widget
				old_pointer_button_press_actions := capture_widget.pointer_button_press_actions
				capture_widget.pointer_button_press_actions.wipe_out
				capture_widget.pointer_button_press_actions.extend_kamikaze (contextual_help_procedure)
				old_pointer_style := capture_widget.pointer_style
				capture_widget.set_pointer_style ((create {EV_STOCK_PIXMAPS}).Help_cursor)
				capture_widget.enable_capture
			end
		end
	
	display_help_for_widget (a_widget: EV_WIDGET) is
			-- Display contextual help for `a_widget', if any.
		require
			a_widget_not_void: a_widget /= Void
		local
			an_help_context: FUNCTION [ANY, TUPLE, EV_HELP_CONTEXT]
		do
			an_help_context := a_widget.help_context
			if an_help_context /= Void then
				help_engine.show (an_help_context.item (Void))
			end
		end

feature -- Events

	internal_idle_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when no events are in queue.

	once_idle_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be preformed once when no events are in queue.
			-- Wiped out after being called.

	do_once_on_idle (an_action: PROCEDURE [ANY, TUPLE []]) is
			-- Perform `an_action' one time only on idle.
		do
			once_idle_actions.extend (an_action)
			if not internal_idle_actions.has (do_once_idle_actions_agent) then
				internal_idle_actions.extend (do_once_idle_actions_agent)
			end
		end

	do_once_idle_actions is
			-- Call `once_idle_actions' then wipe it out.
			-- Remove `do_once_idle_actions_agent' from `internal_idle_actions'.
		do

			once_idle_actions.call ([])
			once_idle_actions.wipe_out
			internal_idle_actions.prune_all (do_once_idle_actions_agent)
		end

	do_once_idle_actions_agent: PROCEDURE [EV_APPLICATION_I, TUPLE []]
			-- Agent for `do_once_idle_actions'.

feature -- Event handling

	accelerator_actions (an_accelerator: EV_ACCELERATOR):
		EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when `an_accelerator' key sequence is
			-- pressed.
		do
			-- FIXME implement this!!
			create Result
		ensure
			not_void: Result /= Void
		end

feature -- Status report

	tooltip_delay: INTEGER is
			-- Time in milliseconds before tooltips pop up.
		deferred
		end

	focused_widget: EV_WIDGET is
			-- Widget with keyboard focus
		local
			current_windows: like windows
		do
			current_windows := windows
			from
				current_windows.start
			until
				current_windows.after
			loop
				if current_windows.item.has_focus then
					Result := focused_widget_from_container (current_windows.item.item)
					if Result = Void then
						Result := current_windows.item
					end
				end
				current_windows.forth
			end
		end

feature -- Status setting

	set_tooltip_delay (a_delay: INTEGER) is
			-- Set `tooltip_delay' to `a_delay'.
		require
			a_delay_non_negative: a_delay >= 0
		deferred
		ensure
			assigned: tooltip_delay = a_delay
		end

feature -- Implementation

	interface: EV_APPLICATION
            -- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

feature {EV_PICK_AND_DROPABLE_IMP} -- Pick and drop

	target_menu (a_pebble: ANY): EV_MENU is
			-- Menu of targets that accept `a_pebble'.
		local
			cur: CURSOR
			trg: EV_ABSTRACT_PICK_AND_DROPABLE
			i: EV_MENU_ITEM
			targets: like pnd_targets
			identified: IDENTIFIED
			sensitive: EV_SENSITIVE
		do
			targets := pnd_targets
			create Result
			create identified
			cur := targets.cursor
			from
				targets.start
			until
				targets.after
			loop
				trg ?= identified.id_object (targets.item)
				if trg /= Void then
					if
						trg.drop_actions.accepts_pebble (a_pebble)
					then
						sensitive ?= trg
						if not (sensitive /= Void and not sensitive.is_sensitive) then
							if trg.target_name /= Void then
								create i.make_with_text (
									trg.target_name
								)
								Result.extend (i)
								i.select_actions.extend (
									(trg.drop_actions)~call ([a_pebble])
								)
							end
						end
					end
				end
				targets.forth
			end
			targets.go_to (cur)
		end

feature {NONE} -- Debug

	trace is
			-- Output all PND targets.
		local
			cur: CURSOR
			trg: EV_ABSTRACT_PICK_AND_DROPABLE
			identified: IDENTIFIED
		do
			cur := pnd_targets.cursor
			create identified
			from
				pnd_targets.start
			until
				pnd_targets.after
			loop
				trg ?= identified.id_object (pnd_targets.item)
				if trg /= Void then
					io.error.put_string (trg.target_name)
				end
				pnd_targets.forth
			end
			pnd_targets.go_to (cur)
		end

feature {NONE} -- Implementation

	clipboard_internal: EV_CLIPBOARD
			-- Internal clipboard object.

	old_pointer_style: EV_CURSOR
			-- Pointer style of window being used while contextual help is enabled

 	old_pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Button press actions of window being used whie contextual help is enabled

	screen: EV_SCREEN is
			-- Screen object used to retrieve widget under mouse pointer
		once
			create Result
		end

	capture_widget: EV_WIDGET
			-- Widget that captures input while contextual help is enabled
	
	help_handler_procedure: PROCEDURE [ANY, TUPLE] is
			-- Help handler procedure associated with help accelerator
		once
			Result := ~help_handler
		end
	
	help_handler is
			-- Display contextual help for currently focused widget.
		local
			w: EV_WIDGET
		do
			w := focused_widget
			if w /= Void then
				display_help_for_widget (w)
			end
		end

	contextual_help_handler_procedure: PROCEDURE [ANY, TUPLE] is
			-- Help handler procedure associated with context help accelerator
		once
			Result := ~enable_contextual_help
		end

	contextual_help_procedure: PROCEDURE [ANY, TUPLE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]] is
			-- Called when mouse pointer is pressed while contextual help is enabled
		once
			Result := ~contextual_help
		end

	contextual_help (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			-- Send help context of widget under mouse cursor when left mouse button is pressed to help engine.
			-- Cancel contextual help mode when right mouse button is pressed.
		local
			w: EV_WIDGET
		do
			if button = 1 then
				disable_contextual_help
				w := screen.widget_at_position (screen_x, screen_y)
				if w /= Void then
					display_help_for_widget (w)
				end
			end
		end
	
	disable_contextual_help is
			-- Disable contextual help: remove capture and restore mouse pointer style.
		do
			check
				valid_capture_widget: capture_widget /= Void
			end
			if old_pointer_button_press_actions /= Void then
				capture_widget.pointer_button_press_actions.fill (old_pointer_button_press_actions)
			end
			check
				valid_old_pointer_style: old_pointer_style /= Void
			end
			capture_widget.set_pointer_style (old_pointer_style)
			capture_widget.disable_capture
		end
	
	focused_widget_from_container (a_widget: EV_WIDGET): EV_WIDGET is
			-- Child widget of `a_widget' with keyboard focus, if any
		local
			a_container: EV_CONTAINER
			a_widget_list: LINEAR [EV_WIDGET]
		do
			a_container ?= a_widget
			if a_container /= Void then
				from
					a_widget_list := a_container.linear_representation
					a_widget_list.start
				until
					a_widget_list.after or Result /= Void
				loop
					Result := focused_widget_from_container (a_widget_list.item)
					a_widget_list.forth
				end
			else
				if a_widget.has_focus then
					Result := a_widget
				end
			end
		ensure
			focused_widget: Result /= Void implies Result.has_focus
		end
			
invariant
	pnd_targets_not_void: is_usable implies pnd_targets /= void
	windows_not_void: is_usable implies windows /= void
	internal_idle_actions_not_void: is_usable implies
		internal_idle_actions /= Void
	once_idle_actions_not_void: is_usable implies
		once_idle_actions /= Void
	do_once_idle_actions_agent: is_usable implies
		do_once_idle_actions_agent /= Void

end -- class EV_APPLICATION_I

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
--| Revision 1.16  2001/06/07 23:08:08  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.10.4.21  2001/06/04 19:42:10  king
--| Removed left alt and right alt pressed
--|
--| Revision 1.10.4.20  2001/02/17 23:19:52  pichery
--| Added `locked_window' feature.
--|
--| Revision 1.10.4.19  2001/02/16 01:08:36  rogers
--| Replaced is_useable with is_usable.
--|
--| Revision 1.10.4.18  2001/02/15 18:00:53  rogers
--| Added left_alt_pressed and right_alt_pressed as deferred.
--| Removed alt_pressed.
--|
--| Revision 1.10.4.17  2000/11/27 22:45:28  rogers
--| Modified target_menu so that disabled targets are not included in the menu.
--|
--| Revision 1.10.4.16  2000/11/22 19:52:12  rogers
--| Added ctrl_pressed, alt_pressed and shift_pressed.
--|
--| Revision 1.10.4.15  2000/11/20 20:20:30  rogers
--| Setting the contextual_help_accelerator in initialize, has been modified
--| as the order of the boolean arguments to make_with_key_combination from
--| EV_ACCELERATOR has been changed.
--|
--| Revision 1.10.4.14  2000/11/06 19:36:11  king
--| Accounted for default to stock name change
--|
--| Revision 1.10.4.13  2000/10/30 17:38:39  king
--| Now creating clipboard with side-effect
--|
--| Revision 1.10.4.12  2000/10/27 01:27:18  manus
--| Removed call to `eval' which was obsolete and replace by `item' from the FUNCTION class.
--|
--| Revision 1.10.4.11  2000/10/11 20:48:25  raphaels
--| Added `display_help_for_widget'.
--| Replaced keys by accelerators for help related features.
--|
--| Revision 1.10.4.9  2000/10/07 03:08:29  raphaels
--| Added `enable_contextual_help' and necessary implementation features.
--|
--| Revision 1.10.4.8  2000/10/03 00:15:06  raphaels
--| Added `help_key', `help_engine' and corresponding settings features.
--|
--| Revision 1.10.4.7  2000/09/07 02:14:12  manus
--| Removed inheritance from IDENTIFIED.
--|
--| Revision 1.10.4.6  2000/07/25 17:28:29  brendel
--| Removed confusing "empty" entry in target menu. Now no menu shows
--| up at all when picking from a source with no valid targets.
--|
--| Revision 1.10.4.5  2000/07/24 21:31:37  oconnor
--| inherit action sequences _I class
--|
--| Revision 1.10.4.4  2000/07/18 01:17:38  brendel
--| Added `trace'.
--| Minor speed optimization.
--|
--| Revision 1.10.4.3  2000/07/12 22:19:19  brendel
--| Moved `target_menu' from _IMP (GTK).
--|
--| Revision 1.10.4.2  2000/06/14 00:18:19  oconnor
--| Some users have had problems with application initialization
--| because their code wasn't structured the way we expected it to be.
--| We have revised EV_APPLICATION to simplify application creation.
--| Previously one would inherit EV_APPLICATION,
--| define `first_window' as a once function that created a window
--| and define prepare to do initialization.
--| A class EV_OLD_APPLICATION is attached and in the release, it
--| serves as a drop in replacement for current code.
--|
--| Now the concept of first window is gone.
--| The deferred prepare' feature has also been removed.
--| As a result EV_APPLICATION is no longer deferred and the ordering
--| of application creation is less restricted.
--| All that is required to start the app now is to call `launch' on
--| the EV_APPLICATION object. This will usually be done after setting
--| up some/an initial window(s).
--|
--| Revision 1.10.4.1  2000/05/03 19:08:56  oconnor
--| mergred from HEAD
--|
--| Revision 1.15  2000/03/23 19:18:32  brendel
--| Formatting.
--|
--| Revision 1.14  2000/03/23 19:04:31  brendel
--| Fixed compiler errors.
--|
--| Revision 1.13  2000/03/23 18:54:26  oconnor
--| added once idle actions implementation
--|
--| Revision 1.12  2000/02/22 18:39:40  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.11  2000/02/14 11:40:34  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.10.6.16  2000/02/04 04:15:55  oconnor
--| release
--|
--| Revision 1.10.6.15  2000/01/28 21:16:58  brendel
--| Added feature `tooltip_delay'.
--|
--| Revision 1.10.6.14  2000/01/27 19:29:53  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.10.6.13  2000/01/26 18:08:51  brendel
--| Added feature `sleep'.
--|
--| Revision 1.10.6.12  2000/01/21 18:20:19  oconnor
--| added stub for accelertor_actions
--|
--| Revision 1.10.6.11  2000/01/20 17:36:19  king
--| Added idle_actions and internal_idle_actions.
--|
--| Revision 1.10.6.10  1999/12/16 09:20:18  oconnor
--| provide user access to root windows list
--|
--| Revision 1.10.6.9  1999/12/15 05:21:11  oconnor
--| formatting
--|
--| Revision 1.10.6.8  1999/12/15 03:58:46  oconnor
--| use weak refs for global PND list
--|
--| Revision 1.10.6.7  1999/12/14 16:52:56  oconnor
--| renamed EV_PND_SOURCE -> EV_PICK_AND_DROPABLE
--|
--| Revision 1.10.6.6  1999/12/13 19:40:59  oconnor
--| added pnd_targets: LINKED_LIST [EV_PND_TARGET], global list of pnd targets
--|
--| Revision 1.10.6.5  1999/12/07 20:46:36  oconnor
--| revised layout and comments
--|
--| Revision 1.10.6.4  1999/12/03 04:09:24  brendel
--| Added is_initialized as postcondition to initialize.
--|
--| Revision 1.10.6.3  1999/12/01 00:04:41  brendel
--| Deffered -> deferred.
--|
--| Revision 1.10.6.2  1999/11/30 23:55:22  oconnor
--| added process events
--|
--| Revision 1.10.6.1  1999/11/24 17:30:04  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.10.2.4  1999/11/04 23:10:33  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.10.2.3  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
