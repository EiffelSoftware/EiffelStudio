indexing
	description: "[
		Objects that represent the implementation interface for rich text widgets.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RICH_TEXT_I
	
inherit
	EV_TEXT_I
		redefine
			interface
		end
		
	EV_RICH_TEXT_ACTION_SEQUENCES_I

feature -- Status report

	character_format (caret_index: INTEGER): EV_CHARACTER_FORMAT is
			-- `Result' is character format at caret position `caret_index'
		require
			valid_character_index: caret_index >= 1 and caret_index <= text_length + 1
		deferred
		ensure
			result_not_void: Result /= Void
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end
		
	paragraph_format (caret_index: INTEGER): EV_PARAGRAPH_FORMAT is
			-- `Result' is paragraph_format at caret position `caret_index'.
		require
			valid_character_index: caret_index >= 1 and caret_index <= text_length + 1
		deferred
		ensure
			result_not_void: Result /= Void
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end	
		
	formatting_contiguous (start_index, end_index: INTEGER): BOOLEAN is
			-- Is formatting from caret position `start_index' to `end_index' contiguous?
		require
			valid_character_index: start_index >= 1 and end_index <= text_length + 1 and
				start_index <= end_index
		deferred
		ensure
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end
		
	formatting_range_information (start_index, end_index: INTEGER): EV_CHARACTER_FORMAT_RANGE_INFORMATION is
			-- Formatting range information from caret position `start_index' to `end_index'.
			-- All attributes in `Result' are set to `True' if they remain consitent from `start_index' to
			--`end_index' and `False' otherwise.
			-- `Result' is a snapshot of `Current', and does not remain consistent as the contents
			-- are subsequently changed.
		require
			valid_character_index: start_index >= 1 and end_index <= text_length + 1 and
				start_index <= end_index
		deferred
		ensure
			result_not_void: Result /= Void
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end	
		end
		
	buffer_locked_in_format_mode: BOOLEAN
			-- Is buffered formatting underway?
		
	buffer_locked_in_append_mode: BOOLEAN
			-- Is buffered appending underway?
			
	index_from_position (an_x_position, a_y_position: INTEGER): INTEGER is
			-- Index of character closest to position `x_position', `y_position'.
		require
			position_valid: an_x_position >= 0 and an_x_position <= width and
				a_y_position >= 0 and a_y_position <= height
		deferred
		ensure
			index_valid: Result >= 1 and Result <= text_length
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end
		
	position_from_index (an_index: INTEGER): EV_COORDINATE is
			-- Position of character at index `an_index'.
		require
			index_valid: an_index >= 1 and an_index <= text_length
			character_displayed: character_displayed (an_index)
		deferred
		ensure
			position_valid: Result.x >= 0 and Result.x <= width and
				Result.y >= 0 and Result.y <= height
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end
		
	character_displayed (an_index: INTEGER): BOOLEAN is
			-- Is character `an_index' currently visible in `Current'?
		require
			index_valid: an_index >= 1 and an_index <= text_length
		deferred
		ensure
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end
		
	tab_positions: ACTIVE_LIST [INTEGER]
			-- Width of each tab position in pixels, from left to right.
			-- All tab positions not included use `tab_width'.
		
	tab_width: INTEGER is
			-- Default width in pixels of each tab in `Current'.
		deferred
		ensure
			result_positive: Result > 0
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end

feature -- Status setting

	set_current_format (format: EV_CHARACTER_FORMAT) is
			-- apply `format' to current caret position, applicable
			-- to next typed characters.
		require
			format_not_void: format /= Void
		deferred
		ensure
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end

	format_region (start_position, end_position: INTEGER; format: EV_CHARACTER_FORMAT) is
			-- Apply `format' to all characters between the caret positions `start_position' and `end_position'.
			-- Formatting is applied immediately. May or may not change the cursor position.
		require
			valid_positions: start_position < end_position and start_position >= 1 and end_position <= text_length + 1
			format_not_void: format /= Void
		deferred
		ensure
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end
		
	format_paragraph (start_line, end_line: INTEGER; format: EV_PARAGRAPH_FORMAT) is
			-- Apply paragraph formatting `format' to lines `start_line', `end_line' inclusive.
		require
			lines_valid: start_line >= 1 and end_line >= start_line and end_line <= line_count
			format_not_void: format /= Void
		deferred
		ensure
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end
		
	modify_region (start_position, end_position: INTEGER; format: EV_CHARACTER_FORMAT; applicable_attributes:EV_CHARACTER_FORMAT_RANGE_INFORMATION) is
			-- Modify formatting from `start_position' to `end_position' applying all attributes of `format' that are set to
			-- `True' within `applicable_attributes', ignoring others.
		require
			applicable_attributes_not_void: applicable_attributes /= Void
			valid_positions: start_position < end_position and start_position >= 1 and end_position <= text_length + 1
			format_not_void: format /= Void
		deferred
		ensure
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end
		
	buffered_format (start_position, end_position: INTEGER; format: EV_CHARACTER_FORMAT) is
			-- Apply a character format `format' from caret positions `start_position' to `end_position' to
			-- format buffer. Call `flush_format_buffer' to apply buffered contents to `Current'.
		require
			valid_positions: start_position <= end_position and start_position >= 1 and end_position <= text_length + 1 
			format_not_void: format /= Void
		deferred
		ensure
			text_not_changed: text.is_equal (old text)
		end
		
	buffered_append (a_text: STRING; format: EV_CHARACTER_FORMAT) is
			-- Apply `a_text' with format `format' to append buffer.
			-- To apply buffer contents to `Current', call `flush_append_buffer' or
			-- `flush_append_buffer_to'.
		require
			a_text_not_void: a_text /= Void
			format_not_void: format /= Void
			buffer_not_locked_for_format: not buffer_locked_in_format_mode
		deferred
		ensure
			buffer_locked_for_append: buffer_locked_in_append_mode
		end
		
	flush_buffer is
			-- Flush contents of buffer.
			-- If `buffer_locked_for_append' then replace contents of `Current' with buffer contents.
			-- If `buffer_locked_for_format' then apply buffered formatting to contents of `Current'.
		deferred
		ensure
			buffer_not_locked: not buffer_locked_in_append_mode and not buffer_locked_in_format_mode
		end
		
	flush_buffer_to (start_position, end_position: INTEGER) is
			-- Replace contents of current from caret position `start_position' to `end_position' with
			-- contents of buffer, since it was last flushed. If `start_position' and `end_position'
			-- are equal, insert the contents of the buffer at caret position `start_position'.
		require
			buffer_locked_for_append: buffer_locked_in_append_mode
			start_position >= 1 and end_position <= text_length + 1 and start_position <= end_position
		deferred
		ensure	
			buffer_locked_for_append: not buffer_locked_in_append_mode
		end
		
	set_tab_width (a_width: INTEGER) is
			-- Assign `a_width' to `tab_width'.
		require
			width_positive: a_width > 0
		deferred
		ensure
			tab_width_set: tab_width = a_width
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end
	
feature {NONE} -- Implementation

	update_tab_positions (value: INTEGER) is
			-- Update tab widths based on contents of `tab_positions'.
		deferred
		end
		

feature {EV_FONT_I} -- Implementation

	interface: EV_RICH_TEXT

end -- class EV_RICH_TEXT_I

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
