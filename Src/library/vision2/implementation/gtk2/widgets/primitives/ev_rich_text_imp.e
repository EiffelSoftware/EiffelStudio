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
			a_tag_table, text_tag: POINTER
		do
			a_format_imp ?= format.implementation
			create a_start_iter.make
			create a_end_iter.make
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_iter_at_offset (text_buffer, a_start_iter.item, start_position - 1)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_iter_at_offset (text_buffer, a_end_iter.item, end_position - 1)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_remove_all_tags (text_buffer, a_start_iter.item, a_end_iter.item)
	
			if a_format_imp.last_text_tag /= default_pointer then
				text_tag := a_format_imp.last_text_tag
			else
				text_tag := a_format_imp.new_text_tag
				a_tag_table := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_tag_table (text_buffer)
				feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_tag_table_add (a_tag_table, text_tag)
			end
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_apply_tag (text_buffer, text_tag, a_start_iter.item, a_end_iter.item)
		end
		
	buffered_format (start_position, end_position: INTEGER; format: EV_CHARACTER_FORMAT) is
			-- Apply a character format `format' from caret positions `start_position' to `end_position' to
			-- format buffer. Call `flush_format_buffer' to apply buffered contents to `Current'.
		do
			if not buffer_locked_in_format_mode then
				buffer_locked_in_format_mode := True
			end
			format_region (start_position, end_position, format)
		end
		
	buffered_append (a_text: STRING; format: EV_CHARACTER_FORMAT) is
			-- Apply `a_text' with format `format' to append buffer.
			-- To apply buffer contents to `Current', call `flush_append_buffer' or
			-- `flush_append_buffer_to'.
		local
			append_index: INTEGER
		do
			if not buffer_locked_in_append_mode then
				buffer_locked_in_append_mode := True
				create append_buffer_start_iter.make
				feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_end_iter (text_buffer, append_buffer_start_iter.item)
				feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_view_set_buffer (text_view, feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_new (default_pointer))
			end
			
			
			append_index := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_char_count (text_buffer) + 1
			append_text (a_text)
			format_region (append_index, feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_char_count (text_buffer), format)
			
			create append_buffer_end_iter.make
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_end_iter (text_buffer, append_buffer_end_iter.item)
		end
		
	flush_buffer is
			-- Flush contents of buffer.
			-- If `buffer_locked_for_append' then replace contents of `Current' with buffer contents.
			-- If `buffer_locked_for_format' then apply buffered formatting to contents of `Current'.
		do
			if buffer_locked_in_format_mode then
				buffer_locked_in_format_mode := False
			elseif buffer_locked_in_append_mode then
				buffer_locked_in_append_mode := False
			end
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_view_set_buffer (text_view, text_buffer)
		end
		
	flush_buffer_to (start_position, end_position: INTEGER) is
			-- Replace contents of current from caret position `start_position' to `end_position' with
			-- contents of buffer, since it was last flushed. If `start_position' and `end_position'
			-- are equal, insert the contents of the buffer at caret position `start_position'.
		do
		end
		
	set_tab_width (a_width: INTEGER) is
			-- Assign `a_width' to `tab_width'.
		do
		end

	tab_width: INTEGER is
			-- Default width in pixels of each tab in `Current'.
		do
		end
		
feature {NONE} -- Implementation

	update_tab_positions (value: INTEGER) is
			-- Update tab widths based on contents of `tab_positions'.
		do
		end

feature {NONE} -- Implementation

	append_buffer_start_iter, append_buffer_end_iter: EV_GTK_TEXT_ITER_STRUCT
		-- GtkTextIter pointers relating to the position of the append buffer in the GtkTextBuffer
	

feature {EV_ANY_I} -- Implementation
	
	interface: EV_RICH_TEXT

end -- class EV_RICH_TEXT_IMP
