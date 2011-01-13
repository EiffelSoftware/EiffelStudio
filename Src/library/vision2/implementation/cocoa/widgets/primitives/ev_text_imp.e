note
	description: "EiffelVision text area, Cocoa implementation."
	author: "Daniel Furrer"
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
			make,
			default_key_processing_blocked
		end

	EV_FONTABLE_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'
		do
			create scroll_view.make
			cocoa_view := scroll_view
			create text_view.make
			text_view.set_horizontally_resizable (True)
			scroll_view.set_document_view (text_view)
			scroll_view.set_has_horizontal_scroller (True)
			scroll_view.set_has_vertical_scroller (True)
			scroll_view.set_autohides_scrollers (True)
			scroll_view.set_border_type ({NS_SCROLL_VIEW}.ns_line_border)

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
		do
			Result := text_view.string.to_string_32
		end

	line (a_line: INTEGER): STRING_32
			-- Returns the content of line `a_line'.
		do
			create Result.make_empty
		end

	first_position_from_line_number (a_line: INTEGER): INTEGER
			-- Position of the first character on line `a_line'.
		do
		end

	last_position_from_line_number (a_line: INTEGER): INTEGER
			-- Position of the last character on line `a_line'.
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
			Result := text_view.selected_range.location + 1
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

	insert_text (a_text: READABLE_STRING_GENERAL)
		local
			l_text: STRING_32
		do
			l_text := text
			l_text.insert_string (a_text, caret_position)
			text_view.set_string (l_text)
			text_view.size_to_fit
		end

	set_text (a_text: READABLE_STRING_GENERAL)
			-- Set `text' to `a_text'
		do
			text_view.set_string (a_text)
			text_view.size_to_fit
		end

	append_text (a_text: READABLE_STRING_GENERAL)
			-- Append `a_text' to `text'.	
		local
			l_text: STRING_32
			range, l_range: NS_RANGE
		do
			l_text := text
			l_text.append (a_text)

			create l_range.make_range (a_text.count, text_view.string.to_string_8.count)

			range := text_view.selected_range
--			text_view.replace_characters_in_range_with_string (l_range, create {NS_STRING}.make_with_string (a_text))
			text_view.set_string (l_text)
			text_view.size_to_fit

			text_view.scroll_range_to_visible (l_range)

			text_view.set_selected_range (range)
		end

	prepend_text (a_text: READABLE_STRING_GENERAL)
			-- Prepend 'txt' to `text'.
		local
			l_text: STRING_32
		do
			l_text := text
			l_text.prepend (a_text)
			text_view.set_string (l_text)
			text_view.size_to_fit
		end

	delete_text (start, finish: INTEGER)
			-- Delete the text between `start' and `finish' index
			-- both sides include.
		local
			l_text: STRING_32
		do
			l_text := text
			l_text.remove_substring (start, finish)
			text_view.set_string (l_text)
			text_view.size_to_fit
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

	on_change_actions
			-- The text within the widget has changed.
		do
		end

feature {EV_ANY_I} -- Implementation

	scroll_view: NS_SCROLL_VIEW

	text_view: NS_TEXT_VIEW;

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TEXT note option: stable attribute end;

end -- class EV_TEXT_IMP
