indexing
	description: "This control permits the user to enter and edit text %
		%from the keyboard. Ancestor of WEL_SINGLE_LINE_EDIT and %
		%WEL_MULTIPLE_LINE_EDIT."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_EDIT

inherit
	WEL_STATIC
		undefine
			default_style
		redefine
			class_name,
			background_color,
			process_notification
		end

	WEL_ES_CONSTANTS
		export
			{NONE} all
		end

	WEL_EM_CONSTANTS
		export
			{NONE} all
		end

	WEL_EN_CONSTANTS
		export
			{NONE} all
		end

feature -- Access

	background_color: WEL_COLOR_REF is
			-- Background color used for the background of the
			-- control
			-- Can be redefined by the user
		do
			create Result.make_system (Color_window)
		end

feature -- Status report

	read_only: BOOLEAN is
			-- Is the current edit control read-only?
		require
			exists: exists
		do
			Result := flag_set (style, Es_readonly)
		end

feature -- Basic operations

	clip_cut is
			-- Cut the current selection to the clipboard.
		require
			exists: exists
			has_selection: has_selection
		do
			cwin_send_message (item, Wm_cut, to_wparam (0), to_lparam (0))
		ensure
			has_no_selection: not has_selection
		end

	clip_copy is
			-- Copy the current selection to the clipboard.
		require
			exists: exists
			has_selection: has_selection
		do
			cwin_send_message (item, Wm_copy, to_wparam (0), to_lparam (0))
		end

	clip_paste is
			-- Paste at the current caret position the
			-- content of the clipboard.
		require
			exists: exists
		do
			cwin_send_message (item, Wm_paste, to_wparam (0), to_lparam (0))
		end

	undo is
			-- Undo the last operation.
			-- The previously deleted text is restored or the
			-- previously added text is deleted.
		require
			exists: exists
			can_undo: can_undo
		do
			cwin_send_message (item, Em_undo, to_wparam (0), to_lparam (0))
		end

	delete_selection is
			-- Delete the current selection.
		require
			exists: exists
			has_selection: has_selection
		do
			cwin_send_message (item, Wm_clear, to_wparam (0), to_lparam (0))
		ensure
			has_no_selection: not has_selection
		end

	select_all is
			-- Select all the text.
		require
			exists: exists
			positive_length: text_length > 0
		do
			cwin_send_message (item, Em_setsel, to_wparam (0), to_lparam (-1))
		ensure
			has_selection: has_selection
			selection_start_set: selection_start = 0
			selection_end_set: selection_end <= text_length + 2
		end

	unselect is
			-- Unselect the current selection.
		require
			exists: exists
			has_selection: has_selection
		do
			cwin_send_message (item, Em_setsel, to_wparam (-1), to_lparam (0))
		ensure
			has_no_selection: not has_selection
		end

	replace_selection (new_text: STRING_GENERAL) is
			-- Replace the current selection with `new_text'.
			-- If there is no selection, `new_text' is inserted
			-- at the current `caret_position'.
		require
			exists: exists
			new_text_not_void: new_text /= Void
		local
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (new_text)
			cwin_send_message (item, Em_replacesel, to_wparam (0), a_wel_string.item)
		end

feature -- Status setting

	set_modify (modify: BOOLEAN)is
			-- Set `modified' with `modify'
		require
			exists: exists
		do
			if modify then
				cwin_send_message (item, Em_setmodify, to_wparam (1), to_lparam (0))
			else
				cwin_send_message (item, Em_setmodify, to_wparam (0), to_lparam (0))
			end
		ensure
			modified_set: modified = modify
		end

	set_read_only is
			-- Set the read-only state.
		require
			exists: exists
		do
			cwin_send_message (item, Em_setreadonly, to_wparam (1), to_lparam (0))
		end

	set_read_write is
			-- Set the read-write state.
		require
			exists: exists
		do
			cwin_send_message (item, Em_setreadonly, to_wparam (0), to_lparam (0))
		end

	set_text_limit (limit: INTEGER) is
			-- Set to `limit' the length of the text the user
			-- can enter into the edit control.
		require
			exists: exists
			positive_limit: limit >= 0
		do
			cwin_send_message (item, Em_limittext, to_wparam (limit), to_lparam (0))
		end

	get_text_limit: INTEGER is
			-- Get the maximum length of text that the user
			-- can enter into the edit control.
		require
			exisits: exists
		do
			Result := cwin_send_message_result_integer (item, Em_getlimittext, to_wparam (0), to_lparam (0))
		ensure
			positive_result: Result >= 0
		end

	set_selection (start_position, end_position: INTEGER) is
			-- Set the selection between `start_position'
			-- and `end_position'.
		require
			exists: exists
			selection_in_lower_bound: start_position >= 0 and end_position >= 0
			selection_in_upper_bound: start_position <= text_length and end_position <= text_length
		do
			cwin_send_message (item, Em_setsel, to_wparam (start_position), to_lparam (end_position))
		ensure
			has_selection: (start_position /= end_position) implies has_selection
--			logical_order: (end_position >= start_position) implies (selection_start = start_position and selection_end = end_position)
--			reverse_order: (end_position < start_position) implies (selection_start = end_position and selection_end = start_position)
		end

	set_caret_position (position: INTEGER) is
			-- Set the caret position with `position'.
		require
			exists: exists
			position_large_enough: position >= 0
			position_small_enough: position <= text_length
		do
			cwin_send_message (item, Em_setsel, to_wparam (position), to_lparam (position))
		ensure
			has_no_selection: not has_selection
			caret_position_set: caret_position = position
		end

feature -- Status report

	caret_position: INTEGER is
			-- Caret position
		require
			exists: exists
		local
			sel_end: INTEGER
		do
			fixme (once "[
				Replace sel_end's type by INTEGER_32, as $sel_end has to be a pointer to a DWORD.
			]")
				-- We pass `Void' as the previous implementation only returned
				-- the high value part of the result, corresponding to the
				-- end position.
			cwin_send_message (item, Em_getsel, to_wparam (0), $sel_end)
			Result := sel_end
		end

	has_selection: BOOLEAN is
			-- Has a current selection?
		require
			exists: exists
		local
			sel_start, sel_end: INTEGER
		do
			fixme (once "[
				Replace sel_start, and set_end 's type by INTEGER_32, as it has
				to be a pointer to a DWORD.
			]")
			cwin_send_message (item, Em_getsel, $sel_start, $sel_end)
			Result := sel_end /= sel_start
		end

	selection_start: INTEGER is
			-- Index of the first character selected
		require
			exists: exists
			has_selection: has_selection
		local
			sel_start: INTEGER
		do
			fixme (once "[
				Replace sel_start's type by INTEGER_32, as $sel_start has to be a pointer to a DWORD.
			]")
			cwin_send_message (item, Em_getsel, $sel_start, to_lparam (0))
			Result := sel_start
		ensure
			result_large_enough: Result >= 0
			result_small_enough: Result <= text_length
		end

	selection_end: INTEGER is
			-- Index of the last character selected
		require
			exists: exists
			has_selection: has_selection
		local
			sel_end: INTEGER
		do
			fixme (once "[
				Replace sel_end's type by INTEGER_32, as $sel_end has to be a pointer to a DWORD.
			]")
			cwin_send_message (item, Em_getsel, to_wparam (0), $sel_end)
			Result := sel_end
		ensure
			result_large_enough: Result >= 0
			result_small_enough: Result <= text_length + 2
		end

	can_undo: BOOLEAN is
			-- Can the last operation be undone?
		require
			exists: exists
		do
			Result := cwin_send_message_result (item, Em_canundo, to_wparam (0), to_lparam (0)) /= default_pointer
		end

	modified: BOOLEAN is
			-- Has the text been modified?
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
				Em_getmodify, to_wparam (0), to_lparam (0)) /= default_pointer
		end

	formatting_rect: WEL_RECT is
			-- Limiting rectangle the text. It is independent of
			-- the size of the edit-control window.
		require
			exists: exists
		do
			create Result.make (0, 0, 0, 0)
			cwin_send_message (item, Em_getrect, to_wparam (0), Result.item)
		ensure
			result_not_void: Result /= Void
		end

feature -- Notifications

	on_en_change is
			-- The user has taken an action
			-- that may have altered the text.
		require
			exists: exists
		do
		end

	on_en_vscroll is
			-- The user click on the vertical scroll bar.
		require
			exists: exists
		do
		end

	on_en_hscroll is
			-- The user click on the horizontal scroll bar.
		require
			exists: exists
		do
		end

	on_en_errspace is
			-- Cannot allocate enough memory to
			-- meet a specific request.
		require
			exists: exists
		do
		end

	on_en_setfocus is
			-- Receive the keyboard focus.
		require
			exists: exists
		do
		end

	on_en_killfocus is
			-- Lose the keyboard focus.
		require
			exists: exists
		do
		end

	on_en_update is
			-- The control is about to display altered text.
		require
			exists: exists
		do
		end

	on_en_maxtext is
			-- The current text insertion has exceeded
			-- the specified number of characters.
		require
			exists: exists
		do
		end

feature -- Obsolete

	clear_selection is obsolete "Use ``delete_selection''"
			-- Delete the current selection.
		require
			exists: exists
			has_selection: has_selection
		do
			delete_selection
		ensure
			has_no_selection: not has_selection
		end

feature {NONE} -- Implementation

	process_notification (notification_code: INTEGER) is
		do
			if notification_code = En_change then
				on_en_change
			elseif notification_code = En_vscroll then
				on_en_vscroll
			elseif notification_code = En_hscroll then
				on_en_hscroll
			elseif notification_code = En_errspace then
				on_en_errspace
			elseif notification_code = En_setfocus then
				on_en_setfocus
			elseif notification_code = En_killfocus then
				on_en_killfocus
			elseif notification_code = En_update then
				on_en_update
			elseif notification_code = En_maxtext then
				on_en_maxtext
			else
				default_process_notification (notification_code)
			end
		end

	class_name: STRING_32 is
			-- Window class name to create
		once
			Result := (create {WEL_STRING}.share_from_pointer (cwin_edit_class)).string
		end

	cwin_edit_class: POINTER is
		external
			"C inline use <windows.h>"
		alias
			"WC_EDIT"
		end

	default_style: INTEGER is
			-- Default style used to create the control
		deferred
		end

invariant
	consistent_selection: exists and then has_selection implies
		selection_start >= 0 and then selection_start <= text_length and then
		selection_end >= 0 and then selection_end <= text_length + 2 and then
		selection_start < selection_end

	valid_caret_position: exists implies caret_position >= 0 and then
		caret_position <= text_length + 2

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




end -- class WEL_EDIT

