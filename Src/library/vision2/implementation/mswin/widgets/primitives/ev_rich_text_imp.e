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
		undefine
			default_ex_style,
			default_style,
			destroy,
			class_name,
			internal_caret_position,
			internal_set_caret_position,
			text,
			wel_text,
			process_notification_info,
			set_tab_stops_array,
			set_default_tab_stops,
			set_tab_stops,
			set_text,
			wel_set_text
		redefine
			interface,
			initialize,
			make,
			enable_word_wrapping,
			disable_word_wrapping,
			first_position_from_line_number,
			last_position_from_line_number,
			caret_position,
			set_caret_position,
			select_region,
			selection_start,
			selection_end
		select
			wel_line_index,
			wel_item,
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
			wel_make,
			is_sensitive,
			is_displayed,
			wel_has_capture,
			x_position,
			y_position,
			wel_move_and_resize
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
			text_length as wel_text_length,
			set_text as wel_set_text,
			line as wel_line
		undefine
			hide,
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
			current_line_number,
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
			destroy,
			wel_make
		redefine
			default_style,
			default_ex_style,
			class_name,
			text_stream_in,
			insert_rtf_stream_in,
			rtf_stream_in,
			default_process_notification
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
		
	EV_RICH_TEXT_ACTION_SEQUENCES_IMP
	
create
	make
	
feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		local
			screen_dc: WEL_SCREEN_DC
			logical_pixels: INTEGER
		do
			base_make (an_interface)
			multiple_line_edit_make (default_parent, "", 0, 0, 0, 0, -1)
			set_options (Ecoop_set, Eco_autovscroll + Eco_autohscroll)
			show_vertical_scroll_bar
			set_text_limit (2560000)
			enable_all_notifications
			
				-- Connect events to `tab_positions' to update `Current' as values
				-- change.
			create tab_positions
			tab_positions.add_actions.extend (agent update_tab_positions)
			tab_positions.remove_actions.extend (agent update_tab_positions)
			
				-- Calculate the default tab space. In a rich edit control, it is
				-- Half an Inch, so query the horizontal resolution and divide by 2. 
			create screen_dc
			screen_dc.get
			logical_pixels := get_device_caps (screen_dc.item, logical_pixels_x)
			screen_dc.release
			tab_width := logical_pixels // 2
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

	character_format (caret_index: INTEGER): EV_CHARACTER_FORMAT is
			-- `Result' is character format at caret position `caret_index'
		local
			wel_character_format: WEL_CHARACTER_FORMAT
			a_font: EV_FONT
			color_ref: WEL_COLOR_REF
			effects: INTEGER
			font_imp: EV_FONT_IMP
			a_wel_font: WEL_FONT
			character_effects: EV_CHARACTER_FORMAT_EFFECTS
		do
			safe_store_caret
		
			set_selection (caret_index - 1, caret_index - 1)
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
				
			safe_restore_caret
		end

	index_from_position (an_x_position, a_y_position: INTEGER): INTEGER is
			-- Index of character closest to position `x_position', `y_position'. 
		local
			new_lines_to_caret_position, position: INTEGER
		do
			position := character_index_from_position (an_x_position, a_y_position)
			new_lines_to_caret_position := wel_text.substring (1, position).occurrences ('%R')
			Result := position + 1 - new_lines_to_caret_position
		end
		
	position_from_index (an_index: INTEGER): EV_COORDINATE is
			-- Position of character at index `an_index'.
		do
			Result := internal_position_from_index (an_index)
		end

	internal_position_from_index (an_index: INTEGER): EV_COORDINATE is
			-- Position of character at index `an_index'.
			-- Internal version which has no precondition, as we implement `character_displayed'
			-- using the result of this call. Using `position_from_index' directly is not
			-- possible due to its precondition.
		local
			wel: WEL_POINT
		do
			wel := position_from_character_index (an_index - 1)
			create Result.set (wel.x, wel.y)
		end

	character_displayed (an_index: INTEGER): BOOLEAN is
			-- Is character `an_index' currently visible in `Current'?
		local
			pos: EV_COORDINATE
		do
			pos := internal_position_from_index (an_index)
			Result := pos.x >= 0 and pos.x <= width and
				pos.y >= 0 and pos.y <= height
		end
		
	tab_width: INTEGER 
			-- Default width in pixels of each tab in `Current'.
			
	first_position_from_line_number (a_line: INTEGER): INTEGER is	
			-- Position of the first character on the `i'-th line.
		do
			Result := wel_line_index (a_line - 1) + 1
		end

	last_position_from_line_number (a_line: INTEGER): INTEGER is
			-- Position of the last character on the `i'-th line.
		local
			new_lines_to_first_position: INTEGER
		do
			if
				valid_line_index (a_line + 1)
			then
				Result := first_position_from_line_number (a_line + 1) - 1
			else
				new_lines_to_first_position := wel_text.substring (1, wel_line_index (a_line - 1)).occurrences ('%R')
				Result := wel_text_length - 1 - new_lines_to_first_position
			end
		end
		
	caret_position: INTEGER is
			-- Current position of caret.
		do
			Result := internal_caret_position + 1
		end
		
	set_caret_position (pos: INTEGER) is
			-- set current caret position.
			--| This position is used for insertions.
		do
			internal_set_caret_position (pos - 1)
		end
		
	selection_start: INTEGER is
			-- Index of first character selected.
		do
			Result := (wel_selection_start + 1).min (text_length)
		end

	selection_end: INTEGER is
			-- Index of last character selected.
		do
			Result := wel_selection_end.min (text_length)
		end

feature -- Status setting

	set_text (a_text: STRING) is
			-- Set `text' with `a_text'.
		local
			stream: WEL_RICH_EDIT_BUFFER_LOADER
			l_text: STRING
		do
			if a_text /= Void then
				l_text := a_text.twin
					-- Replace "%N" with "%R%N" for Windows.
				convert_string (l_text)
			end
			create stream.make (l_text)
			text_stream_in (stream)
			stream.release_stream
		end

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
			counter: INTEGER
			character: CHARACTER
			format_underlined, format_striked: BOOLEAN
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
				is_current_format_underlined := False
				is_current_format_striked_through := False
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
			format_underlined := formats.i_th (format_index).effects.is_underlined
			if not is_current_format_underlined and format_underlined then
				temp_string.append ("\ul")
				is_current_format_underlined := True
			elseif is_current_format_underlined and not format_underlined then
				temp_string.append ("\ulnone")
				is_current_format_underlined := False
			end
			format_striked := formats.i_th (format_index).effects.is_striked_out
			if not is_current_format_striked_through and format_striked then
				temp_string.append ("\strike")
				is_current_format_striked_through := True
			elseif is_current_format_striked_through and not format_striked then
				temp_string.append ("\strikenone")
				is_current_format_striked_through := False
			end
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
			buffer_locked_in_append_mode := False
		end
		

	flush_buffer is
			-- Flush any buffered operations.
		local
			counter: INTEGER
			last_end_value: INTEGER
			stream: WEL_RICH_EDIT_BUFFER_LOADER
			insert_pos: INTEGER
			temp_string: STRING
			format_index: INTEGER
			font_text: STRING
			color_text: STRING
			a_color: EV_COLOR
			default_font_format: STRING
			format_underlined, format_striked: BOOLEAN
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
						format_underlined := formats.i_th (format_index).effects.is_underlined
						if not is_current_format_underlined and format_underlined then
							temp_string.append ("\ul")
							is_current_format_underlined := True
						elseif is_current_format_underlined and not format_underlined then
							temp_string.append ("\ulnone")
							is_current_format_underlined := False
						end
						format_striked := formats.i_th (format_index).effects.is_striked_out
						if not is_current_format_striked_through and format_striked then
							temp_string.append ("\strike")
							is_current_format_striked_through := True
						elseif is_current_format_striked_through and not format_striked then
							temp_string.append ("\strikenone")
							is_current_format_striked_through := False
						end
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
			elseif buffer_locked_in_append_mode then
				
				generate_rtf_heading				
				buffered_text := Void
				create stream.make (internal_text)
				rtf_stream_in (stream)
				stream.release_stream
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
		
	set_tab_width (a_width: INTEGER) is
			-- Assign `a_width' to `tab_width'.
		do
			tab_width := a_width
			update_tab_positions (1)
		end
		
	update_tab_positions (value: INTEGER) is
			-- Update tab widths based on contents of `tab_positions'.
			-- `value' is the index of the changed value when called directly by `tab_positions', as
			-- the result of a list modidifcation, and is not used.
			-- Therefore, when calling `update_tab_positions' explicitly, any value may be passed.
		local
			array: ARRAY [INTEGER]
			counter: INTEGER
			value_in_twips: INTEGER
			screen_dc: WEL_SCREEN_DC
			logical_pixels: INTEGER
			current_default: INTEGER
		do
			if tab_positions.count > 0 then
				create screen_dc
				screen_dc.get
				logical_pixels := get_device_caps (screen_dc.item, logical_pixels_x)
				screen_dc.release
				
					-- Calculate the default tab width
				current_default := mul_div (1440, tab_width, logical_pixels)
				
					-- The Windows rich edit only supports 32 positions to be set for tab stops. After that,
					-- the default is reverted to.
				create array.make (1, 32)
				from
					counter := 1
				until
					counter > 32
				loop
					if tab_positions.count >= counter then
							-- Set tab to the value in `tab_positions'.
						value_in_twips := value_in_twips + mul_div (1440, tab_positions.i_th (counter), logical_pixels)
					else
							-- Use the current default value, as a user has not set the position within `tab_positions'.
						value_in_twips := value_in_twips + current_default
					end
					array.put (value_in_twips, counter)
					tab_positions.forth
					counter := counter + 1
				end
					-- The formatting is applied to the current selection.
				set_selection (0, text_length)
				set_tab_stops_array (array)
				
					-- Ensure change is reflected immediately.
				invalidate
			end
		end
		
	text_stream_in (stream: WEL_RICH_EDIT_STREAM_IN) is
			-- Start a text stream in operation with `stream'.
		do
			Precursor {WEL_RICH_EDIT} (stream)
			update_tab_positions (1)
		end
		
	rtf_stream_in (stream: WEL_RICH_EDIT_STREAM_IN) is
			-- Start a rtf stream in operation with `stream'.
		do
			Precursor {WEL_RICH_EDIT} (stream)
			update_tab_positions (1)
		end
		
	insert_rtf_stream_in (stream: WEL_RICH_EDIT_STREAM_IN) is
			-- Start a rtf stream in operation with `stream'.
		do
			Precursor {WEL_RICH_EDIT} (stream)
			update_tab_positions (1)
		end
		
	select_region (start_pos, end_pos: INTEGER) is
			-- Select (hilight) text between 
			-- 'start_pos' and 'end_pos'
		local
			actual_start, actual_end: INTEGER
		do
			if start_pos < end_pos then
				actual_start := start_pos
				actual_end := end_pos
			else
				actual_start := end_pos
				actual_end := start_pos
			end
			set_selection (actual_start - 1, actual_end)
		end
		
	set_current_format (format: EV_CHARACTER_FORMAT) is
			-- apply `format' to current caret position, applicable
			-- to next typed characters.
		local
			wel_character_format: WEL_CHARACTER_FORMAT
		do	
			safe_store_caret	
			wel_character_format ?= format.implementation
			check
				wel_character_format_not_void: wel_character_format /= Void
			end
			set_character_format_selection (wel_character_format)
			safe_restore_caret
		end
		
	safe_store_caret is
			-- Store caret position, and block caret change events from occuring.
		do
			internal_actions_blocked := True
			original_caret_position := caret_position
		end
		
	safe_restore_caret is
			-- Restore caret position stored by last call to `safe_store_caret' and restore
			-- change events.
		do
			set_caret_position (original_caret_position)
			internal_actions_blocked := False

		end
		
	internal_actions_blocked: BOOLEAN
		-- Are caret position and selection change actions blocked internally due to an operation
		-- occurring that may affect them. They must be displayed during the implementation of
		-- certain features that require such modification as part of their implementation. See
		-- `safe_store_caret', `safe_restore_caret'.
	
	original_caret_position: INTEGER
		-- Original position of caret before call `to `safe_store_caret', to be restored by `safe_restore_caret'.
		
feature {EV_CONTAINER_IMP} -- Implementation

	on_en_selchange (selection_type: INTEGER; character_range: WEL_CHARACTER_RANGE) is
			-- En_selchange received by `parent'. See WEL_EN_SELCHANGE_CONSTANTS for
			-- `selection_type' values. `character_range' contains lower and upper selection,
			-- equal when caret is moved with no selection.
		do
			if not internal_actions_blocked then
				if selection_type = feature {WEL_EN_SELCHANGE_CONSTANTS}.sel_empty then
					if must_fire_final_selection then
							-- A selection has just been removed from `Current' so fire `selection_change_actions'
							-- one final time.
						must_fire_final_selection := False
						if selection_change_actions_internal /= Void then
							selection_change_actions_internal.call ([Void])
						end	
					end
					check
						character_range_consistent: character_range.minimum = character_range.maximum
					end
					if caret_move_actions_internal /= Void then
						caret_move_actions_internal.call ([character_range.minimum + 1])
					end
				else
					must_fire_final_selection := True
					check
						character_range_consistent: character_range.minimum /= character_range.maximum
					end
					if selection_change_actions_internal /= Void then
						selection_change_actions_internal.call ([Void])
					end
				end	
			end
		end
		
	must_fire_final_selection: BOOLEAN
		-- Must the selection change actions be fired when there is no selection, notifying
		-- that the selection has been lost. This is only fired once, hence the need for this boolean.
		
feature {NONE} -- Implementation

	is_current_format_underlined: BOOLEAN
	is_current_format_striked_through: BOOLEAN

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
