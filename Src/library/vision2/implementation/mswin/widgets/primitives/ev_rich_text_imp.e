indexing
	description: "[
		EiffelVision2 rich text. Windows implemnetation.
		]"
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
		rename
			text_length as wel_text_length
		undefine
			default_ex_style,
			default_style,
			destroy,
			class_name,
			internal_caret_position,
			internal_set_caret_position,
			text,
			wel_text,
			process_notification_info
		redefine
			interface,
			initialize,
			make,
			wel_text_length,
			enable_word_wrapping,
			disable_word_wrapping
		select
			wel_line_index,
			wel_item,
			wel_line,
			wel_current_line_number,
			wel_selection_start,
			wel_line_count,
			wel_selection_end,
			deselect_all,
			copy_selection,
			cut_selection,
			wel_destroy,
			wel_resize,
			wel_move,
			wel_set_text,
			wel_make,
			is_sensitive,
			is_displayed,
			wel_has_capture,
			x_position,
			y_position,
			wel_move_and_resize,
			wel_text_length
		end
		
	WEL_RICH_EDIT
		rename
			parent as wel_parent,
			height as wel_height,
			width as wel_width,
			set_font as wel_set_font,
			set_background_color as wel_set_background_color,
			foreground_color as wel_foreground_color,
			background_color as wel_background_color,
			font as wel_font,
			set_parent as wel_set_parent,
			make as wel_make,
			caret_position as internal_caret_position,
			set_caret_position as internal_set_caret_position,
			text as wel_text,
			text_length as wel_text_length
		undefine
			hide,
			set_text,
			line_count,
			on_left_button_down,
			on_right_button_down,
			on_left_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_char,
			on_set_focus,
			on_kill_focus,
			on_key_up,
			on_key_down,
			on_set_cursor,
			has_capture,
			set_height,
			set_width,
			insert_text,
			selected_text,
			set_tab_stops_array,
			set_default_tab_stops,
			current_line_number,
			set_tab_stops,
			on_en_change,
			selection_end,
			selection_start,
			has_selection,
			set_selection,
			set_text_limit,
			select_all,
			default_process_message,
			on_desactivate,
			on_sys_key_up,
			on_sys_key_down,
			on_mouse_wheel,
			on_middle_button_double_click,
			on_middle_button_up,
			on_middle_button_down,
			on_size,
			disable,
			enable,
			background_brush,
			wel_text_length,
			wel_foreground_color,
			wel_background_color,
			class_name,
			show,
			line,
			destroy,
			wel_make
		redefine
			default_style,
			default_ex_style,
			class_name
		end
		
	WEL_CFM_CONSTANTS
		export
			{NONE} all
		end
		
	EV_FONT_CONSTANTS
		export
			{NONE} all
		end
		
	WEL_UNIT_CONVERSION
		export
			{NONE} all
		end
	
create
	make
	
feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			multiple_line_edit_make (default_parent, "", 0, 0, 0, 0, -1)
			set_options (Ecoop_set, Eco_autovscroll + Eco_autohscroll)
			show_vertical_scroll_bar
			set_text_limit (2560000)
		end
		

	default_style: INTEGER is
			-- Default style used to create the control
			-- (from WEL_RICH_EDIT)
			-- (export status {NONE})
		once
			Result := Ws_visible + Ws_child + Ws_border + Ws_vscroll + Es_savesel +
				Es_disablenoscroll + Es_multiline + es_autovscroll + Es_Wantreturn
		end
		
	default_ex_style: INTEGER is
			-- Extended windows style used to create `Current'.
		do
			Result := Ws_ex_clientedge
		end
		
	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_TEXT_IMP}
		end

feature -- Status report

	text: STRING is
			-- text of `Current'.
		do
			Result := wel_text
			Result.prune_all ('%R')
		end
		
	wel_text_length: INTEGER is
			-- Text length
		do
			Result := text.count
		end

	character_format (character_index: INTEGER): EV_CHARACTER_FORMAT is
			-- `Result' is character format of character `character_index'
		local
			wel_character_format: WEL_CHARACTER_FORMAT
			imp: EV_CHARACTER_FORMAT_I
			a_font: EV_FONT
			color_ref: WEL_COLOR_REF
			effects: INTEGER
			font_imp: EV_FONT_IMP
			a_wel_font: WEL_FONT
			character_effects: EV_CHARACTER_FORMAT_EFFECTS
		do
			select_region (character_index, character_index)
			wel_character_format := current_selection_character_format
			effects := wel_character_format.effects
			color_ref := wel_character_format.text_color
			create a_font
			font_imp ?= a_font.implementation
			create a_wel_font.make_indirect (wel_character_format.log_font)
			font_imp.set_by_wel_font (a_wel_font)
			
			create character_effects
			if flag_set (effects, cfm_strikeout) then
				character_effects.enable_striked_out
			end
			if flag_set (effects, Cfm_underline) then
				character_effects.enable_underlined
			end
			
			create Result.make_with_values (a_font,
				create {EV_COLOR}.make_with_8_bit_rgb (color_ref.red, color_ref.blue, color_ref.green),
				character_effects)
		end

feature -- Status setting

	format_region (first_pos, last_pos: INTEGER; format: EV_CHARACTER_FORMAT) is
			-- Set the format of the text between `first_pos' and `last_pos' to
			-- `format'. May or may not change the cursor position.
		local
			wel_character_format: WEL_CHARACTER_FORMAT
		do
			set_selection (first_pos - 1, last_pos - 1)
			wel_character_format ?= format.implementation
			check
				wel_character_format_not_void: wel_character_format /= Void
			end
			set_character_format_selection (wel_character_format)
		end
		
	buffered_format (start_pos, end_pos: INTEGER; format: EV_CHARACTER_FORMAT) is
			-- Apply a characted format `format' from character positions `start_pos' to `end_pos' to
			-- format buffer. Call `flush_format_buffer' to apply buffered contents to `Current'.
		local
			format_out: STRING
		do
			if not buffer_locked_in_format_mode then
				start_formats.clear_all
				end_formats.clear_all
				formats.wipe_out
				formats_index.clear_all
				heights.wipe_out
				buffer_locked_in_format_mode := True
			end
			if not formats.has (format) then
				formats.extend (format)
				heights.extend (format.font.height * 2)
			end
			format_out := format.hash_value
			formats_index.put (formats.index_of (format, 1), start_pos)
			start_formats.put (format_out, start_pos)
			end_formats.put (format_out, end_pos)
		end
		
	buffered_append (a_text: STRING; format: EV_CHARACTER_FORMAT) is
			-- Apply `a_text' with format `format' to append buffer.
			-- To apply buffer contents to `Current', call `flush_append_buffer' or
			-- `flush_append_buffer_to'.
		local
			hashed_character_format: STRING
			temp_string: STRING
			format_index: INTEGER
			font_text: STRING
			counter: INTEGER
			character: CHARACTER
		do
			if not buffer_locked_in_append_mode then
				start_formats.clear_all
				end_formats.clear_all
				formats.wipe_out
				formats_index.clear_all
				heights.wipe_out
				buffer_locked_in_append_mode := True
				internal_text := ""
				internal_text.resize (default_string_size)
				hashed_formats.clear_all
				format_offsets.clear_all
			end
			hashed_character_format := format.hash_value
			if not hashed_formats.has (hashed_character_format) then
				hashed_formats.put (format, hashed_character_format)
				formats.extend (format)
				heights.extend (format.font.height * 2)
				format_offsets.extend (hashed_formats.count, hashed_character_format)
			end
			format_index := format_offsets.item (hashed_character_format) 
			temp_string := "\cf"
			temp_string.append (format_index.out)
			temp_string.append ("\f")
			temp_string.append (format_index.out)
			temp_string.append ("\fs")
			temp_string.append (heights.i_th (format_index).out)
			temp_string.append (" ")
			internal_text.append (temp_string)
			from
				counter := 1
			until
				counter > a_text.count
			loop
				character := a_text.item (counter)
				if character = '%N' then
					internal_text.append ("\par%N")
				elseif character = '\' then
					internal_text.append ("\\")
				elseif character = '{' then
					internal_text.append ("\{")	
				elseif character = '}' then
					internal_text.append ("\}")
				else
					internal_text.append_character (a_text.item (counter))
				end
				counter := counter + 1
			end
		end
		
	flush_buffer_to (start_position, end_position: INTEGER) is
			-- Replace contents of current from caret position `start_position' to `end_position' with
			-- contents of buffer, since it was last flushed. If `start_position' and `end_position'
			-- are equal, insert the contents of the buffer at caret position `start_position'.
		local
			stream: WEL_RICH_EDIT_BUFFER_LOADER
		do
				-- If `start_position' and `end_position' are equal, the
				-- text must be inserted. If not, the appropriate area is
				-- selected, and will be replaced.
			if start_position = end_position then
				set_caret_position (start_position)
			else
					-- We use `end_position' less one, as `select_region' uses
					-- character positions, and not caret positions.
				set_selection (start_position - 1, end_position)
			end
			generate_rtf_heading
			create stream.make (internal_text)
			insert_rtf_stream_in (stream)
			stream.release_stream
			print (stream.error)
			buffer_locked_in_append_mode := False
		end
		

	flush_buffer is
			-- Flush any buffered operations.
		local
			counter: INTEGER
			start_value, end_value: INTEGER
			last_end_value: INTEGER
			stream: WEL_RICH_EDIT_BUFFER_LOADER
			current_start, current_end: INTEGER
			insert_pos: INTEGER
			temp_string: STRING
			format_index: INTEGER
			color_text: STRING
			a_color: EV_COLOR
			font_text: STRING
			a_font: EV_FONT
			a_font_imp: EV_FONT_IMP
			log_font: WEL_LOG_FONT
			family: STRING
			current_family: INTEGER
			default_font_format: STRING
		do
				-- Do nothing if buffer is not is format mode or append mode,
				-- as there is nothing to flush. A user may call them however, as there
				-- is no need to restrict against such calls.
			if buffer_locked_in_format_mode then
				buffered_text := text.twin
					-- Generate an insertion string to use for default font
				default_font_format := "\cf1\f0\fs"
				default_font_format.append ((font.height * 2).out)
				default_font_format.append (" ")
				
					-- Generate FRT Header corresponding to all fonts used in formatting.			
					--{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl{\f0\fnil\fcharset0 MS Shell Dlg;}{\f1\fswiss\fcharset0 Arial;}}
				font_text := "{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl"

					-- Add the default font of `Current' as the first in the font table.
				font_text.append (generate_font_heading (font, 0))
				
					-- Now add all fonts used in formatting.
				from
					formats.start
				until
					formats.off
				loop
					font_text.append (generate_font_heading (formats.item.font, formats.index))
					formats.forth
				end
				font_text.append ("}")
					
					-- Generate RTF Header corresponding to all colors used in formatting.
					--	{\colortbl ;\red255\green0\blue0;\red0\green255\blue0;}
				color_text := "{\colortbl ;"
					-- The foreground color of the control is always the first entry in the color table.
				a_color := interface.foreground_color
				color_text.append ("\red")
				color_text.append (a_color.red_8_bit.out)
				color_text.append ("\green")
				color_text.append (a_color.green_8_bit.out)
				color_text.append ("\blue")
				color_text.append (a_color.blue_8_bit.out)
				color_text.append (";")
				from
					formats.start
				until
					formats.off
				loop
					a_color := formats.item.color
					color_text.append ("\red")
					color_text.append (a_color.red_8_bit.out)
					color_text.append ("\green")
					color_text.append (a_color.green_8_bit.out)
					color_text.append ("\blue")
					color_text.append (a_color.blue_8_bit.out)
					color_text.append (";")
					formats.forth
				end
				color_text := color_text + "}"
				
				internal_text := font_text.twin 
				internal_text.append ("%R%N")
				internal_text.append (color_text)
				internal_text.append ("%R%N")
				internal_text.append (view_text)
				last_end_value := 1
				internal_text.resize (default_string_size)
				from
					counter := 1
					insert_pos := internal_text.count + 1
				until
					counter > buffered_text.count
				loop
					if start_formats.item (counter) /= Void then
						format_index := formats_index.item (counter)
						temp_string := "\cf"
						temp_string.append ((format_index + 1).out)
						temp_string.append ("\f")
						temp_string.append (format_index.out)
						temp_string.append ("\fs")
						temp_string.append (heights.i_th (format_index).out)
						temp_string.append (" ")
						internal_text.append_string (temp_string)
					end
					if buffered_text.item (counter).is_equal ('%N') then
						internal_text.append_string ("\par%N")
					else
						internal_text.append_character (buffered_text.item (counter))
					end
					insert_pos := insert_pos + 1
					
					if end_formats.item (counter) /= Void and start_formats.item (counter + 1) = Void then
						internal_text.append_string (default_font_format)
					end
					counter := counter + 1
				end
				internal_text.append ("}")
				buffered_text := Void
				create stream.make (internal_text)
				rtf_stream_in (stream)
				stream.release_stream
				print (stream.error)
			elseif buffer_locked_in_append_mode then
				
				generate_rtf_heading				
				buffered_text := Void
				create stream.make (internal_text)
				rtf_stream_in (stream)
				stream.release_stream
				print (stream.error)
			end
			buffer_locked_in_append_mode := False
			buffer_locked_in_format_mode := False
		end
		
	generate_rtf_heading is
			-- Generate the rtf heading for buffered operations into `internal_text'.
			-- Current contents of `internal_text' are lost.
		require
			buffer_locked_in_append_mode: buffer_locked_in_append_mode
		local
			a_color: EV_COLOR
			font_text: STRING
			color_text: STRING
			internal_text_twin: STRING
		do
				-- Generate the representation of fonts used.
			font_text := "{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl"
			
				-- Add each font to `font_text' in order.
			from
				formats.start
			until
				formats.off
			loop
				font_text.append (generate_font_heading (formats.item.font, formats.index))
				formats.forth
			end
			font_text.append ("}")
			
				-- Now generate text corresponding to all colors.
			color_text := "{\colortbl ;"
			from
				formats.start
			until
				formats.off
			loop
				a_color := formats.item.color
				color_text.append ("\red")
				color_text.append (a_color.red_8_bit.out)
				color_text.append ("\green")
				color_text.append (a_color.green_8_bit.out)
				color_text.append ("\blue")
				color_text.append (a_color.blue_8_bit.out)
				color_text.append (";")
				formats.forth
			end
			color_text.append ("}")
			internal_text_twin := internal_text.twin
			internal_text := font_text.twin
			internal_text.append ("%R%N")
			internal_text.append (color_text)
			internal_text.append ("%R%N")
			internal_text.append (internal_text_twin)
			internal_text.append ("}")
		end
		
	enable_word_wrapping is
			-- Ensure `has_word_wrap' is True.
		local
			stream_in: WEL_RICH_EDIT_BUFFER_LOADER
			stream_out: WEL_RICH_EDIT_BUFFER_SAVER
			old_text_as_rtf: STRING
		do
				-- Store contents of `Current' as RTF.
			create stream_out.make
			rtf_stream_out (stream_out)
			stream_out.release_stream
			old_text_as_rtf := stream_out.text
			
			wel_destroy
			internal_window_make (wel_parent, "", default_style, 0, 0, 0, 0, 0, default_pointer)
			set_options (Ecoop_set, Eco_autovscroll + Eco_autohscroll)
			show_vertical_scroll_bar
			set_text_limit (2560000)
			set_default_font
			cwin_send_message (wel_item, Em_limittext, 0, 0)
			if parent_imp /= Void then
				parent_imp.notify_change (2 + 1, Current)
			end
			
				-- Restore contents of `Current' from stored RTF.
			create stream_in.make (old_text_as_rtf)
			insert_rtf_stream_in (stream_in)
			stream_in.release_stream
		end
		
	disable_word_wrapping is
			-- Ensure `has_word_wrap' is False.
		local
			stream_in: WEL_RICH_EDIT_BUFFER_LOADER
			stream_out: WEL_RICH_EDIT_BUFFER_SAVER
			old_text_as_rtf: STRING
		do
				-- Store contents of `Current' as RTF.
			create stream_out.make
			rtf_stream_out (stream_out)
			stream_out.release_stream
			old_text_as_rtf := stream_out.text
			
			wel_destroy
			internal_window_make (wel_parent, "", default_style + Ws_hscroll, 0, 0, 0, 0, 0, default_pointer)
			set_options (Ecoop_set, Eco_autovscroll + Eco_autohscroll)
			set_text_limit (2560000)
			set_default_font
			cwin_send_message (wel_item, Em_limittext, 0, 0)
			show_scroll_bars
			if parent_imp /= Void then
				parent_imp.notify_change (2 + 1, Current)
			end
			
				-- Restore contents of `Current' from stored RTF.
			create stream_in.make (old_text_as_rtf)
			insert_rtf_stream_in (stream_in)
			stream_in.release_stream
		end
		
feature {NONE} -- Implementation

	default_string_size: INTEGER is 50000
		-- Default size used for all internal strings for buffering.
		-- This reduces the need to resize the string as the formatting is applied.
		-- Resizing strings can be slow, so is to be avoided wherever possible.

	-- `hashed_formats', `format_offsets' and `color_offsets' are only used in the
	-- buffered append operations, while the other once lists and hash tables are used
	-- in the buffered formatting operations.

	hashed_formats: HASH_TABLE [EV_CHARACTER_FORMAT, STRING] is
			-- A list of all character formats to be applied to buffering, accessible
			-- through `hash_value' of EV_CHARACTER_FORMAT. This ensures that repeated formats
			-- are not stored multiple times.
		once
			create Result.make (10)			
		end

	format_offsets: HASH_TABLE [INTEGER, STRING] is
			-- The index of each format in `hashed_formats' within the RTF document that must be generated.
			-- For each set of formatting that must be applied, a reference to the format in the document
			-- must be specified, and this table holds the appropriate offset of that formatting.
		once
			create Result.make (10)
		end

	view_text: STRING is "\viewkind4\uc1\pard"
		-- A STRING constant representing the view type of the RTF document.
		
	internal_text: STRING
		-- Internal representation of text, built as RTF. This is built and then
		-- streamed into `Current' when necessary.
		
	buffered_text: STRING
		-- Internal representation of `text' used only when flushing the buffers. Prevents the need
		-- to stream the contents of `current', every time that the `text' is needed.

	start_formats: HASH_TABLE [STRING, INTEGER] is
			-- The format type applicable at a paticular character position. The `item' is used to look up the
			-- character format from `hashed_formats'.
		once
			create Result.make (20)
		end

	end_formats: HASH_TABLE [STRING, INTEGER] is
			-- The format type applicable at a paticular character position. The integer represents the index of the
			-- closing caret index.
		once
			create Result.make (20)
		end
		
	formats: ARRAYED_LIST [EV_CHARACTER_FORMAT] is
			-- All character formats used in `Current'.
		once
			create Result.make (10)
		end
		
	heights: ARRAYED_LIST [INTEGER] is
			-- All heights of formats used in `Current', corresponding to contents of `forrmats'.
		once
			create Result.make (10)
		end

	formats_index: HASH_TABLE [INTEGER, INTEGER] is
			-- The index of each format relative to a paticular character index. This permits the correct
			-- format to be looked up when the start positions of the formats are traversed.
		once
			create Result.make (10)
		end

	generate_font_heading (a_font: EV_FONT; index: INTEGER): STRING is
			-- `Result' is a generated font descriptions for `a_font' with index `index'
			-- within the document.
		require
			a_font_not_void: a_font /= Void
			index_not_negative: index >= 0
		local
			a_font_imp: EV_FONT_IMP
			log_font: WEL_LOG_FONT
			current_family: INTEGER
			family: STRING
		do
			Result := "{"
			a_font_imp ?= a_font.implementation
			check
				font_imp_not_void: a_font_imp /= Void
			end
			log_font := a_font_imp.wel_font.log_font
			current_family := a_font_imp.family
				--\fnil | \froman | \fswiss | \fmodern | \fscript | \fdecor | \ftech | \fbidi
			inspect current_family
			when family_screen then
				family := "ftech"
			when family_roman then
				family := "froman"
			when family_sans then
				family := "fswiss"
			when family_typewriter then
				family := "fscript"
			when family_modern then
				family := "fmodern"
			else
				family := "fnil"
			end
			Result := Result + "\f" + index.out + "\" + family + "\fcharset" + log_font.char_set.out + " " + a_font.name + ";}"
		ensure
			Result_not_void: Result /= Void
		end

	destroy is
			-- Destroy `Current'.
		do
			destroy_item
		end

	class_name: STRING is
			-- Window class name to create
		once
			create Result.make (0)
			Result := (create {WEL_STRING}.make_by_pointer (class_name_pointer)).string
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_RICH_TEXT

end -- class EV_RICH_TEXT_IMP

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
