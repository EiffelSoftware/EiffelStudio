indexing
	description: "Abstract notions of a window."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_WINDOW

inherit
	WEL_ANY

	WEL_WINDOW_MANAGER
		export
			{NONE} all
		undefine
			is_equal
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

	WEL_RETURN_VALUE
		
feature -- Access

	parent: WEL_WINDOW
			-- Parent window

	commands: WEL_COMMAND_MANAGER
			-- Command manager associated to the current window.

feature -- Status report

	is_inside: BOOLEAN is
			-- Is the current window inside another window?
		do
			Result := flag_set (style, Ws_child)
		end

	default_processing_enabled: BOOLEAN is 
		obsolete
			"Use `default_processing' instead"
			-- Is the default window processing enabled?
			-- If True (by default) the standard window
			-- procedure will be called. Otherwise, the standard
			-- window procedure will not be called and the
			-- normal behavior will not occur.
		do
			Result := default_processing
		end

	enabled: BOOLEAN is
			-- Is the window enabled for mouse and keyboard input?
		require
			exists: exists
		do
			Result := cwin_is_window_enabled (item)
		end

	shown: BOOLEAN is
			-- Is the window shown?
		require
			exists: exists
		do
			Result := cwin_is_window_visible (item)
		end

	minimized: BOOLEAN is
			-- Is the window minimized?
		require
			exists: exists
		do
			Result := cwin_is_iconic (item)
		end

	maximized: BOOLEAN is
			-- Is the window maximized?
		require
			exists: exists
		do
			Result := cwin_is_zoomed (item)
		end

	focused_window: WEL_WINDOW is
			-- Current window which has the focus.
		require
			exists: exists
		do
			Result := window_of_item (cwin_get_focus)
		end

	captured_window: WEL_WINDOW is
			-- Current window which has been captured.
		require
			exists: exists
			window_captured: window_captured
		do
			Result := window_of_item (cwin_get_capture)
		end

	window_captured: BOOLEAN is
			-- Has a window been captured?
		do
			Result := cwin_get_capture /= default_pointer
		end

	has_focus: BOOLEAN is
			-- Does this window have the focus?
		require
			exists: exists
		do
			Result := focused_window = Current
		end

	has_capture: BOOLEAN is
			-- Does this window have the capture?
		require
			exists: exists
		do
			Result := window_captured and then
				captured_window = Current
		end

	has_vertical_scroll_bar: BOOLEAN is
			-- Does this window have a vertical scroll bar?
		require
			exists: exists
		do
			Result := flag_set (style, Ws_vscroll)
		end

	has_horizontal_scroll_bar: BOOLEAN is
			-- Does this window have a horizontal scroll bar?
		require
			exists: exists
		do
			Result := flag_set (style, Ws_hscroll)
		end

	x: INTEGER is
			-- Window x position
		require
			exists: exists
		local
			rect: WEL_RECT
			point: WEL_POINT
		do
			if parent /= Void then
				-- Unfortunately, there is no easy
				-- way to get the relative x position of
				-- a child!
				rect := window_rect
				create point.make (rect.x, rect.y)
				point.screen_to_client (parent)
				Result := point.x
			else
				Result := absolute_x
			end
		ensure
			parent = Void implies Result = absolute_x
		end

	y: INTEGER is
			-- Window y position
		require
			exists: exists
		local
			rect: WEL_RECT
			point: WEL_POINT
		do
			if parent /= Void then
				-- Unfortunately, there is no easy
				-- way to get the relative y position of
				-- a child!
				rect := window_rect
				create point.make (rect.x, rect.y)
				point.screen_to_client (parent)
				Result := point.y
			else
				Result := absolute_y
			end
		ensure
			parent = Void implies Result = absolute_y
		end

	width: INTEGER is
			-- Window width
		require
			exists: exists
		do
			Result := window_rect.width
		end

	height: INTEGER is
			-- Window height
		require
			exists: exists
		do
			Result := window_rect.height
		end

	absolute_x: INTEGER is
			-- Absolute x position
		require
			exists: exists
		do
			Result := window_rect.x
		ensure
			Result = window_rect.x
		end

	absolute_y: INTEGER is
			-- Absolute y position
		require
			exists: exists
		do
			Result := window_rect.y
		ensure
			Result = window_rect.y
		end

	minimal_width: INTEGER is
			-- Minimal width allowed for the window
			-- Zero by default.
		do
		ensure
			positive_result: Result >= 0
			result_small_enough: Result <= maximal_width
		end

	maximal_width: INTEGER is
			-- Maximal width allowed for the window
		do
			Result := screen_width
		ensure
			result_large_enough: Result >= minimal_width
		end

	minimal_height: INTEGER is
			-- Minimal height allowed for the window
			-- Zero by default.
		do
		ensure
			positive_result: Result >= 0
			result_small_enough: Result <= maximal_height
		end

	maximal_height: INTEGER is
			-- Maximal height allowed for the window
		do
			Result := screen_height
		ensure
			result_large_enough: Result >= minimal_height
		end

	client_rect: WEL_RECT is
			-- Client rectangle
		require
			exists: exists
		do
			create Result.make_client (Current)
		ensure
			result_not_void: Result /= Void
		end

	window_rect: WEL_RECT is
			-- Window rectangle (absolute position)
		require
			exists: exists
		do
			create Result.make_window (Current)
		ensure
			result_not_void: Result /= Void
		end

	 text: STRING is
			-- Window text
		require
			exists: exists
		local
			length: INTEGER
			a_wel_string: WEL_STRING
			nb: INTEGER
		do
			length := text_length
			if length > 0 then
				length := length + 1
				create Result.make (length)
				Result.fill_blank
				create a_wel_string.make (Result)
				nb := cwin_get_window_text (item, a_wel_string.item, length)
				Result := a_wel_string.string
				Result.head (nb)
			else
				create Result.make (0)
			end
		ensure
			result_not_void: Result /= Void
		end

	text_length: INTEGER is
			-- Text length
		require
			exists: exists
		do
			Result := cwin_get_window_text_length (item)
		ensure
			positive_result: Result >= 0
		end

	placement: WEL_WINDOW_PLACEMENT is
			-- Window placement information
		require
			exists: exists
		do
			create Result.make (Current)
		ensure
			result_not_void: Result /= Void
		end

	style: INTEGER is
			-- Window style
		require
			exists: exists
		do
			Result := cwin_get_window_long (item, Gwl_style)
		end

	ex_style: INTEGER is
			-- Window ex_style
		require
			exists: exists
		do
			Result := cwin_get_window_long (item, Gwl_exstyle)
		end

	background_brush: WEL_BRUSH is
			-- Current window background color used to refresh the window when
			-- requested by the WM_ERASEBKGND windows message.
			-- By default there is no background
		do
		ensure
			new_object: Result /= Void implies Result /= background_brush
		end

	commands_enabled: BOOLEAN is
			-- Is the commands execution enabled?
		do
			Result := commands_enabled_ref.item
		end

	command_exists (message: INTEGER): BOOLEAN is
			-- Does a command associated to `message' exist?
		require
			positive_message: message >= 0
		do
			Result := commands /= Void and then
				commands.exists (message)
		end

	command (message: INTEGER): WEL_COMMAND is
			-- Command associated to `message'
		require
			positive_message: message >= 0
			command_exists: command_exists (message)
		do
			Result := commands.item (message).command
		ensure
			result_not_void: Result /= Void
		end

	command_argument (message: INTEGER): ANY is
			-- Command argument associated to `message'
		require
			positive_message: message >= 0
			command_exists: command_exists (message)
		do
			Result := commands.item (message).argument
		end

feature -- Status setting

	enable_commands is
			-- Enable commands execution.
		do
			commands_enabled_ref.set_item (True)
		ensure
			commands_enabled: commands_enabled
		end

	disable_commands is
			-- Disable commands execution.
		do
			commands_enabled_ref.set_item (False)
		ensure
			commands_disabled: not commands_enabled
		end

	enable_default_processing is
			-- Enable default window processing.
			-- The standard window procedure will be called for
			-- each messages received by the window and then the
			-- normal behavior will occur.
		do
			set_default_processing (True)
		ensure
			default_processing_enabled: default_processing
		end

	disable_default_processing is
			-- Disable default window processing.
			-- The standard window procedure will not be called for
			-- each messages received by the window and then the
			-- normal behavior will not occur.
		do
			set_default_processing (False)
		ensure
			default_processing_disabled: not default_processing
		end

	enable is
			-- Enable mouse and keyboard input.
		require
			exists: exists
		do
			cwin_enable_window (item, True)
		ensure
			enabled: enabled
		end

	disable is
			-- Disable mouse and keyboard input
		require
			exists: exists
		do
			cwin_enable_window (item, False)
		ensure
			disabled: not enabled
		end

	show is
			-- Show the window
		require
			exists: exists
		do
			cwin_show_window (item, Sw_show)
		end

	hide is
			-- Hide the window
		require
			exists: exists
		do
			cwin_show_window (item, Sw_hide)
		ensure
			hidden: not shown
		end

	minimize is
			-- Minimize the window and display its icon
		require
			exists: exists
		do
			cwin_show_window (item, Sw_showminimized)
		ensure
			minimized: minimized
		end

	maximize is
			-- Maximize the window
		require
			exists: exists
		do
			cwin_show_window (item, Sw_showmaximized)
		ensure
			maximized: maximized
		end

	restore is
			-- Restore the window to its
			-- original size and position after
			-- `minimize' or `maximize'
		require
			exists: exists
		do
			cwin_show_window (item, Sw_restore)
		end

	set_focus is
			-- Set the focus to `Current'
		require
			exists: exists
		do
			cwin_set_focus (item)
		end

	set_capture is
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
		ensure
			has_capture: has_capture
		end

	set_heavy_capture is
			-- Set the mouse capture to the `Current' window.
			-- Once the window has captured the mouse, all
			-- mouse input is directed to this window, regardless
			-- of whether the cursor is over that window. Only
			-- one window can have the mouse capture at a time.
			--
			-- Works for ALL windows.
		require
			exists: exists
			has_not_capture: not has_capture
		local
			has_heavy_capture: BOOLEAN
		do
			has_heavy_capture := cwel_hook_mouse (item)
			check
				capture_initialized: has_heavy_capture
			end
		end

	release_capture is
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

	release_heavy_capture is
			-- Release the mouse capture after a call
			-- to `set_heavy_capture'.
		require
			exists: exists
		local
			has_heavy_capture: BOOLEAN
		do
			has_heavy_capture := not cwel_unhook_mouse
			check
				capture_stopped: not has_heavy_capture
			end
		end

	set_style (a_style: INTEGER) is
			-- Set `style' with `a_style'.
		require
			exists: exists
		local
			cur_ex_style: INTEGER
		do
			cwin_set_window_long (item, Gwl_style, a_style)

				-- Update changes
			cur_ex_style := ex_style
			update_cached_style (cur_ex_style, cur_ex_style)
		end

	set_ex_style (an_ex_style: INTEGER) is
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
			cwin_set_window_long (item, Gwl_exstyle, an_ex_style)

				-- Update changes
			update_cached_style (old_ex_style, an_ex_style)
		end

	update_cached_style(new_ex_style, old_ex_style: INTEGER) is
			-- Update Window cache buffer for Window style.
			--|
			--| Certain window data is cached, so changes you make using 
			--| SetWindowLong will not take effect until you call the 
			--| SetWindowPos function. Specifically, if you change any 
			--| of the frame styles, you must call SetWindowPos with 
			--| the SWP_FRAMECHANGED flag for the cache to be updated 
			--| properly. 
		local
			Hwnd_const: POINTER
			Swp_const: INTEGER
		do
			if flag_set (new_ex_style, Ws_ex_topmost) then
				-- The new style specify "Top most", 
				-- so we change the current Z order to "Top most".
				Hwnd_const := Hwnd_topmost
			else
				if flag_set (old_ex_style, Ws_ex_topmost) then
					-- The old style specify "Top most", not the
					-- new one so we change the current Z order.
					Hwnd_const := Hwnd_notopmost
				else
					-- The old style does not specify "Top most", like the
					-- new one so ignore Z order changes.
					Swp_const := set_flag (Swp_const, Swp_nozorder)
				end
			end
			Swp_const := set_flag (Swp_const, Swp_nomove)
			Swp_const := set_flag (Swp_const, Swp_nosize)
			Swp_const := set_flag (Swp_const, Swp_framechanged)
			cwin_set_window_pos (item, Hwnd_const, 0, 0, 0, 0, Swp_const)
		end

feature -- Element change

	set_parent (a_parent: WEL_WINDOW) is
			-- Change the parent of the current window.
		require
			exists: exists
		do
			if a_parent /= Void then
				parent := a_parent
				cwin_set_parent (item, a_parent.item)
			else
				parent := Void
				cwin_set_parent (item, default_pointer)
			end
		end

	set_text (a_text: STRING) is
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
			cwin_set_window_text (item, a_wel_string.item)
		ensure
			text_set_when_not_void: a_text /= Void implies
				equal (text, a_text)
			text_set_when_void: a_text = Void implies	
				text.count = 0
		end
		
	set_placement (a_placement: WEL_WINDOW_PLACEMENT) is
			-- Set `placement' with `a_placement'
		require
			exists: exists
			a_placement_not_void: a_placement /= Void
		do
			cwin_set_window_placement (item, a_placement.item)
		ensure
			-- placement_set: placement = a_placement
		end

	set_x (a_x: INTEGER) is
			-- Set `x' with `a_x'
		require
			exists: exists
		do
			move (a_x, y)
		end

	set_y (a_y: INTEGER) is
			-- Set `y' with `a_y'
		require
			exists: exists
		do
			move (x, a_y)
		end

	set_width (a_width: INTEGER) is
			-- Set `width' with `a_width'
		require
			exists: exists
		do
			resize (a_width, height)
		end

	set_height (a_height: INTEGER) is
			-- Set `height' with `a_height'
		require
			exists: exists
		do
			resize (width, a_height)
		end

	set_timer (timer_id, time_out: INTEGER) is
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
		
	has_system_window_locked: BOOLEAN is
			-- Is there any window locked ?
		local
			b: BOOLEAN
		do
			Result := not c_lock_window_update (item)
			if not Result then
					b := c_lock_window_update (default_pointer)
					check
						success:b
					end
			end
		end
		
	lock_window_update is
			-- Disables drawing in the current window. A locked window cannot be moved.
			-- Only one window can be locked at a time. To unlock a window locked with 
			-- `lock_window_update' , call 'unlock_window_update'.
		require
			exists: exists
		local
			success : BOOLEAN
		do
			success := c_lock_window_update (item)
			check
				-- success: success
			end
		ensure
			has_system_window_locked
		end

	unlock_window_update is
			-- Unlock a locked window.	
		require
			exists: exists
		local
			success : BOOLEAN
		do
			success := c_lock_window_update (default_pointer)
			check
				-- success: success
			end
		end

feature -- Basic operations

	put_command (a_command: WEL_COMMAND; message: INTEGER; argument: ANY) is
			-- Put `a_command' associated to `message'.
		require
			a_command_not_void: a_command /= Void
			positive_message: message >= 0
		local
			command_exec: WEL_COMMAND_EXEC
		do
			-- Has a command been already put?
			-- If no, let's create `commands'.
			if commands = Void then
				create commands.make
			end
			create command_exec.make (a_command, argument)
			commands.force (command_exec, message)
		ensure
			command_added: command (message) = a_command and
				command_argument (message) = argument
		end

	remove_command (message: INTEGER) is
			-- Remove the command associated to `message'.
		require
			positive_message: message >= 0
			command_exists: command_exists (message)
		do
			commands.remove (message)
		ensure
			command_removed: not command_exists (message)
		end

	show_with_option (cmd_show: INTEGER) is
			-- Set the window's visibility with `cmd_show'.
			-- See class WEL_SW_CONSTANTS for `cmd_show' value.
		require
			exists: exists
			parent_shown: parent /= Void implies parent.exists and
				parent.shown
		do
			cwin_show_window (item, cmd_show)
		end

	move_and_resize (a_x, a_y, a_width, a_height: INTEGER;
			repaint: BOOLEAN) is
			-- Move the window to `a_x', `a_y' position and
			-- resize it with `a_width', `a_height'.
		require
			exists: exists
		do
			cwin_move_window (item, a_x, a_y,
				a_width, a_height, repaint)
		end

	move (a_x, a_y: INTEGER) is
			-- Move the window to `a_x', `a_y'.
		require
			exists: exists
		do
			cwin_set_window_pos (item, default_pointer,
				a_x, a_y, 0, 0,
				Swp_nosize + Swp_nozorder + Swp_noactivate)
		end

	resize (a_width, a_height: INTEGER) is
			-- Resize the window with `a_width', `a_height'.
		require
			exists: exists
		do
			cwin_set_window_pos (item, default_pointer,
				0, 0, a_width, a_height,
				Swp_nomove + Swp_nozorder + Swp_noactivate)
		end

	set_z_order (z_order: POINTER) is
			-- Set the z-order of the window.
			-- See class WEL_HWND_CONSTANTS for `z_order' values.
		require
			exists: exists
			valid_hwnd_constant: valid_hwnd_constant (z_order)
		do
			cwin_set_window_pos (item, z_order,
				0, 0, 0, 0, Swp_nosize + Swp_nomove +
				Swp_noactivate)
		end

	insert_after (a_window: WEL_WINDOW) is
			-- Insert the current window after `a_window'.
		require
			exists: exists
			a_window_not_void: a_window /= Void
			a_window_not_current: a_window /= Current
			a_window_exists: a_window.exists
		do
			cwin_set_window_pos (item, a_window.item, 0, 0, 0, 0,
				Swp_nosize + Swp_nomove + Swp_noactivate)
		end

	show_scroll_bars is
			-- Show the horizontal and vertical scroll bars.
		require
			exists: exists
		do
			cwin_show_scroll_bar (item, Sb_both, True)
		end

	show_vertical_scroll_bar is
			-- Show the vertical scroll bar.
		require
			exists: exists
		do
			cwin_show_scroll_bar (item, Sb_vert, True)
		end

	show_horizontal_scroll_bar is
			-- Show the horizontal scroll bar.
		require
			exists: exists
		do
			cwin_show_scroll_bar (item, Sb_horz, True)
		end

	hide_scroll_bars is
			-- Hide the horizontal and vertical scroll bars.
		require
			exists: exists
		do
			cwin_show_scroll_bar (item, Sb_both, False)
		end

	hide_vertical_scroll_bar is
			-- Hide the vertical scroll bar.
		require
			exists: exists
		do
			cwin_show_scroll_bar (item, Sb_vert, False)
		end

	hide_horizontal_scroll_bar is
			-- Hide the horizontal scroll bar.
		require
			exists: exists
		do
			cwin_show_scroll_bar (item, Sb_horz, False)
		end

	disable_horizontal_scroll_bar is
			-- Disable the horizontal scroll bar.
		require
			exists: exists
		do
			cwin_enable_scroll_bar (item, Sb_horz, Esb_disable_both)
		end

	enable_horizontal_scroll_bar is
			-- Enable the horizontal scroll bar.
		require
			exists: exists
		do
			cwin_enable_scroll_bar (item, Sb_horz, Esb_enable_both)
		end

	disable_vertical_scroll_bar is
			-- Disable the vertical scroll bar.
		require
			exists: exists
		do
			cwin_enable_scroll_bar (item, Sb_vert, Esb_disable_both)
		end

	enable_vertical_scroll_bar is
			-- Enable the vertical scroll bar.
		require
			exists: exists
		do
			cwin_enable_scroll_bar (item, Sb_vert, Esb_enable_both)
		end

	message_box (a_text, a_title: STRING; a_style: INTEGER): INTEGER is
		obsolete "Use class WEL_MSG_BOX instead"
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

	information_message_box (a_text, a_title: STRING) is
		obsolete "Use class WEL_MSG_BOX instead"
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

	warning_message_box (a_text, a_title: STRING) is
		obsolete "Use class WEL_MSG_BOX instead"
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

	error_message_box (a_text: STRING) is
		obsolete "Use class WEL_MSG_BOX instead"
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

	question_message_box (a_text, a_title: STRING): BOOLEAN is
		obsolete "Use class WEL_MSG_BOX instead"
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

	update is
			-- Update the client area by sending a Wm_paint message.
		require
			exists: exists
		do
			cwin_update_window (item)
		end

	invalidate is
			-- Invalide the entire client area of the window. The
			-- background will be erased before.
		require
			exists: exists
		do
			cwin_invalidate_rect (item, default_pointer, True)
		end

	invalidate_without_background is
			-- Invalidate the entire client area of the window. The
			-- background will not be erased.
		require
			exists: exists
		do
			cwin_invalidate_rect (item, default_pointer, False)
		end

	invalidate_rect (rect: WEL_RECT; erase_background: BOOLEAN) is
			-- Invalidate the area `rect' and erase
			-- the background if `erase_background' is True.
		require
			exists: exists
			rect_not_void: rect /= Void
		do
			cwin_invalidate_rect (item, rect.item, erase_background)
		end

	invalidate_region (region: WEL_REGION; erase_background: BOOLEAN) is
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

	validate_rect (rect: WEL_RECT) is
			-- Validate the area `rect'.
		require
			exists: exists
			rect_not_void: rect /= Void
		do
			cwin_validate_rect (item, rect.item)
		end

	validate_region (region: WEL_REGION) is
			-- Validate the area `region'.
		require
			exists: exists
			region_not_void: region /= Void
			region_exists: region.exists
		do
			cwin_validate_rgn (item, region.item)
		end

	kill_timer (timer_id: INTEGER) is
			-- Kill the timer identified by `timer_id'.
			-- See also `set_timer', `on_timer'.
		require
			exists: exists
			positive_timer_id: timer_id > 0
		do
			cwin_kill_timer (item, timer_id)
		end

	scroll (a_x, a_y: INTEGER) is
			-- Scroll the contents of the window's client area.
			-- `a_x' and `a_y' specify the amount of horizontal
			-- and vertical scrolling.
		require
			exists: exists
		do
			cwin_scroll_window (item, a_x, a_y,
				default_pointer, default_pointer)
		end

	win_help (help_file: STRING; a_command, data: INTEGER) is
			-- Start the Windows Help program with `help_file'.
			-- `a_command' specifies the type of help requested. See
			-- class WEL_HELP_CONSTANTS for `a_command' values.
			-- 'data' is depandant on 'a_command'.  Check MSDN for more details.
		require
			exists: exists
			help_file_not_void: help_file /= Void
		local
			 a_wel_string: WEL_STRING
		do
			create a_wel_string.make (help_file)
			cwin_win_help (item, a_wel_string.item, a_command, data)
		end

	set_class_icon (new_icon: WEL_ICON) is
			-- Replace the current icon for the class which this window
			-- belongs to.
			--
			-- The SetClassLong function replaces the specified 32-bit (long) 
			-- value at the specified offset into the extra class memory 
			-- or the WNDCLASSEX structure for the class to which the 
			-- specified window belongs. 
		do
			cwin_set_class_long (
				item, 
				Wel_gcl_constants.Gcl_hicon, 
				cwel_pointer_to_integer(new_icon.item)
				)
		end

	set_class_small_icon (new_icon: WEL_ICON) is
			-- Replace the current icon for the class which this window
			-- belongs to.
			--
			-- The SetClassLong function replaces the specified 32-bit (long) 
			-- value at the specified offset into the extra class memory 
			-- or the WNDCLASSEX structure for the class to which the 
			-- specified window belongs. 
		do
			cwin_set_class_long (
				item, 
				Wel_gcl_constants.Gcl_hiconsm, 
				cwel_pointer_to_integer(new_icon.item)
				)
		end

feature -- Removal

	destroy is
			-- Destroy the window.
		require
			exists: exists
		do
			cwin_destroy_window (item)
		ensure
			not_exists: not exists
		end

feature -- Messages

	on_size (size_type, a_width, a_height: INTEGER) is
			-- Wm_size message
			-- See class WEL_SIZE_CONSTANTS for `size_type' value
		require
			exists: exists
		do
		end

	on_move (x_pos, y_pos: INTEGER) is
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

	on_left_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Wm_lbuttondown message
			-- See class WEL_MK_CONSTANTS for `keys' value
		require
			exists: exists
		do
		end

	on_left_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Wm_lbuttonup message
			-- See class WEL_MK_CONSTANTS for `keys' value
		require
			exists: exists
		do
		end

	on_left_button_double_click (keys, x_pos, y_pos: INTEGER) is
			-- Wm_lbuttondblclk message
			-- See class WEL_MK_CONSTANTS for `keys' value
		require
			exists: exists
		do
		end

	on_middle_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Wm_rbuttondown message
			-- See class WEL_MK_CONSTANTS for `keys' value
		require
			exists: exists
		do
		end

	on_middle_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Wm_rbuttonup message
			-- See class WEL_MK_CONSTANTS for `keys' value
		require
			exists: exists
		do
		end

	on_middle_button_double_click (keys, x_pos, y_pos: INTEGER) is
			-- Wm_rbuttondblclk message
			-- See class WEL_MK_CONSTANTS for `keys' value
		require
			exists: exists
		do
		end
	on_right_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Wm_rbuttondown message
			-- See class WEL_MK_CONSTANTS for `keys' value
		require
			exists: exists
		do
		end

	on_right_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Wm_rbuttonup message
			-- See class WEL_MK_CONSTANTS for `keys' value
		require
			exists: exists
		do
		end

	on_right_button_double_click (keys, x_pos, y_pos: INTEGER) is
			-- Wm_rbuttondblclk message
			-- See class WEL_MK_CONSTANTS for `keys' value
		require
			exists: exists
		do
		end

	on_mouse_move (keys, x_pos, y_pos: INTEGER) is
			-- Wm_mousemove message
			-- See class WEL_MK_CONSTANTS for `keys' value
		require
			exists: exists
		do
		end

	on_char (character_code, key_data: INTEGER) is
			-- Wm_char message
			-- See class WEL_VK_CONSTANTS for `character_code' value.
		require
			exists: exists
		do
		end

	on_sys_char (character_code, key_data: INTEGER) is
			-- Wm_syschar message
		require
			exists: exists
		do
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- Wm_keydown message
		require
			exists: exists
		do
		end

	on_key_up (virtual_key, key_data: INTEGER) is
			-- Wm_keyup message
		require
			exists: exists
		do
		end

	on_sys_key_down (virtual_key, key_data: INTEGER) is
			-- Wm_syskeydown message
		require
			exists: exists
		do
		end

	on_sys_key_up (virtual_key, key_data: INTEGER) is
			-- Wm_syskeyup message
		require
			exists: exists
		do
		end

	on_set_focus is
			-- Wm_setfocus message
		require
			exists: exists
		do
		end

	on_kill_focus is
			-- Wm_killfocus message
		require
			exists: exists
		do
		end

	on_set_cursor (hit_code: INTEGER) is
			-- Wm_setcursor message.
			-- See class WEL_HT_CONSTANTS for valid `hit_code' values.
		require
			exists: exists
		do
		end

	on_show is
			-- Wm_showwindow message.
			-- The window is being shown.
		require
			exists: exists
		do
		end

	on_hide is
			-- Wm_showwindow message.
			-- The window is being hidden.
		require
			exists: exists
		do
		end

	on_destroy is
			-- Wm_destroy message.
			-- The window is about to be destroyed.
		require
			exists: exists
		do
		end

	on_timer (timer_id: INTEGER) is
			-- Wm_timer message.
			-- A Wm_timer has been received from `timer_id'
			-- See also `set_timer', `kill_timer'.
		require
			exists: exists
			positive_timer_id: timer_id > 0
		do
		end

	on_notify (control_id: INTEGER; info: WEL_NMHDR) is
		require
			exists: exists
			info_not_void: info /= Void
		do
		end

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Wm_erasebkgnd message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
		local
			bk_brush: WEL_BRUSH
		do
			bk_brush := background_brush
			if bk_brush /= Void then
				paint_dc.fill_rect (invalid_rect, bk_brush)
				bk_brush.delete
					--| Disable the default windows processing and return correct
					--| value to Windows, i.e. nonzero value.
				disable_default_processing
				set_message_return_value (1)
			end
		end

	on_desactivate is
			-- Called when window loses activation.
		do
		end

	on_activate is
			-- Called when window gains activation (alt-tab or mouse click on title bar)
		do
		end

feature {WEL_WINDOW} -- Implementation

	default_window_procedure: POINTER
			-- Default window procedure

	internal_window_make (a_parent: WEL_WINDOW; a_name: STRING;
			a_style, a_x, a_y, a_w, a_h, an_id: INTEGER;
			data: POINTER) is
			-- Create the window
		local
			a_wel_string1, a_wel_string2: WEL_STRING
		do
			parent := a_parent
			create a_wel_string1.make (class_name)
			if a_name /= Void then
				create a_wel_string2.make (a_name)
				item := cwin_create_window_ex (default_ex_style,
					a_wel_string1.item, a_wel_string2.item, a_style, a_x, a_y, a_w, a_h,
					parent_item, an_id,
					main_args.current_instance.item, data)
			else
				item := cwin_create_window_ex (default_ex_style,
					a_wel_string1.item, default_pointer, a_style, a_x, a_y, a_w, a_h,
					parent_item, an_id,
					main_args.current_instance.item, data)
			end
			if item /= default_pointer then
				register_current_window
				set_default_window_procedure
			end
		ensure
			exists: exists
		end

	class_name: STRING is
			-- Window class name to create
		deferred
		ensure
			result_not_void: Result /= Void
		end

	parent_item: POINTER is
			-- Parent `item'.
			-- Equal to `default_pointer' if no parent
		do
			if parent /= Void then
				Result := parent.item
			end
		ensure
			result_parent_not_void: (parent /= Void implies
				Result /= default_pointer) or
				Result = default_pointer
		end

	set_default_window_procedure is
			-- Set `default_window_procedure' if the window must
			-- call its previous window procedure.
		do
		end

	default_style: INTEGER is
			-- Default style used to create the window.
			-- See class WEL_WS_CONSTANTS.
		deferred
		end

	default_ex_style: INTEGER is
			-- Default extented style used to create the window
		do
			Result := 0
		end

	main_args: WEL_MAIN_ARGUMENTS is
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

	commands_enabled_ref: BOOLEAN_REF is
			-- Is the commands execution enabled?
			-- False by default.
		once
			create Result
			Result.set_item (False)
		end

	on_wm_show_window (wparam, lparam: INTEGER) is
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

	on_wm_destroy is
			-- Wm_destroy message.
			-- The window must be unregistered
		require
			exists: exists
		do
			on_destroy
			destroy_item
				-- Stop default processing because no more C objects attached
				-- to WEL object.
			disable_default_processing
		ensure
			destroyed: not exists
			unregistered: not registered (Current)
		end

	on_wm_notify (wparam, lparam: INTEGER) is
			-- Wm_notify message
		require
			exists: exists
		local
			info: WEL_NMHDR
		do
			create info.make_by_pointer (cwel_integer_to_pointer (lparam))
			on_notify (wparam, info)
		end

	on_wm_erase_background (wparam: INTEGER) is
			-- Wm_erasebkgnd message.
			-- A WEL_DC and WEL_PAINT_STRUCT are created and passed to the
			-- `on_erase_background' routine.
		require
			exists: exists
		local
			paint_dc: WEL_PAINT_DC
		do
			create paint_dc.make_by_pointer (Current, cwel_integer_to_pointer(wparam))
			on_erase_background (paint_dc, client_rect)
		end

	on_wm_activate (wparam: INTEGER) is
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

	default_process_message (msg, wparam, lparam: INTEGER) is
			-- Process `msg' which has not been processed by
			-- `process_message'.
		do
		end

feature {WEL_DISPATCHER, WEL_WINDOW}

	window_process_message, process_message (hwnd: POINTER; msg,
			wparam, lparam: INTEGER): INTEGER is
			-- Call the routine `on_*' corresponding to the
			-- message `msg'.
		require
			exists: exists
		do
			if commands /= Void and then
			   commands_enabled and then
			   commands.has (msg)
			then
				commands.item (msg).execute (Current, msg, wparam, lparam)
			end

			inspect msg
			when Wm_mousemove then
				on_mouse_move (wparam,
					c_mouse_message_x (lparam),
					c_mouse_message_y (lparam))
			when Wm_setcursor then
				on_set_cursor (cwin_lo_word (lparam))
			when Wm_size then
				on_size (wparam,
					cwin_lo_word (lparam),
					cwin_hi_word (lparam))
			when Wm_move then
				on_move (cwin_lo_word (lparam),
					cwin_hi_word (lparam))
			when Wm_lbuttondown then
				on_left_button_down (wparam,
					c_mouse_message_x (lparam),
					c_mouse_message_y (lparam))
			when Wm_lbuttonup then
				on_left_button_up (wparam,
					c_mouse_message_x (lparam),
					c_mouse_message_y (lparam))
			when Wm_lbuttondblclk then
				on_left_button_double_click (wparam,
					c_mouse_message_x (lparam),
					c_mouse_message_y (lparam))
			when Wm_mbuttondown then
				on_middle_button_down (wparam,
					c_mouse_message_x (lparam),
					c_mouse_message_y (lparam))
			when Wm_mbuttonup then
				on_middle_button_up (wparam,
					c_mouse_message_x (lparam),
					c_mouse_message_y (lparam))
			when Wm_mbuttondblclk then
				on_middle_button_double_click (wparam,
					c_mouse_message_x (lparam),
					c_mouse_message_y (lparam))
			when Wm_rbuttondown then
				on_right_button_down (wparam,
					c_mouse_message_x (lparam),
					c_mouse_message_y (lparam))
			when Wm_rbuttonup then
				on_right_button_up (wparam,
					c_mouse_message_x (lparam),
					c_mouse_message_y (lparam))
			when Wm_rbuttondblclk then
				on_right_button_double_click (wparam,
					c_mouse_message_x (lparam),
					c_mouse_message_y (lparam))
			when Wm_timer then
				on_timer (wparam)
			when Wm_setfocus then
				on_set_focus
			when Wm_killfocus then
				on_kill_focus
			when Wm_char then
				on_char (wparam, lparam)
			when Wm_keydown then
				on_key_down (wparam, lparam)
			when Wm_keyup then
				on_key_up (wparam, lparam)
			when Wm_syschar then
				on_sys_char (wparam, lparam)
			when Wm_syskeydown then
				on_sys_key_down (wparam, lparam)
			when Wm_syskeyup then
				on_sys_key_up (wparam, lparam)
			when Wm_showwindow then
				on_wm_show_window (wparam, lparam)
			when Wm_notify then
				on_wm_notify (wparam, lparam)
			when Wm_destroy then
				on_wm_destroy
			when Wm_erasebkgnd then
				on_wm_erase_background (wparam)
			when Wm_activate then
				on_wm_activate (wparam)
			else
				default_process_message (msg, wparam, lparam)
			end
		end

	call_default_window_procedure (msg, wparam, lparam: INTEGER): INTEGER is
		do
			Result := cwin_def_window_proc (item, msg, wparam,
				lparam)
		end

feature -- Registration

	register_current_window is
			-- Register `Current' in window manager.
		do
			set_internal_data (eif_object_id (Current))
		end

feature {WEL_WINDOW_MANAGER, WEL_DISPATCHER} -- Registration

	internal_data: INTEGER is
			-- Data set to widget at creation.
			-- Used for having weak references
		do
			Result := cwin_get_window_long (item, Gwl_userdata)
		end

	set_internal_data (v: INTEGER) is
			-- Set data of window.
		do
			cwin_set_window_long (item, Gwl_userdata, v)
		end

feature {WEL_BLOCKING_DISPATCHER, WEL_WINDOW} -- Properties

	is_located_inside (window: WEL_WINDOW): BOOLEAN is
			-- Is `Current' directly or indirectly located inside `window'?
		do
			if window = Current then
				Result := True
			elseif parent = Void then
				Result := False
			else
				Result := parent.is_located_inside (window)
			end
		end

feature {NONE} -- Removal

	destroy_item is
			-- At this stage, the window has been already destroyed
			-- by Windows (see `on_wm_destroy').
			-- Reset C and WEL structure that keep track of Current.
		do
			eif_object_id_free (internal_data)

				-- Clean `item' C pointer.
			item := default_pointer
		end

feature {NONE} -- Constants

	Wel_gcl_constants: WEL_GCL_CONSTANTS is
		once
			create Result
		end	

feature {NONE} -- Externals

	cwin_create_window_ex (a_ex_stlyle: INTEGER; a_class_name,
				a_name: POINTER; a_style, a_x, a_y, a_w,
				a_h: INTEGER; a_parent_hwnd: POINTER;
				an_id: INTEGER; a_hinstance,
				param: POINTER): POINTER is
			-- SDK CreateWindowEx
		external
			"C [macro %"wel.h%"] (DWORD, LPCSTR, LPCSTR, DWORD, int, %
				%int, int, int, HWND, HMENU, HINSTANCE, %
				%LPVOID): EIF_POINTER"
		alias
			"CreateWindowEx"
		end

	cwin_set_parent (hwmd_child, hwmd_parent: POINTER) is
			-- Change the parent of the given child
		external
			"C [macro <winuser.h>] (HWND, HWND)"
		alias
			"SetParent"
		end 

	cwin_destroy_window (hwnd: POINTER) is
			-- SDK DestroyWindow
		external
			"C [macro %"wel.h%"] (HWND)"
		alias
			"DestroyWindow"
		end

	cwin_is_iconic (hwnd: POINTER): BOOLEAN is
			-- SDK IsIconic
		external
			"C [macro %"wel.h%"] (HWND): EIF_BOOLEAN"
		alias
			"IsIconic"
		end

	cwin_is_zoomed (hwnd: POINTER): BOOLEAN is
			-- SDK IsZoomed
		external
			"C [macro %"wel.h%"] (HWND): EIF_BOOLEAN"
		alias
			"IsZoomed"
		end

	cwin_enable_window (hwnd: POINTER; enable_flag: BOOLEAN) is
			-- SDK EnableWindow
		external
			"C [macro %"wel.h%"] (HWND, BOOL)"
		alias
			"EnableWindow"
		end

	cwin_is_window_enabled (hwnd: POINTER): BOOLEAN is
			-- SDK IsWindowEnabled
		external
			"C [macro %"wel.h%"] (HWND): EIF_BOOLEAN"
		alias
			"IsWindowEnabled"
		end

	cwin_set_focus (hwnd: POINTER) is
			-- SDK SetFocus
		external
			"C [macro %"wel.h%"] (HWND)"
		alias
			"SetFocus"
		end

	cwin_set_timer (hwnd: POINTER; timer_id, time_out: INTEGER;
				proc: POINTER) is
			-- SDK SetTimer
		external
			"C [macro %"wel.h%"] (HWND, UINT, UINT, TIMERPROC)"
		alias
			"SetTimer"
		end

	cwin_kill_timer (hwnd: POINTER; timer_id: INTEGER) is
			-- SDK KillTimer
		external
			"C [macro %"wel.h%"] (HWND, UINT)"
		alias
			"KillTimer"
		end

	cwin_get_focus: POINTER is
			-- SDK GetFocus
		external
			"C [macro %"wel.h%"]: EIF_POINTER"
		alias
			"GetFocus ()"
		end

	cwin_set_capture (hwnd: POINTER) is
			-- SDK SetCapture
		external
			"C [macro %"wel.h%"] (HWND)"
		alias
			"SetCapture"
		end

	cwin_release_capture is
			-- SDK ReleaseCapture
		external
			"C [macro %"wel.h%"]"
		alias
			"ReleaseCapture ()"
		end

	cwin_get_capture: POINTER is
			-- SDK GetCapture
		external
			"C [macro %"wel.h%"]: EIF_POINTER"
		alias
			"GetCapture ()"
		end

	cwin_show_window (hwnd: POINTER; cmd_show: INTEGER) is
			-- SDK ShowWindow
		external
			"C [macro %"wel.h%"] (HWND, int)"
		alias
			"ShowWindow"
		end

	cwin_is_window_visible (hwnd: POINTER): BOOLEAN is
			-- SDK IsWindowVisible
		external
			"C [macro %"wel.h%"] (HWND): EIF_BOOLEAN"
		alias
			"IsWindowVisible"
		end

	cwin_set_window_text (hwnd, str: POINTER) is
			-- SDK SetWindowText
		external
			"C [macro %"wel.h%"] (HWND, LPCSTR)"
		alias
			"SetWindowText"
		end

	cwin_get_window_text_length (hwnd: POINTER): INTEGER is
			-- SDK GetWindowTextLength
		external
			"C [macro %"wel.h%"] (HWND): EIF_INTEGER"
		alias
			"GetWindowTextLength"
		end

	cwin_get_window_text (hwnd, str: POINTER; len: INTEGER): INTEGER is
			-- SDK GetWindowText
		external
			"C [macro %"wel.h%"] (HWND, LPSTR, int): EIF_INTEGER"
		alias
			"GetWindowText"
		end

	cwin_message_box_result (hwnd, a_text, a_title: POINTER;
			a_style: INTEGER): INTEGER is
			-- SDK MessageBox (with result)
		external
			"C [macro %"wel.h%"] (HWND, LPCSTR, LPCSTR, %
				%UINT): EIF_INTEGER"
		alias
			"MessageBox"
		end

	cwin_message_box (hwnd, a_text, a_title: POINTER;
			a_style: INTEGER) is
			-- SDK MessageBox (without result)
		external
			"C [macro %"wel.h%"] (HWND, LPCSTR, LPCSTR, UINT)"
		alias
			"MessageBox"
		end

	cwin_def_window_proc (hwnd: POINTER; msg, wparam,
			lparam: INTEGER): INTEGER is
			-- SDK DefWindowProc
		external
			"C [macro %"wel.h%"] (HWND, UINT, WPARAM, %
				%LPARAM): EIF_INTEGER"
		alias
			"DefWindowProc"
		end

	cwin_update_window (hwnd: POINTER) is
			-- SDK UpdateWindow
		external
			"C [macro %"wel.h%"] (HWND)"
		alias
			"UpdateWindow"
		end

	cwin_invalidate_rect (hwnd, a_rect: POINTER;
			erase_background: BOOLEAN) is
			-- SDK InvalidateRect
		external
			"C [macro %"wel.h%"] (HWND, RECT *, BOOL)"
		alias
			"InvalidateRect"
		end

	cwin_invalidate_rgn (hwnd, a_region: POINTER;
			erase_background: BOOLEAN) is
			-- SDK InvalidateRgn
		external
			"C [macro %"wel.h%"] (HWND, HRGN, BOOL)"
		alias
			"InvalidateRgn"
		end

	cwin_validate_rect (hwnd, a_rect: POINTER) is
			-- SDK ValidateRect
		external
			"C [macro %"wel.h%"] (HWND, RECT *)"
		alias
			"ValidateRect"
		end

	cwin_validate_rgn (hwnd, a_region: POINTER) is
			-- SDK ValidateRgn
		external
			"C [macro %"wel.h%"] (HWND, HRGN)"
		alias
			"ValidateRgn"
		end

	cwin_send_message_result (hwnd: POINTER; msg, wparam,
				lparam: INTEGER): INTEGER is
			-- SDK SendMessage (with the result)
		external
			"C [macro %"wel.h%"] (HWND, UINT, %
				%WPARAM, LPARAM): EIF_INTEGER"
		alias
			"SendMessage"
		end

	cwin_send_message (hwnd: POINTER; msg, wparam,
				lparam: INTEGER) is
			-- SDK SendMessage (without the result)
		external
			"C [macro %"wel.h%"] (HWND, UINT, WPARAM, LPARAM)"
		alias
			"SendMessage"
		end

	cwin_post_message_result (hwnd: POINTER; msg, wparam,
				lparam: INTEGER): BOOLEAN is
			-- SDK PostMessage (with the result)
		external
			"C [macro %"wel.h%"] (HWND, UINT, %
				%WPARAM, LPARAM): EIF_BOOLEAN"
		alias
			"PostMessage"
		end

	cwin_post_message (hwnd: POINTER; msg, wparam,
				lparam: INTEGER) is
			-- SDK PostMessage (without the result)
		external
			"C [macro %"wel.h%"] (HWND, UINT, WPARAM, LPARAM)"
		alias
			"PostMessage"
		end


	cwin_move_window (hwnd: POINTER; a_x, a_y, a_w, a_h: INTEGER;
				repaint: BOOLEAN) is
			-- SDK MoveWindow
		external
			"C [macro %"wel.h%"] (HWND, int, int, int, int, BOOL)"
		alias
			"MoveWindow"
		end

	cwin_set_window_pos (hwnd, hwnd_after: POINTER; a_x, a_y, a_w, a_h,
				flags: INTEGER) is
			-- SDK SetWindowPos
		external
			"C [macro %"wel.h%"] (HWND, HWND, int, int, int, %
				%int, int)"
		alias
			"SetWindowPos"
		end

	cwin_set_window_placement (hwnd, a_placement: POINTER) is
			-- SDK SetWindowPlacement
		external
			"C [macro %"wel.h%"] (HWND, WINDOWPLACEMENT *)"
		alias
			"SetWindowPlacement"
		end

	cwin_show_scroll_bar (hwnd: POINTER; bar_flag: INTEGER;
			show_flag: BOOLEAN) is
			-- SDK ShowScrollBar
		external
			"C [macro %"wel.h%"] (HWND, int, BOOL)"
		alias
			"ShowScrollBar"
		end

	cwin_enable_scroll_bar (hwnd: POINTER; wsbflags, warrows: INTEGER) is
			-- SDK EnableScrollBar
		external
			"C [macro %"wel.h%"] (HWND, int, int)"
		alias
			"EnableScrollBar"
		end

	cwin_scroll_window (hwnd: POINTER; a_x, a_y: INTEGER;
			scroll_rect, clip_rect: POINTER) is
			-- SDK ScrollWindow
		external
			"C [macro %"wel.h%"] (HWND, int, int, RECT *, RECT *)"
		alias
			"ScrollWindow"
		end

	cwin_win_help (hwnd, file: POINTER; a_command, data: INTEGER) is
			-- SDK WinHelp
		external
			"C [macro %"wel.h%"] (HWND, LPCSTR, UINT, DWORD)"
		alias
			"WinHelp"
		end

	c_mouse_message_x (lparam: INTEGER): INTEGER is
		external
			"C [macro %"wel.h%"]"
		end

	c_mouse_message_y (lparam: INTEGER): INTEGER is
		external
			"C [macro %"wel.h%"]"
		end

	cwel_window_procedure_address: POINTER is
		external
			"C [macro <disptchr.h>]"
		end

	c_lock_window_update (hwnd_lock: POINTER): BOOLEAN is
		external
			"C [macro %"wel.h%"] (HWND): EIF_BOOLEAN"
		alias
			"LockWindowUpdate"
		end

	cwel_hook_mouse (hwnd: POINTER): BOOLEAN is
		external
			"C (HWND): EIF_BOOLEAN | %"wel_mousehook.h%""
		end

	cwel_unhook_mouse: BOOLEAN is
		external
			"C (): EIF_BOOLEAN | %"wel_mousehook.h%""
		end

	cwin_set_class_long (hwnd: POINTER; n_index: INTEGER;
			new_value: INTEGER) is
			-- SDK SetClassLong
		external
			"C [macro %"wel.h%"] (HWND, int, LONG)"
		alias
			"SetClassLong"
		end

end -- class WEL_WINDOW

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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
--|----------------------------------------------------------------

