--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"Eiffel Vision application. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_APPLICATION_IMP
	
inherit
	EV_APPLICATION_I

 	WEL_APPLICATION
 		rename
 			make as wel_make
		redefine
			init_application,
			message_loop,
			create_dispatcher,
			run
 		end

	WEL_CONSTANTS
		export
			{NONE} all
		end

	WEL_ICC_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the application.
		do
			base_make (an_interface)
			set_application (Current)
			create_dispatcher
			create blocking_windows_stack.make (5)
			init_instance
			init_application
		end

	launch  is
			-- Start the event loop.
		do
			set_application_main_window (main_window)
			run
		end

	run is
			-- Create `main_window' and start the message loop.
			--| Redefined so post_launch_actions can be called at
			--| The correct time.
		local
			d: WEL_MAIN_DIALOG
		do
			d ?= application_main_window
			if d /= Void then
				d.activate
			end
			application_main_window.show_with_option (default_show_command)
			interface.post_launch_actions.call ([])
			message_loop
		end


feature -- Basic operation

	process_events is
			-- Process any pending events.
			--| Pass control to the GUI toolkit so that it can
			--| handle any events that may be in its queue.
		local
			msg: WEL_MSG
			done: BOOLEAN
		do
			from
				create msg.make
			until
				done or
					(
					has_blocking_window 
					and (
						blocking_window.is_destroyed or 
						(not blocking_window.is_show_requested)
						)
					)
			loop
				msg.peek_all
				if msg.last_boolean_result then
					process_message (msg)
				else
					if not internal_idle_actions.empty then
						internal_idle_actions.call ([])
					elseif not interface.idle_actions.empty then 
						interface.idle_actions.call ([])
					else
						done := True
					end
				end
			end

				-- Signal to Windows to our thread is now
 				-- idle.
			c_sleep (0)
		end

	sleep (msec: INTEGER) is
			-- Wait for `msec' milliseconds and return.
		do
			c_sleep (msec)
		end

	has_blocking_window: BOOLEAN is
			-- Has the application a blocking window. The blocking 
			-- window is the window that receive user input.
		do
			Result := not blocking_windows_stack.empty
		ensure
			blocking_window_useable:
				Result implies blocking_window /= Void
		end

	blocking_window: EV_WINDOW_IMP
			-- Get the current blocking window. 
			-- The blocking window is the window that 
			-- receive user input and this is the only
			-- one.

feature -- Root window

	main_window: EV_WINDOW_IMP is
			-- Current main window of the application.
		once
			Result ?= root_windows.first.implementation
		end

feature -- Element change

	add_root_window (w: EV_WINDOW) is
			-- Add `w' to the list of root windows.
		do
			root_windows.extend (w)
		end

	remove_root_window (w: EV_WINDOW) is
			-- Remove `w' from the root windows list.
		local
			window: WEL_COMPOSITE_WINDOW
		do
			root_windows.prune_all (w)
			if root_windows.empty then
				cwin_post_quit_message (0)
			else
				window ?= root_windows.first.implementation
				check
					window_is_assigned_correctly: window /= Void
				end
				set_application_main_window (window)
			end
		end

	window_with_focus: EV_WINDOW_IMP
			-- `Result' is EV_WINDOW with current focus.
		
	set_window_with_focus (a_window: EV_WINDOW) is
			-- Assign implementation of `a_window' to `window_with_focus'.
		local
			win_imp: EV_WINDOW_IMP
		do
			win_imp ?= a_window.implementation
			window_with_focus := win_imp
		end

	set_blocking_window (a_window_imp: EV_WINDOW_IMP) is
			-- Set the blocking window to `a_window'. The
			-- blocking window is the window that receive
			-- user input.
		do
			blocking_windows_stack.extend (a_window_imp)
			blocking_window := blocking_windows_stack.item
			if not blocking_dispatcher_enabled then
				enable_blocking_dispatcher
				set_blocking_dispatcher_window (blocking_window)
			end
		ensure
			has_blocking_window: has_blocking_window
			blocking_window_set: equal (blocking_window, a_window_imp)
		end

	remove_blocking_window (a_window: EV_WINDOW_IMP) is
			-- Remove the current blocking window. 
			-- The blocking window is the window that 
			-- receive user input.
		require
			a_window_is_current_blocking_window:
				equal(a_window, blocking_window)
		do
			blocking_windows_stack.remove
			if blocking_windows_stack.empty then
				blocking_window := Void
				disable_blocking_dispatcher
			else
				blocking_window := blocking_windows_stack.item
				set_blocking_dispatcher_window (blocking_window)
			end				
		end

feature -- Status report

	tooltip_delay: INTEGER is
			-- Time in milliseconds before tooltips pop up.
		do
			check
				to_be_implemented: False
			end
		end

feature -- Status setting

	set_tooltip_delay (a_delay: INTEGER) is
			-- Set `tooltip_delay' to `a_delay'.
		do
			check
				to_be_implemented: False
			end
		end

feature -- Basic operation

	destroy is
			-- End the application.
		do
			from
				root_windows.start
			until
				root_windows.empty
			loop
				root_windows.item.destroy
			end
			quit_requested := True
			destroy_just_called := True
			is_destroyed := True
		end

feature {NONE} -- WEL Implemenation

	controls_dll: WEL_INIT_COMMCTRL_EX
			-- Needed for loading the common controls dlls.

	rich_edit_dll: WEL_RICH_EDIT_DLL
			-- Needed if the user want to open a rich edit.

	init_application is
			-- Load the dll needed sometimes
		do
			create controls_dll.make_with_flags (Icc_userex_classes
					+ Icc_win95_classes + Icc_cool_classes
					+ Icc_bar_classes + Icc_updown_class)
			create rich_edit_dll.make
		end

feature {NONE} -- Implementation

	blocking_windows_stack: ARRAYED_STACK [EV_WINDOW_IMP]
			-- Windows that are bloking window. The top
			-- window represent the window that is the
			-- real current blocking window.

	message_loop is
			-- Windows message loop.
			--| Redefined to add accelerator functionality.
		local
			msg: WEL_MSG
		do
			from
				create msg.make
			until
				quit_requested
			loop
				msg.peek_all
				if msg.last_boolean_result then
					process_message (msg)
				else
					if not internal_idle_actions.empty then
						internal_idle_actions.call ([])
					elseif not interface.idle_actions.empty then 
						interface.idle_actions.call ([])
					else
						msg.wait
					end
				end
			end
		end

	quit_requested: BOOLEAN
			-- Has a Wm_quit message been processed?
			-- Or has destroy been called?

	process_message (msg: WEL_MSG) is
			-- Dispatch `msg'.
			--| Different from WEL because of accelerators.
		local
			dlg: POINTER
		do
			if msg.last_boolean_result then
				if msg.quit then
					quit_requested := True
				else
					dlg := cwin_get_last_active_popup (main_window.wel_item)
					if is_dialog (dlg) then
						-------------------------------------------
						-- A Window Dialog is Present 
						-------------------------------------------
						msg.process_dialog_message (dlg)
						if not msg.last_boolean_result then
							msg.translate
							msg.dispatch
						end
					else
						-------------------------------------------
						-- No Dialog is Present, Default behaviour
						-------------------------------------------
					if window_with_focus /= Void and then window_with_focus.accelerators /= Void then
						msg.translate_accelerator (window_with_focus,
							window_with_focus.accelerators)
						if not msg.last_boolean_result then
							msg.translate
							msg.dispatch
						end
					else
						msg.translate
						msg.dispatch
					end
					end
				end
			end
		end

feature {NONE} -- Blocking Dispatcher

	create_dispatcher is
			-- Create the `dispatcher'.
		local
			blocking_dispatcher: WEL_BLOCKING_DISPATCHER
		do
			create blocking_dispatcher.make
			dispatcher := blocking_dispatcher
		end

	enable_blocking_dispatcher is
		local
			blocking_dispatcher: WEL_BLOCKING_DISPATCHER
		do
			blocking_dispatcher ?= dispatcher
			blocking_dispatcher.enable_blocking_dispatcher
		end

	blocking_dispatcher_enabled: BOOLEAN is
		local
			blocking_dispatcher: WEL_BLOCKING_DISPATCHER
		do
			blocking_dispatcher ?= dispatcher
			Result := blocking_dispatcher.blocking_dispatcher_enabled
		end

	disable_blocking_dispatcher is
		local
			blocking_dispatcher: WEL_BLOCKING_DISPATCHER
		do
			blocking_dispatcher ?= dispatcher
			blocking_dispatcher.disable_blocking_dispatcher
		end

	set_blocking_dispatcher_window (a_window: WEL_WINDOW) is
		local
			blocking_dispatcher: WEL_BLOCKING_DISPATCHER
		do
			blocking_dispatcher ?= dispatcher
			blocking_dispatcher.set_blocking_dispatcher_window (a_window)
		end

	remove_blocking_dispatcher_window is
		local
			blocking_dispatcher: WEL_BLOCKING_DISPATCHER
		do
			blocking_dispatcher ?= dispatcher
			blocking_dispatcher.remove_blocking_dispatcher_window
		end

	blocking_dispatcher_window: WEL_WINDOW is
		local
			blocking_dispatcher: WEL_BLOCKING_DISPATCHER
		do
			blocking_dispatcher ?= dispatcher
			Result := blocking_dispatcher.blocking_dispatcher_window
		end
	
feature {NONE} -- Inapplicable

	iterate is
			-- Loop the application.
			-- Already done by WEL : do nothing.
        do
			check
				Do_nothing: True
			end
        end

	on_accelerator_command (id: INTEGER) is
			-- The `acelerator_id' has been activated.
		do
			check
				Inapplicable: False
			end
		end

	parent_imp: EV_CONTAINER_IMP is
			-- Parent of the current widget.
		do
			check
				Inapplicable: False
			end
		end

	wrong_application: CELL [EV_APPLICATION_IMP] is
			-- The current application. Needed for the
			-- accelerators.
		do
			check
				Inapplicable: False
			end
		end

	focus_on_widget: CELL [EV_WIDGET_IMP] is
			-- Widget that currently have the focus.
		do
			check
				Inapplicable: False
			end
 		end

feature {NONE} -- Externals

	c_sleep (v: INTEGER) is
			-- Sleep for `v' milliseconds.
		external
			"C | <winbase.h>"
		alias
			"Sleep"
		end

	cwin_post_quit_message (exit_code: INTEGER) is
			-- SDK PostQuitMessage.
		external
			"C [macro <wel.h>] (int)"
		alias
			"PostQuitMessage"
		end

end -- class EV_APPLICATION_IMP

--|-----------------------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.37  2000/06/07 17:27:53  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.16.8.9  2000/05/23 18:24:14  rogers
--| Fixed bug in remove_root_window where removing the main_window would
--| cause the execution to finish as the removed window would then be set as
--| the main_window again. Now passes the first window in root_windows to
--| set_application_main_window.
--|
--| Revision 1.16.8.8  2000/05/19 23:33:27  rogers
--| Added set_window_with_focus. Window_with_focus is now an attribute. This
--| fixes a bug where windows brought to the front with a click on one of their
--| children, would not recieve the keyboard accelerators correctly.
--|
--| Revision 1.16.8.7  2000/05/17 20:33:50  rogers
--| Added window_with_focus which returns application window which currently
--| has the focus, and keyboard accelerators are now always passed to
--| the window_with_focus.
--|
--| Revision 1.16.8.6  2000/05/17 19:39:10  rogers
--| Process_message now will check for an accelerator being pressed.
--| Only works for main_window currently.
--|
--| Revision 1.16.8.5  2000/05/15 23:27:35  rogers
--| Redefined run from WEL_APPLICATION so the post_launch_actions can be called
--| at the correct time. Previously, they were called before the first window
--| was displayed.
--|
--| Revision 1.16.8.4  2000/05/14 07:39:05  pichery
--| Changed blocking window implementation. This is
--| now done in the class WEL_BLOCKING_DISPATCHER.
--|
--| Revision 1.16.8.3  2000/05/13 03:26:32  pichery
--| Reimplementation `process_messages'
--|
--| Revision 1.16.8.2  2000/05/09 19:24:00  pichery
--| Added unauthorized message `Wm_mouseleave'.
--| Modified `process_events' to take into account blocking
--| windows.
--|
--| Revision 1.16.8.1  2000/05/03 19:09:12  oconnor
--| mergred from HEAD
--|
--| Revision 1.36  2000/05/03 00:32:08  pichery
--| Merged class EV_APPLICATION_IMP and
--| EV_MODAL_EMULATION_IMP.
--|
--| Revision 1.35  2000/04/26 16:28:42  brendel
--| Added call to post_launch_actions.
--|
--| Revision 1.34  2000/04/24 17:43:19  rogers
--| Comments, formatting.
--|
--| Revision 1.33  2000/04/20 18:26:54  brendel
--| Cleanup.
--| Application quits when every window is destroyed.
--| Every window is destroyed and app quits when destroy gets called.
--|
--| Revision 1.32  2000/04/20 00:40:47  brendel
--| process_events now also uses extended message processing that message
--| loop has.
--|
--| Revision 1.31  2000/04/13 19:36:14  brendel
--| Improved add_root_window and remove_root_window.
--| When destroy is called, wipes out root_windows.
--| Application exits when root_windows empty.
--|
--| Revision 1.30  2000/04/11 18:14:33  brendel
--| First window is now shown after postlaunch actions.
--|
--| Revision 1.29  2000/04/10 16:11:50  brendel
--| Reverted wrong implementation of message_loop.
--|
--| Revision 1.28  2000/04/06 00:04:50  brendel
--| message_loop now ends when destroyed.
--|
--| Revision 1.27  2000/04/03 17:50:13  rogers
--| Redefined run from WEL_APPLICATION to avoid `first_window'
--| being shown automatically.
--|
--| Revision 1.26  2000/03/29 20:33:48  brendel
--| Implemented post_launch_actions.
--|
--| Revision 1.25  2000/03/23 19:03:52  brendel
--| Removed once_idle_actions.
--|
--| Revision 1.24  2000/03/23 18:20:20  brendel
--| Implemented once_idle_actions in new way.
--|
--| Revision 1.23  2000/03/21 02:23:11  brendel
--| First implementation of accelerators. Takes only `first_window'. The
--| rest is to be implemented.
--|
--| Revision 1.22  2000/03/16 23:26:10  brendel
--| Formatting.
--| Tried something with accelerators.
--|
--| Revision 1.21  2000/03/14 03:02:53  brendel
--| Merged changed from WINDOWS_RESIZING_BRANCH.
--|
--| Revision 1.20.2.2  2000/03/14 00:17:49  brendel
--| Improved comment.
--|
--| Revision 1.20.2.1  2000/03/14 00:05:10  brendel
--| Added `do_once_on_idle'.
--| Added `once_idle_actions', called and cleared on idle.
--|
--| Revision 1.20  2000/02/29 19:21:27  rogers
--| Launch now sets the root_window to the main_window.
--| Set root_window now sets the application main_window.
--| Remove window has been altered, see diffs, and destroy now sets
--|destroy just called to True and is_destroyed to True.
--|
--| Revision 1.18  2000/02/19 05:44:59  oconnor
--| released
--|
--| Revision 1.17  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.16.10.9  2000/01/29 01:13:30  brendel
--| Added not yet implemented features for tooltips.
--|
--| Revision 1.16.10.8  2000/01/27 19:30:09  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.16.10.7  2000/01/26 18:34:10  brendel
--| Added feature `sleep'.
--|
--| Revision 1.16.10.6  2000/01/25 17:37:51  brendel
--| Removed code associated with old events.
--| Implementation and more removal is needed.
--|
--| Revision 1.16.10.5  2000/01/20 17:36:20  king
--| Added idle_actions and internal_idle_actions.
--|
--| Revision 1.16.10.4  1999/12/17 17:28:05  rogers
--| Altered to fit in with the review branch. Make takes an interface.
--|
--| Revision 1.16.10.3  1999/12/01 00:21:20  oconnor
--| partial implementation of process_events
--|
--| Revision 1.16.10.2  1999/11/30 23:58:17  oconnor
--| added process_events
--|
--| Revision 1.16.10.1  1999/11/24 17:30:17  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.16.6.3  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
