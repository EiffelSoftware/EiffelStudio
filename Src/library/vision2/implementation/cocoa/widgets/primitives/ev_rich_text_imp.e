note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RICH_TEXT_IMP

inherit
	EV_RICH_TEXT_I
		undefine
			text_length
		redefine
			interface,
			next_change_of_character
		end

	EV_TEXT_IMP
		redefine
			make,
			interface,
			initialize,
			initialize_buffer_events
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			create tab_positions
			Precursor
		end

	initialize
			-- Set up `Current'
		do

	--		set_tab_width (96 // 2)
	--		create temp_start_iter.make
    --		create temp_end_iter.make
			Precursor {EV_TEXT_IMP}

			tab_positions.internal_add_actions.extend (agent update_tab_positions)
			tab_positions.internal_remove_actions.extend (agent update_tab_positions)
		end

	initialize_buffer_events
			-- Initialize `text_buffer' events
		do
		end

feature {NONE} -- Implementation

	next_change_of_character (current_pos: INTEGER; a_text_length: INTEGER): INTEGER
		do

		end

	initialize_for_saving
			-- Initialize `Current' for save operations, by performing
			-- optimizations that prevent the control from slowing down due to
			-- unecessary optimizations.
		do

		end

	complete_saving
			-- Restore `Current' back to its default state before last call
			-- to `initialize_for_saving'.
		do

		end

	initialize_for_loading
			-- Initialize `Current' for load operations, by performing
			-- optimizations that prevent the control from slowing down due to
			-- unecessary optimizations.
		do

		end

	complete_loading
			-- Restore `Current' back to its default state before last call
			-- to `initialize_for_loading'.
		do

		end

	font_char_set (a_font: EV_FONT): INTEGER
			-- `Result' is char set of font `a_font'.
		do

		end

feature -- Status Report

	format_paragraph (start_line, end_line: INTEGER; format: EV_PARAGRAPH_FORMAT)
			--  Apply paragraph formatting `format' to lines `start_line', `end_line' inclusive.
		do
		end

	character_format_range_information (start_index, end_index: INTEGER): EV_CHARACTER_FORMAT_RANGE_INFORMATION
			-- Formatting range information from caret position `start_index' to `end_index'.
			-- All attributes in `Result' are set to `True' if they remain consitent from `start_index' to
			--`end_index' and `False' otherwise.
			-- `Result' is a snapshot of `Current', and does not remain consistent as the contents
			-- are subsequently changed.
		do
			check False then end
		end

	internal_character_format_range_information (start_index, end_index: INTEGER; abort_on_change: BOOLEAN; change_index: INTEGER_REF): EV_CHARACTER_FORMAT_RANGE_INFORMATION
			-- Formatting range information from caret position `start_index' to `end_index'.
			-- All attributes in `Result' are set to `True' if they remain consistent from `start_index' to
			--`end_index' and `False' otherwise.
			-- `Result' is a snapshot of `Current', and does not remain consistent as the contents
			-- are subsequently changed.
		do
			check False then end
		end

	paragraph_format_range_information (start_index, end_index: INTEGER): EV_PARAGRAPH_FORMAT_RANGE_INFORMATION
			-- Formatting range information from caret position `start_index' to `end_index'.
			-- All attributes in `Result' are set to `True' if they remain consitent from `start_index' to
			--`end_index' and `False' otherwise.
			-- `Result' is a snapshot of `Current', and does not remain consistent as the contents
			-- are subsequently changed.
		do
			check False then end
		end

	paragraph_format_contiguous, internal_paragraph_format_contiguous (start_position, end_position: INTEGER): BOOLEAN
			-- Is paragraph formatting from line `start_position' to `end_position' contiguous?
		do

		end

	character_format_contiguous (start_index, end_index: INTEGER): BOOLEAN
			-- Is formatting from caret position `start_index' to `end_index' contiguous?
			-- Internal version which permits optimizations as caret position and selection
			-- does not need to be restored.
		do

		end

	internal_character_format_contiguous (start_index, end_index: INTEGER): BOOLEAN
			-- Is formatting from caret position `start_index' to `end_index' contiguous?
		do

		end

	selected_paragraph_format: EV_PARAGRAPH_FORMAT
			-- `Result' is paragraph format of current selection.
			-- If more than one format is contained in the selection, `Result'
			-- is the first of these formats.
		do
			check False then end
		end

	modify_region (start_position, end_position: INTEGER; format: EV_CHARACTER_FORMAT; applicable_attributes: EV_CHARACTER_FORMAT_RANGE_INFORMATION)
			-- Modify formatting from `start_position' to `end_position' applying all attributes of `format' that are set to
			-- `True' within `applicable_attributes', ignoring others.
		do

		end

	modify_paragraph (start_position, end_position: INTEGER; format: EV_PARAGRAPH_FORMAT; applicable_attributes: EV_PARAGRAPH_FORMAT_RANGE_INFORMATION)
			-- Modify paragraph formatting from caret positions `start_position' to `end_position' applying all attributes of `format' that are set to
			-- `True' within `applicable_attributes', ignoring others.
		do

		end

	paragraph_format, internal_paragraph_format (caret_index: INTEGER): EV_PARAGRAPH_FORMAT
			-- `Result' is paragraph_format at caret position `caret_index'.
		do
			check False then end
		end

	selected_character_format: EV_CHARACTER_FORMAT
			-- Format of the character which starts the selection
		do
			check False then
			end
		end

	index_from_position (an_x_position, a_y_position: INTEGER): INTEGER
			-- Index of character closest to position `x_position', `y_position'.
		do

		end

	position_from_index (an_index: INTEGER): EV_COORDINATE
			-- Position of character at index `an_index'.
		do
			check False then end
		end

	character_displayed (an_index: INTEGER): BOOLEAN
			-- Is character `an_index' currently visible in `Current'?
		do

		end

feature -- Status report

	character_format (pos: INTEGER): EV_CHARACTER_FORMAT
			-- `Result' is character format at position `pos'. On some platforms
			-- this may be optimized to take the selected character format and therefore
			-- should only be used by `next_change_of_character'.
		do
			create Result.default_create
		end

	internal_character_format (character_index: INTEGER): EV_CHARACTER_FORMAT_IMP
			-- `Result' is character format of character `character_index'.
		do
			check False then end
		end

feature -- Status setting

	set_current_format (format: EV_CHARACTER_FORMAT)
			-- apply `format' to current caret position, applicable
			-- to next typed characters.
		do

		end

	format_region (start_position, end_position: INTEGER; format: EV_CHARACTER_FORMAT)
			-- Apply `format' to all characters between the caret positions `start_position' and `end_position'.
			-- Formatting is applied immediately. May or may not change the cursor position.
		do
		end

	buffered_format (start_position, end_position: INTEGER; format: EV_CHARACTER_FORMAT)
			-- Apply a character format `format' from caret positions `start_position' to `end_position' to
			-- format buffer. Call `flush_format_buffer' to apply buffered contents to `Current'.
		do

		end

	buffered_append (a_text: READABLE_STRING_GENERAL; format: EV_CHARACTER_FORMAT)
			-- Apply `a_text' with format `format' to append buffer.
			-- To apply buffer contents to `Current', call `flush_append_buffer' or
			-- `flush_append_buffer_to'.
		do

		end

	flush_buffer
			-- Flush contents of buffer.
			-- If `buffer_locked_for_append' then replace contents of `Current' with buffer contents.
			-- If `buffer_locked_for_format' then apply buffered formatting to contents of `Current'.
		do

		end

	flush_buffer_to (start_position, end_position: INTEGER)
			-- Replace contents of current from caret position `start_position' to `end_position' with
			-- contents of buffer, since it was last flushed. If `start_position' and `end_position'
			-- are equal, insert the contents of the buffer at caret position `start_position'.
		do

		end

	set_tab_width (a_width: INTEGER)
			-- Assign `a_width' to `tab_width'.
		do
			tab_width := a_width
		end

	pango_tab_array: POINTER
		-- Array of pango tabs used for `Current'

	tab_width: INTEGER
			-- Default width in pixels of each tab in `Current'.

feature {NONE} -- Implementation

	previous_caret_position, previous_selection_start, previous_selection_end: INTEGER
		-- Values used for determining whether either the selection or caret_position has changed inorder to fire appropriate event

feature {NONE} -- Implementation



	modify_region_internal (a_text_buffer: POINTER; start_position, end_position: INTEGER; format_imp: EV_CHARACTER_FORMAT_IMP; applicable_attributes: EV_CHARACTER_FORMAT_RANGE_INFORMATION)
			-- Apply `format' to all characters between the caret positions `start_position' and `end_position'.
			-- Formatting is applied immediately. May or may not change the cursor position.
		do

		end

	modify_paragraph_internal (start_position, end_position: INTEGER; format_imp: EV_PARAGRAPH_FORMAT_IMP; applicable_attributes: EV_PARAGRAPH_FORMAT_RANGE_INFORMATION)
			-- Apply paragraph formatting `format' from position `start_position' to `end_position' based on `applicable_attributes'
		do

		end

	update_tab_positions (value: INTEGER)
			-- Update tab widths based on contents of `tab_positions'.
		do

		end

	dispose_append_buffer
			-- Clean up `append_buffer'.
		do
		end

	append_buffer: POINTER
		-- Pointer to the GtkTextBuffer used for append buffering.	

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_RICH_TEXT note option: stable attribute end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_RICH_TEXT_IMP

