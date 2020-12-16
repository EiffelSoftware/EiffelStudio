note
	description: "Abstract notions of a window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_WINDOW

inherit
	WEL_ANY
		redefine
			dispose
		end

	REFACTORING_HELPER
		export
			{NONE} all
		end

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		end

	WEL_DATA_TYPE
		export
			{NONE} all
		end

	WEL_SYSTEM_METRICS
		export
			{NONE} all
		end

	WEL_WORD_OPERATIONS
		export
			{NONE} all
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end

	WEL_SB_CONSTANTS
		export
			{NONE} all
		end

	WEL_WM_CONSTANTS
		export
			{NONE} all
		end

	WEL_WS_CONSTANTS
		export
			{NONE} all
		end

	WEL_WA_CONSTANTS
		export
			{NONE} all
		end

	WEL_SWP_CONSTANTS
		export
			{NONE} all
		end

	WEL_SW_CONSTANTS
		export
			{NONE} all
		end

	WEL_MB_CONSTANTS
		export
			{NONE} all
		end

	WEL_ID_CONSTANTS
		export
			{NONE} all
		end

	WEL_ESB_CONSTANTS
		export
			{NONE} all
		end

	WEL_HWND_CONSTANTS
		export
			{NONE} all
			{ANY} valid_hwnd_constant
		end

	WEL_RESIZING_SUPPORT
		export
			{NONE} all
		end

	WEL_RETURN_VALUE

feature -- Access

	parent: detachable WEL_WINDOW
			-- Parent window

	commands: detachable WEL_COMMAND_MANAGER
			-- Command manager associated to the current window.

feature -- Status report

	is_inside: BOOLEAN
			-- Is the current window inside another window?
		require
			exists: exists
		do
			Result := flag_set (style, Ws_child)
		end

	default_processing_enabled: BOOLEAN
		obsolete
			"Use `default_processing' instead [2017-05-31]."
			-- Is the default window processing enabled?
			-- If True (by default) the standard window
			-- procedure will be called. Otherwise, the standard
			-- window procedure will not be called and the
			-- normal behavior will not occur.
		do
			Result := default_processing
		end

	enabled: BOOLEAN
			-- Is the window enabled for mouse and keyboard input?
		require
			exists: exists
		do
			Result := cwin_is_window_enabled (item)
		end

	shown: BOOLEAN
			-- Is the window shown?
		require
			exists: exists
		do
			Result := cwin_is_window_visible (item)
		end

	minimized: BOOLEAN
			-- Is the window minimized?
		require
			exists: exists
		do
			Result := cwin_is_iconic (item)
		end

	maximized: BOOLEAN
			-- Is the window maximized?
		require
			exists: exists
		do
			Result := cwin_is_zoomed (item)
		end

	focused_window: detachable WEL_WINDOW
			-- Current window which has the focus.
		require
			exists: exists
		local
			p, null: POINTER
		do
			p := {WEL_API}.get_focus
			if p /= null then
				Result := window_of_item (p)
			end
		end

	captured_window: detachable WEL_WINDOW
			-- Current window which has been captured.
		require
			exists: exists
			window_captured: window_captured
		local
			p, null: POINTER
		do
			p := cwin_get_capture
			if p /= null then
				Result := window_of_item (p)
			end
		end

	window_captured: BOOLEAN
			-- Has a window been captured?
		do
			Result := cwin_get_capture /= default_pointer
		end

	has_focus: BOOLEAN
			-- Does this window have the focus?
		require
			exists: exists
		do
			Result := focused_window = Current
		end

	has_capture: BOOLEAN
			-- Does this window have the capture?
		require
			exists: exists
		do
			Result := window_captured and then
				captured_window = Current
		end

	has_heavy_capture: BOOLEAN
			-- Does this window have the heavy capture?
		obsolete
			"Use `has_capture' instead [2017-05-31]."
		do
			Result := has_capture
		end

	heavy_capture_activated: BOOLEAN
			-- Is the heavy capture currently running?
			-- (i.e. is there a window in the current program
			-- with `has_heavy_capture' to True?)
		obsolete
			"Use `has_capture' instead [2017-05-31]."
		do
			Result := has_capture
		end

	has_vertical_scroll_bar: BOOLEAN
			-- Does this window have a vertical scroll bar?
		require
			exists: exists
		do
			Result := flag_set (style, Ws_vscroll)
		end

	has_horizontal_scroll_bar: BOOLEAN
			-- Does this window have a horizontal scroll bar?
		require
			exists: exists
		do
			Result := flag_set (style, Ws_hscroll)
		end

	x: INTEGER
			-- Window x position
		require
			exists: exists
		local
			rect: WEL_RECT
			point: WEL_POINT
			l_parent: like parent
		do
			l_parent := parent
			if l_parent /= Void then
				-- Unfortunately, there is no easy
				-- way to get the relative x position of
				-- a child!
				rect := window_rect
				create point.make (rect.x, rect.y)
				point.screen_to_client (l_parent)
				Result := point.x
			else
				Result := absolute_x
			end
		ensure
			parent = Void implies Result = absolute_x
		end

	y: INTEGER
			-- Window y position
		require
			exists: exists
		local
			rect: WEL_RECT
			point: WEL_POINT
			l_parent: like parent
		do
			l_parent := parent
			if l_parent /= Void then
				-- Unfortunately, there is no easy
				-- way to get the relative y position of
				-- a child!
				rect := window_rect
				create point.make (rect.x, rect.y)
				point.screen_to_client (l_parent)
				Result := point.y
			else
				Result := absolute_y
			end
		ensure
			parent = Void implies Result = absolute_y
		end

	width: INTEGER
			-- Window width
		require
			exists: exists
		do
			Result := window_rect.width
		end

	height: INTEGER
			-- Window height
		require
			exists: exists
		do
			Result := window_rect.height
		end

	absolute_x: INTEGER
			-- Absolute x position
		require
			exists: exists
		do
			Result := window_rect.x
		ensure
			Result = window_rect.x
		end

	absolute_y: INTEGER
			-- Absolute y position
		require
			exists: exists
		do
			Result := window_rect.y
		ensure
			Result = window_rect.y
		end

	minimal_width: INTEGER
			-- Minimal width allowed for the window
			-- Zero by default.
		do
		ensure
			positive_result: Result >= 0
			result_small_enough: Result <= maximal_width
		end

	maximal_width: INTEGER
			-- Maximal width allowed for the window
		do
			Result := screen_width
		ensure
			result_large_enough: Result >= minimal_width
		end

	minimal_height: INTEGER
			-- Minimal height allowed for the window
			-- Zero by default.
		do
		ensure
			positive_result: Result >= 0
			result_small_enough: Result <= maximal_height
		end

	maximal_height: INTEGER
			-- Maximal height allowed for the window
		do
			Result := screen_height
		ensure
			result_large_enough: Result >= minimal_height
		end

	client_rect: WEL_RECT
			-- Client rectangle
		require
			exists: exists
		do
			create Result.make_client_from_pointer (item)
		ensure
			result_not_void: Result /= Void
		end

	window_rect: WEL_RECT
			-- Window rectangle (absolute position)
		require
			exists: exists
		do
			create Result.make_window_from_pointer (item)
		ensure
			result_not_void: Result /= Void
		end

	 text: STRING_32
			-- Window text
		require
			exists: exists
		local
			length: INTEGER
			l_wel_string: WEL_STRING
			nb: INTEGER
		do
			length := text_length
			if length > 0 then
				length := length + 1
				create l_wel_string.make_empty (length)
				nb := {WEL_API}.get_window_text (item, l_wel_string.item, length)
				Result := l_wel_string.substring (1, nb)
			else
				create Result.make (0)
			end
		ensure
			result_not_void: Result /= Void
		end

	text_substring (nb: INTEGER): WEL_STRING
			-- `nb' code units of `text' retrieved as a WEL_STRING.
		require
			exists: exists
			valid_upper_bound: nb <= text_length
		local
			l_actual_count: INTEGER
		do
			create Result.make_empty (nb + 1)
			l_actual_count := {WEL_API}.send_message_result_integer (item, wm_gettext, to_wparam (nb + 1), Result.item)
			Result.set_count (l_actual_count)
		end

	text_length: INTEGER
			-- Text length
		require
			exists: exists
		do
			Result := cwin_get_window_text_length (item)
		ensure
			positive_result: Result >= 0
		end

	placement: WEL_WINDOW_PLACEMENT
			-- Window placement information
		require
			exists: exists
		do
			create Result.make (Current)
		ensure
			result_not_void: Result /= Void
		end

	style: INTEGER
			-- Window style
		require
			exists: exists
		do
			Result := cwin_get_window_long (item, Gwl_style).to_integer_32
		end

	ex_style: INTEGER
			-- Window ex_style
		require
			exists: exists
		do
			Result := cwin_get_window_long (item, Gwl_exstyle).to_integer_32
		end

	background_brush: detachable WEL_BRUSH
			-- Current window background color used to refresh the window when
			-- requested by the WM_ERASEBKGND windows message.
			-- By default there is no background
		do
		ensure
			new_object: Result /= Void implies Result /= background_brush
		end

	background_brush_gdip: detachable WEL_GDIP_BRUSH
			-- GDI+ version of `background_brush'
			-- Result void if GDI+ not available
		do
		end

	commands_enabled: BOOLEAN
			-- Is the commands execution enabled?
		do
			Result := commands_enabled_ref.item
		end

	command_exists (message: INTEGER): BOOLEAN
			-- Does a command associated to `message' exist?
		require
			positive_message: message >= 0
		local
			l_commands: like commands
		do
			l_commands := commands
			Result := l_commands /= Void and then l_commands.exists (message)
		ensure
			definition: Result implies attached commands as l_commands_var and then l_commands_var.item (message) /= Void
		end

	command (message: INTEGER): WEL_COMMAND
			-- Command associated to `message'
		require
			positive_message: message >= 0
			command_exists: command_exists (message)
		local
			l_message: detachable WEL_COMMAND_EXEC
			l_commands: like commands
		do
			l_commands := commands
				-- Per precondition
			check l_commands_attached: l_commands /= Void then end
			l_message := l_commands.item (message)
				-- Per precondition
			check l_message_attached: l_message /= Void then end
			Result := l_message.command
		ensure
			result_not_void: Result /= Void
		end

	command_argument (message: INTEGER): detachable ANY
			-- Command argument associated to `message'
		require
			positive_message: message >= 0
			command_exists: command_exists (message)
		local
			l_message: detachable WEL_COMMAND_EXEC
			l_commands: like commands
		do
			l_commands := commands
				-- Per precondition
			check l_commands_attached: l_commands /= Void then end
			l_message := l_commands.item (message)
				-- Per precondition
			check l_message_attached: l_message /= Void then end
			Result := l_message.argument
		end

feature -- Status setting

	enable_commands
			-- Enable commands execution.
		do
			commands_enabled_ref.put (True)
		ensure
			commands_enabled: commands_enabled
		end

	disable_commands
			-- Disable commands execution.
		do
			commands_enabled_ref.put (False)
		ensure
			commands_disabled: not commands_enabled
		end

	enable_default_processing
			-- Enable default window processing.
			-- The standard window procedure will be called for
			-- each messages received by the window and then the
			-- normal behavior will occur.
		do
			set_default_processing (True)
		ensure
			default_processing_enabled: default_processing
		end

	disable_default_processing
			-- Disable default window processing.
			-- The standard window procedure will not be called for
			-- each messages received by the window and then the
			-- normal behavior will not occur.
		do
			set_default_processing (False)
		ensure
			default_processing_disabled: not default_processing
		end

	enable
			-- Enable mouse and keyboard input.
		require
			exists: exists
		do
			cwin_enable_window (item, True)
		ensure
			enabled: enabled
		end

	disable
			-- Disable mouse and keyboard input
		require
			exists: exists
		do
			cwin_enable_window (item, False)
		ensure
			disabled: not enabled
		end

	enable_drag_accept_files
			-- Allow `Current' to be a file drag and drop target.
		require
			exists
		do
			cwin_drag_accept_files (item, True)
		end

	disable_drag_accept_files
			-- Disallow `Current' from being a file drag and drop target.
		require
			exists
		do
			cwin_drag_accept_files (item, False)
		end

	show
			-- Show the window
		require
			exists: exists
		do
			cwin_show_window (item, sw_show)
		end

	hide
			-- Hide the window
		require
			exists: exists
		do
			cwin_show_window (item, Sw_hide)
		ensure
			hidden: not shown
		end

	minimize
			-- Minimize the window and display its icon
		require
			exists: exists
		do
			cwin_show_window (item, Sw_showminimized)
		ensure
			minimized: minimized
		end

	maximize
			-- Maximize the window
		require
			exists: exists
		do
			cwin_show_window (item, Sw_showmaximized)
		ensure
			maximized: maximized
		end

	restore
			-- Restore the window to its
			-- original size and position after
			-- `minimize' or `maximize'
		require
			exists: exists
		do
			cwin_show_window (item, Sw_restore)
		end

	set_focus
			-- Set the focus to `Current'
		require
			exists: exists
		do
			cwin_set_focus (item)
		end

	set_capture
			-- Set the mouse capture to the `Current' window.
			-- Once the window has captured the mouse, all
			-- mouse input is directed to this window, regardless
			-- of whether the cursor is over that window. Only
			-- one window can have the mouse capture at a time.
			--
			-- Works only for windows in the same thread as your
			-- application.
		require
			exists: exists
			has_not_capture: not has_capture
		do
			cwin_set_capture (item)
		end

	set_heavy_capture
			-- Set the mouse capture to the `Current' window.
			-- Once the window has captured the mouse, all
			-- mouse input is directed to this window, regardless
			-- of whether the cursor is over that window. Only
			-- one window can have the mouse capture at a time.
			--
			-- Works for ALL windows.
		obsolete
			"Use `set_capture' instead [2017-05-31]."
		require
			exists: exists
			has_not_capture: not has_capture
		do
			cwin_set_capture (item)
		end

	release_capture
			-- Release the mouse capture after a call
			-- to `set_capture'.
		require
			exists: exists
			has_capture: has_capture
		do
			cwin_release_capture
		ensure
			not_has_capture: not has_capture
		end

	release_heavy_capture
			-- Release the mouse capture after a call
			-- to `set_heavy_capture'.
		obsolete
			"Use `release_capture' instead [2017-05-31]."
		require
			exists: exists
			has_capture: has_capture
		do
			cwin_release_capture
		ensure
			not_has_capture: not has_capture
		end

	set_style (a_style: INTEGER)
			-- Set `style' with `a_style'.
		require
			exists: exists
		local
			cur_ex_style: INTEGER
		do
			cwin_set_window_long (item, Gwl_style, cwel_integer_to_pointer (a_style))

				-- Update changes
			cur_ex_style := ex_style
			update_cached_style (cur_ex_style, cur_ex_style)
		end

	set_ex_style (an_ex_style: INTEGER)
			-- Set `an_ex_style' with `ex_style'.
			--
		require
			exists: exists
		local
			old_ex_style: INTEGER
		do
				-- Remember the current Extended style
			old_ex_style := ex_style

				-- Change the Extended style
			cwin_set_window_long (item, Gwl_exstyle, cwel_integer_to_pointer (an_ex_style))

				-- Update changes
			update_cached_style (an_ex_style, old_ex_style)
		end

	update_cached_style (new_ex_style, old_ex_style: INTEGER)
			-- Update Window cache buffer for Window style.
			--|
			--| Certain window data is cached, so changes you make using
			--| SetWindowLong will not take effect until you call the
			--| SetWindowPos function. Specifically, if you change any
			--| of the frame styles, you must call SetWindowPos with
			--| the SWP_FRAMECHANGED flag for the cache to be updated
			--| properly.
		local
			hwnd_const: POINTER
			swp_const: INTEGER
			l_success: BOOLEAN
		do
			if flag_set (new_ex_style, Ws_ex_topmost) then
					-- The new style specify "Top most",
					-- so we change the current Z order to "Top most".
				hwnd_const := Hwnd_topmost
			else
				if flag_set (old_ex_style, Ws_ex_topmost) then
						-- The old style specify "Top most", not the
						-- new one so we change the current Z order.
					hwnd_const := Hwnd_notopmost
				else
						-- The old style does not specify "Top most", like the
						-- new one so ignore Z order changes.
					swp_const := swp_nozorder
				end
			end
			swp_const := swp_const | swp_nomove | swp_nosize | swp_framechanged | swp_noactivate
			l_success := {WEL_API}.set_window_pos (item, hwnd_const, 0, 0, 0, 0, swp_const)
		end

feature -- Element change

	set_parent (a_parent: detachable WEL_WINDOW)
			-- Change the parent of the current window.
		require
			exists: exists
		local
			l_previous_hwnd: POINTER
		do
			if a_parent /= Void and then a_parent.exists then
				parent := a_parent
				l_previous_hwnd := {WEL_API}.set_parent (item, a_parent.item)
			else
				parent := Void
				l_previous_hwnd := {WEL_API}.set_parent (item, default_pointer)
			end
			if l_previous_hwnd = default_pointer and a_parent /= Void then
					-- Most of the time the `recursive_set_parent' workaround
					-- will work, but not all the time :-(.
				l_previous_hwnd := recursive_set_parent (a_parent)
			end
		end

	set_text (a_text: detachable READABLE_STRING_GENERAL)
			-- Set the window text
		require
			exists: exists
		local
			a_wel_string: WEL_STRING
		do
			if a_text /= Void then
				create a_wel_string.make (a_text)
			else
				create a_wel_string.make_empty (0)
			end
			{WEL_API}.set_window_text (item, a_wel_string.item)
		ensure
			text_set_when_not_void: a_text /= Void implies text.same_string_general (a_text)
			text_set_when_void: a_text = Void implies text.count = 0
		end

	set_placement (a_placement: WEL_WINDOW_PLACEMENT)
			-- Set `placement' with `a_placement'
		require
			exists: exists
			a_placement_not_void: a_placement /= Void
			a_placement_exists: a_placement.exists
		do
			cwin_set_window_placement (item, a_placement.item)
		ensure
			-- placement_set: placement = a_placement
		end

	set_x (a_x: INTEGER)
			-- Set `x' with `a_x'
		require
			exists: exists
		do
			move (a_x, y)
		end

	set_y (a_y: INTEGER)
			-- Set `y' with `a_y'
		require
			exists: exists
		do
			move (x, a_y)
		end

	set_width (a_width: INTEGER)
			-- Set `width' with `a_width'
		require
			exists: exists
		do
			resize (a_width, height)
		end

	set_height (a_height: INTEGER)
			-- Set `height' with `a_height'
		require
			exists: exists
		do
			resize (width, a_height)
		end

	set_timer (timer_id, time_out: INTEGER)
			-- Set a timer identified by `timer_id' with a
			-- `time_out' value (in milliseconds).
			-- See also `on_timer', `kill_timer'.
		require
			exists: exists
			positive_timer_id: timer_id > 0
			positive_time_out: time_out > 0
		do
			cwin_set_timer (item, timer_id, time_out,
				default_pointer)
		end

	has_system_window_locked: BOOLEAN
			-- Is there any window locked ?
		local
			c_result: BOOLEAN
		do
			Result := not c_lock_window_update (item)
			if not Result then
				c_result := c_lock_window_update (default_pointer)
				check
					success: c_result
				end
			end
		end

	lock_window_update
			-- Disables drawing in the current window. A locked window cannot be moved.
			-- Only one window can be locked at a time. To unlock a window locked with
			-- `lock_window_update' , call 'unlock_window_update'.
		require
			exists: exists
		local
			success : BOOLEAN
		do
			success := c_lock_window_update (item)
		ensure
			has_system_window_locked
		end

	unlock_window_update
			-- Unlock a locked window.	
		require
			exists: exists
		local
			success : BOOLEAN
		do
			success := c_lock_window_update (default_pointer)
		end

	enable_redraw
			-- Ensure `Current' is redrawn as required.
		require
			exists: exists
		do
			{WEL_API}.send_message (item, wm_setredraw, {WEL_DATA_TYPE}.to_wparam (1), default_pointer)
		end

	disable_redraw
			-- Disable redrawing of `Current' until next call to `enable_redraw'.
		require
			exists: exists
		do
			{WEL_API}.send_message (item, wm_setredraw, default_pointer, default_pointer)
		end


feature -- Basic operations

	put_command (a_command: WEL_COMMAND; message: INTEGER; argument: detachable ANY)
			-- Put `a_command' associated to `message'.
		require
			a_command_not_void: a_command /= Void
			positive_message: message >= 0
		local
			command_exec: WEL_COMMAND_EXEC
			l_commands: like commands
		do
				-- Has a command been already put?
				-- If no, let's create `commands'.
			l_commands := commands
			if l_commands = Void then
				create l_commands.make
				commands := l_commands
			end
			create command_exec.make (a_command, argument)
			l_commands.force (command_exec, message)
		ensure
			command_added: command (message) = a_command and
				command_argument (message) = argument
		end

	remove_command (message: INTEGER)
			-- Remove the command associated to `message'.
		require
			positive_message: message >= 0
			command_exists: command_exists (message)
		local
			l_commands: like commands
		do
			l_commands := commands
				-- Per precondition
			check l_commands_attached: l_commands /= Void then end
			l_commands.remove (message)
		ensure
			command_removed: not command_exists (message)
		end

	show_with_option (cmd_show: INTEGER)
			-- Set the window's visibility with `cmd_show'.
			-- See class WEL_SW_CONSTANTS for `cmd_show' value.
		require
			exists: exists
			parent_shown: attached parent as l_parent implies l_parent.exists and l_parent.shown
		do
			cwin_show_window (item, cmd_show)
		end

	move_and_resize (a_x, a_y, a_width, a_height: INTEGER; repaint: BOOLEAN)
			-- Move the window to `a_x', `a_y' position and
			-- resize it with `a_width', `a_height'.
		require
			exists: exists
		do
			move_and_resize_internal (a_x, a_y, a_width, a_height, repaint, 0)
		end

	move (a_x, a_y: INTEGER)
			-- Move the window to `a_x', `a_y'.
		require
			exists: exists
		do
			move_and_resize_internal (a_x, a_y, 0, 0, True, Swp_nosize)
		end

	resize (a_width, a_height: INTEGER)
			-- Resize the window with `a_width', `a_height'.
		require
			exists: exists
		do
			move_and_resize_internal (0, 0, a_width, a_height, True, Swp_nomove)
		end

	set_z_order (z_order: POINTER)
			-- Set the z-order of the window.
			-- See class WEL_HWND_CONSTANTS for `z_order' values.
		require
			exists: exists
			valid_hwnd_constant: valid_hwnd_constant (z_order)
		local
			l_success: BOOLEAN
		do
			l_success := {WEL_API}.set_window_pos (item, z_order,
				0, 0, 0, 0, Swp_nosize + Swp_nomove +
				Swp_noactivate)
		end

	bring_to_top
			-- Bring this window to the top of the Z order.
			--
			-- Note:
			--  * If the window is a top-level window, it is activated.
			--  * If the window is a child window, the top-level parent window
			--    associated with the child window is activated.
		require
			exists: exists
		local
			success: BOOLEAN
		do
			success := cwin_bring_window_to_top (item)
		end

	insert_after (a_window: WEL_WINDOW)
			-- Insert the current window after `a_window'.
		require
			exists: exists
			a_window_not_void: a_window /= Void
			a_window_not_current: a_window /= Current
			a_window_exists: a_window.exists
		local
			l_success: BOOLEAN
		do
			l_success := {WEL_API}.set_window_pos (item, a_window.item, 0, 0, 0, 0,
				Swp_nosize + Swp_nomove + Swp_noactivate)
		end

	show_scroll_bars
			-- Show the horizontal and vertical scroll bars.
		require
			exists: exists
		do
			cwin_show_scroll_bar (item, Sb_both, True)
		end

	show_vertical_scroll_bar
			-- Show the vertical scroll bar.
		require
			exists: exists
		do
			cwin_show_scroll_bar (item, Sb_vert, True)
		end

	show_horizontal_scroll_bar
			-- Show the horizontal scroll bar.
		require
			exists: exists
		do
			cwin_show_scroll_bar (item, Sb_horz, True)
		end

	hide_scroll_bars
			-- Hide the horizontal and vertical scroll bars.
		require
			exists: exists
		do
			cwin_show_scroll_bar (item, Sb_both, False)
		end

	hide_vertical_scroll_bar
			-- Hide the vertical scroll bar.
		require
			exists: exists
		do
			cwin_show_scroll_bar (item, Sb_vert, False)
		end

	hide_horizontal_scroll_bar
			-- Hide the horizontal scroll bar.
		require
			exists: exists
		do
			cwin_show_scroll_bar (item, Sb_horz, False)
		end

	disable_horizontal_scroll_bar
			-- Disable the horizontal scroll bar.
		require
			exists: exists
		do
			cwin_enable_scroll_bar (item, Sb_horz, Esb_disable_both)
		end

	enable_horizontal_scroll_bar
			-- Enable the horizontal scroll bar.
		require
			exists: exists
		do
			cwin_enable_scroll_bar (item, Sb_horz, Esb_enable_both)
		end

	disable_vertical_scroll_bar
			-- Disable the vertical scroll bar.
		require
			exists: exists
		do
			cwin_enable_scroll_bar (item, Sb_vert, Esb_disable_both)
		end

	enable_vertical_scroll_bar
			-- Enable the vertical scroll bar.
		require
			exists: exists
		do
			cwin_enable_scroll_bar (item, Sb_vert, Esb_enable_both)
		end

	message_box (a_text, a_title: READABLE_STRING_GENERAL; a_style: INTEGER): INTEGER
		obsolete "Use class WEL_MSG_BOX instead [2017-05-31]."
			-- Show an information message box with `Current'
			-- as parent with `a_text' and `a_title'.
			-- See class WEL_MB_CONSTANTS for `a_style' value.
			-- See class WEL_ID_CONSTANTS for the return value.
		require
			exists: exists
			text_not_void: a_text /= Void
			title_not_void: a_title /= Void
		local
			a_wel_string1, a_wel_string2: WEL_STRING
		do
			create a_wel_string1.make (a_text)
			create a_wel_string2.make (a_title)
			Result := cwin_message_box_result (item, a_wel_string1.item, a_wel_string2.item,
				a_style)
		end

	information_message_box (a_text, a_title: READABLE_STRING_GENERAL)
		obsolete "Use class WEL_MSG_BOX instead [2017-05-31]."
			-- Show an information message box with `Current'
			-- as parent with `a_text' and `a_title'.
		require
			exists: exists
			text_not_void: a_text /= Void
			title_not_void: a_title /= Void
		local
			a_wel_string1, a_wel_string2: WEL_STRING
		do
			create a_wel_string1.make (a_text)
			create a_wel_string2.make (a_title)
			cwin_message_box (item, a_wel_string1.item, a_wel_string2.item,
				Mb_ok + Mb_iconinformation)
		end

	warning_message_box (a_text, a_title: READABLE_STRING_GENERAL)
		obsolete "Use class WEL_MSG_BOX instead [2017-05-31]."
			-- Show a warning message box with `Current'
			-- as parent with `a_text' and `a_title'.
		require
			exists: exists
			text_not_void: a_text /= Void
			title_not_void: a_title /= Void
		local
			a_wel_string1, a_wel_string2: WEL_STRING
		do
			create a_wel_string1.make (a_text)
			create a_wel_string2.make (a_title)
			cwin_message_box (item, a_wel_string1.item, a_wel_string2.item,
				Mb_ok + Mb_iconexclamation)
		end

	error_message_box (a_text: READABLE_STRING_GENERAL)
		obsolete "Use class WEL_MSG_BOX instead [2017-05-31]."
			-- Show an error message box with `Current' as
			-- parent with `a_text' and error as title.
		require
			exists: exists
			text_not_void: a_text /= Void
		local
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (a_text)
			cwin_message_box (item, a_wel_string.item, default_pointer,
				Mb_ok + Mb_iconhand)
		end

	question_message_box (a_text, a_title: READABLE_STRING_GENERAL): BOOLEAN
		obsolete "Use class WEL_MSG_BOX instead [2017-05-31]."
			-- Show a question message box with `Current'
			-- as parent with `a_text' and `a_title'.
			-- True is returned if the user answers yes, False
			-- otherwise.
		require
			exists: exists
			text_not_void: a_text /= Void
			title_not_void: a_title /= Void
		local
			a_wel_string1, a_wel_string2: WEL_STRING
		do
			create a_wel_string1.make (a_text)
			create a_wel_string2.make (a_title)
			Result := cwin_message_box_result (item, a_wel_string1.item, a_wel_string2.item,
				Mb_yesno + Mb_iconquestion) = Idyes
		end

	update
			-- Update the client area by sending a Wm_paint message.
		require
			exists: exists
		do
			cwin_update_window (item)
		end

	invalidate
			-- Invalide the entire client area of the window. The
			-- background will be erased before.
		require
			exists: exists
		do
			cwin_invalidate_rect (item, default_pointer, True)
		end

	invalidate_without_background
			-- Invalidate the entire client area of the window. The
			-- background will not be erased.
		require
			exists: exists
		do
			cwin_invalidate_rect (item, default_pointer, False)
		end

	invalidate_rect (rect: WEL_RECT; erase_background: BOOLEAN)
			-- Invalidate the area `rect' and erase
			-- the background if `erase_background' is True.
		require
			exists: exists
			rect_not_void: rect /= Void
			rect_exists: rect.exists
		do
			cwin_invalidate_rect (item, rect.item, erase_background)
		end

	invalidate_region (region: WEL_REGION; erase_background: BOOLEAN)
			-- Invalidate the area `region' and erase
			-- the background if `erase_background' is True.
		require
			exists: exists
			region_not_void: region /= Void
			region_exists: region.exists
		do
			cwin_invalidate_rgn (item, region.item,
				erase_background)
		end

	validate
			-- Validate the entire client area of the window.
		require
			exists: exists
		do
			cwin_validate_rect (item, default_pointer)
		end

	validate_rect (rect: WEL_RECT)
			-- Validate the area `rect'.
		require
			exists: exists
			rect_not_void: rect /= Void
			rect_exists: rect.exists
		do
			cwin_validate_rect (item, rect.item)
		end

	validate_region (region: WEL_REGION)
			-- Validate the area `region'.
		require
			exists: exists
			region_not_void: region /= Void
			region_exists: region.exists
		do
			cwin_validate_rgn (item, region.item)
		end

	kill_timer (timer_id: INTEGER)
			-- Kill the timer identified by `timer_id'.
			-- See also `set_timer', `on_timer'.
		require
			exists: exists
			positive_timer_id: timer_id > 0
		do
			cwin_kill_timer (item, timer_id)
		end

	scroll (a_x, a_y: INTEGER)
			-- Scroll the contents of the window's client area.
			-- `a_x' and `a_y' specify the amount of horizontal
			-- and vertical scrolling.
		require
			exists: exists
		do
			cwin_scroll_window (item, a_x, a_y,
				default_pointer, default_pointer)
		end

	win_help (help_file: READABLE_STRING_GENERAL; a_command, data: INTEGER)
			-- Start the Windows Help program with `help_file'.
			-- `a_command' specifies the type of help requested. See
			-- class WEL_HELP_CONSTANTS for `a_command' values.
			-- 'data' is depandant on 'a_command'.  Check MSDN for more details.
		obsolete
			"Use `win_help_from_path' instead [2017-05-31]."
		require
			exists: exists
			help_file_not_void: help_file /= Void
		do
			win_help_from_path (create {PATH}.make_from_string (help_file), a_command, data)
		end

	win_help_from_path (help_path: PATH; a_command, data: INTEGER)
			-- Start the Windows Help program with `help_path'.
			-- `a_command' specifies the type of help requested. See
			-- class WEL_HELP_CONSTANTS for `a_command' values.
			-- 'data' is depandant on 'a_command'.  Check MSDN for more details.
		require
			exists: exists
			help_file_not_void: help_path /= Void
		local
			 a_wel_string: WEL_STRING
		do
			create a_wel_string.make_from_path (help_path)
			cwin_win_help (item, a_wel_string.item, a_command, data)
		end

	set_class_icon (new_icon: WEL_ICON)
			-- Replace the current icon for the class which this window
			-- belongs to.
			--
			-- The SetClassLong function replaces the specified 32-bit (long)
			-- value at the specified offset into the extra class memory
			-- or the WNDCLASSEX structure for the class to which the
			-- specified window belongs.
		require
			new_icon_not_void: new_icon /= Void
			new_icon_exists: new_icon.exists
		do
			cwin_set_class_long (item, Wel_gcl_constants.Gclp_hicon, new_icon.item)
		end

	set_class_small_icon (new_icon: WEL_ICON)
			-- Replace the current icon for the class which this window
			-- belongs to.
			--
			-- The SetClassLong function replaces the specified 32-bit (long)
			-- value at the specified offset into the extra class memory
			-- or the WNDCLASSEX structure for the class to which the
			-- specified window belongs.
		require
			new_icon_not_void: new_icon /= Void
			new_icon_exists: new_icon.exists
		do
			cwin_set_class_long (item, Wel_gcl_constants.Gclp_hiconsm, new_icon.item)
		end

feature -- Removal

	destroy
			-- Destroy the window.
		require
			exists: exists
		do
			destroy_item_from_context (False)
		ensure
			not_exists: not exists
		end

feature {WEL_WINDOW} -- Messages

	on_size (size_type, a_width, a_height: INTEGER)
			-- Wm_size message
			-- See class WEL_SIZE_CONSTANTS for `size_type' value
		require
			exists: exists
		do
		end

	on_move (x_pos, y_pos: INTEGER)
			-- Wm_move message.
			-- This message is sent after a window has been moved.
			-- `x_pos' specifies the x-coordinate of the upper-left
			-- corner of the client area of the window.
			-- `y_pos' specifies the y-coordinate of the upper-left
			-- corner of the client area of the window.
		require
			exists: exists
		do
		end

feature {NONE} -- Messages

	on_dpi_changed (a_dpi: NATURAL_32;  window_pos: WEL_WINDOW_POS)
			-- WM_dpichange message.
			-- This message is sent to a window whose dpi changed,
		require
			exists: exists
		do
		end

	on_window_pos_changed (window_pos: WEL_WINDOW_POS)
			-- Wm_windowpschanged message.
			-- This message is sent to a window whose size,
			-- position, or place in the Z order has changed as a
			-- result of a call to `move' or `resize'.
		require
			exists: exists
			window_pos_not_void: window_pos /= Void
			window_pos_exists: window_pos.exists
		do
		end

	on_window_pos_changing (window_pos: WEL_WINDOW_POS)
			-- Wm_windowposchanging
			-- This message is sent to a window whose size,
			-- position or place in the Z order is about to change
			-- as a result of a call to `move', `resize'.
			-- `window_pos' can be changed to override the default
			-- values.
		require
			exists: exists
			window_pos_not_void: window_pos /= Void
			window_pos_exists: window_pos.exists
		do
		end

	on_left_button_down (keys, x_pos, y_pos: INTEGER)
			-- Wm_lbuttondown message
			-- See class WEL_MK_CONSTANTS for `keys' value
		require
			exists: exists
		do
		end

	on_left_button_up (keys, x_pos, y_pos: INTEGER)
			-- Wm_lbuttonup message
			-- See class WEL_MK_CONSTANTS for `keys' value
		require
			exists: exists
		do
		end

	on_left_button_double_click (keys, x_pos, y_pos: INTEGER)
			-- Wm_lbuttondblclk message
			-- See class WEL_MK_CONSTANTS for `keys' value
		require
			exists: exists
		do
		end

	on_middle_button_down (keys, x_pos, y_pos: INTEGER)
			-- Wm_rbuttondown message
			-- See class WEL_MK_CONSTANTS for `keys' value
		require
			exists: exists
		do
		end

	on_middle_button_up (keys, x_pos, y_pos: INTEGER)
			-- Wm_rbuttonup message
			-- See class WEL_MK_CONSTANTS for `keys' value
		require
			exists: exists
		do
		end

	on_middle_button_double_click (keys, x_pos, y_pos: INTEGER)
			-- Wm_rbuttondblclk message
			-- See class WEL_MK_CONSTANTS for `keys' value
		require
			exists: exists
		do
		end

	on_right_button_down (keys, x_pos, y_pos: INTEGER)
			-- Wm_rbuttondown message
			-- See class WEL_MK_CONSTANTS for `keys' value
		require
			exists: exists
		do
		end

	on_right_button_up (keys, x_pos, y_pos: INTEGER)
			-- Wm_rbuttonup message
			-- See class WEL_MK_CONSTANTS for `keys' value
		require
			exists: exists
		do
		end

	on_right_button_double_click (keys, x_pos, y_pos: INTEGER)
			-- Wm_rbuttondblclk message
			-- See class WEL_MK_CONSTANTS for `keys' value
		require
			exists: exists
		do
		end

	on_mouse_move (keys, x_pos, y_pos: INTEGER)
			-- Wm_mousemove message
			-- See class WEL_MK_CONSTANTS for `keys' value
		require
			exists: exists
		do
		end

	on_mouse_wheel (delta, keys, x_pos, y_pos: INTEGER)
			-- Wm_mousewheel message
		require
			exists: exists
		do
		end

	on_char (character_code, key_data: INTEGER)
			-- Wm_char message
			-- See class WEL_VK_CONSTANTS for `character_code' value.
		require
			exists: exists
		do
		end

	on_sys_char (character_code, key_data: INTEGER)
			-- Wm_syschar message
		require
			exists: exists
		do
		end

	on_key_down (virtual_key, key_data: INTEGER)
			-- Wm_keydown message
		require
			exists: exists
		do
		end

	on_key_up (virtual_key, key_data: INTEGER)
			-- Wm_keyup message
		require
			exists: exists
		do
		end

	on_sys_key_down (virtual_key, key_data: INTEGER)
			-- Wm_syskeydown message
		require
			exists: exists
		do
		end

	on_sys_key_up (virtual_key, key_data: INTEGER)
			-- Wm_syskeyup message
		require
			exists: exists
		do
		end

	on_set_focus
			-- Wm_setfocus message
		require
			exists: exists
		do
		end

	on_kill_focus
			-- Wm_killfocus message
		require
			exists: exists
		do
		end

	on_set_cursor (hit_code: INTEGER)
			-- Wm_setcursor message.
			-- See class WEL_HT_CONSTANTS for valid `hit_code' values.
		require
			exists: exists
		do
		end

	on_show
			-- Wm_showwindow message.
			-- The window is being shown.
		require
			exists: exists
		do
		end

	on_hide
			-- Wm_showwindow message.
			-- The window is being hidden.
		require
			exists: exists
		do
		end

	on_destroy
			-- Wm_destroy message.
			-- The window is about to be destroyed.
		require
			exists: exists
		do
		end

	on_timer (timer_id: INTEGER)
			-- Wm_timer message.
			-- A Wm_timer has been received from `timer_id'
			-- See also `set_timer', `kill_timer'.
		require
			exists: exists
			positive_timer_id: timer_id > 0
		do
		end

	on_notify (control_id: INTEGER; info: WEL_NMHDR)
		require
			exists: exists
			info_not_void: info /= Void
			info_exists: info.exists
		do
		end

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT)
			-- Wm_erasebkgnd message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
		require
			paint_dc_not_void: paint_dc /= Void
			invalid_rect_not_void: invalid_rect /= Void
			invalid_rect_exists: invalid_rect.exists
		local
			bk_brush: detachable WEL_BRUSH
		do
			bk_brush := background_brush
			if bk_brush /= Void then
				paint_dc.fill_rect (invalid_rect, bk_brush)
				bk_brush.delete
					--| Disable the default windows processing and return correct
					--| value to Windows, i.e. nonzero value.
				disable_default_processing
				set_message_return_value (to_lresult (1))
			end
		end

	on_desactivate
			-- Called when window loses activation.
		do
		end

	on_activate
			-- Called when window gains activation (alt-tab or mouse click on title bar)
		do
		end

	on_getdlgcode
			-- Called when window receives WM_GETDLGCODE message.
		do
		end

	on_wm_theme_changed
			-- Called when window receives WM_THEMECHANGED message.
		do
		end

	on_wm_dpi_changed (a_wparam: POINTER; a_lparam: POINTER)
			-- Called when a window receives WM_DPICHANGED message.
		require
			exists: exists
		local
			l_rect: WEL_RECT
			l_dpi: NATURAL_32
			l_wp: WEL_WINDOW_POS
		do
				-- When we handle the WM_DPICHANGED, the app it's
				-- responsible to call SetWindowsPos and scale windows controls
				-- and resources, at the moment only SetWindowsPos is handled.
				-- a_wparam new dpi setting
				-- need to use the new DPI retrieved from the a_wparam to calculate the new scale factor.
			l_dpi := cwin_hi_word (a_wparam).to_natural_32

				-- a_lparam windows rectangle scaled for the new DPI.
			create l_rect.make_by_pointer (a_lparam)
			move_and_resize_internal (l_rect.left, l_rect.top, l_rect.width, l_rect.height, True, 0)

			l_wp := Window_pos_internal
			if l_wp.item /= default_pointer then
				create l_wp.make_by_pointer (a_lparam)
			else
				l_wp.set_item (a_lparam)
			end
			on_dpi_changed (l_dpi, l_wp)
		end

feature {WEL_WINDOW, WEL_DISPATCHER} -- Implementation

	default_window_procedure: POINTER
			-- Default window procedure

feature {WEL_WINDOW} -- Implementation

	internal_window_make (a_parent: detachable WEL_WINDOW; a_name: detachable READABLE_STRING_GENERAL;
			a_style, a_x, a_y, a_w, a_h, an_id: INTEGER;
			data: POINTER)
			-- Create the window
		local
			a_wel_string1, a_wel_string2: WEL_STRING
			l_error: WEL_ERROR
		do
			parent := a_parent
			create a_wel_string1.make (class_name)
			if a_name /= Void and then not a_name.is_empty then
				create a_wel_string2.make (a_name)
				item := cwin_create_window_ex (default_ex_style,
					a_wel_string1.item, a_wel_string2.item, a_style, a_x, a_y, a_w, a_h,
					parent_item, cwel_integer_to_pointer (an_id),
					main_args.current_instance.item, data)
			else
				item := cwin_create_window_ex (default_ex_style,
					a_wel_string1.item, default_pointer, a_style, a_x, a_y, a_w, a_h,
					parent_item, cwel_integer_to_pointer (an_id),
					main_args.current_instance.item, data)
			end
			if item /= default_pointer then
					-- Workaround until we can scale the windows resource
					-- when we get a WM_dpichange.
					-- Here Windows will scale the non-client area (title bar etc) of the windows.
				--{WEL_SCALING_API}.enable_non_client_dpi_scaling (item)
				register_current_window
				set_default_window_procedure
			else
				create l_error
				l_error.display_last_error
			end
		ensure
			exists: exists
		end

	class_name: STRING_32
			-- Window class name to create
		deferred
		ensure
			result_not_void: Result /= Void
		end

	parent_item: POINTER
			-- Parent `item'.
			-- Equal to `default_pointer' if no parent
		local
			l_parent: like parent
		do
			l_parent := parent
			if l_parent /= Void then
				Result := l_parent.item
			end
		ensure
			result_parent_not_void: (parent /= Void implies
				Result /= default_pointer) or
				Result = default_pointer
		end

	set_default_window_procedure
			-- Set `default_window_procedure' if the window must
			-- call its previous window procedure.
		require
			exists: exists
		do
		end

	default_style: INTEGER
			-- Default style used to create the window.
			-- See class WEL_WS_CONSTANTS.
		deferred
		end

	default_ex_style: INTEGER
			-- Default extented style used to create the window
		do
			Result := 0
		end

	main_args: WEL_MAIN_ARGUMENTS
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

	commands_enabled_ref: CELL [BOOLEAN]
			-- Is the commands execution enabled?
			-- False by default.
		once
			create Result.put (False)
		ensure
			commands_enabled_ref_not_void: Result /= Void
		end

	on_wm_show_window (wparam, lparam: INTEGER)
			-- Wm_showwindow message
		require
			exists: exists
		do
			if wparam = 0 then
				on_hide
			else
				on_show
			end
		end

	on_wm_destroy
			-- Wm_destroy message.
		require
			exists: exists
		do
			on_destroy
		end

	on_wm_nc_destroy
			--  Wm_ncdestroy message.
		do
		end

	on_wm_notify (wparam, lparam: POINTER)
			-- Wm_notify message
		require
			exists: exists
		local
			info: WEL_NMHDR
		do
			create info.make_by_pointer (lparam)
			on_notify (wparam.to_integer_32, info)
		end

	on_wm_erase_background (wparam: POINTER)
			-- Wm_erasebkgnd message.
			-- A WEL_DC and WEL_PAINT_STRUCT are created and passed to the
			-- `on_erase_background' routine.
		require
			exists: exists
		local
			paint_dc: WEL_PAINT_DC
		do
			create paint_dc.make_by_pointer (Current, wparam)
			on_erase_background (paint_dc, client_rect)
		end

	on_wm_activate (wparam: INTEGER)
			-- Wm_activate message
		require
			exists: exists
		do
			if wparam = Wa_inactivate then
				on_desactivate
			else
				on_activate
			end
		end

	on_wm_window_pos_changing (lparam: POINTER)
			-- Wm_windowposchanging message
		require
			exists: exists
		local
			l_wp: WEL_WINDOW_POS
		do
			l_wp := window_pos_internal
				-- Try to use reuse window pos object if not already set.
			if l_wp.item /= default_pointer then
				create l_wp.make_by_pointer (lparam)
			else
				l_wp.set_item (lparam)
			end
			on_window_pos_changing (l_wp)
				-- Unset the shared pointer before returning.
			l_wp.set_item (default_pointer)
		end

	on_wm_window_pos_changed (lparam: POINTER)
			-- Wm_windowposchanged message
		require
			exists: exists
		local
			l_wp: WEL_WINDOW_POS
		do
			l_wp := window_pos_internal
				-- Try to use reuse window pos object if not already set.
			if l_wp.item /= default_pointer then
				create l_wp.make_by_pointer (lparam)
			else
				l_wp.set_item (lparam)
			end
			on_window_pos_changed (l_wp)
				-- Unset the shared pointer before returning.
			l_wp.set_item (default_pointer)
		end

	on_wm_dropfiles (wparam: POINTER)
			-- Wm_dropfile message
		require
			exists: exists
		do
		end

	default_process_message (msg: INTEGER; wparam, lparam: POINTER)
			-- Process `msg' which has not been processed by
			-- `process_message'.
		do
		end

	recursive_set_parent (a_parent: WEL_WINDOW): POINTER
			-- Helper function for `set_parent'. It is needed because Windows
			-- will report an error even if it is valid to set the parent. The
			-- cause is that Windows doesn't like deeply nested window.
			-- To circumvent the issue we trick Windows by removing the parent
			-- from the tree, adding the child to the parent, and then adding
			-- back the parent to the tree (for the first parenting operation
			-- we assume that no failure can occur thus the checks).
			-- If it works we are done, otherwise we repeat the same operation
			-- recursively on the parent as it often does not work at the first level
			-- until we reached no parent.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		local
			l_parent_of_parent: detachable WEL_WINDOW
			l_previous_child_parent: POINTER
			l_failure: BOOLEAN
		do
			l_parent_of_parent := a_parent.parent
			if l_parent_of_parent /= Void then
					-- Remove parenting information from `a_parent'.
				Result := {WEL_API}.set_parent (a_parent.item, set_parent_window.item)
				check no_failure: Result /= default_pointer end
					-- Add `Current' as child of `a_parent'. It should not fail
					-- since we are only one level deep.
				l_previous_child_parent := {WEL_API}.set_parent (item, a_parent.item)
				l_failure := l_previous_child_parent = default_pointer
					-- Now rebuild the parenting information of `a_parent' (failure or not it is the same)
				Result := {WEL_API}.set_parent (a_parent.item, l_parent_of_parent.item)
				if l_failure then
						-- We are in the same state as we came on entry.
					Result := default_pointer
				elseif Result = default_pointer then
					Result := a_parent.recursive_set_parent (l_parent_of_parent)
					if Result = default_pointer then
							-- We have to reconstruct the tree as it was originally.
						check has_parent: l_previous_child_parent /= default_pointer end
						Result := {WEL_API}.set_parent (item, l_previous_child_parent)
						Result := {WEL_API}.set_parent (a_parent.item, l_parent_of_parent.item)
						Result := default_pointer
					end
				end
			end
		end

feature {NONE} -- Implementation

	set_parent_window: WEL_WINDOW
			-- Window used by `recursive_set_parent' to temporary store a window in it.
			-- Before we were using no window, but then the windows would briefly flash
			-- on screen which is not very nice.
		once
			create {WEL_FRAME_WINDOW} Result.make_top ("Window used for fixing bug in SetParent")
		ensure
			set_parent_window_not_void: Result /= Void
			set_parent_window_not_destroyed: Result.exists
		end

feature {WEL_ABSTRACT_DISPATCHER, WEL_WINDOW} -- Implementation

	window_process_message, process_message (hwnd: POINTER; msg: INTEGER;
		wparam, lparam: POINTER): POINTER
			-- Call the routine `on_*' corresponding to the
			-- message `msg'.
		require
			exists: exists
		local
			l_message: detachable WEL_COMMAND_EXEC
			l_commands: like commands
		do
			inspect msg
			when Wm_mousemove then
				on_mouse_move (wparam.to_integer_32,
					x_position_from_lparam (lparam),
					y_position_from_lparam (lparam))
			when Wm_setcursor then
				on_set_cursor (cwin_lo_word (lparam))
			when Wm_windowposchanging then
				on_wm_window_pos_changing (lparam)
			when Wm_windowposchanged then
				on_wm_window_pos_changed (lparam)
			when Wm_move then
				on_move (x_position_from_lparam (lparam), y_position_from_lparam (lparam))
					-- Set `internal_wm_size_called' for fixing
					-- `move_and_resize_internal', `move' and `resize' by sending
					-- a  WM_SIZE message when Windows failed to do so.
				internal_wm_size_called := True
			when Wm_size then
				on_size (wparam.to_integer_32, cwin_lo_word (lparam), cwin_hi_word (lparam))
					-- Set `internal_wm_size_called' for fixing
					-- `move_and_resize_internal', `move' and `resize' by sending
					-- a  WM_SIZE message when Windows failed to do so.
				internal_wm_size_called := True

			when Wm_nccalcsize then
			when Wm_lbuttondown then
				on_left_button_down (wparam.to_integer_32,
					x_position_from_lparam (lparam),
					y_position_from_lparam (lparam))
			when Wm_lbuttonup then
				on_left_button_up (wparam.to_integer_32,
					x_position_from_lparam (lparam),
					y_position_from_lparam (lparam))
			when Wm_lbuttondblclk then
				on_left_button_double_click (wparam.to_integer_32,
					x_position_from_lparam (lparam),
					y_position_from_lparam (lparam))
			when Wm_mbuttondown then
				on_middle_button_down (wparam.to_integer_32,
					x_position_from_lparam (lparam),
					y_position_from_lparam (lparam))
			when Wm_mbuttonup then
				on_middle_button_up (wparam.to_integer_32,
					x_position_from_lparam (lparam),
					y_position_from_lparam (lparam))
			when Wm_mbuttondblclk then
				on_middle_button_double_click (wparam.to_integer_32,
					x_position_from_lparam (lparam),
					y_position_from_lparam (lparam))
			when Wm_rbuttondown then
				on_right_button_down (wparam.to_integer_32,
					x_position_from_lparam (lparam),
					y_position_from_lparam (lparam))
			when Wm_rbuttonup then
				on_right_button_up (wparam.to_integer_32,
					x_position_from_lparam (lparam),
					y_position_from_lparam (lparam))
			when Wm_rbuttondblclk then
				on_right_button_double_click (wparam.to_integer_32,
					x_position_from_lparam (lparam),
					y_position_from_lparam (lparam))
			when Wm_mousewheel then
				on_mouse_wheel (c_mouse_wheel_delta (wparam),
					cwin_lo_word (wparam),
					x_position_from_lparam (lparam),
					y_position_from_lparam (lparam))
			when Wm_timer then
				on_timer (wparam.to_integer_32)
			when Wm_setfocus then
				on_set_focus
			when Wm_killfocus then
				on_kill_focus
			when Wm_char then
				on_char (wparam.to_integer_32, lparam.to_integer_32)
			when Wm_keydown then
				on_key_down (wparam.to_integer_32, lparam.to_integer_32)
			when Wm_keyup then
				on_key_up (wparam.to_integer_32, lparam.to_integer_32)
			when Wm_syschar then
				on_sys_char (wparam.to_integer_32, lparam.to_integer_32)
			when Wm_syskeydown then
				on_sys_key_down (wparam.to_integer_32, lparam.to_integer_32)
			when Wm_syskeyup then
				on_sys_key_up (wparam.to_integer_32, lparam.to_integer_32)
			when Wm_showwindow then
				on_wm_show_window (wparam.to_integer_32, lparam.to_integer_32)
			when Wm_notify then
				on_wm_notify (wparam, lparam)
			when Wm_destroy then
				on_wm_destroy
			when Wm_ncdestroy then
				on_wm_nc_destroy
					-- After this call, windows has really destroyed the current object, so we simply
					-- need to reset `item'.
				item := default_pointer
			when Wm_erasebkgnd then
				on_wm_erase_background (wparam)
			when Wm_activate then
				on_wm_activate (wparam.to_integer_32)
			when wm_getdlgcode then
				on_getdlgcode
			when Wm_dropfiles then
				on_wm_dropfiles (wparam)
			when wm_themechanged then
				on_wm_theme_changed
			when wm_queryuistate, wm_changeuistate, wm_updateuistate then
					-- Override windows behavior so that when running on Windows XP
					-- with a manifest file you get the focus outline rectangle on
					-- controls.
				disable_default_processing
			when wm_dpichanged then
				on_wm_dpi_changed (wparam, lparam)
			else
				default_process_message (msg, wparam, lparam)
			end
			l_commands := commands
			if l_commands /= Void and then commands_enabled and then l_commands.has (msg) then
				l_message := l_commands.item (msg)
					-- Per checking.
				check l_message_attached: l_message /= Void then end
				l_message.execute (Current, msg, wparam, lparam)
			end
		end

	call_default_window_procedure (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER): POINTER
		do
			Result := cwin_def_window_proc (hwnd, msg, wparam, lparam)
		end

feature -- Registration

	frozen register_current_window
			-- Register `Current' in window manager.
		local
			l_old_data: POINTER
			l_object_id: like internal_object_id
		do
			l_object_id := internal_object_id
				-- If object was already registered, no need to create a new entry.
			if l_object_id = 0 then
				l_object_id := eif_current_object_id
				internal_object_id := l_object_id
			end
			l_old_data := {WEL_API}.set_window_long (item, Gwlp_userdata, cwel_integer_to_pointer (l_object_id))
		ensure
			registered: is_registered
		end

	is_registered: BOOLEAN
			-- Is `window' registered?
		local
			l_data, null: POINTER
			l_object_id: like internal_object_id
		do
				-- Default is `Result := False'.
			if exists then
				l_data := {WEL_API}.get_window_long (item, gwlp_userdata)
				if l_data /= null then
					l_object_id := l_data.to_integer_32
					Result := l_object_id = internal_object_id and then eif_is_object_id_of_current (l_object_id)
				end
			end
		end

feature {NONE} -- Registration

	frozen internal_object_id: INTEGER
			-- Data set to widget at creation.
			-- Used for having weak references

feature {WEL_WINDOW} -- Properties

	is_located_inside (window: WEL_WINDOW): BOOLEAN
			-- Is `Current' directly or indirectly located inside `window'?
		local
			l_parent: like parent
		do
			if window = Current then
				Result := True
			else
				l_parent := parent
				if l_parent = Void then
					Result := False
				else
					Result := l_parent.is_located_inside (window)
				end
			end
		end

feature {NONE} -- Removal

	dispose
			-- Free allocated memory.
		local
			l_object_id: INTEGER
		do
				-- Free weak reference taken by `internal_object_id'.
			l_object_id := internal_object_id
			if l_object_id > 0 then
				eif_object_id_free (l_object_id)
				internal_object_id := -1
			end

			Precursor {WEL_ANY}
		end

	frozen destroy_item
			-- Called by GC and `item' is still not equal to default_pointer,
			-- meaning that `destroy' has not been called. We need to call it.
		do
			destroy_item_from_context (True)
		end

	frozen destroy_item_from_context (is_from_gc: BOOLEAN)
			-- Cleanup current. If `is_from_gc' then it was called from `dispose',
			-- otherwise from a call to `destroy'.
		local
			l_null: POINTER
			p, hwnd: POINTER
			l_result: BOOLEAN
		do
				-- Take care of `item'.
			hwnd := item
			if hwnd /= l_null and then is_window (hwnd) then
					-- When called from `dispose' we do not want to come back in Eiffel code
					-- in the call to `{WEL_API}.destroy_window'. This is why we reset the dispatched
					-- pointer but only in non .NET mode. In .NET mode, it does not matter as the
					-- GC thread runs in its own thread and if WEL is compiled in mono-threaded mode,
					-- we might have a race condition since there is only one WEL_DISPATCHER object,
					-- thus while collecting some message might not be processed correctly.
				if is_from_gc and not {PLATFORM}.is_dotnet then
						-- Save protected reference to `dispatcher' object.
					p := cwel_dispatcher_pointer

						-- No more `dispatcher' object is called from C code of WEL,
						-- avoiding to go through Eiffel when destroying the window.
					cwel_set_dispatcher_pointer (l_null)
				end

					-- Destroying the window.
				l_result := {WEL_API}.destroy_window (hwnd)
				if not l_result then
						-- In a multithreaded application it may fail when the thread
						-- who created `hwnd' is not the current thread. This means
						-- that the current windows was not destroyed.
						-- To ensure that the window will be destroyed, we send a
						-- WM_CLOSE message which by default calls `DestroyWindow'
						-- but this time it will be done in the proper thread.
						-- When Current is a dialog, sending WM_CLOSE does not have any effect
						-- (at least on .NET) and instead we call `{WEL_API}.end_dialog'.
					if cwin_get_window_long (hwnd, dwlp_dlgproc) /= l_null then
						l_result := {WEL_API}.end_dialog (hwnd, cwel_integer_to_pointer (0))
					else
						{WEL_API}.post_message (hwnd, wm_close, l_null, l_null)
					end
				end

				if is_from_gc and not {PLATFORM}.is_dotnet then
						-- Restore `dispatcher' object so that dispatching can proceed.
					cwel_set_dispatcher_pointer (p)
				end
			end
			item := l_null
		ensure
			not_exists: not exists
		end

	track_mouse_event (info: WEL_TRACK_MOUSE_EVENT): BOOLEAN
			-- Start a windows TRACKMOUSEEVENT dependent on information
			-- contained in `info'
		require
			info_not_void: info /= Void
			info_exists: info.exists
		do
			Result := cwin_track_mouse_event (info.item)
		end

feature {WEL_WINDOW} -- Windows bug workaround

	frozen move_and_resize_internal (a_x, a_y, a_width, a_height: INTEGER; repaint: BOOLEAN; a_flags: INTEGER)
			-- Move the window to `a_x', `a_y' position and
			-- resize it with `a_width', `a_height'.
			-- This wrapper around `cwin_move_window' is required to solve an issue with
			-- Windows not sending a WM_SIZE message when setting the size of a deeply nested window.
			-- Experiment shows it is happening when the window is at a 32 level deep on 32 bits,
			-- and 16 level deep on 64 bits.
			-- This is a limitation that the windows kernel imposes on the messaging system
			-- so that the callstack is not too deep. To circumvent this we simply call
			-- `PostMessage' when it fails to resize the window.
		require
			exists: exists
		local
			l_diff: BOOLEAN
			l_flags: INTEGER
			l_pos: WEL_WINDOW_POS
		do
				-- Reset `internal_wm_size_called'. It is set to True in `process_message'
				-- when receiving a WM_SIZE message.
			internal_wm_size_called := False

				-- Compute `SetWindowPos' flags.
			l_flags := a_flags | Swp_nozorder | Swp_noactivate
			if not repaint then
				l_flags := l_flags | swp_noredraw
			end

				-- Find out if a size change was requested.
			l_diff := ((l_flags & swp_nosize) = 0) and then (a_width /= width or a_height /= height)

				 -- Perform call to `SetWindowPos'.
			if not {WEL_API}.set_window_pos (item, default_pointer, a_x, a_y,  a_width, a_height, l_flags) then
					-- An error occurred, what can we do then?
				do_nothing
			end

			if l_diff and then not internal_wm_size_called then
					-- Because messaging processing is actually done in kernel mode where call stack
					-- size is limited (and half the size on 64-bit because Microsoft did not change
					-- the limit), when a stack overflow occurs it is silently caught by the kernel
					-- and it simply returns without having sent either of the resizing messages:
					-- WM_SIZE or WM_WINDOWPOSCHANGED.
					-- To fix this, we are sending a special message to `silly_window' that contains
					-- the requested resizing information that will be send on the next processing
					-- of the event queue.
					-- Thanks to `l_diff' we are able to catch cases where a resizing message
					-- was not sent because it did not need to.
					-- Ideally, we should hook to the resizing to WM_WINDOWPOSCHANGED instead of
					-- WM_SIZE because it creates less stack size in kernel mode to push the limit
					-- slightly further.

					-- Store the various arguments of the call.
				create l_pos.make
				l_pos.set_hwnd (item)
				l_pos.set_x (a_x)
				l_pos.set_y (a_y)
				l_pos.set_width (a_width)
				l_pos.set_height (a_height)
				l_pos.set_flags (l_flags)
					-- The receiver of the message will free the allocated memory for `l_pos'.
				l_pos.set_shared
					-- Post the message to `silly_window'.
				{WEL_API}.post_message (silly_window.item, {WEL_RESIZING_SUPPORT}.wm_set_window_pos_msg, l_pos.item, to_lparam(0))
			end
		end

	internal_wm_size_called: BOOLEAN
			-- Was `WM_SIZE' message received just after a call to `MoveWindow'/`SetWindowPos'?
			-- See comments on `move_and_resize_internal' for more details.

feature {NONE} -- Constants

	Wel_gcl_constants: WEL_GCL_CONSTANTS
		once
			create Result
		end

feature {NONE} -- Implementation

	frozen window_pos_internal: WEL_WINDOW_POS
			-- Reusable WEL_WINDOW_POS to avoid creation of a new object on each WM_WINDOWPOSCHANGING/CHANGED
			-- Do not use.
		once
			create Result.make_by_pointer (default_pointer)
		end

feature {NONE} -- Externals

	cwin_create_window_ex (a_ex_stlyle: INTEGER; a_class_name,
				a_name: POINTER; a_style, a_x, a_y, a_w,
				a_h: INTEGER; a_parent_hwnd: POINTER;
				an_id: POINTER; a_hinstance,
				param: POINTER): POINTER
			-- SDK CreateWindowEx
		external
			"C [macro %"wel.h%"] (DWORD, LPCTSTR, LPCTSTR, DWORD, int, %
				%int, int, int, HWND, HMENU, HINSTANCE, %
				%LPVOID): EIF_POINTER"
		alias
			"CreateWindowEx"
		end

	cwin_set_parent (hwmd_child, hwmd_parent: POINTER)
			-- Change the parent of the given child and return handle to
			-- previous parent, or NULL otherwise.
		obsolete
			"Use {WEL_API}.set_parent instead [2017-05-31]."
		external
			"C [macro <winuser.h>] (HWND, HWND)"
		alias
			"SetParent"
		end

	cwin_destroy_window (hwnd: POINTER): INTEGER
			-- SDK DestroyWindow
		external
			"C [macro %"wel.h%"] (HWND): BOOL"
		alias
			"DestroyWindow"
		end

	cwin_drag_accept_files (hwnd: POINTER; accept: BOOLEAN)
			-- SDK DragAcceptFiles
		external
			"C inline use %"wel.h%""
		alias
			"DragAcceptFiles ((HWND) $hwnd, (BOOL) $accept)"
		end

	cwin_drag_query_file (hdrop: POINTER; ifile: INTEGER; buffer_pointer: POINTER; buffer_size: INTEGER): INTEGER
			-- SDK DragQueryFile
		external
			"C inline use %"wel.h%""
		alias
			"DragQueryFile ((HDROP) $hdrop, (UINT) $ifile, (LPTSTR) $buffer_pointer, (UINT) $buffer_size)"
		end

	cwin_is_iconic (hwnd: POINTER): BOOLEAN
			-- SDK IsIconic
		external
			"C [macro %"wel.h%"] (HWND): EIF_BOOLEAN"
		alias
			"IsIconic"
		end

	cwin_is_zoomed (hwnd: POINTER): BOOLEAN
			-- SDK IsZoomed
		external
			"C [macro %"wel.h%"] (HWND): EIF_BOOLEAN"
		alias
			"IsZoomed"
		end

	cwin_enable_window (hwnd: POINTER; enable_flag: BOOLEAN)
			-- SDK EnableWindow
		external
			"C [macro %"wel.h%"] (HWND, BOOL)"
		alias
			"EnableWindow"
		end

	cwin_is_window_enabled (hwnd: POINTER): BOOLEAN
			-- SDK IsWindowEnabled
		external
			"C [macro %"wel.h%"] (HWND): EIF_BOOLEAN"
		alias
			"IsWindowEnabled"
		end

	cwin_set_focus (hwnd: POINTER)
			-- SDK SetFocus
		external
			"C [macro %"wel.h%"] (HWND)"
		alias
			"SetFocus"
		end

	cwin_set_timer (hwnd: POINTER; timer_id, time_out: INTEGER; proc: POINTER)
			-- SDK SetTimer
		external
			"C [macro %"wel.h%"] (HWND, UINT_PTR, UINT, TIMERPROC)"
		alias
			"SetTimer"
		end

	cwin_kill_timer (hwnd: POINTER; timer_id: INTEGER)
			-- SDK KillTimer
		external
			"C [macro %"wel.h%"] (HWND, UINT_PTR)"
		alias
			"KillTimer"
		end

	cwin_get_focus: POINTER
			-- SDK GetFocus
		obsolete
			"Use {WEL_API}.get_focus instead [2017-05-31]."
		external
			"C [macro %"wel.h%"]: EIF_POINTER"
		alias
			"GetFocus ()"
		end

	cwin_set_capture (hwnd: POINTER)
			-- SDK SetCapture
		external
			"C inline use %"wel_capture.h%""
		alias
			"cwel_capture ((HWND) $hwnd);"
		end

	cwin_release_capture
			-- SDK ReleaseCapture
		external
			"C inline use %"wel_capture.h%""
		alias
			"cwel_release_capture ();"
		end

	cwin_get_capture: POINTER
			-- SDK GetCapture
		external
			"C inline use %"wel_capture.h%""
		alias
			"return (EIF_POINTER) cwel_captured_window();"
		end

	cwin_show_window (hwnd: POINTER; cmd_show: INTEGER)
			-- SDK ShowWindow
		external
			"C [macro %"wel.h%"] (HWND, int)"
		alias
			"ShowWindow"
		ensure
			is_class: class
		end

	cwin_is_window_visible (hwnd: POINTER): BOOLEAN
			-- SDK IsWindowVisible
		external
			"C [macro %"wel.h%"] (HWND): EIF_BOOLEAN"
		alias
			"IsWindowVisible"
		end

	cwin_set_window_text (hwnd, str: POINTER)
			-- SDK SetWindowText
		obsolete
			"Use {WEL_API}.set_window_text instead [2017-05-31]."
		external
			"C [macro %"wel.h%"] (HWND, LPCTSTR)"
		alias
			"SetWindowText"
		end

	cwin_get_window_text_length (hwnd: POINTER): INTEGER
			-- SDK GetWindowTextLength
		external
			"C [macro %"wel.h%"] (HWND): EIF_INTEGER"
		alias
			"GetWindowTextLength"
		end

	cwin_get_window_text (hwnd, str: POINTER; len: INTEGER): INTEGER
			-- SDK GetWindowText
		external
			"C [macro %"wel.h%"] (HWND, LPTSTR, int): EIF_INTEGER"
		alias
			"GetWindowText"
		end

	cwin_message_box_result (hwnd, a_text, a_title: POINTER;
			a_style: INTEGER): INTEGER
			-- SDK MessageBox (with result)
		external
			"C [macro %"wel.h%"] (HWND, LPCTSTR, LPCTSTR, %
				%UINT): EIF_INTEGER"
		alias
			"MessageBox"
		end

	cwin_message_box (hwnd, a_text, a_title: POINTER;
			a_style: INTEGER)
			-- SDK MessageBox (without result)
		external
			"C [macro %"wel.h%"] (HWND, LPCTSTR, LPCTSTR, UINT)"
		alias
			"MessageBox"
		end

	cwin_def_window_proc (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER): POINTER
			-- SDK DefWindowProc
		external
			"C [macro <windows.h>] (HWND, UINT, WPARAM, LPARAM): LRESULT"
		alias
			"DefWindowProc"
		end

	cwin_update_window (hwnd: POINTER)
			-- SDK UpdateWindow
		external
			"C [macro %"wel.h%"] (HWND)"
		alias
			"UpdateWindow"
		end

	cwin_track_mouse_event (struct: POINTER): BOOLEAN
		external
			"C [macro %"wel.h%"] (TRACKMOUSEEVENT*): EIF_BOOLEAN"
		alias
			"_TrackMouseEvent"
		end

	cwin_invalidate_rgn (hwnd, a_region: POINTER;
			erase_background: BOOLEAN)
			-- SDK InvalidateRgn
		external
			"C [macro %"wel.h%"] (HWND, HRGN, BOOL)"
		alias
			"InvalidateRgn"
		end

	cwin_validate_rect (hwnd, a_rect: POINTER)
			-- SDK ValidateRect
		external
			"C [macro %"wel.h%"] (HWND, RECT *)"
		alias
			"ValidateRect"
		end

	cwin_validate_rgn (hwnd, a_region: POINTER)
			-- SDK ValidateRgn
		external
			"C [macro %"wel.h%"] (HWND, HRGN)"
		alias
			"ValidateRgn"
		end

	cwin_send_message_result (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER): POINTER
			-- SDK SendMessage (with the result)
		obsolete
			"Use {WEL_API}.send_message_result instead [2017-05-31]."
		external
			"C [macro %"wel.h%"] (HWND, UINT, WPARAM, LPARAM): EIF_POINTER"
		alias
			"SendMessage"
		end

	cwin_send_message_result_integer (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER): INTEGER
			-- SDK SendMessage (with the result)
		obsolete
			"Use {WEL_API}.send_message_result_integer instead [2017-05-31]."
		external
			"C [macro %"wel.h%"] (HWND, UINT, WPARAM, LPARAM): EIF_INTEGER"
		alias
			"SendMessage"
		end

	cwin_send_message (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER)
			-- SDK SendMessage (without the result)
		obsolete
			"Use {WEL_API}.send_message instead [2017-05-31]."
		external
			"C [macro %"wel.h%"] (HWND, UINT, WPARAM, LPARAM)"
		alias
			"SendMessage"
		end

	cwin_post_message_result (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER): BOOLEAN
			-- SDK PostMessage (with the result)
		obsolete
			"Use {WEL_API}.post_message_result instead [2017-05-31]."
		external
			"C [macro %"wel.h%"] (HWND, UINT, %
				%WPARAM, LPARAM): EIF_BOOLEAN"
		alias
			"PostMessage"
		end

	cwin_post_message (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER)
			-- SDK PostMessage (without the result)
		obsolete
			"Use {WEL_API}.post_message instead [2017-05-31]."
		external
			"C [macro %"wel.h%"] (HWND, UINT, WPARAM, LPARAM)"
		alias
			"PostMessage"
		end

	cwin_bring_window_to_top (hwnd: POINTER): BOOLEAN
			-- SDK BringWindowToTop, Return True is case of Success
		external
			"C [macro %"wel.h%"] (HWND): BOOL"
		alias
			"BringWindowToTop"
		end

	cwin_move_window (hwnd: POINTER; a_x, a_y, a_w, a_h: INTEGER;
				repaint: BOOLEAN)
			-- SDK MoveWindow
		obsolete
			"Use {WEL_API}.move_window (x, y, w, h, b).do_nothing instead [2017-05-31]."
		external
			"C [macro %"wel.h%"] (HWND, int, int, int, int, BOOL)"
		alias
			"MoveWindow"
		end

	cwin_set_window_pos (hwnd, hwnd_after: POINTER; a_x, a_y, a_w, a_h,
				flags: INTEGER)
			-- SDK SetWindowPos
		obsolete
			"Use {WEL_API}.set_window_pos (hwnd, hwnd_after, a_x, a_y, a_w, a_h, flags).do_nothing instead [2017-05-31]."
		external
			"C [macro %"wel.h%"] (HWND, HWND, int, int, int, int, UINT)"
		alias
			"SetWindowPos"
		end

	cwin_set_window_placement (hwnd, a_placement: POINTER)
			-- SDK SetWindowPlacement
		external
			"C [macro %"wel.h%"] (HWND, WINDOWPLACEMENT *)"
		alias
			"SetWindowPlacement"
		end

	cwin_show_scroll_bar (hwnd: POINTER; bar_flag: INTEGER;
			show_flag: BOOLEAN)
			-- SDK ShowScrollBar
		external
			"C [macro %"wel.h%"] (HWND, int, BOOL)"
		alias
			"ShowScrollBar"
		end

	cwin_enable_scroll_bar (hwnd: POINTER; wsbflags, warrows: INTEGER)
			-- SDK EnableScrollBar
		external
			"C [macro %"wel.h%"] (HWND, int, int)"
		alias
			"EnableScrollBar"
		end

	cwin_scroll_window (hwnd: POINTER; a_x, a_y: INTEGER;
			scroll_rect, clip_rect: POINTER)
			-- SDK ScrollWindow
		external
			"C [macro %"wel.h%"] (HWND, int, int, RECT *, RECT *)"
		alias
			"ScrollWindow"
		end

	cwin_win_help (hwnd, file: POINTER; a_command, data: INTEGER)
			-- SDK WinHelp
		external
			"C [macro %"wel.h%"] (HWND, LPCTSTR, UINT, DWORD)"
		alias
			"WinHelp"
		end

	c_mouse_wheel_delta (wparam: POINTER): INTEGER
		external
			"C inline use <windows.h>"
		alias
			"((short)HIWORD($wparam))"
		end

	x_position_from_lparam (lparam: POINTER): INTEGER
		external
			"C macro use %"winx.h%""
		alias
			"GET_X_LPARAM"
		end

	y_position_from_lparam (lparam: POINTER): INTEGER
		external
			"C macro use %"winx.h%""
		alias
			"GET_Y_LPARAM"
		end

	cwel_window_procedure_address: POINTER
		external
			"C [macro <disptchr.h>]"
		end

	c_lock_window_update (hwnd_lock: POINTER): BOOLEAN
		external
			"C [macro %"wel.h%"] (HWND): EIF_BOOLEAN"
		alias
			"LockWindowUpdate"
		end

	cwin_set_class_long (hwnd: POINTER; n_index: INTEGER; new_value: POINTER)
			-- SDK SetClassLong
		external
			"C [macro %"wel.h%"] (HWND, int, LONG_PTR)"
		alias
			"SetClassLongPtr"
		end

	cwel_set_dispatcher_pointer (dispatcher_ptr: POINTER)
		external
			"C [macro %"disptchr.h%"]"
		end

	cwel_dispatcher_pointer: POINTER
		external
			"C [macro %"disptchr.h%"]"
		end

	cwel_get_message_pos: INTEGER
		external
			"[
				C signature (): DWORD
				use <windows.h>
			]"
		alias
			"GetMessagePos"
		end

feature {WEL_INPUT_EVENT} -- Externals

	cwin_invalidate_rect (hwnd, a_rect: POINTER; erase_background: BOOLEAN)
			-- SDK InvalidateRect
		external
			"C [macro %"wel.h%"] (HWND, RECT *, BOOL)"
		alias
			"InvalidateRect"
		end



note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
