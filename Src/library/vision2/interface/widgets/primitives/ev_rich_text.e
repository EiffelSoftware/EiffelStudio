indexing
	description: "[
		EiffelVision rich text area, supporting multiple lines of text, with font and color
		formatting applicable on a character by character basis.
		]"
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
		
feature -- Access

	character_format (character_index: INTEGER): EV_CHARACTER_FORMAT is
			-- `Result' is character format of character `character_index'
		require
			not_destroyed: not is_destroyed
			valid_character_index: character_index >= 1 and character_index <= text_length
		do
			Result := implementation.character_format (character_index)
		ensure
			result_not_void: Result /= Void
		end
		
	buffer_locked_in_format_mode: BOOLEAN is
			-- Is buffered formatting underway?
			-- `True' after one or more calls to `buffered_format' and `False'
			-- after buffer is flushed.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.buffer_locked_in_format_mode
		end
		
	buffer_locked_in_append_mode: BOOLEAN is
			-- Is buffered appending underway?
			-- `True' after one or more calls to `buffered_append' and `False'
			-- after buffer is flushed.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.buffer_locked_in_append_mode
		end

feature -- Status setting

	format_region (start_position, end_position: INTEGER; format: EV_CHARACTER_FORMAT) is
			-- Apply `format' to all characters between the caret positions `start_position' and `end_position'.
			-- Formatting is applied immediately. May or may not change the cursor position.
		require
			not_destroyed: not is_destroyed
			valid_positions: start_position < end_position and start_position >= 1 and end_position <= text_length + 1
			format_not_void: format /= Void
		do
			implementation.format_region (start_position, end_position, format)
		ensure
			text_not_changed: text.is_equal (old text)
		end

	buffered_format (start_position, end_position: INTEGER; format: EV_CHARACTER_FORMAT) is
			-- Apply a character format `format' from caret positions `start_position' to `end_position' to
			-- format buffer. Call `flush_buffer' to apply buffered contents to `Current'.
		require
			not_destroyed: not is_destroyed
			valid_positions: start_position < end_position and start_position >= 1 and end_position <= text_length 
			format_not_void: format /= Void
			buffer_not_locked_for_append: not buffer_locked_in_append_mode
		do
			implementation.buffered_format (start_position, end_position, format)
		ensure
			text_not_changed: text.is_equal (old text)
			buffer_locked_for_format: buffer_locked_in_format_mode
		end
		
	buffered_append (a_text: STRING; format: EV_CHARACTER_FORMAT) is
			-- Apply `a_text' with format `format' to append buffer.
			-- To apply buffer contents to `Current', call `flush_buffer' which replaces current content,
			-- or `flush_buffer_to' which inserts the formatted text.
		require
			not_destroyed: not is_destroyed
			a_text_not_void: a_text /= Void
			format_not_void: format /= Void
			buffer_not_locked_for_format: not buffer_locked_in_format_mode
		do
			implementation.buffered_append (a_text, format)
		ensure
			buffer_locked_for_append: buffer_locked_in_append_mode
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
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := not buffer_locked_in_append_mode and not buffer_locked_in_format_mode
		end

feature {EV_ANY_I} -- Implementation

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

end -- class EV_RICH_TEXT

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
