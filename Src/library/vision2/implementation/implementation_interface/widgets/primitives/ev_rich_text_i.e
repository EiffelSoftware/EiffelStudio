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
		
	selected_character_format: EV_CHARACTER_FORMAT is
			--
		require
			has_selection: has_selection
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
		
	selected_paragraph_format: EV_PARAGRAPH_FORMAT is
			-- `Result' is paragraph format of current selection.
			-- If more than one format is contained in the selection, `Result'
			-- is the first of these formats.
		require
			has_selection: has_selection
		deferred
		ensure
			result_not_void: Result /= Void
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end
		
	character_format_contiguous (start_index, end_index: INTEGER): BOOLEAN is
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
		
	paragraph_format_contiguous (start_position, end_position: INTEGER): BOOLEAN is
			-- Is paragraph formatting from caret_position `start_position' to `end_position' contiguous?
		require
			valid_character_index: start_position >= 1 and end_position <= text_length + 1 and
				start_position <= end_position
		deferred
		ensure
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
			valid_character_index: start_index >= 1 and end_index <= text_length + 1 and
				start_index <= end_index
		deferred
		ensure
			result_not_void: Result /= Void
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
			valid_character_index: start_position >= 1 and end_position <= text_length + 1 and
				start_position <= end_position
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
		
	tab_positions: EV_ACTIVE_LIST [INTEGER]
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
			-- Formatting is applied immediately.
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
		
	format_paragraph (start_position, end_position: INTEGER; format: EV_PARAGRAPH_FORMAT) is
			-- Apply paragraph formatting `format' to character positions `start_position', `end_position' inclusive.
			-- Formatting applies to complete lines as seperated by new line characters that `start_position' and
			-- `end_position' fall on.
		require
			valid_positions: start_position < end_position and start_position >= 1 and end_position <= text_length + 1
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

	modify_paragraph (start_position, end_position: INTEGER; format: EV_PARAGRAPH_FORMAT; applicable_attributes: EV_PARAGRAPH_FORMAT_RANGE_INFORMATION) is
			-- Modify paragraph formatting from lines `start_position' to `end_position' applying all attributes of `format' that are set to
			-- `True' within `applicable_attributes', ignoring others. Modification applies to complete lines as seperated by
			-- new line characters that `start_position' and `end_position' fall on.
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
			buffer_locked_for_format: buffer_locked_in_format_mode
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
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
			text_not_changed: text.is_equal (old text)
			buffer_locked_for_append: buffer_locked_in_append_mode
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old selection_start = selection_start and old selection_end = selection_end
		end
		
	flush_buffer is
			-- Flush contents of buffer.
			-- If `buffer_locked_for_append' then replace contents of `Current' with buffer contents.
			-- If `buffer_locked_for_format' then apply buffered formatting to contents of `Current'.
		deferred
		ensure
			buffer_not_locked: not buffer_locked_in_append_mode and not buffer_locked_in_format_mode
			caret_not_moved: caret_position = old caret_position
			unselected: not has_selection
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
			caret_not_moved: caret_position = old caret_position
			unselected: not has_selection
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

	save_to_named_file (a_filename: FILE_NAME) is
			-- Save `text' and formatting of `Current' to file `a_filename' in RTF format.
		require
			filename_not_void: a_filename /= Void
		local
			l_text_length: INTEGER
			l_text: STRING
			counter: INTEGER
			current_format: EV_CHARACTER_FORMAT
			buffer: EV_RICH_TEXT_BUFFERING_STRUCTURES_I
			last_counter: INTEGER
			text_file: PLAIN_TEXT_FILE
			start_indexes: ARRAYED_LIST [INTEGER]
			current_lower_line_index: INTEGER
			current_upper_line_index: INTEGER
		do
			create buffer.set_rich_text (Current)
			initialize_for_saving
			l_text := text
			l_text_length := l_text.count
			start_indexes := buffer.start_line_indexes (l_text)
			current_lower_line_index := 1
			current_upper_line_index := 2
			from
				counter := 1
				last_counter := 1
			until
				counter > l_text_length
			loop
					-- Retrieve next character change index.
				counter := next_change_of_character (counter)
				if counter > start_indexes.i_th (current_upper_line_index) then
					if paragraph_format_contiguous (current_lower_line_index, current_upper_line_index) then
						current_upper_line_index := current_upper_line_index + 1
					else
						do_nothing
					end
				end
				
					-- Retrieve last character format found while executing `next_change_of_character'.
				current_format := last_format
				
					-- Now process based on this character format spanning `counter' positions.
				buffer.append_text_for_rtf (l_text.substring (last_counter, counter - 1), current_format)
				last_counter := counter
			end
			buffer.generate_complete_rtf_from_buffering
			complete_saving
			create text_file.make_open_write (a_filename)
			text_file.put_string (buffer.internal_text)
			text_file.close
		end
		
	next_change_of_character (current_pos: INTEGER): INTEGER is
			-- `Result' is caret position at next change of character.
		local
			counter: INTEGER
			last_false_pos, current_step: INTEGER
			value_finder: INTEGER
			last_contiguous_position: INTEGER
		do
			counter := current_pos
			from
				current_step := default_step
				value_finder := default_step
				last_false_pos := 0				
			until
				(last_contiguous_position - last_false_pos).abs = 1
			loop
				if internal_character_format_contiguous (counter, counter + current_step) then
						-- This is performed here so that on Windows we do not have to
						-- change the selection while querying the format. The previous call has
						-- set the selection already.
					last_format := internal_character_format (counter)
					last_contiguous_position := current_step
					if value_finder = default_step then
						current_step := current_step + default_step
					else
						value_finder := value_finder // 2
						current_step := current_step + value_finder
					end
				else
					last_false_pos := current_step
					value_finder := value_finder // 2
					current_step := current_step - value_finder
				end
			end
			Result := current_pos + last_contiguous_position
		end
		
	last_format: EV_CHARACTER_FORMAT
		-- Last contiguous character format found be last query to `next_change_of_character'.
		-- By using this we can optimize various implementations by not providing another
		-- query to the control if not needed.
	
	default_step: INTEGER is 8
		-- Default step used when buffering into RTF.
	
	internal_character_format_contiguous (start_index, end_index: INTEGER): BOOLEAN is
			-- Is formatting from caret position `start_index' to `end_index' contiguous?
			-- Internal version which permits optimizations as caret position and selection
			-- does not need to be restored.
		deferred
		end
		
	internal_character_format (pos: INTEGER): EV_CHARACTER_FORMAT is
			-- `Result' is character format at position `pos'. On some platforms
			-- this may be optimized to take the selected character format and therefore
			-- should only be used by `next_change_of_character'.
		deferred
		end

	initialize_for_saving is
			-- Initialize `Current' for save operations, by performing
			-- optimizations that prevent the control from slowing down due to
			-- unecessary optimizations.
		deferred
		end
		
	complete_saving is
			-- Restore `Current' back to its default state before last call
			-- to `initialize_for_saving'.
		deferred
		end
		
	font_char_set (a_font: EV_FONT): INTEGER is
			-- `Result' is char set of font `a_font'.
		require
			a_font_not_void: a_font /= Void
		deferred
		ensure
			result_not_void: Result >= 0
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
