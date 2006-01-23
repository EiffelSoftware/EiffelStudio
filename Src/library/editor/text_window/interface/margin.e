indexing
	description: "Margin control for use with TEXT_PANEL."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MARGIN

inherit	
	TEXT_OBSERVER
		export
			{NONE} all
		redefine
			on_text_loaded,
			on_text_block_loaded
		end		
		
	SHARED_EDITOR_DATA

create
	make

feature -- Initialization

	make (a_text_panel: TEXT_PANEL) is
			-- Create a new margin
		require
			text_panel_not_void: a_text_panel /= Void
		do
			text_panel := a_text_panel
			build_margin_area
			a_text_panel.text_displayed.add_lines_observer (Current)
			a_text_panel.text_displayed.add_edition_observer (Current)
		end	
		
	build_margin_area is
			-- Initialize variables and objects related to display.	
		do
			create margin_area
			margin_area.set_minimum_size (1, 1)

			margin_area.expose_actions.extend (agent on_repaint)
			margin_area.resize_actions.extend (agent on_size)						

				-- Add widgets to our margin area
			create widget
			widget.extend (margin_area)
			widget.enable_item_expand (margin_area)

				-- Set up the screen.
			create buffered_screen.make_with_size (margin_area.width, text_panel.editor_area.height)
			buffered_screen.set_background_color (editor_preferences.margin_background_color)			
			hide_breakpoints
--			hide_line_numbers
		end

feature -- Access
		
	width: INTEGER is
			-- Width in pixels calculated based on which tokens should be displayed
		local
			l_no_lines: INTEGER
			l_max_token: EDITOR_TOKEN_LINE_NUMBER
--			l_bptok: EDITOR_TOKEN_BREAKPOINT
			l_spacer: STRING
		do	
		    Result := 1
			if line_numbers_visible then				
				Result := Result + internal_line_number_area_width
			end
--			if not hidden_breakpoints then					
--				create l_bptok.make
--				Result := Result + l_bptok.width
--			end
		end	
		
	hidden_breakpoints: BOOLEAN
			-- Are breakpoints hidden? (Default: True)
			
	line_numbers_visible: BOOLEAN is
			-- Are line numbers hidden?
		do
		    Result := text_panel.line_numbers_visible
		end

feature -- Status setting

	hide_breakpoints is
			-- Do not show breakpoints even if there are some.
		do
			hidden_breakpoints := True
		end

	show_breakpoints is
			-- Show breakpoints if there are some.
		do
			hidden_breakpoints := False
		end

	set_margin_width (a_width: INTEGER) is
			-- If `a_width' is greater than `width', assign `a_width' to `width'
			-- update display if necessary.
		do
			widget.set_minimum_width (a_width)						
			if width /= buffered_screen.width then
				buffered_screen.set_size (a_width, margin_area.height)
				update_buffered_screen (0, margin_area.height)								
				update_display
			end			
		end
		
	set_first_line_displayed (fld: INTEGER) is
			-- Assign `fld' to `first_line_displayed'.
		require
			fld_large_enough: fld > 0
		local
			diff, y_offset: INTEGER
			zone: EV_RECTANGLE
		do
			diff := fld - first_line_displayed
			if diff /= 0 then
				first_line_displayed := fld
				if diff.abs < text_panel.number_of_lines_displayed then
					if diff < 0 then
						y_offset := buffered_screen.height + diff * text_panel.line_height
						create zone.make (0, 0, buffered_screen.width, y_offset)
						buffered_screen.draw_sub_pixmap (0, - diff * text_panel.line_height, buffered_screen, zone)
						update_buffered_screen (0, - diff * text_panel.line_height)
					elseif diff > 0 then
						y_offset := diff * text_panel.line_height
						create zone.make (0, y_offset, buffered_screen.width, buffered_screen.height)
						buffered_screen.draw_sub_pixmap (0, 0, buffered_screen, zone)
						update_buffered_screen (buffered_screen.height - y_offset, buffered_screen.height)
					end
					update_display
				else
					margin_area.redraw
				end
			end
		end

feature -- Graphical Interface

	text_panel: TEXT_PANEL
			-- The text panel/editor to which Current is anchored

	widget: EV_VERTICAL_BOX
			-- Widget holding drawing area

	margin_area: EV_DRAWING_AREA
			-- Part of the screen where the information is displayed.

	buffered_screen: EDITOR_BUFFERED_SCREEN
			-- Buffer containing the current displayed margin.		

feature {NONE} -- Text Loading

	on_text_loaded is
			-- Finish the margin setup as the entire text has been loaded in the editor.
		do
			--set_first_line_displayed
			refresh_now
		end

	on_text_block_loaded (was_first_block: BOOLEAN) is
			-- Update scroll bar as a new block of text as been loaded.
		do			
			refresh_now					
		end

feature -- Basic operations

	destroy is
			-- Destroy
		do	
			if widget /= Void then				
				widget.wipe_out	
				widget := Void
			end
			if margin_area /= Void then
				margin_area.destroy
				margin_area := Void
			end
		end		

	refresh is
			-- Refresh
		do
			set_margin_width (width)
			margin_area.redraw
		end
		
	refresh_now is
			-- Update display without waiting for next idle
		do
			refresh
			margin_area.flush
		end

	setup_margin is
			-- Update `Current' as the first page of the new content has been loaded.
		do			
			refresh_now
		end

feature {NONE} -- Implementation

	in_resize: BOOLEAN
			-- Are we in a call to on_resize that was not triggered by the function itself?

	first_line_displayed: INTEGER
			-- First line currently displayed

	default_width: INTEGER is 5
			-- Default character width of margin for when number of lines is less than 100,000

	default_line_number_area_width_cell: CELL [INTEGER] is
			-- Value of line number area width for files with less than 100,000 lines).
		local
			l_no_lines: INTEGER
			l_max_token: EDITOR_TOKEN_LINE_NUMBER
			l_spacer: STRING
		once		
			create Result
			create l_max_token.make
			l_no_lines := text_panel.text_displayed.number_of_lines
			create l_spacer.make_filled ('0', default_width)
			l_max_token.set_internal_image (l_spacer)	
			l_max_token.update_width
			Result.put (l_max_token.width)
		end

	internal_line_number_area_width: INTEGER is
			-- Width of line number display area of Current
		local
			l_max_token: EDITOR_TOKEN_LINE_NUMBER
		do
			if text_panel.text_displayed.number_of_lines < 100_000 then
				Result := default_line_number_area_width_cell.item
			else			
				create l_max_token.make		
				l_max_token.set_internal_image (text_panel.text_displayed.number_of_lines.out)						
				l_max_token.update_width
				Result := Result + l_max_token.width	
			end
		end		

feature {TEXT_PANEL} -- Display functions

	on_repaint (x, y, a_width, a_height: INTEGER) is
			-- Repaint the part of the panel between in the rectangle between
			-- (`x', `y') and (`x' + `a_width', `y' + `a_height').
			--| Actually, rectangle defined by (0, y) -> (margin_area.width, y + height) is redrawn.
		do
			if a_width /= 0 and a_height /= 0 then
				update_buffered_screen (y, y + a_height)
				update_display
			end
		end

	update_buffered_screen (top: INTEGER; bottom: INTEGER) is
 			-- Update buffered pixmap between lines number `top' and `bottom'.
 		local
 			curr_line			: INTEGER
 			first_line_to_draw	: INTEGER
 			last_line_to_draw	: INTEGER
 			curr_y				: INTEGER
 		do
			buffered_screen.set_background_color (editor_preferences.margin_background_color)
			buffered_screen.clear_rectangle (0, top, buffered_screen.width, bottom - top)
			set_margin_width (width)

 				-- Draw all lines
 			first_line_to_draw := (text_panel.first_line_displayed + top // text_panel.line_height ).max (1)
 			last_line_to_draw := (text_panel.first_line_displayed + (bottom - 1) // text_panel.line_height).min (text_panel.text_displayed.number_of_lines)
 			curr_y := top
 
 			if first_line_to_draw <= last_line_to_draw then
 				text_panel.text_displayed.go_i_th (first_line_to_draw)
 				from
 					curr_line := first_line_to_draw
 				until
 					curr_line > last_line_to_draw or else text_panel.text_displayed.after
 				loop
 					display_line (curr_line, text_panel.text_displayed.current_line)
 					curr_line := curr_line + 1
 					text_panel.text_displayed.forth
 				end
 
 				curr_y := (curr_line - text_panel.first_line_displayed) * text_panel.line_height
 			end
 			if curr_y < bottom then
 				-- The file is too small for the screen, so we fill in the
 				-- last portion of the screen.
				buffered_screen.set_background_color (editor_preferences.margin_background_color)
				buffered_screen.clear_rectangle (0, curr_y, width, bottom - curr_y)
 			end
 		end

	update_display is
			-- Update display by drawing the buffered pixmap on `margin_area'.
		do
			margin_area.draw_sub_pixmap (0,	0, buffered_screen, create {EV_RECTANGLE}.make (0, 0, width, buffered_screen.height))					
		end

	on_size (a_x, a_y: INTEGER; a_width, a_height: INTEGER) is
			-- Refresh the panel after it has been resized (and moved) to new coordinates (`a_x', `a_y') and
			-- new size (`a_width', `a_height'). 
			--| Note: This feature is called during the creation of the window
		local
			fld: INTEGER
			old_height: INTEGER
			w,h: INTEGER
		do
				-- Resize & redraw the buffered screen.
			if buffered_screen /= Void then -- System initialized.
				in_resize := True				

				if buffered_screen.width < a_width then
--					if in_resize then
						w := width.max (a_width)
						h := a_height.max (1)
--					else
--						w := margin_width.max (a_width).max (buffered_screen.width)
--						h := a_height.max (1).max (buffered_screen.height)
--					end
					buffered_screen.set_size (w, h)
					update_buffered_screen (0, h)
				else
					old_height := buffered_screen.height
--					if in_resize then
						w := width.max (margin_area.width)
						h := a_height.max (1)
--					else
--						w := editor_width.max (editor_area.width - left_margin_width).max (buffered_screen.width)
--						h := a_height.max (1).max (buffered_screen.height)
--					end
					buffered_screen.set_size (w, h)
					if old_height < a_height then
						update_buffered_screen (old_height - 1, h)
					end
				end
				in_resize := False
			end
		end

	display_line (xline: INTEGER; a_line: EDITOR_LINE) is
 			-- Display `a_line' on the buffered screen.
 		local
-- 			bp_token			: EDITOR_TOKEN_BREAKPOINT
 			line_token			: EDITOR_TOKEN_LINE_NUMBER
 			curr_token			: EDITOR_TOKEN
 			curr_y, max_chars	: INTEGER
 			spacer_text			: STRING
 		do
 			if text_panel.text_displayed.number_of_lines > 99999 then 				
	 			max_chars := text_panel.number_of_lines.out.count		
 			else 				
	 			max_chars := default_width
 			end
 			
 			create spacer_text.make_filled ('0', max_chars - xline.out.count)
 			
 				-- Set the correct image for line number
 			line_token ?= text_panel.text_displayed.line (xline).number_token
			if line_token /= Void then
				line_token.set_internal_image (spacer_text + xline.out)
			end
 			
   			curr_y := (xline - text_panel.first_line_displayed) * text_panel.line_height
  			from
					-- Display the first applicable token in the margin
				a_line.start
				curr_token := a_line.item
 			until
 				a_line.after or else not curr_token.is_margin_token
 			loop 						
				if curr_token.is_margin_token then
--					bp_token ?= curr_token
--					if bp_token /= Void and then not hidden_breakpoints then						
--						bp_token.display (curr_y, buffered_screen, text_panel) 	
--					elseif bp_token /= Void then						
--						bp_token.hide
--					else
						line_token ?= curr_token
						if line_token /= Void and then line_numbers_visible then
							line_token.display (curr_y, buffered_screen, text_panel) 	
						elseif line_token /= Void then						
							line_token.hide
						end
--					end
				end
				a_line.forth 				
				curr_token := a_line.item
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MARGIN
