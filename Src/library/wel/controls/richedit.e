indexing
	description: "A control in which the user can enter and edit rich text."
	note: "Rich edit DLL needs to be loaded. See class WEL_RICH_EDIT_DLL. %
		%All paragraph measurements are in twips. A twip is 1/1440 of %
		%an inch or 1/20 of a point."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RICH_EDIT

inherit
	WEL_MULTIPLE_LINE_EDIT
		rename
			make as multiple_line_edit_make
		redefine
			class_name,
			default_style,
			set_selection,
			selection_start,
			selection_end,
			set_text_limit,
			set_tab_stops_array,
			set_tab_stops,
			set_default_tab_stops
		end

	WEL_RICH_EDIT_MESSAGE_CONSTANTS
		export
			{NONE} all
		end

	WEL_RICH_EDIT_STYLE_CONSTANTS
		export
			{NONE} all
		end

	WEL_ENM_CONSTANTS
		export
			{NONE} all
		end

	WEL_ECO_CONSTANTS
		export
			{NONE} all
		end

creation
	make,
	make_by_id

feature {NONE} -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW; a_name: STRING;
			a_x, a_y, a_width, a_height, an_id: INTEGER) is
			-- Make a rich edit control.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
			a_name_not_void: a_name /= Void
		do
			multiple_line_edit_make (a_parent, a_name,
				a_x, a_y, a_width, a_height, an_id)
			set_options (Ecoop_set, Eco_autovscroll + Eco_autohscroll)
		ensure
			parent_set: parent = a_parent
			exists: exists
			name_set: text.is_equal (a_name)
			id_set: id = an_id
		end

feature -- Status report

	selection_start: INTEGER is
			-- Index of the first character selected
		do
			Result := selection.minimum
		end

	selection_end: INTEGER is
			-- Index of the last character selected
		do
			Result := selection.maximum
		end

	selection: WEL_CHARACTER_RANGE is
			-- Structure which contains the starting and ending
			-- character positions of the selection.
		require
			exists: exists
		do
			!! Result.make_empty
			cwin_send_message (item, Em_exgetsel, 0,
				Result.to_integer)
		end

	default_character_format: WEL_CHARACTER_FORMAT is
			-- Default character format information
		require
			exists: exists
		do
			!! Result.make
			Result.set_all_masks
			cwin_send_message (item, Em_getcharformat, 0,
				Result.to_integer)
		ensure
			result_not_void: Result /= Void
		end

	current_selection_character_format: WEL_CHARACTER_FORMAT is
			-- Current selection character format information
		require
			exists: exists
		do
			!! Result.make
			Result.set_all_masks
			cwin_send_message (item, Em_getcharformat, 1,
				Result.to_integer)
		ensure
			result_not_void: Result /= Void
		end

	selected_text: STRING is
			-- Currently selected text
		require
			exists: exists
			has_selection: has_selection
		local
			a: ANY
		do
			!! Result.make (selection_end - selection_start)
			a := Result.to_c
			Result.fill_blank
			cwin_send_message (item, Em_getseltext, 0,
				cwel_pointer_to_integer ($a))
		ensure
			valid_length: Result.count =
				selection_end - selection_start
		end

	event_mask: INTEGER is
			-- Event mask which specifies notification message the
			-- control sends to its parent window.
			-- See class WEL_ENM_CONSTANTS for values.
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
				Em_geteventmask, 0, 0)
		end

feature -- Status setting

	set_selection (start_position, end_position: INTEGER) is
			-- Set the selection between `start_position'
			-- and `end_position'.
		local
			range: WEL_CHARACTER_RANGE
		do
			!! range.make (start_position, end_position)
			cwin_send_message (item, Em_exsetsel, 0,
				range.to_integer)
			if scroll_caret_at_selection then
				cwel_scroll_caret (item)
			end
		end

	set_text_limit (limit: INTEGER) is
			-- Set the length of the text the user can enter into
			-- the edit control.
		do
			cwin_send_message (item, Em_exlimittext, 0, limit)
		end

	set_tab_stops_array (tab: ARRAY [INTEGER]) is
			-- Set tab stops using the values of `tab'.
		local
			para: WEL_PARAGRAPH_FORMAT
		do
			!! para.make
			para.set_tabulations (tab)
			set_paragraph_format (para)
		end

	set_tab_stops (tab: INTEGER) is
			-- Set tab stops at every `tab' dialog box units.
		local
			para: WEL_PARAGRAPH_FORMAT
		do
			!! para.make
			para.set_tabulation (tab)
			set_paragraph_format (para)
		end

	set_default_tab_stops is
			-- Set default tab stops.
		local
			para: WEL_PARAGRAPH_FORMAT
		do
			!! para.make
			para.set_default_tabulation
			set_paragraph_format (para)
		end

	set_event_mask (an_event_mask: INTEGER) is
			-- Set `event_mask' with `an_event_mask'.
			-- See class WEL_ENM_CONSTANTS for values.
		require
			exists: exists
		do
			cwin_send_message (item, Em_seteventmask, 0,
				an_event_mask)
		ensure
			event_mask_set: event_mask = an_event_mask
		end

	set_options (operation, an_options: INTEGER) is
			-- Set the opetions for the control.
			-- See class WEL_ECO_CONSTANTS for values.
		require
			exists: exists
		do
			cwin_send_message (item, Em_setoptions, operation,
				an_options)
		end

	enable_standard_notifications is
			-- Enable the standard notifications.
			-- (Enm_change, Enm_update and Enm_scroll).
		require
			exists: exists
		do
			set_event_mask (Enm_change + Enm_update + Enm_scroll)
		end

	disable_notifications is
			-- Disable all notifications.
		require
			exists: exists
		do
			set_event_mask (Enm_none)
		ensure
			no_notification: event_mask = Enm_none
		end

feature -- Basic operations

	hide_selection is
			-- Hide the selection.
		require
			exists: exists
		do
			cwin_send_message (item, Em_hideselection, 1, 0)
		end

	show_selection is
			-- Show the selection.
		require
			exists: exists
		do
			cwin_send_message (item, Em_hideselection, 0, 0)
		end

feature -- Element change

	set_character_format_selection (a_char_format: WEL_CHARACTER_FORMAT) is
			-- Set the current selection with `a_char_format'.
		require
			exists: exists
			a_char_format_not_void: a_char_format /= Void
		do
			cwin_send_message (item, Em_setcharformat,
				Scf_selection, a_char_format.to_integer)
		end

	set_character_format_word (a_char_format: WEL_CHARACTER_FORMAT) is
			-- Set the current word with `a_char_format'.
		require
			exists: exists
			a_char_format_not_void: a_char_format /= Void
		do
			cwin_send_message (item, Em_setcharformat,
				Scf_word + Scf_selection,
				a_char_format.to_integer)
		end

	set_paragraph_format (a_para_format: WEL_PARAGRAPH_FORMAT) is
			-- Set the current paragraph with `a_para_format'.
		require
			exists: exists
			a_para_format_not_void: a_para_format /= Void
		do
			cwin_send_message (item, Em_setparaformat, 0,
				a_para_format.to_integer)
		end

feature -- Obsolete

	default_char_format: WEL_CHARACTER_FORMAT is obsolete
			"Use ``default_character_format''"
		require
			exists: exists
		do
			Result := default_character_format
		ensure
			result_not_void: Result /= Void
		end

	current_selection_char_format: WEL_CHARACTER_FORMAT is obsolete
			"Use ``current_selection_character_format''"
		require
			exists: exists
		do
			Result := current_selection_character_format
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	class_name: STRING is
			-- Window class name to create
		once
			Result := "RichEdit"
		end

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_border +
				Ws_hscroll + Ws_vscroll + Es_savesel +
				Es_disablenoscroll + Es_multiline
		end

feature {NONE} -- Externals

	Scf_selection: INTEGER is
		external
			"C [macro <redit.h>]"
		alias
			"SCF_SELECTION"
		end

	Scf_word: INTEGER is
		external
			"C [macro <redit.h>]"
		alias
			"SCF_WORD"
		end

end -- class WEL_RICH_EDIT

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
