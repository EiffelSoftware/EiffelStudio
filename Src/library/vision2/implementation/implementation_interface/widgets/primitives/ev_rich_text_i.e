note
	description: "[
			Objects that represent the implementation interface for rich text widgets.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	character_format (caret_index: INTEGER): EV_CHARACTER_FORMAT
			-- `Result' is character format at caret position `caret_index'
		require
			valid_character_index: caret_index >= 1 and caret_index <= text_length + 1
		deferred
		ensure
			result_not_void: Result /= Void
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old start_selection = start_selection and old end_selection = end_selection
		end

	selected_character_format: EV_CHARACTER_FORMAT
			-- `Result' is character format of current selection.
			-- If more than one format is contained in the selection, `Result'
			-- is the first of these formats.
		require
			has_selection: has_selection
		deferred
		ensure
			result_not_void: Result /= Void
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old start_selection = start_selection and old end_selection = end_selection
		end

	paragraph_format (caret_index: INTEGER): EV_PARAGRAPH_FORMAT
			-- `Result' is paragraph_format at caret position `caret_index'.
		require
			valid_character_index: caret_index >= 1 and caret_index <= text_length + 1
		deferred
		ensure
			result_not_void: Result /= Void
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old start_selection = start_selection and old end_selection = end_selection
		end

	selected_paragraph_format: EV_PARAGRAPH_FORMAT
			-- `Result' is paragraph format of current selection.
			-- If more than one format is contained in the selection, `Result'
			-- is the first of these formats.
		require
			has_selection: has_selection
		deferred
		ensure
			result_not_void: Result /= Void
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old start_selection = start_selection and old end_selection = end_selection
		end

	character_format_contiguous (start_index, end_index: INTEGER): BOOLEAN
			-- Is formatting from caret position `start_index' to `end_index' contiguous?
		require
			valid_character_index: start_index >= 1 and end_index <= text_length + 1 and
				start_index <= end_index
		deferred
		ensure
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old start_selection = start_selection and old end_selection = end_selection
		end

	paragraph_format_contiguous (start_position, end_position: INTEGER): BOOLEAN
			-- Is paragraph formatting from caret_position `start_position' to `end_position' contiguous?
		require
			valid_character_index: start_position >= 1 and end_position <= text_length + 1 and
				start_position <= end_position
		deferred
		ensure
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old start_selection = start_selection and old end_selection = end_selection
		end

	character_format_range_information (start_index, end_index: INTEGER): EV_CHARACTER_FORMAT_RANGE_INFORMATION
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
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old start_selection = start_selection and old end_selection = end_selection
		end

	paragraph_format_range_information (start_position, end_position: INTEGER): EV_PARAGRAPH_FORMAT_RANGE_INFORMATION
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
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old start_selection = start_selection and old end_selection = end_selection
		end

	buffer_locked_in_format_mode: BOOLEAN
			-- Is buffered formatting underway?

	buffer_locked_in_append_mode: BOOLEAN
			-- Is buffered appending underway?

	index_from_position (an_x_position, a_y_position: INTEGER): INTEGER
			-- Index of character closest to position `x_position', `y_position'.
		require
			position_valid: an_x_position >= 0 and an_x_position <= width and
				a_y_position >= 0 and a_y_position <= height
		deferred
		ensure
			index_valid: Result >= 1 and Result <= text_length
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old start_selection = start_selection and old end_selection = end_selection
		end

	position_from_index (an_index: INTEGER): EV_COORDINATE
			-- Position of character at index `an_index'.
		require
			index_valid: an_index >= 1 and an_index <= text_length
			character_displayed: character_displayed (an_index)
		deferred
		ensure
			position_valid: Result.x >= 0 and Result.x <= width and
				Result.y >= 0 and Result.y <= height
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old start_selection = start_selection and old end_selection = end_selection
		end

	character_displayed (an_index: INTEGER): BOOLEAN
			-- Is character `an_index' currently visible in `Current'?
		require
			index_valid: an_index >= 1 and an_index <= text_length
		deferred
		ensure
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old start_selection = start_selection and old end_selection = end_selection
		end

	tab_positions: EV_ACTIVE_LIST [INTEGER]
			-- Width of each tab position in pixels, from left to right.
			-- All tab positions not included use `tab_width'.

	tab_width: INTEGER
			-- Default width in pixels of each tab in `Current'.
		deferred
		ensure
			result_positive: Result > 0
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old start_selection = start_selection and old end_selection = end_selection
		end

feature {EV_ANY, EV_ANY_I, EV_RICH_TEXT_BUFFERING_STRUCTURES_I} -- Status setting

	set_current_format (format: EV_CHARACTER_FORMAT)
			-- apply `format' to current caret position, applicable
			-- to next typed characters.
		require
			format_not_void: format /= Void
		deferred
		ensure
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old start_selection = start_selection and old end_selection = end_selection
		end

	format_region (start_position, end_position: INTEGER; format: EV_CHARACTER_FORMAT)
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
				old start_selection = start_selection and old end_selection = end_selection
		end

	format_paragraph (start_position, end_position: INTEGER; format: EV_PARAGRAPH_FORMAT)
			-- Apply paragraph formatting `format' to caret positions `start_position', `end_position' inclusive.
			-- Formatting applies to complete lines as separated by new line characters that `start_position' and
			-- `end_position' fall on.
		require
			valid_positions: start_position <= end_position and start_position >= 1 and end_position <= text_length + 1
			format_not_void: format /= Void
		deferred
		ensure
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old start_selection = start_selection and old end_selection = end_selection
		end

	modify_region (start_position, end_position: INTEGER; format: EV_CHARACTER_FORMAT; applicable_attributes: EV_CHARACTER_FORMAT_RANGE_INFORMATION)
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
				old start_selection = start_selection and old end_selection = end_selection
		end

	modify_paragraph (start_position, end_position: INTEGER; format: EV_PARAGRAPH_FORMAT; applicable_attributes: EV_PARAGRAPH_FORMAT_RANGE_INFORMATION)
			-- Modify paragraph formatting `format' from caret positions `start_position' to `end_position' inclusive.
			-- Formatting applies to complete lines as separated by new line characters that `start_position' and
			-- `end_position' fall on. All attributes of `format' that are set to `True' within `applicable_attributes' are applied.
		require
			applicable_attributes_not_void: applicable_attributes /= Void
			valid_positions: start_position <= end_position and start_position >= 1 and end_position <= text_length + 1
			format_not_void: format /= Void
		deferred
		ensure
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old start_selection = start_selection and old end_selection = end_selection
		end

	buffered_format (start_position, end_position: INTEGER; format: EV_CHARACTER_FORMAT)
			-- Apply a character format `format' from caret positions `start_position' to `end_position' to
			-- format buffer. Call `flush_buffer' to apply buffered contents to `Current'.
			-- `format' is not cloned internally and when buffer is flushed, its reference is
			-- used. Therefore, you must not modify `format' externally after passing to
			-- this procedure, otherwise all buffered appends that referenced the same `format' object
			-- will use its current value.
		require
			valid_positions: start_position <= end_position and start_position >= 1 and end_position <= text_length + 1
			format_not_void: format /= Void
		deferred
		ensure
			text_not_changed: text.is_equal (old text)
			buffer_locked_for_format: buffer_locked_in_format_mode
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old start_selection = start_selection and old end_selection = end_selection
		end

	buffered_append (a_text: READABLE_STRING_GENERAL; format: EV_CHARACTER_FORMAT)
			-- Append `a_text' with format `format' to append buffer.
			-- To render buffer to `Current', call `flush_buffer' which replaces current content,
			-- or `flush_buffer_to' which inserts the formatted text.
			-- `format' is not cloned internally and when buffer is flushed, its reference is
			-- used. Therefore, you must not modify `format' externally after passing to
			-- this procedure, otherwise all buffered appends that referenced the same `format' object
			-- will use its current value.
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
				old start_selection = start_selection and old end_selection = end_selection
		end

	flush_buffer
			-- Flush contents of buffer.
			-- If `buffer_locked_for_append' then replace contents of `Current' with buffer contents.
			-- If `buffer_locked_for_format' then apply buffered formatting to contents of `Current'.
		deferred
		ensure
			buffer_not_locked: not buffer_locked_in_append_mode and not buffer_locked_in_format_mode
			caret_consistent: (old buffer_locked_in_append_mode implies caret_position = 1) or
				old buffer_locked_in_format_mode implies (caret_position = old caret_position)
			unselected: not has_selection
		end

	flush_buffer_to (start_position, end_position: INTEGER)
			-- Replace contents of current from caret position `start_position' to `end_position' with
			-- contents of buffer, since it was last flushed. If `start_position' and `end_position'
			-- are equal, insert the contents of the buffer at caret position `start_position'.
		require
			buffer_locked_for_append: buffer_locked_in_append_mode
			start_position >= 1 and end_position <= text_length + 1 and start_position <= end_position
		deferred
		ensure
			buffer_locked_for_append: not buffer_locked_in_append_mode
			caret_consistent: old caret_position <= text_length + 1 implies caret_position = old caret_position
			unselected: not has_selection
		end

	set_tab_width (a_width: INTEGER)
			-- Assign `a_width' in pixels to `tab_width'.
		require
			width_positive: a_width > 0
		deferred
		ensure
			tab_width_set: tab_width = a_width
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old start_selection = start_selection and old end_selection = end_selection
		end

	save_to_named_path (a_filename: PATH)
			-- Save `text' and formatting of `Current' to file `a_filename' in RTF format.
		require
			filename_not_void: a_filename /= Void
		local
			l_text_length, current_lower_line_index, last_counter,
			last_paragraph_change, current_paragraph_index, counter: INTEGER
			l_text: like text
			current_format: EV_CHARACTER_FORMAT_I
			buffer: EV_RICH_TEXT_BUFFERING_STRUCTURES_I
			text_file: RAW_FILE
			paragraph_indexes: detachable ARRAYED_LIST [INTEGER]
			paragraph_formats: detachable ARRAYED_LIST [STRING_32]
			paragraphs_exhausted: BOOLEAN
			last_load_value, current_load_value: INTEGER
		do
			create buffer.set_rich_text (Current)
			l_text := text
			l_text_length := l_text.count

			initialize_for_saving

				-- Now retreive paragraph information for `l_text'.
			buffer.generate_paragraph_information (l_text)
			paragraph_indexes := buffer.paragraph_start_indexes
			paragraph_formats := buffer.paragraph_formats
			check paragraph_formats /= Void then end
			check paragraph_indexes /= Void then end

			current_lower_line_index := 1
			last_paragraph_change := 1
			buffer.internal_text.append (paragraph_formats.i_th (current_lower_line_index))
			if paragraph_formats.count = 1 then
					-- If there was no change of paragraph in the document, we must
					-- flag that we have exhausted all paragraphs.
				paragraphs_exhausted := True
			end
			current_lower_line_index := current_lower_line_index + 1
			from
				counter := 1
				last_counter := 1
			until
				counter >= l_text_length
			loop
				current_format := internal_character_format (counter + 1)
					-- Retrieve next character change index.
				counter := next_change_of_character (counter, l_text_length + 1)

				if counter > current_paragraph_index and not paragraphs_exhausted then
					current_paragraph_index := paragraph_indexes.i_th (current_lower_line_index)
					if current_paragraph_index /= last_counter then
						buffer.append_text_for_rtf (l_text.substring (last_counter, current_paragraph_index - 1), current_format)
						last_counter := current_paragraph_index
					end
					from
					until
						current_lower_line_index + 1 > paragraph_formats.count or else paragraph_indexes.i_th (current_lower_line_index) >= counter
					loop
						buffer.internal_text.append (paragraph_formats.i_th (current_lower_line_index))
						current_lower_line_index := current_lower_line_index + 1
						current_paragraph_index := paragraph_indexes.i_th (current_lower_line_index).min (counter)
						buffer.append_text_for_rtf (l_text.substring (paragraph_indexes.i_th (current_lower_line_index - 1), current_paragraph_index - 1), current_format)
						last_counter := current_paragraph_index
					end
					if counter > paragraph_indexes.i_th (current_lower_line_index) then
						current_lower_line_index := current_lower_line_index + 1
					end
					if current_lower_line_index > paragraph_indexes.count then
							-- We have now exhausted all paragraph formatting, so set this flag this as so.
						paragraphs_exhausted := True
							-- Now write the final paragraph format into the document
						buffer.internal_text.append (paragraph_formats.i_th (paragraph_formats.count))

							-- It is possible that we have just exhausted all paragraph formats, but still not encountered the final
							-- characters in the text.
						if last_counter < counter then
							buffer.append_text_for_rtf (l_text.substring (last_counter, counter - 1), current_format)
							last_counter := counter
						end
					end
				else

						-- Now process based on this character format spanning `counter' positions.
					buffer.append_text_for_rtf (l_text.substring (last_counter, (counter - 1).min (l_text.count)), current_format)
					last_counter := counter
				end

				if file_access_actions_internal /= Void then
						-- We add 1 to `l_text_length' in this calculation
						-- as counter is equal to  `l_text_length' + 1 on loop exit.
					current_load_value := (counter * 100) // (l_text_length + 1)
						-- Now only fire the actions if `current_load_value' has changed.
					if current_load_value /= last_load_value then
						last_load_value := current_load_value
						file_access_actions_internal.call ([current_load_value])
					end
				end
			end
			check
				counter_set_to_length_plus_one: counter = l_text_length + 1
			end
			buffer.generate_complete_rtf_from_buffering
			complete_saving
			create text_file.make_with_path (a_filename)
			text_file.open_write
			if ∀ c: buffer.internal_text ¦ c.natural_32_code <= 0x7f then
				text_file.put_string (buffer.internal_text.to_string_8)
			else
					-- TODO: improve performance.
				across
					buffer.internal_text as c
				loop
					if c.natural_32_code <= 0x7f then
						text_file.put_character (c.to_character_8)
					else
						text_file.put_character ('\')
						text_file.put_character ('u')
						text_file.put_integer_16 (c.code.as_integer_16)
						text_file.put_character ('?')
					end
				end
			end
			text_file.close
		ensure
			text_not_changed: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
			selection_not_changed: old has_selection = has_selection and has_selection implies
				old start_selection = start_selection and old end_selection = end_selection
		end

	set_with_named_path (a_filename: PATH)
			-- Set `text' and formatting of `Current' from file `a_filename' in RTF format.
		require
			filename_not_void: a_filename /= Void
		local
			text_file: RAW_FILE
			l_text: detachable STRING
			buffer: EV_RICH_TEXT_BUFFERING_STRUCTURES_I
		do
			initialize_for_loading
			create text_file.make_with_path (a_filename)
			text_file.open_read
			text_file.read_stream (text_file.count)
			l_text := text_file.last_string
			check l_text /= Void end
			text_file.close
			create buffer.set_rich_text (Current)
			buffer.set_with_rtf (l_text)
			last_load_successful := buffer.last_load_successful
			complete_loading
			set_caret_position (1)
		ensure
			caret_reset_if_successful: last_load_successful implies caret_position = 1
			unselected_if_successful: last_load_successful implies not has_selection
			text_not_changed_if_failed: not last_load_successful implies old text.is_equal (text)
			caret_not_moved_if_failed: not last_load_successful implies caret_position = old caret_position
			selection_not_changed_if_failed: not last_load_successful implies (old has_selection = has_selection and has_selection implies
					old start_selection = start_selection and old end_selection = end_selection)
		end

	last_load_successful: BOOLEAN
			-- Did last call to `set_with_named_file' complete succesfully?
			-- If an invalid RTF file is passed, `Result' is `False'.
			-- `Result' is undefined if `set_with_named_file' not called.

	next_change_of_character (current_pos: INTEGER; maximum_caret_pos: INTEGER): INTEGER
			-- `Result' is caret position at next change of character from `current_pos',
			-- checking maximum caret position `maximum_caret_pos'. By passing `maximum_caret_pos' as
			-- an argument, it prevents querying from the rich text constantly as it can be
			-- precomputed instead.
		require
			valid_position: current_pos < maximum_caret_pos
			maximum_pos_valid: maximum_caret_pos <= text_length + 1
		local
			counter, last_false_pos, current_step,
			value_finder, last_contiguous_position: INTEGER
		do
			counter := current_pos
			from
				current_step := default_step
				value_finder := default_step
				last_false_pos := 0
			until
				(last_contiguous_position - last_false_pos).abs = 1 or counter = maximum_caret_pos
			loop
					-- We must check that we are not attempting to query outside of the current text bounds.
					-- If so, we treat it as a non contiguous find, and keep processing.
				if counter + current_step <= maximum_caret_pos and then internal_character_format_contiguous (counter, counter + current_step) then
					last_contiguous_position := current_step
					if value_finder = default_step then
						counter := (counter + default_step - 1).min (maximum_caret_pos)
						current_step := default_step
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
			Result := (counter + last_contiguous_position).min (maximum_caret_pos)
		ensure
			Result_valid: Result <= maximum_caret_pos
		end

	default_step: INTEGER = 8
			-- Default step used when buffering into RTF.

	internal_character_format_contiguous (start_index, end_index: INTEGER): BOOLEAN
			-- Is formatting from caret position `start_index' to `end_index' contiguous?
			-- Internal version which permits optimizations as caret position and selection
			-- does not need to be restored.
		require
			valid_character_index: start_index >= 1 and end_index <= text_length + 1 and start_index <= end_index
		deferred
		end

	internal_character_format (pos: INTEGER): EV_CHARACTER_FORMAT_I
			-- `Result' is character format at position `pos'. On some platforms
			-- this may be optimized to take the selected character format and therefore
			-- should only be used by `next_change_of_character'.
		require
			valid_character_index: pos >= 1 and pos <= text_length + 1
		deferred
		ensure
			result_not_void: Result /= Void
		end

	internal_paragraph_format_contiguous (start_position, end_position: INTEGER): BOOLEAN
			-- Is paragraph formatting from caret_position `start_position' to `end_position' contiguous?
		require
			valid_character_index: start_position >= 1 and end_position <= text_length + 1 and start_position <= end_position
		deferred
		end

	internal_paragraph_format (caret_index: INTEGER): EV_PARAGRAPH_FORMAT
			-- `Result' is paragraph_format at caret position `caret_index'.
		require
			valid_character_index: caret_index >= 1 and caret_index <= text_length + 1
		deferred
		ensure
			result_not_void: Result /= Void
		end

	initialize_for_saving
			-- Initialize `Current' for save operations, by performing
			-- optimizations that prevent the control from slowing down due to
			-- unecessary optimizations.
		deferred
		end

	complete_saving
			-- Restore `Current' back to its default state before last call
			-- to `initialize_for_saving'.
		deferred
		end

	initialize_for_loading
			-- Initialize `Current' for load operations, by performing
			-- optimizations that prevent the control from slowing down due to
			-- unecessary optimizations.
		deferred
		end

	complete_loading
			-- Restore `Current' back to its default state before last call
			-- to `initialize_for_loading'.
		deferred
		end

	font_char_set (a_font: EV_FONT): INTEGER
			-- `Result' is char set of font `a_font'.
		require
			a_font_not_void: a_font /= Void
		deferred
		ensure
			result_not_void: Result >= 0
		end

feature {NONE} -- Implementation

	update_tab_positions (value: INTEGER)
			-- Update tab widths based on contents of `tab_positions'.
		deferred
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_RICH_TEXT note option: stable attribute end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
