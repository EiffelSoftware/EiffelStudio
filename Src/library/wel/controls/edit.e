indexing
	description: "This control permits the user to enter and edit text %
		%from the keyboard. Ancestor of WEL_SINGLE_LINE_EDIT and %
		%WEL_MULTIPLE_LINE_EDIT."
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
			process_notification
		end

	WEL_EM_CONSTANTS
		export
			{NONE} all
		end

	WEL_EN_CONSTANTS
		export
			{NONE} all
		end

feature -- Basic operations

	clip_cut is
			-- Cut the current selection to the clipboard.
		require
			exists: exists
			has_selection: has_selection
		do
			cwin_send_message (item, Wm_cut, 0, 0)
		end

	clip_copy is
			-- Copy the current selection to the clipboard.
		require
			exists: exists
			has_selection: has_selection
		do
			cwin_send_message (item, Wm_copy, 0, 0)
		end
	
	clip_paste is
			-- Paste at the current caret position the
			-- content of the clipboard.
		require
			exists: exists
                        has_selection: has_selection
		do
			cwin_send_message (item, Wm_paste, 0, 0)
		end

	undo is
			-- Undo the last operation.
			-- The previously deleted text is restored or the
			-- previously added text is deleted.
		require
			exists: exists
			can_undo: can_undo
		do
			cwin_send_message (item, Em_undo, 0, 0)
		end

	clear_selection is
			-- Delete the current selection.
		require
			exists: exists
			has_selection: has_selection
		do
			cwin_send_message (item, Wm_clear, 0, 0)
		end

feature -- Status setting

	set_modify (modify: BOOLEAN)is
			-- Set `modified' with `modify'
		require
			exists: exists
		do
			if modify then
				cwin_send_message (item, Em_setmodify, 1, 0)
			else
				cwin_send_message (item, Em_setmodify, 0, 0)
			end
		ensure
			modified_set: modified = modify
		end

	set_selection (start_position, end_position: INTEGER) is
			-- Set the selection between `start_position'
			-- and `end_position'.
		require
			exists: exists
			start_large_enough: start_position >= 0
			consistent_selection: start_position <= end_position
			end_small_enough: end_position <= text_length
		do
			cwel_set_selection_edit (item, start_position,
				end_position)
		ensure
			has_selection: has_selection
			selection_start_set: selection_start = start_position
			selection_end_set: selection_end = end_position
		end

	select_all is
			-- Select all the text.
		require
			exists: exists
		do
			cwin_send_message (item, Em_setsel, 0, -1)
		ensure
			has_selection: has_selection
			selection_start_set: selection_start = 0
			selection_end_set: selection_end = text_length
		end

feature -- Status report

	has_selection: BOOLEAN is
			-- Has a current selection?
		require
			exists: exists
		do
			Result := cwin_lo_word (cwin_send_message_result (item,
				Em_getsel, 0, 0)) >= 0
		end

	selection_start: INTEGER is
			-- Index of the first character selected
		require
			exists: exists
			has_selection: has_selection
		do
			Result := cwin_lo_word (cwin_send_message_result (item,
				Em_getsel, 0, 0))
		ensure
			result_large_enough: Result >= 0
			result_small_enough: Result <= text.count
		end

	selection_end: INTEGER is
			-- Index of the last character selected
		require
			exists: exists
			has_selection: has_selection
		do
			Result := cwin_hi_word (cwin_send_message_result (item,
				Em_getsel, 0, 0))
		ensure
			result_large_enough: Result >= 0
			result_small_enough: Result <= text.count
		end

	can_undo: BOOLEAN is
			-- Can the last operation be undone?
		require
			exists: exists
		do
			Result := cwin_send_message_result (item, Em_canundo,
				0, 0) /= 0
		end

	modified: BOOLEAN is
			-- Has the text been modified?
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
				Em_getmodify, 0, 0) = 1
		end

feature {NONE} -- Notifications

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
			end
		end

	class_name: STRING is
			-- Window class name to create
		once
			Result := "EDIT"
		end

	default_style: INTEGER is
			-- Default style used to create the control
		deferred
		end

feature {NONE} -- Externals

	cwel_set_selection_edit (hwnd: POINTER; start_pos, end_pos: INTEGER) is
		external
			"C [macro <wel.h>]"
		end

end -- class WEL_EDIT

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
