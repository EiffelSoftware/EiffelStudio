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

	create_caret_move_actions: EV_INTEGER_ACTION_SEQUENCE is
			-- Create a caret move action sequence.
		do
		end
			
	create_selection_change_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a selection change action sequence.
		do
		end

feature -- Status Report

	index_from_position (an_x_position, a_y_position: INTEGER): INTEGER is
			-- Index of character closest to position `x_position', `y_position'.
		local
			a_buf_x, a_buf_y: INTEGER
			a_text_iter: EV_GTK_TEXT_ITER_STRUCT
			text_count: INTEGER
		do
			gtk_text_view_window_to_buffer_coords (text_view, an_x_position, a_y_position, $a_buf_x, $a_buf_y)
			create a_text_iter.make
			gtk_text_view_get_iter_at_location (text_view, a_text_iter.item, a_buf_x, a_buf_y)
			text_count := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_char_count (text_buffer)

			Result := feature {EV_GTK_EXTERNALS}.gtk_text_iter_get_offset (a_text_iter.item) + 1
			Result := Result.min (text_count).max (1)
		end
		
	position_from_index (an_index: INTEGER): EV_COORDINATE is
			-- Position of character at index `an_index'.
		local
			a_text_iter: EV_GTK_TEXT_ITER_STRUCT
			a_x, a_y, a_x2, a_y2: INTEGER
			a_rectangle: MANAGED_POINTER
		do
			create a_text_iter.make
			create a_rectangle.make (feature {EV_GTK_EXTERNALS}.c_gdk_rectangle_struct_size)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_iter_at_offset (text_buffer, a_text_iter.item, an_index - 1)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_view_get_iter_location (text_view, a_text_iter.item, a_rectangle.item)
			a_x := feature {EV_GTK_EXTERNALS}.gdk_rectangle_struct_x (a_rectangle.item)
			a_y := feature {EV_GTK_EXTERNALS}.gdk_rectangle_struct_y (a_rectangle.item)
			gtk_text_view_buffer_to_window_coords (text_view, a_x, a_y, $a_x2, $a_y2)
			create Result.set (a_x2, a_y2)
		end
		
	character_displayed (an_index: INTEGER): BOOLEAN is
			-- Is character `an_index' currently visible in `Current'?
		local
			a_text_iter: EV_GTK_TEXT_ITER_STRUCT
			a_x, a_y, a_char_x, a_char_y, a_char_width, a_char_height: INTEGER
			a_rectangle: MANAGED_POINTER
		do
			create a_text_iter.make
			create a_rectangle.make (feature {EV_GTK_EXTERNALS}.c_gdk_rectangle_struct_size)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_iter_at_offset (text_buffer, a_text_iter.item, an_index - 1)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_view_get_iter_location (text_view, a_text_iter.item, a_rectangle.item)
			a_x := feature {EV_GTK_EXTERNALS}.gdk_rectangle_struct_x (a_rectangle.item)
			a_y := feature {EV_GTK_EXTERNALS}.gdk_rectangle_struct_y (a_rectangle.item)
			a_char_width := feature {EV_GTK_EXTERNALS}.gdk_rectangle_struct_width (a_rectangle.item)
			a_char_height := feature {EV_GTK_EXTERNALS}.gdk_rectangle_struct_height (a_rectangle.item)
			gtk_text_view_buffer_to_window_coords (text_view, a_x, a_y, $a_char_x, $a_char_y)
			Result := (a_char_x >= 0 and a_char_x < width) and then (a_char_y >= 0 and a_char_y < height)
		end
	
feature -- Status report

	character_format (character_index: INTEGER): EV_CHARACTER_FORMAT is
			-- `Result' is character format of character `character_index'.
		local
			a_text_iter: EV_GTK_TEXT_ITER_STRUCT
			a_text_attributes, a_text_appearance: POINTER
			a_font_description: POINTER
			a_color: POINTER
			a_font: EV_FONT
			font_size, font_weight, font_style: INTEGER
			a_effects: EV_CHARACTER_FORMAT_EFFECTS
			a_red, a_blue, a_green: INTEGER
			a_family: STRING
		do
			create Result
			create a_text_iter.make
			feature {EV_GTK_EXTERNALS}.gtk_text_buffer_get_iter_at_offset (text_buffer, a_text_iter.item, character_index - 1)
			a_text_attributes := gtk_text_view_get_default_attributes (text_view)
			gtk_text_iter_get_attributes (a_text_iter.item, a_text_attributes)
			
			a_text_appearance := gtk_text_attributes_struct_text_appearance (a_text_attributes)
			

			a_font_description := gtk_text_attributes_struct_font_description (a_text_attributes)
			create a_family.make_from_c (feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_get_family (a_font_description))
			font_style := feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_get_style (a_font_description)
			font_weight := feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_get_weight (a_font_description)
			font_size := feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_get_size (a_font_description) // feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_scale

			
			a_color := gtk_text_appearance_struct_fg_color (a_text_appearance)
			a_red := feature {EV_GTK_EXTERNALS}.gdk_color_struct_red (a_color) // 256
			a_blue := feature {EV_GTK_EXTERNALS}.gdk_color_struct_blue (a_color) // 256
			a_green := feature {EV_GTK_EXTERNALS}.gdk_color_struct_green (a_color) // 256
			Result.set_color (create {EV_COLOR}.make_with_8_bit_rgb (a_red, a_green, a_blue))
			
			create a_effects
			if gtk_text_appearance_struct_strikethrough (a_text_appearance) > 0 then
				a_effects.enable_striked_out
			end
			if gtk_text_appearance_struct_underline (a_text_appearance) > 0 then
				a_effects.enable_underlined
			end
			
			Result.set_effects (a_effects)
	
			gtk_text_attributes_free (a_text_attributes)
		end

feature -- Status setting

	set_current_format (format: EV_CHARACTER_FORMAT) is
			-- apply `format' to current caret position, applicable
			-- to next typed characters.
		do
		end
		
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

	gtk_text_attributes_struct_font_description (a_text_attributes: POINTER): POINTER is
			external
				"C struct GtkTextAttributes access font use <gtk/gtk.h>"
			end

	gtk_text_attributes_struct_text_appearance (a_text_attributes: POINTER): POINTER is
			external
				"C struct GtkTextAttributes access &appearance use <gtk/gtk.h>"
			end

	gtk_text_appearance_struct_bg_color (a_text_appearance: POINTER): POINTER is
			external
				"C struct GtkTextAppearance access &bg_color use <gtk/gtk.h>"
			end
			
	gtk_text_appearance_struct_underline (a_text_appearance: POINTER): INTEGER is
			external
				"C struct GtkTextAppearance access underline use <gtk/gtk.h>"
			end

	gtk_text_appearance_struct_strikethrough (a_text_appearance: POINTER): INTEGER is
			external
				"C struct GtkTextAppearance access strikethrough use <gtk/gtk.h>"
			end

	gtk_text_appearance_struct_fg_color (a_text_appearance: POINTER): POINTER is
			external
				"C struct GtkTextAppearance access &fg_color use <gtk/gtk.h>"
			end

	gtk_text_iter_get_attributes (a_text_iter: POINTER; a_text_values: POINTER) is
			external
				"C inline use <gtk/gtk.h>"
			alias
				"gtk_text_iter_get_attributes ((GtkTextIter*) $a_text_iter, (GtkTextAttributes*) $a_text_values )"
			end
			
	gtk_text_view_get_default_attributes (a_text_view: POINTER): POINTER is
			external
				"C inline use <gtk/gtk.h>"
			alias
				"gtk_text_view_get_default_attributes ((GtkTextView*) $a_text_view)"
			end
			
	gtk_text_attributes_free (a_text_attributes: POINTER) is
			external
				"C inline use <gtk/gtk.h>"
			alias
				"free ((GtkTextAttributes*) $a_text_attributes)"
			end

	gtk_text_view_get_iter_at_location (a_text_view,  a_text_iter: POINTER; buffer_x, buffer_y: INTEGER) is
			external
				"C inline use <gtk/gtk.h>"
			alias
				"gtk_text_view_get_iter_at_location ((GtkTextView*) $a_text_view, (GtkTextIter*) $a_text_iter, (gint) $buffer_x, (gint) $buffer_y)"
			end

	gtk_text_view_window_to_buffer_coords (a_text_view: POINTER; window_x, window_y: INTEGER; buffer_x, buffer_y: POINTER) is
			external
				"C inline use <gtk/gtk.h>"
			alias
				"gtk_text_view_window_to_buffer_coords ((GtkTextView*) $a_text_view, GTK_TEXT_WINDOW_TEXT, (gint) $window_x, (gint) $window_y, (gint *) $buffer_x, (gint *) $buffer_y)"
			end
		
	gtk_text_view_buffer_to_window_coords (a_text_view: POINTER; buffer_x, buffer_y: INTEGER; window_x, window_y: POINTER) is
			external
				"C inline use <gtk/gtk.h>"
			alias
				"gtk_text_view_buffer_to_window_coords ((GtkTextView*) $a_text_view, GTK_TEXT_WINDOW_TEXT, (gint) $buffer_x, (gint) $buffer_y, (gint *) $window_x, (gint *) $window_y)"
			end

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

	dispose_append_buffer is
			-- Clean up `append_buffer'.
		do
			feature {EV_GTK_DEPENDENT_EXTERNALS}.object_unref (append_buffer)
			append_buffer := default_pointer
		end

	append_buffer: POINTER
		-- Pointer to the GtkTextBuffer used for append buffering.	

feature {EV_ANY_I} -- Implementation
	
	interface: EV_RICH_TEXT

end -- class EV_RICH_TEXT_IMP
