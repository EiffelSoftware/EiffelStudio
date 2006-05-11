indexing
	description:
		"Eiffel Vision application. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			message_loop
 		end

	WEL_CONSTANTS
		export
			{NONE} all
		end

	WEL_ICC_CONSTANTS
		export
			{NONE} all
		end

	WEL_TOOLTIP_CONSTANTS
		export
			{NONE} all
		end

	WEL_WORD_OPERATIONS
		export
			{NONE} all
		end

	EV_APPLICATION_ACTION_SEQUENCES_IMP

	WEL_VK_CONSTANTS

	WEL_WINDOWS_VERSION
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the application with `an_interface' interface.
		local
			l_result: BOOLEAN
		do
			base_make (an_interface)
			set_application (Current)
			create_dispatcher
			create blocking_windows_stack.make (5)
			create all_tooltips.make (2)
			init_instance
			init_application
			tooltip_delay := no_tooltip_delay_assigned

				-- This is a hack to ensure that `silly_main_window' exists before
				-- we create any widgets. If this is not the case, then `themes_active' fails
				-- during creation of the widgets, and those widgets created before a window
				-- end up with a null theme handle.
			l_result := silly_main_window.is_inside
			cwin_disable_xp_ghosting
				-- Initialize the theme drawer to the correct version for
				-- the current platform.
			update_theme_drawer
			dispatcher.set_exception_callback (agent on_exception_action)

			create theme_window.make
		end

	launch  is
			-- Start the event loop.
		do
			set_application_main_window (silly_main_window)
			call_post_launch_actions
			message_loop
		end

feature -- Access

	all_tooltips: ARRAYED_LIST [POINTER]
		-- Result is all tooltips that have been set in the application.

	key_pressed (virtual_key: INTEGER): BOOLEAN is
			-- Is `virtual_key' currently pressed?
		do
			Result := cwin_get_keyboard_state (virtual_key) < 0
				--| The high order bit of i will be set if the key is down.
				--| If the high order bit of an INTEGER is set, then the
				--| value is negative. The correct solution is
				--|	Result := i & 0xF0000000 but this does not work with
				--| 4.5. Julian.
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
		do
			from
				create msg.make
				msg.peek_all
			until
				not msg.last_boolean_result
			loop
				process_message (msg)
				msg.peek_all
			end
		end

	sleep (msec: INTEGER) is
			-- Wait for `msec' milliseconds and return.
		do
			c_sleep (msec)
		end

	lock is
			-- Lock the Mutex.
		do
		end

	try_lock: BOOLEAN is
			-- Try to see if we can lock, False means no lock could be attained
		do
			Result := True
		end

	unlock is
			-- Unlock the Mutex.
		do
		end

feature -- Root window

	Silly_main_window: EV_INTERNAL_SILLY_WINDOW_IMP is
			-- Current main window of the application.
		once
			--| Previously this would return the first window created
			--| by the user. This forced a window to be created before the
			--| application was launched. Now we set the main window
			--| to an EV_INTERNAL_SILLY_WINDOW_IMP which is never seen by the
			--| User. The application still ends when the last of the user
			--| created windows is destroyed. This now allows an application
			--| to create it's windows from within post_launch_actions and
			--| provides more flexibility.
			create Result.make_top ("Main Window")
			Result.move (0, 0)
		end

feature -- Element change

	add_root_window (w: WEL_FRAME_WINDOW) is
			-- Add `w' to the list of root windows.
		do
				-- Initialize the theme drawer to the correct version for
				-- the current platform. This needs to be performed after a window
				-- is added to the system as otherwise a call to `themes_active' is False.
			update_theme_drawer
			Application_windows_id.extend (w.item)
		end

	remove_root_window (w: WEL_FRAME_WINDOW) is
			-- Remove `w' from the root windows list.
		do
			Application_windows_id.prune_all (w.item)
		end

	window_with_focus: EV_TITLED_WINDOW_IMP
			-- `Result' is EV_TITLED_WINDOW with current focus.

	set_window_with_focus (a_window: EV_TITLED_WINDOW) is
			-- Assign implementation of `a_window' to `window_with_focus'.
		local
			win_imp: EV_TITLED_WINDOW_IMP
		do
			if a_window /= Void then
				win_imp ?= a_window.implementation
				window_with_focus := win_imp
			else
				window_with_focus := Void
			end
		end

feature {NONE} -- Implementation

	Application_windows_id: ARRAYED_LIST [POINTER] is
			-- All user created windows in the application.
			--| For internal use only.
		once
			create Result.make (5)
		ensure
			not_void: Result /= Void
		end

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
			create res.make (Application_windows_id.count)
			Result := res
			from
				Application_windows_id.start
			until
				Application_windows_id.after
			loop
				if is_window (Application_windows_id.item) then
					ev_win ?= window_of_item (Application_windows_id.item)
					if ev_win /= Void then
						res.extend (ev_win.interface)
						Application_windows_id.forth
					else
							-- Object has been collected, we remove it
							-- from `Application_windows_id'.
						Application_windows_id.remove
					end
				else
						-- Object has been collected, we remove it
						-- from `Application_windows_id'.
					Application_windows_id.remove
				end
			end
		end

feature {EV_BUTTON_IMP, EV_WEL_CONTROL_CONTAINER_IMP, EV_PRIMITIVE_IMP, EV_CONTAINER_IMP} -- Theme drawing

	theme_drawer: EV_THEME_DRAWER_IMP
			-- `Result' is object suitable for drawing using the
			-- currently selected themes.

	update_theme_drawer is
			-- Updated `theme_drawer' to use current Windows settings.
		do
			if themes_active then
				create {EV_XP_THEME_DRAWER_IMP} theme_drawer
			else
				create {EV_CLASSIC_THEME_DRAWER_IMP} theme_drawer
			end
		end

	set_theme_drawer (drawer: EV_THEME_DRAWER_IMP) is
			-- Assign `drawer' to `theme_drawer'.
		require
			drawer_not_void: drawer /= Void
		do
			theme_drawer := drawer
		ensure
			drawer_set: theme_drawer = drawer
		end

	themes_active: BOOLEAN is
			-- Are themes currently active?
		do
			Result := uxtheme_dll_available and then cwin_is_theme_active and then cwin_is_app_themed and then comctl32_version >= version_600
		end

	uxtheme_dll_available: BOOLEAN is
			-- Is the "uxtheme.dll" required for theme support available on the current platform?
		local
			dll: WEL_DLL
		once
			create dll.make ("uxtheme.dll")
			Result := dll.exists
		end

feature {EV_ANY_I, EV_PICK_AND_DROPABLE_IMP, EV_INTERNAL_COMBO_FIELD_IMP} -- Status Report

	pick_and_drop_source: EV_PICK_AND_DROPABLE_IMP
		-- The current pick and drop source.
		--| If `Void' then no pick and drop is currently executing.
		--| This allows us to globally check whether a pick and drop
		--| is executing, and if so, the source.

	drop_actions_executing: BOOLEAN
		-- Are the `drop_actions' for a pick and dropable object currently executing?

	dockable_source: EV_DOCKABLE_SOURCE_IMP
		-- The current dockable source if a dock is executing.

feature {EV_PICK_AND_DROPABLE_IMP, EV_DOCKABLE_SOURCE_IMP} -- Status Report

	enable_drop_actions_executing is
			-- Assign `True' to `drop_actions_executing'.
		do
			drop_actions_executing := True
		ensure
			drop_actions_executing: drop_actions_executing
		end

	disable_drop_actions_executing is
			-- Assign `False' to `drop_actions_executing'.
		do
			drop_actions_executing := False
		ensure
			drop_actions_not_executing: not drop_actions_executing
		end

	dock_started (source: EV_DOCKABLE_SOURCE_IMP) is
			-- Assign `source' to `dockable_source'.
		require
			source_not_void: source /= Void
		do
			dockable_source := source
		ensure
			source_set: dockable_source = source
		end

	dock_ended is
			-- Ensure `dockable_source' is Void.
		do
			dockable_source := Void
		ensure
			dockable_source = Void
		end

	transport_started (widget: EV_PICK_AND_DROPABLE_IMP) is
			-- Assign `widget' to `pick_and_drop_source'.
		require
			widget_not_void: widget /= Void
		do
			pick_and_drop_source := widget
		ensure
			source_set: pick_and_drop_source = widget
		end

	transport_ended is
			-- Assign `Void' to `pick_and_drop_source'.
		do
			pick_and_drop_source := Void
		ensure
			pick_and_drop_source = Void
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
		local
			l_wel_tooltip: WEL_TOOLTIP
			l_hwnd: POINTER
		do
			tooltip_delay := a_delay
				-- Iterate through all tooltips within application and
				-- call set_initial_delay_time with `a_delay'.
			from
				all_tooltips.start
			until
				all_tooltips.off
			loop
				l_hwnd := all_tooltips.item
				if l_hwnd /= default_pointer and then is_window (l_hwnd) then
					l_wel_tooltip ?= window_of_item (l_hwnd)
					if l_wel_tooltip /= Void then
						cwin_send_message (l_wel_tooltip.item, Ttm_setdelaytime,
							cwel_integer_to_pointer (Ttdt_initial), cwin_make_long (a_delay, 0))
						all_tooltips.forth
					else
							-- Object has been collected, we remove it
							-- from `all_tooltips'.
						all_tooltips.remove
					end
				else
						-- Object has been collected, we remove it
						-- from `all_tooltips'.
					all_tooltips.remove
				end
			end
		end

feature -- Basic operation

	destroy is
			-- Destroy `Current' (End the application).
		do
			cwin_post_quit_message (0)
			quit_requested := True
			set_is_destroyed (True)
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
			create controls_dll.make_with_flags (Icc_win95_classes |
				Icc_date_classes | Icc_userex_classes | Icc_cool_classes)
			create rich_edit_dll.make
		end

feature {NONE} -- Implementation

	theme_window: EV_THEME_WINDOW
			-- Window with responsibility for notify `theme_changed_actions'.

	blocking_windows_stack: ARRAYED_STACK [EV_WINDOW_IMP]
			-- Windows that are blocking window. The top
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
					call_idle_actions
					relinquish_cpu_slice
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
							if focused_window.accelerators /= Void then
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

	process_events_until_stopped is
			-- Process all events until 'stop_processing' is called.
		local
			msg: WEL_MSG
		do
			from
				create msg.make
				msg.peek_all
				stop_processing_requested := False
			until
				stop_processing_requested
			loop
				msg.peek_all
				if msg.last_boolean_result then
					process_message (msg)
				else
					call_idle_actions
					relinquish_cpu_slice
				end
			end
		end

	stop_processing is
			--  Exit `process_events_until_stopped'.
		do
			stop_processing_requested := True
		end

feature {NONE} -- Externals

	cwin_disable_xp_ghosting is
			-- Disable XP ghosting.
		external
			"C inline use <windows.h>"
		alias
			"[
			{
				FARPROC disable_ghosting = NULL;
				HMODULE user32_module = LoadLibrary (L"user32.dll");
				if (user32_module) {
					disable_ghosting = GetProcAddress (user32_module, "DisableProcessWindowsGhosting");
					if (disable_ghosting) {
						(FUNCTION_CAST_TYPE(void,WINAPI,(void)) disable_ghosting) ();
					}
				}
			}
			]"
		end

	cwin_register_window_message (message_name: POINTER): INTEGER is
			-- Register a custom window message named `message_name'.
			-- `Result' is id of new message.
		external
			"C [macro <windows.h>] (LPCTSTR): EIF_INTEGER"
		alias
			"RegisterWindowMessage"
		end

	c_sleep (v: INTEGER) is
			-- Sleep for `v' milliseconds.
		external
			"C [macro <windows.h>] (DWORD)"
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

	cwin_send_message (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER) is
			-- SDK SendMessage (without the result)
		external
			"C [macro %"wel.h%"] (HWND, UINT, WPARAM, LPARAM)"
		alias
			"SendMessage"
		end

	cwin_post_message (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER) is
			-- SDK PostMessage (without the result)
		external
			"C [macro %"wel.h%"] (HWND, UINT, WPARAM, LPARAM)"
		alias
			"PostMessage"
		end

	frozen cwel_integer_to_pointer (i: INTEGER): POINTER is
			-- Converts an integer `i' to a pointer
		external
			"C [macro <wel.h>] (EIF_INTEGER): EIF_POINTER"
		end

	cwin_is_theme_active: BOOLEAN is
			-- SDK's Open
		external
			"dllwin %"uxtheme.dll%" signature (): EIF_BOOLEAN use <windows.h>"
		alias
			"IsThemeActive"
		end

	cwin_is_app_themed: BOOLEAN is
			-- SDK's Open
		external
			"dllwin %"uxtheme.dll%" signature (): EIF_BOOLEAN use <windows.h>"
		alias
			"IsAppThemed"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_APPLICATION_IMP

