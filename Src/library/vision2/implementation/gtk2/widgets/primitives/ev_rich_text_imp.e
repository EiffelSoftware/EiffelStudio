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
			interface,
			initialize
		end

create
	make
	
feature {NONE} -- Initialization

	initialize is
			-- Set up `Current'
		do
			create tab_positions
			tab_positions.add_actions.extend (agent update_tab_positions)
			tab_positions.remove_actions.extend (agent update_tab_positions)
			Precursor {EV_TEXT_IMP}
		end

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
		do
			format_region_internal (text_buffer, start_position, end_position, format)
		end

	buffered_format (start_position, end_position: INTEGER; format: EV_CHARACTER_FORMAT) is
			-- Apply a character format `format' from caret positions `start_position' to `end_position' to
			-- format buffer. Call `flush_format_buffer' to apply buffered contents to `Current'.
		do
			if not buffer_locked_in_format_mode then
				buffer_locked_in_format_mode := True
					-- Temporarily remove text buffer to avoid redraw and event firing
				feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_view_set_buffer (text_view, feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_new (default_pointer))
			end
			format_region (start_position, end_position, format)
		end
		
	buffered_append (a_text: STRING; format: EV_CHARACTER_FORMAT) is
			-- Apply `a_text' with format `format' to append buffer.
			-- To apply buffer contents to `Current', call `flush_append_buffer' or
			-- `flush_append_buffer_to'.
		local
			text_tag_table: POINTER
			buffer_length: INTEGER
		do
			if not buffer_locked_in_append_mode then
				text_tag_table := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_tag_table (text_buffer)
				append_buffer := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_new (text_tag_table)
				buffer_locked_in_append_mode := True
			end
			
			buffer_length := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_char_count (append_buffer) + 1
			append_text_internal (append_buffer, a_text)
			format_region_internal (append_buffer, buffer_length, feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_char_count (append_buffer) + 1,format)
		end
		
	flush_buffer is
			-- Flush contents of buffer.
			-- If `buffer_locked_for_append' then replace contents of `Current' with buffer contents.
			-- If `buffer_locked_for_format' then apply buffered formatting to contents of `Current'.
		local
			text_buffer_iter, append_buffer_start_iter, append_buffer_end_iter: EV_GTK_TEXT_ITER_STRUCT
		do
			if buffer_locked_in_format_mode then
				feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_view_set_buffer (text_view, text_buffer)
				buffer_locked_in_format_mode := False
			elseif buffer_locked_in_append_mode then
				create text_buffer_iter.make
				create append_buffer_start_iter.make
				create append_buffer_end_iter.make
				
				feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_start_iter (append_buffer, append_buffer_start_iter.item)
				feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_end_iter (append_buffer, append_buffer_end_iter.item)
				feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_end_iter (text_buffer, text_buffer_iter.item)
				
				feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_insert_range (text_buffer, text_buffer_iter.item, append_buffer_start_iter.item, append_buffer_end_iter.item)
				dispose_append_buffer
				buffer_locked_in_append_mode := False
			end
			
		end
		
	flush_buffer_to (start_position, end_position: INTEGER) is
			-- Replace contents of current from caret position `start_position' to `end_position' with
			-- contents of buffer, since it was last flushed. If `start_position' and `end_position'
			-- are equal, insert the contents of the buffer at caret position `start_position'.
		local
			text_buffer_start_iter, text_buffer_end_iter, append_buffer_start_iter, append_buffer_end_iter: EV_GTK_TEXT_ITER_STRUCT
		do
			create text_buffer_start_iter.make
			create text_buffer_end_iter.make
			create append_buffer_start_iter.make
			create append_buffer_end_iter.make
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_iter_at_offset (text_buffer, text_buffer_start_iter.item, start_position - 1)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_iter_at_offset (text_buffer, text_buffer_end_iter.item, end_position - 1)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_start_iter (append_buffer, append_buffer_start_iter.item)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_end_iter (append_buffer, append_buffer_end_iter.item)
			
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_delete (text_buffer, text_buffer_start_iter.item, text_buffer_end_iter.item)
			
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_insert_range (text_buffer, text_buffer_start_iter.item, append_buffer_start_iter.item, append_buffer_end_iter.item)
			
			dispose_append_buffer
			buffer_locked_in_append_mode := False
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

	format_region_internal (a_text_buffer: POINTER; start_position, end_position: INTEGER; format: EV_CHARACTER_FORMAT) is
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
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_iter_at_offset (a_text_buffer, a_start_iter.item, start_position - 1)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_iter_at_offset (a_text_buffer, a_end_iter.item, end_position - 1)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_remove_all_tags (a_text_buffer, a_start_iter.item, a_end_iter.item)
	
			if a_format_imp.last_text_tag /= default_pointer then
				text_tag := a_format_imp.last_text_tag
			else
				text_tag := a_format_imp.new_text_tag
				a_tag_table := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_tag_table (a_text_buffer)
				feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_tag_table_add (a_tag_table, text_tag)
			end
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_apply_tag (a_text_buffer, text_tag, a_start_iter.item, a_end_iter.item)
		end

	update_tab_positions (value: INTEGER) is
			-- Update tab widths based on contents of `tab_positions'.
		do
		end

feature {NONE} -- Implementation

	dispose_append_buffer is
			-- Clean up `append_buffer'.
		do
			feature {EV_GTK_DEPENDENT_EXTERNALS}.object_unref (append_buffer)
			append_buffer := default_pointer
		end

	append_buffer: POINTER
		-- Pointer to the GtkTextBuffer used for appending.	

feature {EV_ANY_I} -- Implementation
	
	interface: EV_RICH_TEXT

end -- class EV_RICH_TEXT_IMP
