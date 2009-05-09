note

	description:
		"EiffelVision text area, Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TEXT_IMP

inherit
	EV_TEXT_I
		redefine
			interface
		end

	EV_TEXT_COMPONENT_IMP
		redefine
			interface,
			insert_text,
			initialize,
			create_change_actions,
			dispose,
			default_key_processing_blocked
		end

	EV_FONTABLE_IMP
		redefine
			interface,
			dispose
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create a cocoa text view.
		do
			base_make (an_interface)
			create {NS_SCROLL_VIEW}cocoa_item.new
			create text_view.new
			scroll_view.set_document_view (text_view)
			scroll_view.set_border_type ({NS_SCROLL_VIEW}.ns_line_border)
			create text.make_empty
		end

	create_change_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Hook up the change actions for the text widget
		do
			create Result.default_create
		end

	initialize
			-- Initialize `Current'
		do
			enable_word_wrapping
			set_editable (True)
			set_background_color ((create {EV_STOCK_COLORS}).white)
			initialize_buffer_events
			Precursor {EV_TEXT_COMPONENT_IMP}
		end

	initialize_buffer_events
			-- Initialize events for `Current'
		do

		end

feature -- Status report

	line_number_from_position (i: INTEGER): INTEGER
			-- Line containing caret position `i'.
		do
		end

feature -- Access

	text: STRING_32
			-- Text displayed in label.

	line (a_line: INTEGER): STRING_32
			-- Returns the content of line `a_line'.
		do
		end

	first_position_from_line_number (a_line: INTEGER): INTEGER
			-- Position of the first character on line `a_line'.
		do
		end

	last_position_from_line_number (a_line: INTEGER): INTEGER
			-- Position of the last character on line `a_line'.
		do
		end

	clipboard_content: STRING_32
			-- `Result' is current clipboard content.
		do
		end

feature -- Status report

	has_selection: BOOLEAN

	selection_start, selection_end: INTEGER

	is_editable: BOOLEAN
			-- Is the text editable by the user?

	caret_position: INTEGER
			-- Current position of the caret.
		do
		end

	line_count: INTEGER
			-- Number of display lines present in widget.
		do
			Result := text.occurrences ('%N')
		end

	current_line_number: INTEGER
			-- Returns the number of the display line the cursor currently
			-- is on.
		do
			Result := line_number_from_position (caret_position)
		end

	has_word_wrapping: BOOLEAN
			-- Does `Current' have word wrapping enabled?

feature -- Status setting

	set_editable (flag: BOOLEAN)
			-- if `flag' then make the component read-write.
			-- if not `flag' then make the component read-only.
		do
			is_editable := flag
		end

	set_caret_position (pos: INTEGER)
			-- set current insertion position
		do
		end

feature -- Status setting

	insert_text (a_text: STRING_GENERAL)
		do
			text.insert_string (a_text, caret_position)
			text_view.set_string (text)
		end

	set_text (a_text: STRING_GENERAL)
			-- Set `text' to `a_text'
		do
			text := a_text.as_string_32
			text_view.set_string (text)
		end

	append_text (a_text: STRING_GENERAL)
			-- Append `a_text' to `text'.	
		do
			text.append (a_text)
			text_view.set_string (text)
		end

	prepend_text (a_text: STRING_GENERAL)
			-- Prepend 'txt' to `text'.
		do
			text.prepend (a_text)
			text_view.set_string (text)
		end

	delete_text (start, finish: INTEGER)
			-- Delete the text between `start' and `finish' index
			-- both sides include.
		do
			text.remove_substring (start, finish)
			text_view.set_string (text)
		end

feature -- Basic operation

	scroll_to_line (i: INTEGER)
			-- Scroll `Current' to line number `i'
		do

		end

	scroll_to_end
			-- Scroll to the last line position of `Current'.
		do
		end

	enable_word_wrapping
			-- Enable word wrapping for `Current'
		do
			has_word_wrapping := true
		end

	disable_word_wrapping
			-- Disable word wrapping for `Current'
		do
			has_word_wrapping := False
		end

feature {EV_ANY, EV_ANY_I} -- Basic operation

	select_region (start_pos, end_pos: INTEGER)
			-- Select (hilight) the text between
			-- `start_pos' and `end_pos'. Both `start_pos' and
			-- `end_pos' are selected.
		do
		end

--	select_all is
--			-- Select all the text of `Current'.
--		do
--		end

	deselect_all
			-- Unselect the current selection.
		do
		end

	delete_selection
			-- Delete the current selection.
		do
		end

	cut_selection
			-- Cut `selected_region' by erasing it from
			-- the text and putting it in the Clipboard to paste it later.
			-- If `selectd_region' is empty, it does nothing.
		do
		end

	copy_selection
			-- Copy `selected_region' into the Clipboard.
			-- If the `selected_region' is empty, it does nothing.
		do
		end

	paste (index: INTEGER)
			-- Insert the contents of the clipboard
			-- at `index' postion of `text'.
			-- If the Clipboard is empty, it does nothing.
		do
		end

feature {NONE} -- Implementation

	default_key_processing_blocked (a_key: EV_KEY): BOOLEAN
			--	Does `a_key' require default key processing to be blocked?
		do

		end

	dispose
			-- Clean up `Current'
		do
		end

	on_change_actions
			-- The text within the widget has changed.
		do
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TEXT;

	scroll_view: NS_SCROLL_VIEW
		do
			Result ?= cocoa_item
		end

	text_view: NS_TEXT_VIEW;

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_TEXT_IMP

