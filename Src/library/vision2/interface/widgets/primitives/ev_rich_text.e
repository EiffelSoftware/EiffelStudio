indexing
	description: "[
		EiffelVision rich text area, supporting multiple lines of text, with font and color
		formatting applicable on a character by character basis.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RICH_TEXT
	
inherit
	EV_TEXT
		redefine
			implementation,
			create_implementation,
			is_in_default_state
		end
		
	EV_RICH_TEXT_ACTION_SEQUENCES
		redefine
			implementation
		end
		
feature -- Access

	character_format (caret_index: INTEGER): EV_CHARACTER_FORMAT is
			-- `Result' is character format at caret position `caret_index'.
		require
			not_destroyed: not is_destroyed
			valid_character_index: caret_index >= 1 and caret_index <= text_length + 1
		do
			Result := implementation.character_format (caret_index)
		ensure
			result_not_void: Result /= Void
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end
		
	selected_character_format: EV_CHARACTER_FORMAT is
			-- `Result' is character format of current selection.
			-- If more than one format is contained in the selection, `Result'
			-- is the first of these formats.
		require
			not_destroyed: not is_destroyed
			has_selection: has_selection
		do
			Result := implementation.selected_character_format
		ensure
			result_not_void: Result /= Void
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end

	paragraph_format (caret_index: INTEGER): EV_PARAGRAPH_FORMAT is
			-- `Result' is paragraph_format at caret position `caret_index'.
		require
			not_destroyed: not is_destroyed
			valid_character_index: caret_index >= 1 and caret_index <= text_length + 1
		do
			Result := implementation.paragraph_format (caret_index)
		ensure
			result_not_void: Result /= Void
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end
		
	selected_paragraph_format: EV_PARAGRAPH_FORMAT is
			-- `Result' is paragraph format of current selection.
			-- If more than one format is contained in the selection, `Result'
			-- is the first of these formats.
		require
			not_destroyed: not is_destroyed
			has_selection: has_selection
		do
			Result := implementation.selected_paragraph_format
		ensure
			result_not_void: Result /= Void
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end

	character_format_contiguous (start_index, end_index: INTEGER): BOOLEAN is
			-- Is formatting from caret position `start_index' to `end_index' contiguous?
		require
			not_destroyed: not is_destroyed
			valid_character_index: start_index >= 1 and end_index <= text_length + 1 and
				start_index <= end_index
		do
			Result := implementation.character_format_contiguous (start_index, end_index)
		ensure
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end

	paragraph_format_contiguous (start_position, end_position: INTEGER): BOOLEAN is
			-- Is paragraph formatting from caret_position `start_position' to `end_position' contiguous?
		require
			not_destroyed: not is_destroyed
			valid_character_index: start_position >= 1 and end_position <= text_length + 1 and
				start_position <= end_position
		do
			Result := implementation.paragraph_format_contiguous (start_position, end_position)
		ensure
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end	
		end

	character_format_range_information (start_index, end_index: INTEGER): EV_CHARACTER_FORMAT_RANGE_INFORMATION is
			-- Formatting range information from caret position `start_index' to `end_index'.
			-- All attributes in `Result' are set to `True' if they remain consitent from `start_index' to
			--`end_index' and `False' otherwise.
			-- `Result' is a snapshot of `Current', and does not remain consistent as the contents
			-- are subsequently changed.
		require
			not_destroyed: not is_destroyed
			valid_character_index: start_index >= 1 and end_index <= text_length + 1 and
				start_index <= end_index
		do
			Result := implementation.character_format_range_information (start_index, end_index)
		ensure
			result_not_void: Result /= Void
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end	
		end
		
	paragraph_format_range_information (start_position, end_position: INTEGER): EV_PARAGRAPH_FORMAT_RANGE_INFORMATION is
			-- Formatting range information from caret position `start_position' to `end_position'.
			-- All attributes in `Result' are set to `True' if they remain consitent from `start_position' to
			--`end_position' and `False' otherwise.
			-- `Result' is a snapshot of `Current', and does not remain consistent as the contents
			-- are subsequently changed.
		require
			not_destroyed: not is_destroyed
			valid_character_index: start_position >= 1 and end_position <= text_length + 1 and
				start_position <= end_position
		do
			Result := implementation.paragraph_format_range_information (start_position, end_position)
		ensure
			result_not_void: Result /= Void
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end	
		end

	buffer_locked_in_format_mode: BOOLEAN is
			-- Is buffered formatting underway?
			-- `True' after one or more calls to `buffered_format' and `False'
			-- after buffer is flushed.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.buffer_locked_in_format_mode
		ensure
			caret_not_moved: caret_position = old caret_position
			text_not_changed: text.is_equal (old text)
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end
		
	buffer_locked_in_append_mode: BOOLEAN is
			-- Is buffered appending underway?
			-- `True' after one or more calls to `buffered_append' and `False'
			-- after buffer is flushed.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.buffer_locked_in_append_mode
		ensure
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end
		
	index_from_position (an_x_position, a_y_position: INTEGER): INTEGER is
			-- Index of character closest to position `x_position', `y_position'.
		require
			not_destroyed: not is_destroyed
			position_valid: an_x_position >= 0 and an_x_position <= width and
				a_y_position >= 0 and a_y_position <= height
		do
			Result := implementation.index_from_position (an_x_position, a_y_position)
		ensure
			index_valid: Result >= 1 and Result <= text_length
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end
		
	position_from_index (an_index: INTEGER): EV_COORDINATE is
			-- Position of character at index `an_index'.
		require
			not_destroyed: not is_destroyed
			index_valid: an_index >= 1 and an_index <= text_length
			character_displayed: character_displayed (an_index)
		do
			Result := implementation.position_from_index (an_index)
		ensure
			result_not_void: Result /= Void
			position_valid: Result.x >= 0 and Result.x <= width and
				Result.y >= 0 and Result.y <= height
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end
		
	character_displayed (an_index: INTEGER): BOOLEAN is
			-- Is character `an_index' currently visible in `Current'?
		require
			not_destroyed: not is_destroyed
			index_valid: an_index >= 1 and an_index <= text_length
		do
			Result := implementation.character_displayed (an_index)
		ensure
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end
		
	tab_positions: EV_ACTIVE_LIST [INTEGER] is
			-- Width of each tab position in pixels, from left to right.
			-- Insert values to update tab widths used in `Current'.
			-- All additional tab positions use `tab_width'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.tab_positions
		ensure
			result_not_void: Result /= Void
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end
		
	tab_width: INTEGER is
			-- Default width in pixels of each tab in `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.tab_width
		ensure
			result_positive: Result > 0
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end
		
	last_load_successful: BOOLEAN is
			-- Did last call to `set_with_named_file' complete succesfully?
			-- If an invalid RTF file is passed, `Result' is `False'.
			-- `Result' is undefined if `set_with_named_file' not called.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.last_load_successful
		end

feature -- Status setting

	set_current_format (format: EV_CHARACTER_FORMAT) is
			-- Apply `format' to current caret position, applicable
			-- to next typed characters.
		require
			not_destroyed: not is_destroyed
			format_not_void: format /= Void
		do
			implementation.set_current_format (format)
		ensure
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end
		
	format_paragraph (start_position, end_position: INTEGER; format: EV_PARAGRAPH_FORMAT) is
			-- Apply paragraph formatting `format' to caret positions `start_position', `end_position' inclusive.
			-- Formatting applies to complete lines as seperated by new line characters that `start_position' and
			-- `end_position' fall on.
		require
			not_destroyed: not is_destroyed
			valid_positions: start_position <= end_position and start_position >= 1 and end_position <= text_length + 1
			format_not_void: format /= Void
		do
			implementation.format_paragraph (start_position, end_position, format)
		ensure
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end

	format_region (start_position, end_position: INTEGER; format: EV_CHARACTER_FORMAT) is
			-- Apply `format' to all characters between the caret positions `start_position' and `end_position'.
			-- Formatting is applied immediately.
		require
			not_destroyed: not is_destroyed
			valid_positions: start_position < end_position and start_position >= 1 and end_position <= text_length + 1
			format_not_void: format /= Void
		do
			implementation.format_region (start_position, end_position, format)
		ensure
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end
		
	modify_region (start_position, end_position: INTEGER; format: EV_CHARACTER_FORMAT; applicable_attributes: EV_CHARACTER_FORMAT_RANGE_INFORMATION) is
			-- Modify formatting from caret positions `start_position' to `end_position' applying all attributes
			-- of `format' that are set to `True' within `applicable_attributes', ignoring others.
		require
			not_destroyed: not is_destroyed
			applicable_attributes_not_void: applicable_attributes /= Void
			valid_positions: start_position < end_position and start_position >= 1 and end_position <= text_length + 1
			format_not_void: format /= Void
		do
			implementation.modify_region (start_position, end_position, format, applicable_attributes)
		ensure
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end
		
	modify_paragraph (start_position, end_position: INTEGER; format: EV_PARAGRAPH_FORMAT; applicable_attributes: EV_PARAGRAPH_FORMAT_RANGE_INFORMATION) is
			-- Modify paragraph formatting `format' from caret positions `start_position' to `end_position' inclusive.
			-- Formatting applies to complete lines as seperated by new line characters that `start_position' and
			-- `end_position' fall on. All attributes of `format' that are set to `True' within `applicable_attributes' are applied.
		require
			not_destroyed: not is_destroyed
			applicable_attributes_not_void: applicable_attributes /= Void
			valid_positions: start_position <= end_position and start_position >= 1 and end_position <= text_length + 1
			format_not_void: format /= Void
		do
			implementation.modify_paragraph (start_position, end_position, format, applicable_attributes)
		ensure
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end

	buffered_format (start_position, end_position: INTEGER; format: EV_CHARACTER_FORMAT) is
			-- Apply a character format `format' from caret positions `start_position' to `end_position' to
			-- format buffer. Call `flush_buffer' to apply buffered contents to `Current'.
			-- `format' is not cloned internally and when buffer is flushed, its reference is
			-- used. Therefore, you must not modify `format' externally after passing to
			-- this procedure, otherwise all buffered appends that referenced the same `format' object
			-- will use its current value.
		require
			not_destroyed: not is_destroyed
			valid_positions: start_position < end_position and start_position >= 1 and end_position <= text_length + 1
			format_not_void: format /= Void
			buffer_not_locked_for_append: not buffer_locked_in_append_mode
		do
			implementation.buffered_format (start_position, end_position, format)
		ensure
			text_not_changed: text.is_equal (old text)
			buffer_locked_for_format: buffer_locked_in_format_mode
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end
		
	buffered_append (a_text: STRING_GENERAL; format: EV_CHARACTER_FORMAT) is
			-- Append `a_text' with format `format' to append buffer.
			-- To render buffer to `Current', call `flush_buffer' which replaces current content,
			-- or `flush_buffer_to' which inserts the formatted text.
			-- `format' is not cloned internally and when buffer is flushed, its reference is
			-- used. Therefore, you must not modify `format' externally after passing to
			-- this procedure, otherwise all buffered appends that referenced the same `format' object
			-- will use its current value.
		require
			not_destroyed: not is_destroyed
			a_text_not_void: a_text /= Void
			format_not_void: format /= Void
			buffer_not_locked_for_format: not buffer_locked_in_format_mode
		do
			implementation.buffered_append (a_text, format)
		ensure
			text_not_changed: text.is_equal (old text)
			buffer_locked_for_append: buffer_locked_in_append_mode
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end
		
	flush_buffer_to (start_position, end_position: INTEGER) is
			-- Replace contents of current from caret position `start_position' to `end_position' with
			-- contents of buffer, since it was last flushed. If `start_position' and `end_position'
			-- are equal, insert the contents of the buffer at caret position `start_position'.
			-- Locked buffering modes are reset.
		require
			not_destroyed: not is_destroyed
			buffer_locked_for_append: buffer_locked_in_append_mode
			start_position >= 1 and end_position <= text_length + 1 and start_position <= end_position
		do
			implementation.flush_buffer_to (start_position, end_position)
		ensure	
			buffer_locked_for_append: not buffer_locked_in_append_mode
			caret_consistent: old caret_position <= text_length + 1 implies caret_position = old caret_position
			unselected: not has_selection
		end

	flush_buffer is
			-- Flush contents of buffer and unlock any set buffering mode.
			-- If `buffer_locked_for_append' then replace contents of `Current' with buffer contents.
			-- If `buffer_locked_for_format' then apply buffered formatting to contents of `Current'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.flush_buffer
		ensure
			buffer_not_locked: not buffer_locked_in_append_mode and not buffer_locked_in_format_mode
			caret_consistent: (old buffer_locked_in_append_mode implies caret_position = 1) or
				old buffer_locked_in_format_mode implies (caret_position = old caret_position)
			unselected: not has_selection
		end
		
	set_tab_width (a_width: INTEGER) is
			-- Assign `a_width' in pixels to `tab_width'.
		require
			not_destroyed: not is_destroyed
			width_positive: a_width > 0
		do
			implementation.set_tab_width (a_width)
		ensure
			tab_width_set: tab_width = a_width
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end
		
	save_to_named_file (a_filename: FILE_NAME) is
			-- Save `text' and formatting of `Current' to file `a_filename' in RTF format.
		require
			not_destroyed: not is_destroyed
			filename_not_void: a_filename /= Void
		do
			implementation.save_to_named_file (a_filename)
		ensure
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end
		
	set_with_named_file (a_filename: FILE_NAME) is
			-- Set `text' and formatting of `Current' from file `a_filename' in RTF format.
		require
			not_destroyed: not is_destroyed
			filename_not_void: a_filename /= Void
		do
			implementation.set_with_named_file (a_filename)
		ensure
			caret_reset_if_successful: last_load_successful implies caret_position = 1
			unselected_if_successful: last_load_successful implies not has_selection
			text_not_changed_if_failed: not last_load_successful implies old text.is_equal (text)
			caret_not_moved_if_failed: not last_load_successful implies caret_position = old caret_position
			selection_not_changed_if_failed: not last_load_successful implies (old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end)
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := not buffer_locked_in_append_mode and not buffer_locked_in_format_mode
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_RICH_TEXT_I
			-- Responsible for interaction with native graphics
			-- toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- Create implementation of drawing area.
		do
			create {EV_RICH_TEXT_IMP} implementation.make (Current)
		end

invariant
	buffer_locked_in_a_single_mode: not (buffer_locked_in_append_mode and buffer_locked_in_format_mode)

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




end -- class EV_RICH_TEXT

