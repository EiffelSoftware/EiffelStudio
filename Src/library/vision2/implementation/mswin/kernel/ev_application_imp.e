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
 			make as wel_make,
			main_window as silly_main_window
		export
			{NONE} silly_main_window
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

	EV_APPLICATION_ACTION_SEQUENCES_IMP

	WEL_VK_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the application with `an_interface' interface.
		do
			base_make (an_interface)
			set_application (Current)
			create_dispatcher
			create blocking_windows_stack.make (5)
			create all_tooltips.make (2) 
			init_instance
			init_application
			tooltip_delay := no_tooltip_delay_assigned
		end

	launch  is
			-- Start the event loop.
		do
			set_application_main_window (silly_main_window)
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
			if post_launch_actions_internal /= Void then
				post_launch_actions_internal.call ([])
			end
			message_loop
		end

feature -- Access

	key_pressed (virtual_key: INTEGER): BOOLEAN is
			-- Is `virtual_key' currently pressed?
		local
			i: INTEGER
		do
			i := cwin_get_keyboard_state (virtual_key)
				--| The high order bit of i will be set if the key is down.
				--| If the high order bit of an INTEGER is set, then the
				--| value is negative. The correct solution is
				--|	Result := i & 0xF0000000 but this does not work with
				--| 4.5. Julian.
			if i < 0 then
				Result := True
			end
		end

	ctrl_pressed: BOOLEAN is
			-- Is ctrl key currently pressed?
		do
			Result := key_pressed (vk_control)
		end
		
	alt_pressed: BOOLEAN is
			-- Is alt key currently pressed?
		do
			Result := key_pressed (vk_lmenu) or
				key_pressed (vk_rmenu)
		end
		
	shift_pressed: BOOLEAN is
			-- Is shift key currently pressed?
		do
			Result := key_pressed (vk_shift)
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
				done
			loop
				msg.peek_all
				if msg.last_boolean_result then
					process_message (msg)
				else
					if not internal_idle_actions.is_empty then
						internal_idle_actions.call ([])
					elseif idle_actions_internal /= Void and then
						not idle_actions_internal.is_empty then 
						idle_actions_internal.call ([])
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

feature -- Root window

	silly_main_window: EV_INTERNAL_SILLY_WINDOW_IMP is
			-- Current main window of the application.
		once
			--| Previously this would return the first window created
			--| by the user. This forced a window to be created before the
			--| application was launched. Now we set the main window
			--| to an EV_INTERNAL_SILLY_WINDOW_IMP which is never seen by the
			--| User. The application still ends when the last of the user
			--| created windows is destroyed. This now allows and application
			--| to create it's windows from within post_launch_actions and
			--| provides more flexibility.
			create Result.make_top ("Main Window")
		end

feature -- Element change

	add_root_window (w: WEL_FRAME_WINDOW) is
			-- Add `w' to the list of root windows.
		do
			application_windows_id.extend (w.item)
		end

	remove_root_window (w: WEL_FRAME_WINDOW) is
			-- Remove `w' from the root windows list.
		local
			window: WEL_FRAME_WINDOW
		do
			application_windows_id.prune_all (w.item)
			if application_windows_id.is_empty then
				window := silly_main_window
			else
				from
					application_windows_id.start
				until
					application_windows_id.after or else 
					is_window (application_windows_id.item.item)
				loop
					application_windows_id.forth
				end
				check
					not_after: not application_windows_id.after
				end
				window ?= window_of_item (application_windows_id.item.item)
				check
					window_is_assigned_correctly: window /= Void
				end
			end
			set_application_main_window (window)
		end

	window_with_focus: EV_TITLED_WINDOW_IMP
			-- `Result' is EV_TITLED_WINDOW with current focus.
		
	set_window_with_focus (a_window: EV_TITLED_WINDOW) is
			-- Assign implementation of `a_window' to `window_with_focus'.
		local
			win_imp: EV_TITLED_WINDOW_IMP
		do
			win_imp ?= a_window.implementation
			window_with_focus := win_imp
		end

feature {NONE} -- Implementation

	application_windows_id: ARRAYED_LIST [POINTER] is
			-- All user created windows in the application.
			--| For internal use only.
		once
			create Result.make (5)
		ensure
			not_void: Result /= Void
		end

feature {EV_TOOLTIPABLE_IMP} -- Tooltip

	all_tooltips: ARRAYED_LIST [WEL_TOOLTIP]
		-- Result is all tooltips that have been set in the application.
	
feature {EV_ANY_I, EV_INTERNAL_TOOLBAR_IMP}-- Status report

	tooltip_delay: INTEGER
			-- Time in milliseconds before tooltips pop up.

	no_tooltip_delay_assigned: INTEGER is -1
		-- Constant for use with tooltip_delay.

	windows: LINEAR [EV_WINDOW] is
			-- List of current EV_WINDOWs.
			--| This was introduced to allow the previous internal
			--| implementation to be kept although changing the interface.
		local
			ev_win: EV_WINDOW_IMP
			res: ARRAYED_LIST [EV_WINDOW]
		do
			create res.make (application_windows_id.count)
			Result := res
			from
				application_windows_id.start
			until
				application_windows_id.after
			loop
				if is_window (application_windows_id.item) then
					ev_win ?= window_of_item (application_windows_id.item)
					if ev_win /= Void then
						res.extend (ev_win.interface)
						application_windows_id.forth
					else
							-- Object has been collected, we remove it
							-- from `application_windows_id'.
						application_windows_id.remove
					end
				else
						-- Object has been collected, we remove it
						-- from `application_windows_id'.
					application_windows_id.remove
				end
			end
		end

feature {EV_PICK_AND_DROPABLE_IMP} -- Status Report

	pick_and_drop_source: EV_PICK_AND_DROPABLE_IMP
		-- The current pick and drop source.
		--| If `Void' then no pick and drop is currently executing.
		--| This allows us to globally check whether a pick and drop
		--| is executing, and if so, the source.

	transport_started (widget: EV_PICK_AND_DROPABLE_IMP) is
			-- Assign `widget' to `pick_and_drop_source'.
		do
			pick_and_drop_source := widget
		end

	transport_ended is
			-- Assign `Void' to `pick_and_drop_source'.
		do
			pick_and_drop_source := Void
		end

	awaiting_movement: BOOLEAN
		-- Is there a drag and drop awaiting movement, before the transport
		-- really starts?
		--| This allows us to check globally.


	start_awaiting_movement is
			-- Assign `True' to `awaiting_movement'.
		do
			awaiting_movement := True
		end

	end_awaiting_movement is
			-- Assign `False' to `awaiting_movement'.
		do
			awaiting_movement := False
		end

	transport_just_ended: BOOLEAN
		-- Has a pick/drag and drop just ended and we have not
		-- yet recieved the Wm_ncactivate message in the window
		-- where the pick/drag was ended?
		--| When we cancel a pick/drag, we must reset override_movement
		--| ready for the next pick/drag. However, we still want to override
		--| the default processing for the Wm_ncativate message in the window.
		--| This flag has been added only for this case.
	

	set_transport_just_ended is
			-- Assign `True' to `transport_just_ended'.
		do	
			transport_just_ended := True
		end

	clear_transport_just_ended is
			-- Assign `False' to `transport_just_ended'.
		do
			transport_just_ended := False
		end

	override_from_mouse_activate: BOOLEAN
		-- The default_windows behaviour is being overridden from a
		-- the on_wm_mouse_activate windows message.
		-- This should be reset to False at the start of `on_wm_mouse_activate'
		-- and to true when we know we must override the windows movement
		-- within `on_wm_mouse_activate'.

	set_override_from_mouse_activate is
			-- Assign `True' to override_from_mouse_activate.
		do
			override_from_mouse_activate := True
		end

	clear_override_from_mouse_activate is
			-- Assign `False' to override_from_mouse_activate.
		do
			override_from_mouse_activate := False
		end

feature -- Status setting

	set_tooltip_delay (a_delay: INTEGER) is
			-- Assign `a_delay' to `tooltip_delay'.
		do
			tooltip_delay := a_delay
				-- Iterate through all tooltips within application and
				-- call set_initial_delay_time with `a_delay'. 
			from
				all_tooltips.start
			until
				all_tooltips.off
			loop
				all_tooltips.item.set_initial_delay_time (a_delay)
				all_tooltips.forth
			end
		end

feature -- Basic operation

	destroy is
			-- Destroy `Current' (End the application).
		do
			cwin_post_quit_message (0)
			quit_requested := True
			is_destroyed := True
			window_with_focus := Void
		end

feature {NONE} -- WEL Implemenation

	controls_dll: WEL_INIT_COMMCTRL_EX
			-- Needed for loading the common controls dlls.

	rich_edit_dll: WEL_RICH_EDIT_DLL
			-- Needed if the user want to open a rich edit control.

	init_application is
			-- Load the dll needed sometimes.
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
					if not internal_idle_actions.is_empty then
						internal_idle_actions.call ([])
					elseif idle_actions_internal /= Void and then
						not idle_actions_internal.is_empty then 
						idle_actions_internal.call ([])
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
			focused_window: like window_with_focus
		do
			if msg.last_boolean_result then
				if msg.quit then
					quit_requested := True
				else
					focused_window := window_with_focus
					if
						focused_window /= Void and then
						is_dialog (focused_window.wel_item)
					then
							-- It is a dialog window
						msg.process_dialog_message (focused_window.wel_item)
						if not msg.last_boolean_result then
							msg.translate
							msg.dispatch
						end
					else
							-- It is a normal window
						if
							focused_window /= Void and
							focused_window.exists and then
							focused_window.accelerators /= Void
						then
							msg.translate_accelerator (focused_window,
								focused_window.accelerators)
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
			blocking_dispatcher: WEL_DISPATCHER
		do
			create blocking_dispatcher.make
			dispatcher := blocking_dispatcher
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

	cwin_get_keyboard_state (virtual_key: INTEGER): INTEGER is
			-- `Result' is state of `virtual_key'.
		external
			"C [macro <windows.h>] (int): EIF_INTEGER"
		alias
			"GetKeyState"
		end

end -- class EV_APPLICATION_IMP

--|-----------------------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.40  2001/07/14 12:46:24  manus
--| Replace --! by --|
--|
--| Revision 1.39  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.38  2001/06/07 23:08:12  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.16.8.43  2001/06/04 20:19:49  rogers
--| Removed *_alt_pressed as we only have alt_pressed now.
--|
--| Revision 1.16.8.42  2001/05/24 17:57:57  manus
--| Cosmetics
--| Removed reference to `window_with_focus' when destroying EV_APPLICATION.
--|
--| Revision 1.16.8.41  2001/05/18 17:02:42  rogers
--| Removed destroy_just_called.
--|
--| Revision 1.16.8.40  2001/05/01 22:03:01  pichery
--| The first window of the "root window list" may have been created by
--| a precondition in `EV_FRAME.extend' and may be invalid. As a result,
--| we don't set the first window but the first VALID window as main window.
--|
--| Revision 1.16.8.39  2001/04/24 21:55:48  rogers
--| Removed remaining inapliccable features, as none are needed.
--|
--| Revision 1.16.8.38  2001/04/24 21:38:49  rogers
--| Removed iterate as redundent.
--|
--| Revision 1.16.8.37  2001/04/16 17:09:39  manus
--| `window_of_item' has now a new precondition `is_window' that needs to be
--| satisfied when calling it.
--|
--| Revision 1.16.8.36  2001/02/23 17:03:37  rogers
--| Putting `destroy' from `Current' in the close actions of a window was
--| causing `no_calls_after_destroy' to be violated. In run, we now set
--| `destroy_just_called' to `True' which allows the invariant to succeed
--| the next time it is checked.
--|
--| Revision 1.16.8.35  2001/02/19 23:28:14  manus
--| Fixed message loop to handle correctly dialog messages: we were checking the
--| wrong window to figure out if it was a dialog, now we take `window_with_focus'
--| to perform the check.
--|
--| Revision 1.16.8.34  2001/02/17 01:27:17  manus
--| Removed non-needed inheritance to WEL_WINDOW_MANAGER.
--|
--| Revision 1.16.8.33  2001/02/15 18:02:28  rogers
--| Implemented left_alt_pressed and right_alt_pressed. Removed alt_pressed.
--|
--| Revision 1.16.8.32  2001/02/13 19:31:59  rogers
--| Added override_from_mouse_activate, set_override_from_mouse_activate and
--| clear_override_from_mouse_activate. Used to see override windows movement
--| during pick/drag and drops.
--|
--| Revision 1.16.8.31  2001/02/10 00:28:41  rogers
--| Added awaiting_movment, start_awaiting_movement, end_awaiting_movement,
--| transport_just_ended, set_transport_just_ended and
--| clear_transport_just_ended. These features are all used for global
--| querying of the current pick/drag and drop state.
--|
--| Revision 1.16.8.30  2001/01/24 21:08:39  rogers
--| Added key_pressed. ctrl_press, alt_pressed, and shift_pressed now all use
--| this new feature.
--|
--| Revision 1.16.8.29  2000/12/29 15:28:38  pichery
--| Removed the WEL_BLOCKING_DISPATCHER. It is now useless
--| with the new implementation for Dialogs
--|
--| Revision 1.16.8.28  2000/12/08 03:09:43  manus
--| Cosmetics: text was incorrectly tabulated.
--|
--| Revision 1.16.8.27  2000/11/29 00:46:36  rogers
--| Changed empty to is_empty.
--|
--| Revision 1.16.8.26  2000/11/22 19:56:56  rogers
--| Added ctrl_pressed, alt_pressed and shift_pressed for querying these
--| keys. Added cwin_get_keyboard_state for the implementation of these new
--| features.
--|
--| Revision 1.16.8.25  2000/11/14 19:44:13  rogers
--| Tooltip delay is now initialized to a value that should never be assigned
--| to it. This allows us to know whether the used has set the tooltip delay,
--| just by the current value.
--|
--| Revision 1.16.8.24  2000/11/03 23:42:57  rogers
--| Added pick_and_drop_source, transport_started and transport ended. These
--| features provide global access to pnd_status required for escape key
--| checking.
--|
--| Revision 1.16.8.23  2000/11/01 01:38:40  rogers
--| window_with_focus has been changed to EV_TITLED_WINDOW_IMP.
--|
--| Revision 1.16.8.22  2000/10/04 22:23:43  manus
--| Cosmetics
--|
--| Revision 1.16.8.21  2000/10/03 18:31:18  rogers
--| Fixed bug in remove_root_window which would cause contracts to fail.
--| Removed unused local_variables from destroy.
--|
--| Revision 1.16.8.20  2000/10/03 17:54:14  rogers
--| Removed unreferenced variables from destroy.
--|
--| Revision 1.16.8.19  2000/09/07 02:35:27  manus
--| Correct implementation of `windows' which uses `application_windows_id' an ARRAYED_LIST of
--| POINTER that is used as a weak reference access to actual Vision2 implementation object.
--| Now it means that when you call `destroy' it will work and will stop the program. It was
--| not the case before when used in EiffelBench.
--|
--| Revision 1.16.8.18  2000/08/11 19:14:54  rogers
--| Fixed copyright clause. Now use ! instead of |.
--|
--| Revision 1.16.8.17  2000/08/03 23:57:51  rogers
--| All action sequence calls are no longer done through the interface, they
--| use the internal action sequence instead.
--|
--| Revision 1.16.8.16  2000/07/24 23:02:51  rogers
--| Now inherits EV_APPLICATION_ACTION_SEQUENCES_IMP.
--|
--| Revision 1.16.8.15  2000/06/27 22:18:46  rogers
--| Aded all_tooltips which contains all tooltips used in system.
--| Implemented tooltip_delay and set_tooltip_delay.
--|
--| Revision 1.16.8.14  2000/06/15 03:39:32  pichery
--| Moved `blocking_dispatcher_enabled' to make it
--| more visible.
--|
--| Revision 1.16.8.13  2000/06/14 22:25:59  rogers
--| The type of main window has been changed to EV_INTERNAL_SILLY_WINDOW_IMP.
--| This has been changed so that the user can now create all their windows
--| after launch has been called if they require. The previous implemention
--| would not allow this, they had to create at leat one window before
--| launch was called and the rest afterwards. Renamed root_windows to
--| application_windows.
--|
--| Revision 1.16.8.12  2000/06/13 03:58:12  pichery
--| - Fixed bug in `destroy'
--| - made `enable/disable_blocking_dispatcher' visible
--|   for EV_DIALOG_IMP.
--|
--| Revision 1.16.8.11  2000/06/12 19:38:16  rogers
--| Reviewed. Aded appropriate FIXME's. Comments and formatting.
--|
--| Revision 1.16.8.10  2000/06/12 19:16:45  rogers
--| Fixed process_message. Previously if a window with the focus and
--| accelerators was destroyed using the X on the window, then this would
--| cause the message loop to crash as the update of window_with_focus
--| was not performed yet.
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
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
