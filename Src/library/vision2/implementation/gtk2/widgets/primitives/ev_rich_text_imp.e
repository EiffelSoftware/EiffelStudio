indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RICH_TEXT_IMP
	
inherit
	EV_RICH_TEXT_I
		redefine
			interface
		end

	EV_TEXT_IMP
		redefine
			interface
		end

create
	make

feature -- Status Report

	index_from_position (an_x_position, a_y_position: INTEGER): INTEGER is
			-- Index of character closest to position `x_position', `y_position'.
		do
		end
		
	position_from_index (an_index: INTEGER): EV_COORDINATE is
			-- Position of character at index `an_index'.
		do
		end
		
	character_displayed (an_index: INTEGER): BOOLEAN is
			-- Is character `an_index' currently visible in `Current'?
		do
		end
	
feature -- Status report

	character_format (character_index: INTEGER): EV_CHARACTER_FORMAT is
			-- `Result' is character format of character `character_index'.
		do
		end

feature -- Status setting

	format_region (start_position, end_position: INTEGER; format: EV_CHARACTER_FORMAT) is
			-- Apply `format' to all characters between the caret positions `start_position' and `end_position'.
			-- Formatting is applied immediately. May or may not change the cursor position.
		local
			a_start_iter, a_end_iter: EV_GTK_TEXT_ITER_STRUCT
			a_format_imp: EV_CHARACTER_FORMAT_IMP
			a_tag_table: POINTER
		do
			a_format_imp ?= format.implementation
			create a_start_iter.make
			create a_end_iter.make
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_iter_at_offset (text_buffer, a_start_iter.item, start_position - 1)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_iter_at_offset (text_buffer, a_end_iter.item, end_position)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_remove_all_tags (text_buffer, a_start_iter.item, a_end_iter.item)
			a_tag_table := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_tag_table (text_buffer)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_tag_table_add (a_tag_table, a_format_imp.text_tag)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_apply_tag (text_buffer, a_format_imp.text_tag, a_start_iter.item, a_end_iter.item)
		end
		
	buffered_format (start_position, end_position: INTEGER; format: EV_CHARACTER_FORMAT) is
			-- Apply a character format `format' from caret positions `start_position' to `end_position' to
			-- format buffer. Call `flush_format_buffer' to apply buffered contents to `Current'.
		do
		end
		
	buffered_append (a_text: STRING; format: EV_CHARACTER_FORMAT) is
			-- Apply `a_text' with format `format' to append buffer.
			-- To apply buffer contents to `Current', call `flush_append_buffer' or
			-- `flush_append_buffer_to'.
		do
		end
		
	flush_buffer is
			-- Flush contents of buffer.
			-- If `buffer_locked_for_append' then replace contents of `Current' with buffer contents.
			-- If `buffer_locked_for_format' then apply buffered formatting to contents of `Current'.
		do
		end
		
	flush_buffer_to (start_position, end_position: INTEGER) is
			-- Replace contents of current from caret position `start_position' to `end_position' with
			-- contents of buffer, since it was last flushed. If `start_position' and `end_position'
			-- are equal, insert the contents of the buffer at caret position `start_position'.
		do
		end

feature {EV_ANY_I} -- Implementation
	
	interface: EV_RICH_TEXT

end -- class EV_RICH_TEXT_IMP
