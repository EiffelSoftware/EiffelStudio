note
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
		redefine
			wait_for_input,
			make
		end

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

	WEL_SHARED_METRICS

create
	make

feature -- Initialization

	make
			-- Create the application with `an_interface' interface.
		local
			l_result: INTEGER
			l_process: POINTER
		do
			Precursor
			if {PLATFORM}.is_thread_capable then
				create idle_action_mutex.make
			end
			create blocking_windows_stack.make (5)
			init_instance
			init_application
			tooltip_delay := no_tooltip_delay_assigned

				-- This is a hack to ensure that `silly_main_window' exists before
				-- we create any widgets. If this is not the case, then `themes_active' fails
				-- during creation of the widgets, and those widgets created before a window
				-- end up with a null theme handle.
			silly_main_window.do_nothing
			cwin_disable_xp_ghosting
				-- Initialize the theme drawer to the correct version for
				-- the current platform.
			update_theme_drawer
			dispatcher.set_exception_callback (agent on_exception_action)

			create reusable_message.make
			set_capture_type ({EV_APPLICATION_IMP}.capture_heavy)
			set_application_main_window (silly_main_window)

				-- Get HANDLE to current process.
				-- 0x2 stands for `DUPLICATE_SAME_ACCESS'.
			l_process := {WEL_API}.get_current_process
			l_result := {WEL_API}.duplicate_handle (l_process, l_process, l_process, $l_process, 0, False, 0x2)
			check l_result_good: l_result /= 0 end
			process_handle := l_process

			set_application (Current)
		end

feature -- Access

	key_pressed (virtual_key: INTEGER): BOOLEAN
			-- Is `virtual_key' currently pressed?
		do
			Result := (cwin_get_keyboard_state (virtual_key) & 0xF000) = 0xF000
		end

	key_toggled (virtual_key: INTEGER): BOOLEAN
			-- Is `virtual_key' currently toggled?
		do
			Result := (cwin_get_keyboard_state (virtual_key) & 0x0001) = 0x0001
		end

	ctrl_pressed: BOOLEAN
			-- Is ctrl key currently pressed?
		do
			Result := key_pressed (vk_control)
		end

	alt_pressed: BOOLEAN
			-- Is alt key currently pressed?
		do
			Result := key_pressed (vk_lmenu) or
				key_pressed (vk_rmenu)
		end

	shift_pressed: BOOLEAN
			-- Is shift key currently pressed?
		do
			Result := key_pressed (vk_shift)
		end

	caps_lock_on: BOOLEAN
			-- Is the caps lock key currently on?
		do
			Result := key_toggled (vk_capital)
		end

	is_display_remote: BOOLEAN
			-- Is display for application remote?
		do
			Result := metrics.is_remote_session
		end

feature -- Basic operation

	process_graphical_events
			-- Process any pending paint messages.
			--| Pass control to the GUI toolkit so that it can
			--| handle any paint events that may be in its queue.
		local
			msg: WEL_MSG
		do
			from
				create msg.make
				msg.peek_paint_messages
			until
				not msg.last_boolean_result
			loop
				process_message (msg)
				msg.peek_paint_messages
			end
		end

	sleep (msec: INTEGER)
			-- Wait for `msec' milliseconds and return.
		do
			c_sleep (msec)
		end

	lock
			-- Lock the Mutex.
		do
			if idle_action_mutex /= Void then
				idle_action_mutex.lock
			end
		end

	try_lock: BOOLEAN
			-- Try to see if we can lock, False means no lock could be attained
		do
			if idle_action_mutex /= Void then
				Result := idle_action_mutex.try_lock
			else
					-- Return true if mono-threaded.
				Result := True
			end
		end

	unlock
			-- Unlock the Mutex.
		do
			if idle_action_mutex /= Void then
				idle_action_mutex.unlock
			end
		end

feature {NONE} -- Thread implementation

	idle_action_mutex: detachable MUTEX note option: stable attribute end
			-- Mutex used to access idle_actions.

feature -- Root window

	Silly_main_window: EV_INTERNAL_SILLY_WINDOW_IMP
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

	add_root_window (w: WEL_FRAME_WINDOW)
			-- Add `w' to the list of root windows.
		do
				-- Initialize the theme drawer to the correct version for
				-- the current platform. This needs to be performed after a window
				-- is added to the system as otherwise a call to `themes_active' is False.
			update_theme_drawer
			Application_windows_id.extend (w.item)
		end

	remove_root_window (w: WEL_FRAME_WINDOW)
			-- Remove `w' from the root windows list.
		do
			Application_windows_id.prune_all (w.item)
		end

	window_with_focus: detachable EV_WINDOW_IMP
			-- `Result' is EV_WINDOW with current focus.

	set_window_with_focus (a_window: detachable EV_WINDOW_IMP)
			-- Assign implementation of `a_window' to `window_with_focus'.
		do
			window_with_focus := a_window
		end

feature {NONE} -- Implementation

	Application_windows_id: ARRAYED_LIST [POINTER]
			-- All user created windows in the application.
			--| For internal use only.
		note
			once_status: global
		once
			create Result.make (5)
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I}-- Status report

	tooltip_delay: INTEGER
			-- Time in milliseconds before tooltips pop up.

	no_tooltip_delay_assigned: INTEGER = -1
		-- Constant for use with tooltip_delay.

	windows: LINEAR [EV_WINDOW]
			-- List of current EV_WINDOWs.
			--| This was introduced to allow the previous internal
			--| implementation to be kept although changing the interface.
		local
			ev_win: detachable EV_WINDOW_IMP
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
						res.extend (ev_win.attached_interface)
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

feature {EV_ANY_HANDLER, EV_WEL_CONTROL_CONTAINER_IMP, EV_WIDGET_IMP, WEL_ANY} -- Theme drawing

	theme_drawer: EV_THEME_DRAWER_IMP
			-- `Result' is object suitable for drawing using the
			-- currently selected themes.

	update_theme_drawer
			-- Updated `theme_drawer' to use current Windows settings.
		do
			if themes_active then
				create {EV_XP_THEME_DRAWER_IMP} theme_drawer
			else
				create {EV_CLASSIC_THEME_DRAWER_IMP} theme_drawer
			end
		end

	set_theme_drawer (drawer: EV_THEME_DRAWER_IMP)
			-- Assign `drawer' to `theme_drawer'.
		require
			drawer_not_void: drawer /= Void
		do
			theme_drawer := drawer
		ensure
			drawer_set: theme_drawer = drawer
		end

	themes_active: BOOLEAN
			-- Are themes currently active?
		do
			Result := uxtheme_dll_available and then cwin_is_theme_active and then cwin_is_app_themed and then comctl32_version >= version_600
		end

	uxtheme_dll_available: BOOLEAN
			-- Is the "uxtheme.dll" required for theme support available on the current platform?
		local
			dll: WEL_DLL
		once
			create dll.make ("uxtheme.dll")
			Result := dll.exists
		end

feature {EV_ANY_I, EV_PICK_AND_DROPABLE_IMP, EV_INTERNAL_COMBO_FIELD_IMP} -- Status Report

	pick_and_drop_source: detachable EV_PICK_AND_DROPABLE_IMP
		-- The current pick and drop source.
		--| If `Void' then no pick and drop is currently executing.
		--| This allows us to globally check whether a pick and drop
		--| is executing, and if so, the source.

	drop_actions_executing: BOOLEAN
		-- Are the `drop_actions' for a pick and dropable object currently executing?

	dockable_source: detachable EV_DOCKABLE_SOURCE_IMP
		-- The current dockable source if a dock is executing.

feature {EV_PICK_AND_DROPABLE_IMP, EV_DOCKABLE_SOURCE_IMP} -- Status Report

	enable_drop_actions_executing
			-- Assign `True' to `drop_actions_executing'.
		do
			drop_actions_executing := True
		ensure
			drop_actions_executing: drop_actions_executing
		end

	disable_drop_actions_executing
			-- Assign `False' to `drop_actions_executing'.
		do
			drop_actions_executing := False
		ensure
			drop_actions_not_executing: not drop_actions_executing
		end

	dock_started (source: EV_DOCKABLE_SOURCE_IMP)
			-- Assign `source' to `dockable_source'.
		require
			source_not_void: source /= Void
		do
			dockable_source := source
		ensure
			source_set: dockable_source = source
		end

	dock_ended
			-- Ensure `dockable_source' is Void.
		do
			dockable_source := Void
		ensure
			dockable_source = Void
		end

	transport_started (widget: EV_PICK_AND_DROPABLE_IMP)
			-- Assign `widget' to `pick_and_drop_source'.
		require
			widget_not_void: widget /= Void
		do
			pick_and_drop_source := widget
		ensure
			source_set: pick_and_drop_source = widget
		end

	transport_ended
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


	start_awaiting_movement
			-- Assign `True' to `awaiting_movement'.
		do
			awaiting_movement := True
		end

	end_awaiting_movement
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

	set_transport_just_ended
			-- Assign `True' to `transport_just_ended'.
		do
			transport_just_ended := True
		end

	clear_transport_just_ended
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

	set_override_from_mouse_activate
			-- Assign `True' to override_from_mouse_activate.
		do
			override_from_mouse_activate := True
		end

	clear_override_from_mouse_activate
			-- Assign `False' to override_from_mouse_activate.
		do
			override_from_mouse_activate := False
		end

feature -- Status reports

	capture_type: INTEGER
			-- Type of capture to use when capturing the mouse.
			-- See constants Capture_xxxx at the end of the class.
		do
			Result := internal_capture_type.item
		ensure
			valid_result: Result = Capture_normal or
						  Result = Capture_heavy
		end

feature -- Status setting

	set_tooltip_delay (a_delay: INTEGER)
			-- Assign `a_delay' to `tooltip_delay'.
		do
			tooltip_delay := a_delay
			internal_tooltip.set_initial_delay_time (a_delay)
		end

	set_capture_type (a_capture_type: INTEGER)
			-- Set the type of capture to use when capturing the
			-- mouse to `a_capture_type'.
			-- See constants Capture_xxxx at the end of the class
		require
			valid_capture_type: a_capture_type = Capture_normal or
								a_capture_type = Capture_heavy
		do
			internal_capture_type.put (a_capture_type)
		ensure
			valid_capture: capture_type = Capture_normal or
						   capture_type = Capture_heavy
		end

feature -- Basic operation

	destroy
			-- Destroy `Current' (End the application).
		local
			l_result: INTEGER
		do
			cwin_post_quit_message (0)
			set_is_destroyed (True)
			window_with_focus := Void
			destroy_actions.call (Void)
				-- Destroy `process_handle'
			l_result := {WEL_API}.close_handle (process_handle)
			check l_result_ok: l_result /= 0 end
			process_handle := default_pointer
		end

feature -- Tooltips

	internal_tooltip: WEL_TOOLTIP
			-- WEL_TOOLTIP used internally by current.
		once
			create Result.make (silly_main_window, -1)
			Result.set_max_tip_width (32000)
			Result.activate
				-- Set the inital time delay for the tooltip.
			Result.set_initial_delay_time (tooltip_delay)
		ensure
			internal_tooltip_not_void: Result /= Void
		end

feature {NONE} -- WEL Implemenation

	controls_dll: WEL_INIT_COMMCTRL_EX
			-- Needed for loading the common controls dlls.

	rich_edit_dll: WEL_RICH_EDIT_DLL
			-- Needed if the user want to open a rich edit control.

	init_application
			-- Load the dll needed sometimes.
		do
			create controls_dll.make_with_flags (Icc_win95_classes |
				Icc_date_classes | Icc_userex_classes | Icc_cool_classes)
			create rich_edit_dll.make
		end

feature {NONE} -- Implementation

	theme_window: EV_THEME_WINDOW
			-- Window with responsibility for notify `theme_changed_actions'.
		once
			create Result.make
		end

	blocking_windows_stack: ARRAYED_STACK [EV_WINDOW_IMP]
			-- Windows that are blocking window. The top
			-- window represent the window that is the
			-- real current blocking window.

	message_loop
			-- Windows message loop.
		do
			-- Not applicable with Vision2
		end

	reusable_message: WEL_MSG
			-- Reusable message object.

	process_underlying_toolkit_event_queue
			-- Process event queue from underlying toolkit.
		local
			msg: WEL_MSG
		do
			from
				msg := reusable_message
				msg.peek_all
				user_events_processed_from_underlying_toolkit := False
			until
				not msg.last_boolean_result or else is_destroyed
			loop
				if not user_events_processed_from_underlying_toolkit then
					user_events_processed_from_underlying_toolkit := msg.user_generated
				end
				process_message (msg)
				msg.peek_all
			end
		end

	process_message (msg: WEL_MSG)
			-- Dispatch `msg'.
			--| Different from WEL because of accelerators.
		require
			msg_not_void: msg /= Void
		local
			l_process_events: BOOLEAN
		do
			if msg.last_boolean_result then
				if msg.quit then
					set_is_destroyed (True)
				else
					l_process_events := True
					if attached window_with_focus as l_window_with_focus and then l_window_with_focus.exists and then is_dialog (l_window_with_focus.wel_item) then
						msg.process_dialog_message (l_window_with_focus.wel_item)
						l_process_events := not msg.last_boolean_result
							-- Only process events if the event was not a dialog message.
					end
					if l_process_events then
							-- Dispatch message.
						msg.translate
						msg.dispatch
					end
				end
			end
		end

	internal_capture_type: CELL [INTEGER]
			-- System wide once, in order to always get the
			-- same value.
		once
			create Result.put (0)
		ensure
			internal_capture_type_not_void: Result /= Void
		end

	process_handle: POINTER
			-- HANDLE for current process.

	wait_for_input (msec: INTEGER)
			-- Wait for at most `msec' milliseconds for an input.
		local
			l_result: INTEGER
			l_process, l_null: POINTER
		do
			l_process := process_handle
			if l_process /= l_null then
				l_result := {WEL_API}.msg_wait_for_multiple_objects (1, $l_process, False, msec,
					{WEL_QS_CONSTANTS}.qs_allinput | {WEL_QS_CONSTANTS}.qs_allpostmessage)
				check l_result_ok: l_result /= -1 end
			end
		end

feature -- Public constants

	Capture_heavy: INTEGER = 1
			-- The mouse [has been/should be] captured through
			-- a call to `set_heavy_capture'

	Capture_normal: INTEGER = 0
			-- The mouse [has been/should be] captured through
			-- a call to `set_capture'
			--
			-- Default value.

feature {NONE} -- Externals

	cwin_disable_xp_ghosting
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

	cwin_register_window_message (message_name: POINTER): INTEGER
			-- Register a custom window message named `message_name'.
			-- `Result' is id of new message.
		external
			"C [macro <windows.h>] (LPCTSTR): EIF_INTEGER"
		alias
			"RegisterWindowMessage"
		end

	c_sleep (v: INTEGER)
			-- Sleep for `v' milliseconds.
		external
			"C [macro <windows.h>] (DWORD)"
		alias
			"Sleep"
		end

	cwin_post_quit_message (exit_code: INTEGER)
			-- SDK PostQuitMessage.
		external
			"C [macro <wel.h>] (int)"
		alias
			"PostQuitMessage"
		end

	cwin_get_keyboard_state (virtual_key: INTEGER): INTEGER_16
			-- `Result' is state of `virtual_key'.
		external
			"C [macro <windows.h>] (int): EIF_INTEGER_16"
		alias
			"GetKeyState"
		end

	frozen cwel_integer_to_pointer (i: INTEGER): POINTER
			-- Converts an integer `i' to a pointer
		external
			"C [macro <wel.h>] (EIF_INTEGER): EIF_POINTER"
		end

	cwin_is_theme_active: BOOLEAN
			-- SDK's Open
		external
			"dllwin %"uxtheme.dll%" signature (): EIF_BOOLEAN use <windows.h>"
		alias
			"IsThemeActive"
		end

	cwin_is_app_themed: BOOLEAN
			-- SDK's Open
		external
			"dllwin %"uxtheme.dll%" signature (): EIF_BOOLEAN use <windows.h>"
		alias
			"IsAppThemed"
		end

invariant
	idle_action_mutex_valid: {PLATFORM}.is_thread_capable implies idle_action_mutex /= Void
	process_handle_valid: not is_destroyed implies process_handle /= default_pointer

note
	copyright:	"Copyright (c) 1984-2008, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EV_APPLICATION_IMP
