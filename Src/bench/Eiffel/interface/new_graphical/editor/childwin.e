class
	CHILD_WINDOW

inherit
	WEL_MDI_CHILD_WINDOW
		rename
			make as mdi_child_window_make
		redefine
			on_paint, on_size, class_icon, default_style,
			on_vertical_scroll, on_key_down, on_char
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

	WEL_DIB_COLORS_CONSTANTS
		export
			{NONE} all
		end

	WEL_RASTER_OPERATIONS_CONSTANTS
		export
			{NONE} all
		end

	WEL_SB_CONSTANTS
		export
			{NONE} all
		end

	WEL_VK_CONSTANTS
		export
			{NONE} all
		end

	SHARED_EDITOR_PREFERENCES


creation
	make

feature -- Initialization


	initialize is
			-- Perform all initialization.
		local
			dc: WEL_CLIENT_DC
			space_size : WEL_SIZE
			log_font: WEL_LOG_FONT
			screen_dc: WEL_SCREEN_DC
		do
			if not initialized then

					-- create the font
				create log_font.make(14, "Courier New")
				create current_font.make_indirect(log_font)
				
					-- Compute Font related constants
				create dc.make (Current)
				dc.get
				dc.select_font(current_font)
				space_size := dc.string_size(" ")
				line_increment := space_size.height + 1
				dc.unselect_font
				dc.release

				first_line_displayed := 1

					-- Initialisation done.
				initialized := True
			end
		end

	make (a_parent: WEL_MDI_FRAME_WINDOW; a_name: STRING) is
		do
				-- Create the window.
			mdi_child_window_make (a_parent, a_name)

				-- Retrieve user preferences (syntax highligting, tabulation width, ...).
			editor_preferences.set_tabulation_spaces(4)

				-- Read and parse the file.
			read_and_analyse_file(a_name)

				-- Load the font & Compute Font related constants.
			Initialize
			number_of_lines_displayed := height // line_increment
			number_of_lines := text_displayed.count

				-- Setup the scroll bars.
			set_vertical_range(1,vertical_range_max)

				-- Create the cursor
			create cursor.make_from_absolute_pos(0,1,text_displayed)
		end

	read_and_analyse_file (a_name: STRING) is
		local
			file: PLAIN_TEXT_FILE
			line_item: EDITOR_LINE
			curr_string: STRING
			fake_text: EDITOR_TOKEN_TEXT
			fake_list: EDITOR_LINE
		do
				-- read the file
			create file.make_open_read (a_name)
			create text_displayed.make
			
			from
				file.start
			until
				file.after
			loop
				file.read_line
				curr_string := clone(file.last_string)
				lexer.execute(curr_string)
				create line_item.make_from_lexer(lexer)
				text_displayed.extend(line_item)
			end
		end

feature -- Access

feature -- Basic operations

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Paint the bitmap
		do
			update_buffered_screen(paint_dc, invalid_rect.top, invalid_rect.bottom)
		end

	on_size (size_type: INTEGER; a_width: INTEGER; a_height: INTEGER) is
		local
			dc: WEL_CLIENT_DC
		do
			Initialize

				-- Recompute the number of displayed lines.
			number_of_lines_displayed := height // line_increment

				-- Setup the scroll bars.
			set_vertical_range(1,vertical_range_max)

				-- Compute the first line to be displayed [ = max (0,min(vpos,vmax)) ]
			first_line_displayed := (first_line_displayed.min(vertical_range_max)).max(1)
			set_vertical_position(first_line_displayed)
		end

	on_vertical_scroll (scroll_code, position: INTEGER) is
			-- Vertical scroll is received with a
			-- `scroll_code' type. See class WEL_SB_CONSTANTS for
			-- `scroll_code' values. `position' is the new
			-- scrollbox position.
		local
			vscroll_pos: INTEGER
			vscroll_inc: INTEGER
		do
			vscroll_pos := first_line_displayed

			if scroll_code = Sb_lineup then
				vscroll_pos := vscroll_pos - 1

			elseif scroll_code = Sb_linedown then
				vscroll_pos := vscroll_pos + 1

			elseif scroll_code = Sb_pageup then
				vscroll_pos := vscroll_pos - number_of_lines_displayed
		
			elseif scroll_code = Sb_pagedown then
				vscroll_pos := vscroll_pos + number_of_lines_displayed
		
			elseif scroll_code = Sb_thumbposition then
				vscroll_pos := position
			else
				-- Do nothing.
			end

				-- Compute the first line to be displayed [ = max (0,min(vpos,vmax)) ]
			vscroll_inc := (vscroll_pos.min(vertical_range_max)).max(1) - first_line_displayed
			first_line_displayed := first_line_displayed + vscroll_inc

				-- Update the screen (if needed).
			if vscroll_inc /= 0 then

					-- Setup the new vertical position.
				scroll (0, -line_increment * vscroll_inc)
				set_vertical_position(first_line_displayed)

					-- Ask window to repaint our window.
				update
			end
		end

	on_key_down(virtual_key: INTEGER; key_data: INTEGER) is
			-- Process Wm_keydown message corresponding to the
			-- key `virtual_key' and the associated data `key_data'.
		do
			if virtual_key = Vk_left and then cursor /= Void then
	   			io.putstring("go left%N")
				cursor.go_left_char
				invalidate
				update
			elseif  virtual_key = Vk_right and then cursor /= Void then
	   			io.putstring("go right")
				cursor.go_right_char
				invalidate
				update
			else
				-- Key not handled, do nothing
			end
		end

 	on_char (character_code, key_data: INTEGER) is
   			-- Wm_char message
   			-- See class WEL_VK_CONSTANTS for `character_code' value.
   		do
 		end

feature {NONE} -- Display functions
	
	update_buffered_screen (dc: WEL_DC; top: INTEGER; bottom: INTEGER) is
			-- Update the device context `dc'. Redraw the text.
		local
			curr_line: INTEGER
			first_line_to_draw: INTEGER
			last_line_to_draw: INTEGER
		do
				-- Draw all lines
			dc.select_font(current_font)
			first_line_to_draw := (first_line_displayed + top // line_increment - 1).max(1)
			last_line_to_draw := (first_line_displayed + bottom // line_increment).min(number_of_lines)

			if first_line_to_draw <= last_line_to_draw then
				text_displayed.go_i_th(first_line_to_draw)
				from
					curr_line := first_line_to_draw
				until
					curr_line > last_line_to_draw + 2 or else
					text_displayed.after
				loop
					display_line (0,(curr_line - first_line_displayed)*line_increment,text_displayed.current_line, dc)
					if curr_line = cursor.y_in_lines then
						dc.text_out(cursor.x_in_pixels, (curr_line - first_line_displayed)*line_increment, "#")
					end
					curr_line := curr_line + 1
					text_displayed.forth
				end
			end
			dc.unselect_font
		end

	display_line (d_x: INTEGER; d_y: INTEGER; line: EDITOR_LINE; dc: WEL_DC) is
			-- Display `line' at the coordinates (`d_x',`d_y') on the
			-- device context `dc'.
		local
			curr_x		: INTEGER
		do
			from
				line.start
				curr_x := d_x
			until
				line.after
			loop
				curr_x := line.item.display(curr_x, d_y, dc)
				line.forth
			end
		end

feature {NONE} -- Status Report
	
	first_line_displayed: INTEGER
		-- First line currently displayed on the screen.

	number_of_lines_displayed: INTEGER
		-- Number of lines currently displayed on the screen.

	number_of_lines: INTEGER
		-- Whole number of lines.

	vertical_range_max: INTEGER is
		do
			Result := number_of_lines - number_of_lines_displayed + 2
			Result := Result.max(1)
		end

feature {NONE} -- Constants & Text Attributes

	Left_margin_width: INTEGER is 5
		-- Width in pixel of the margin on the left
		-- of the screen.

	Top_margin_width: INTEGER is 5
		-- Height in pixel of the margin on the top
		-- of the screen.

	line_increment: INTEGER
		-- Height in pixel of a line + an interline.

feature {NONE} -- Implementation

	current_font: WEL_FONT
		-- Current font used to display the text.

	initialized: BOOLEAN
		-- Has initialisations been performed?

	class_icon: WEL_ICON is
			-- Window's icon
		once
			create Result.make_by_id (Id_ico_child_window)
		end

	default_style: INTEGER is
			-- Default style for this window.
		do
			Result := ws_overlappedwindow + ws_vscroll
		end

	lexer: EIFFEL_SCANNER is
			-- Eiffel Lexer
		once
			create Result.make
		end

	cursor: TEXT_CURSOR

--	text_displayed: LINKED_LIST [EDITOR_LINE]
	text_displayed: STRUCTURED_TEXT
			-- text currently displayed on the screen.

end -- class CHILD_WINDOW

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
