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

