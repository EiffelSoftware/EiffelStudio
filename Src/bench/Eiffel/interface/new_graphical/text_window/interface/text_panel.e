indexing
	description: "[
		Read only text area with scroll bars.
		Does not respond to keyboard or mouse events.
	]"
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_PANEL

inherit

	EV_FONT_CONSTANTS
		export
			{NONE} all
		end
	
	TEXT_OBSERVER
		export
			{NONE} all
		redefine
			on_text_loaded,
			on_text_block_loaded
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize the text panel.
		do
			create text_displayed.make
			build_editor_area
			text_displayed.add_lines_observer (Current)
			text_displayed.add_edition_observer (Current)
		end

	build_editor_area is
			-- Initialize variables and objects related to display.
		local
			main_vbox: EV_VERTICAL_BOX
		do
			----------------------------
			-- Vision2 initialisation --
			----------------------------
			create editor_area
			editor_area.set_minimum_size (1, 1)
			editor_width := 100
			offset := 0

			editor_area.expose_actions.extend (~on_repaint)
			editor_area.resize_actions.extend (~on_size)
				
				-- Create scrollbars

			create vertical_scrollbar.make_with_value_range (create {INTEGER_INTERVAL}.make (0, 1))
			vertical_scrollbar.set_step (1)
			vertical_scrollbar.change_actions.extend (~on_vertical_scroll)

			create horizontal_scrollbar.make_with_value_range (create {INTEGER_INTERVAL}.make (0, 1))
			horizontal_scrollbar.set_step (5)
			horizontal_scrollbar.change_actions.extend (~on_horizontal_scroll)

			update_scroll_agent := ~update_scrollbars_display

			create widget

				-- Add widgets to our window

			create main_vbox
			main_vbox.set_background_color (normal_background_color)
			main_vbox.extend (editor_area)
			main_vbox.propagate_background_color
			main_vbox.extend (horizontal_scrollbar)
			main_vbox.disable_item_expand (horizontal_scrollbar)
			widget.extend (main_vbox)

			create scroll_vbox
	
			scroll_vbox.extend (vertical_scrollbar)
			create scroll_cell
			scroll_cell.set_minimum_size (vertical_scrollbar.width, vertical_scrollbar.width)
			scroll_vbox.extend (scroll_cell)
			scroll_vbox.disable_item_expand (scroll_cell)
			widget.extend (scroll_vbox)
			widget.disable_item_expand (scroll_vbox)

			----------------------------
			-- General initialisation --
			----------------------------

				-- First display the first line...
			first_line_displayed := 1

				-- Compute Font related constants.
			number_of_lines_displayed := editor_area.height // line_height

				-- Set up the screen.
			create buffered_screen.make_with_size (editor_area.width, editor_area.height)
			buffered_screen.set_background_color (normal_background_color)
			create left_margin_buffered_screen.make_with_size (left_margin_width, editor_area.height)
			left_margin_buffered_screen.set_background_color (normal_background_color)

			vertical_scrollbar.disable_sensitive
		end

feature -- Access

	widget: EV_HORIZONTAL_BOX
			-- Container that groups the drawing area and
			-- the vertical scrollbar.

	pointer_style: EV_CURSOR is
			-- Pointer style over the text.
		do
			Result := editor_area.pointer_style
		end

	text: STRING is
			-- Image of the text being displayed.
		do
			if text_displayed.is_empty then
				create Result.make (0)
			else
				Result := text_displayed.text
			end
		end

	tabulation_size: INTEGER is
			-- Size of tabulations, in characters
		do
			Result := text_displayed.tabulation_size
		end

	drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Actions performed when user drops a stone on the text_area.
		do
			Result := editor_area.drop_actions
		end

feature -- Element Change

	set_tabulation_size (new_tab_size: INTEGER) is
			-- Assign `new_tab_size' to `tabulation_size'
		require
			meaningful_tab_size: new_tab_size > 0
			no_change_when_text_displayed: is_empty
		do
			text_displayed.set_tabulation_size (new_tab_size)
		end

feature -- Status report

	has_focus: BOOLEAN is
			-- Does the text panel have focus ?
		do
			Result := editor_area.has_focus
		end

	is_empty: BOOLEAN is
			-- Is the text panel blank ?
		do
			Result := text_displayed.is_empty
		end

	view_invisible_symbols: BOOLEAN
			-- Are the spaces, the tabulations and the end_of_line
			-- character visible?

	text_is_fully_loaded: BOOLEAN is
			-- Is current text still being loaded ?
		do
			Result := text_displayed.reading_text_finished
		end

feature -- Status setting

	set_focus is
			-- Give the focus to the editor area.
		do
			if editor_area.is_displayed then
				editor_area.set_focus
			end
		end

	toggle_view_invisible_symbols is
			-- Toggle `view_invisible_symbols'.
		do
			view_invisible_symbols := not view_invisible_symbols
			refresh_now
		ensure
			view_invisible_symbols_set: view_invisible_symbols = not old view_invisible_symbols
		end

feature -- Basic Operations

	refresh is
			-- Update display.
		do
			if left_margin_buffered_screen.width /= left_margin_width then
				left_margin_buffered_screen.set_size (left_margin_width, editor_area.height)
			end
			editor_area.redraw
			
		end

	refresh_now is
			-- Update display without waiting for next idle
		do
			refresh
			editor_area.flush
		end

	display_line_with_context (l_number: INTEGER) is
			-- display line number `l_number' in the editor
			-- center display on this line if it is not yet displayed
			-- scroll otherwise
		require
			line_number_is_valid: 0 < l_number and then l_number <= number_of_lines
			text_loaded: text_is_fully_loaded
		local
			fld: INTEGER
		do
			if text_displayed.number_of_lines > number_of_lines_displayed then
				if first_line_displayed <= l_number - 2 and then l_number + 3 < (first_line_displayed + number_of_lines_displayed) then
						-- line # l_number already displayed
					if number_of_lines_displayed <= 4 then
						fld:= l_number - (number_of_lines_displayed // 2)
						set_first_line_displayed (fld.max (1).min (maximum_top_line_index), True)
					end
				else
						-- line # l_number not displyed yet : center display on it
					fld := l_number - (number_of_lines_displayed // 2)
					set_first_line_displayed (fld.max (1).min (maximum_top_line_index), True)
				end
			end
		end

feature -- Measurement

	number_of_lines: INTEGER is
		do
			Result := text_displayed.number_of_lines
		end

feature -- Content change

	clear_window is
			-- Wipe out the text area.
		do
			reset
			update_vertical_scrollbar
			update_horizontal_scrollbar
			refresh_now
		end
	
	load_eiffel_text (txt: STRING) is
			-- Display class text `txt'.
		do
			text_displayed.load_as_eiffel_text
			load_text (txt)
		end
		
	load_basic_text (txt: STRING) is
			-- Display class text `txt'.
		do
			text_displayed.load_as_basic_text
			load_text (txt)
		end
		
feature {NONE} -- Graphical interface

	editor_area: EV_DRAWING_AREA
			-- Part of the screen where the text is displayed.

	buffered_screen: EDITOR_BUFFERED_SCREEN
			-- Buffer containing the current displayed screen.

	left_margin_buffered_screen: EDITOR_BUFFERED_SCREEN
			-- Buffer containing the current displayed left margin.

	vertical_scrollbar: EV_VERTICAL_SCROLL_BAR
			-- Vertical scroll bar associated to the drawing area

	horizontal_scrollbar: EV_HORIZONTAL_SCROLL_BAR
			-- Horizontal scroll bar associated to the drawing area

	scroll_cell: EV_CELL
			-- Grey square in the lower right corner when the two scroll bars are displayed

	scroll_vbox: EV_VERTICAL_BOX
			-- Box that contains `vertical_scrollbar' and `scroll_cell'.

	font: EV_FONT is
			-- Font used to display the text
		once
			create Result
		end

	line_height: INTEGER is
			-- Height of lines in pixels.
		once
			Result := font.height
		end

	normal_background_color: EV_COLOR is
			-- Default color for text.
		once
			create Result.make_with_rgb (1, 1, 1)
		end


feature {NONE} -- Private properties of the text window

	first_line_displayed: INTEGER
			-- First line currently displayed on the screen.

	number_of_lines_displayed: INTEGER
			-- Number of lines currently displayed on the screen.

	offset: INTEGER
			-- Horizontal offset of the display.

	editor_width: INTEGER
			-- Width of the text. (i.e. minimum width of the panel
			-- for which no scroll bar is needed)

	maximum_top_line_index: INTEGER is
			-- Number of the last possible line that can be displayed
			-- at the top of the editor window.
		do
			Result := (text_displayed.number_of_lines - number_of_lines_displayed + 1).max (1)
		end

	show_vertical_scrollbar: BOOLEAN is
			-- Is it necessary to show the vertical scroll bar ?
		do
			Result := text_displayed /= Void and then (number_of_lines_displayed < text_displayed.number_of_lines)
		end

	horizontal_scrollbar_needs_updating: BOOLEAN
			-- Is it necessary to update horizontal
			-- scroll bar display ?

	vertical_scrollbar_needs_updating: BOOLEAN
			-- Is it necessary to update vertical
			-- scroll bar display ?

feature {NONE} -- Window properties change

	set_editor_width (a_width: INTEGER) is
			-- If `a_width' is greater than `editor_width', assign `a_width' to `editor_width'
			-- update display if necessary.
		do
			editor_width := a_width.max (editor_width)
			if editor_width > buffered_screen.width then
				buffered_screen.set_size (editor_width, editor_area.height)
				update_buffered_screen (0, editor_area.height)
				update_horizontal_scrollbar
				update_display
			end
		end

	set_first_line_displayed (fld: INTEGER; refresh_if_necessary: BOOLEAN) is
			-- Assign `fld' to `first_line_displayed'.
		require
			fld_large_enough: fld > 0
			fld_small_enough: fld <= text_displayed.number_of_lines.max (1)
		local
			diff, y_offset: INTEGER
			zone: EV_RECTANGLE
		do
			diff := fld - first_line_displayed
			if diff /= 0 then
				first_line_displayed := fld
				if diff.abs < number_of_lines_displayed then
					if diff < 0 then
						y_offset := buffered_screen.height + diff * line_height
						create zone.make (0, 0, buffered_screen.width, y_offset)
						buffered_screen.draw_sub_pixmap (0, - diff * line_height, buffered_screen, zone)
						create zone.make (0, 0, left_margin_width, y_offset)
						left_margin_buffered_screen.draw_sub_pixmap (0, - diff * line_height, left_margin_buffered_screen, zone)
						update_buffered_screen (0, - diff * line_height)
					elseif diff > 0 then
						y_offset := diff * line_height
						create zone.make (0, y_offset, buffered_screen.width, buffered_screen.height)
						buffered_screen.draw_sub_pixmap (0, 0, buffered_screen, zone)
						create zone.make (0, y_offset, left_margin_width, left_margin_buffered_screen.height)
						left_margin_buffered_screen.draw_sub_pixmap (0, 0, left_margin_buffered_screen, zone)
						update_buffered_screen (buffered_screen.height - y_offset, buffered_screen.height)
					end
					update_display
				else
					editor_area.redraw
				end
					-- Setup the new vertical position.
				vertical_scrollbar.set_value (first_line_displayed)
			end
		end

	set_offset (an_offset: INTEGER) is
			-- Assign `an_offset' to `offset' and update scrollbar if necessary.
		do
			offset := an_offset
			update_display
			check
				offset_within_bounds: horizontal_scrollbar.value_range.has (an_offset)
			end
			if horizontal_scrollbar.is_show_requested then
				horizontal_scrollbar.set_value (offset)
			end
		end

feature {NONE} -- Scroll bars Management

	update_horizontal_scrollbar is
			-- Update horizontal scrollbar value range and show it or
			-- hide it if it is not needed.
		local
			w: INTEGER
		do
			w := editor_area.width
			if editor_width > w and then text_displayed /= Void then
				horizontal_scrollbar.value_range.resize_exactly (0, editor_width - w)
				horizontal_scrollbar.set_leap (w)
				if horizontal_scrollbar.is_show_requested then 
					if not platform_is_windows then
						horizontal_scrollbar_needs_updating := False
					end
				else
					horizontal_scrollbar.show
					horizontal_scrollbar_needs_updating := True
					if not ev_application.idle_actions.has (update_scroll_agent) then
						ev_application.idle_actions.extend (update_scroll_agent)
					end
				end
			elseif horizontal_scrollbar.is_show_requested then
				horizontal_scrollbar.value_range.resize_exactly (0, 1)
				horizontal_scrollbar.set_leap (1)
				horizontal_scrollbar.hide
				horizontal_scrollbar_needs_updating := True
				set_offset (0)
				if not ev_application.idle_actions.has (update_scroll_agent) then
					ev_application.idle_actions.extend (update_scroll_agent)
				end
			elseif horizontal_scrollbar_needs_updating and then not platform_is_windows then
				horizontal_scrollbar_needs_updating := False
			end
			update_scroll_cell
		end

	update_vertical_scrollbar is
			-- Update vertical scrollbar value range.
			-- Show it or hide it depending on what is appropriate.
		local
			nol: INTEGER
		do
			if show_vertical_scrollbar then
				nol := text_displayed.number_of_lines
				vertical_scrollbar.value_range.resize_exactly (1, maximum_top_line_index)
				vertical_scrollbar.set_value (first_line_displayed)
				vertical_scrollbar.set_leap (number_of_lines_displayed.max (1))
				if scroll_vbox.is_show_requested then
					if not platform_is_windows then
						vertical_scrollbar_needs_updating := False
					end
				else
					scroll_vbox.show
					vertical_scrollbar_needs_updating := True
					if not ev_application.idle_actions.has (update_scroll_agent) then
						ev_application.idle_actions.extend (update_scroll_agent)
					end
				end
			elseif scroll_vbox.is_show_requested then
				scroll_vbox.hide
				vertical_scrollbar_needs_updating := True
				if not ev_application.idle_actions.has (update_scroll_agent) then
					ev_application.idle_actions.extend (update_scroll_agent)
				end
			elseif vertical_scrollbar_needs_updating and then not platform_is_windows then
				vertical_scrollbar_needs_updating := False
			end
			update_scroll_cell
		end

	update_scroll_cell is
			-- Hide or show scroll bar depending on what is appropriate.
		do
			if
				vertical_scrollbar.is_show_requested 
				and then
				horizontal_scrollbar.is_show_requested
			then
				scroll_cell.show
			else
				scroll_cell.hide
			end
		end

	update_scrollbars_display is
			-- Ensure scrollbars are correctly hidden.
		do
			if horizontal_scrollbar_needs_updating then
				horizontal_scrollbar_needs_updating := False
				if platform_is_windows then
					if horizontal_scrollbar.is_show_requested then
						horizontal_scrollbar.show
					else
						horizontal_scrollbar.hide
						scroll_cell.show
						scroll_cell.hide
					end
				else
					if horizontal_scrollbar.is_show_requested then
						horizontal_scrollbar.hide
						horizontal_scrollbar.show
						scroll_cell.hide
						scroll_cell.show
					else
						horizontal_scrollbar.show
						horizontal_scrollbar.hide
						scroll_cell.show
						scroll_cell.hide
					end
				end
			end
			if vertical_scrollbar_needs_updating then
				vertical_scrollbar_needs_updating := False
				if platform_is_windows then
					if scroll_vbox.is_show_requested then
						scroll_vbox.show
					else
						scroll_vbox.hide
					end
				else
					if scroll_vbox.is_show_requested then
						scroll_vbox.hide
						scroll_vbox.show
					else
						scroll_vbox.show
						scroll_vbox.hide
					end
				end
			end
			if ev_application.idle_actions.has (update_scroll_agent) then
				ev_application.idle_actions.prune_all (update_scroll_agent)
			end			
		end

	on_vertical_scroll (vscroll_pos: INTEGER) is
 			-- Process vertical scroll event. `vertical_scrollbar.value' has changed.
 		local
 			vscroll_inc: INTEGER
 		do
				-- Compute the first line to be displayed
			vscroll_inc := (vscroll_pos.min (text_displayed.number_of_lines)).max (1) - first_line_displayed

			set_first_line_displayed (first_line_displayed + vscroll_inc, True)
 		end

 	on_horizontal_scroll (scroll_pos: INTEGER) is
 			-- Process horizontal scroll event. `horizontal_scrollbar.value' has changed.
 		do
			offset := scroll_pos
			update_display
		end

feature {NONE} -- Display functions

	on_repaint (x, y, a_width, a_height: INTEGER) is
			-- Repaint the part of the panel between in the rectangle between
			-- (`x', `y') and (`x' + `a_width', `y' + `a_height').
			--| Actually, rectangle defined by (0, y) -> (editor_area.width, y + height) is redrawn.
		do
			if a_width /= 0 and a_height /= 0 then
				update_buffered_screen (y, y + a_height)
				update_display
			end
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
				number_of_lines_displayed := a_height // line_height
				fld := maximum_top_line_index
				if fld <= 0 then
					first_line_displayed := 1
				else
					first_line_displayed := first_line_displayed.min (fld)
				end
				offset := offset.min (editor_width - a_width).max (0)

				update_vertical_scrollbar
				update_horizontal_scrollbar

				if buffered_screen.width + left_margin_width < a_width then
					if in_resize then
						w := editor_width.max (a_width - left_margin_width)
						h := a_height.max (1)
					else
						w := editor_width.max (a_width - left_margin_width).max (buffered_screen.width)
						h := a_height.max (1).max (buffered_screen.height)
					end
					buffered_screen.set_size (w, h)
					left_margin_buffered_screen.set_size (left_margin_width, h)
					update_buffered_screen (0, h)
				else
					old_height := buffered_screen.height
					if in_resize then
						w := editor_width.max (editor_area.width - left_margin_width)
						h := a_height.max (1)
					else
						w := editor_width.max (editor_area.width - left_margin_width).max (buffered_screen.width)
						h := a_height.max (1).max (buffered_screen.height)
					end
					buffered_screen.set_size (w, h)
					left_margin_buffered_screen.set_size (left_margin_width, h)
					if old_height < a_height then
						update_buffered_screen (old_height - 1, h)
					end
				end
				in_resize := False
			end
		end

	update_buffered_screen (top: INTEGER; bottom: INTEGER) is
 			-- Update buffered pixmap between lines number `top' and `bottom'.
 		local
 			curr_line		: INTEGER
 			first_line_to_draw	: INTEGER
 			last_line_to_draw	: INTEGER
 			curr_y			: INTEGER
 		do
			buffered_screen.set_background_color (normal_background_color)
			buffered_screen.clear_rectangle (0, top, buffered_screen.width, bottom - top)
			left_margin_buffered_screen.set_background_color (normal_background_color)
			left_margin_buffered_screen.clear_rectangle (0, top, left_margin_width, bottom - top)

 				-- Draw all lines
 			first_line_to_draw := (first_line_displayed + top // line_height ).max (1)
 			last_line_to_draw := (first_line_displayed + (bottom - 1) // line_height).min (text_displayed.number_of_lines)
 			curr_y := top
 
 			if first_line_to_draw <= last_line_to_draw then
 				text_displayed.go_i_th (first_line_to_draw)
 				from
 					curr_line := first_line_to_draw
 				until
 					curr_line > last_line_to_draw or else
 					text_displayed.after
 				loop
 					display_line (curr_line, text_displayed.current_line)
 					curr_line := curr_line + 1
 					text_displayed.forth
 				end
 
 				curr_y := (curr_line - first_line_displayed) * line_height
 			end
 			if curr_y < bottom then
 				-- The file is too small for the screen, so we fill in the
 				-- last portion of the screen.
				buffered_screen.set_background_color (normal_background_color)
				buffered_screen.clear_rectangle (0, curr_y, editor_width, bottom - curr_y)
 			end
 		end

	update_display is
			-- Update display by drawing the buffered pixmap on `editor_area'.
		do
			if offset >= left_margin_width then
				editor_area.draw_sub_pixmap (
					0,
					0,
					buffered_screen,
					create {EV_RECTANGLE}.make (
						offset - left_margin_width,
						0,
						editor_area.width + offset - left_margin_width,
						buffered_screen.height)
				)
			else
				editor_area.draw_sub_pixmap (
					0,
					0,
					left_margin_buffered_screen,
					create {EV_RECTANGLE}.make (
						offset,
						0,
						left_margin_width - offset,
						left_margin_buffered_screen.height
					)
				)
				editor_area.draw_sub_pixmap (
					left_margin_width - offset,
					0,
					buffered_screen,
					create {EV_RECTANGLE}.make (
						0,
						0,
						editor_area.width,
						buffered_screen.height
					)
				)
			end
		end
 
 	display_line (xline: INTEGER; a_line: EDITOR_LINE) is
 			-- Display `a_line' on the buffered screen.
		require
			text_is_not_empty: not text_displayed.is_empty
 		local
 			curr_token	: EDITOR_TOKEN
 			curr_y		: INTEGER
 		do
   			curr_y := (xline - first_line_displayed) * line_height
  			from
					-- Display the first token in the margin
				a_line.start
				if Display_margin then
					a_line.item.display (curr_y, left_margin_buffered_screen, Current) 
				end
				a_line.forth
				curr_token := a_line.item
 			until
 				a_line.after or else curr_token = a_line.eol_token or else curr_token.position > editor_width
 			loop
					-- Normally Display the token.
				curr_token.display (curr_y, buffered_screen, Current)

					-- Prepare next iteration
				a_line.forth
				curr_token := a_line.item
			end

			if curr_token.position < editor_width then
					-- Display the end token
				curr_token := a_line.eol_token
				a_line.eol_token.display_end_token_normal (curr_y, buffered_screen,buffered_screen.width, Current)
			end
		end

	invalidate_block (first_line, last_line: INTEGER) is
			-- Redraw lines with numbers between `first_line' and `last_line' on the buffered screen.
		local
			lower_bound, upper_bound: INTEGER
			line_up: INTEGER
		do
			lower_bound := first_line.max (first_line_displayed)
			upper_bound := last_line.min (first_line_displayed + number_of_lines_displayed)
			if upper_bound >= lower_bound then
				line_up := (lower_bound - first_line_displayed) * line_height
				editor_area.redraw_rectangle (0, line_up, editor_area.width, (upper_bound - lower_bound + 1) * line_height)
				editor_area.flush
			end
		end

feature {EB_FORMATTER} -- display functions

	invalidate_line (line_number: INTEGER; flush_screen: BOOLEAN) is
			-- Set the line `line_number' to be redrawn.
			-- Redraw immediately if `flush' is set.
		local
			line_up: INTEGER
		do
  				-- Invalidate old cursor location.
			if line_number >= first_line_displayed and then line_number <= first_line_displayed + number_of_lines_displayed then
				line_up := (line_number - first_line_displayed) * line_height
				editor_area.redraw_rectangle (0, line_up, editor_area.width, line_height)
			end
			if flush_screen then
				editor_area.flush
			end
		end

feature {NONE} -- Constants & Text Attributes

	Left_margin_width: INTEGER is
			-- Width in pixel of the margin on the left
			-- of the screen.
		do
			Result := 4
		end

	Display_margin: BOOLEAN is
			-- Should the margin be displayed or not?
		do
			Result := False
		end

feature {NONE} -- Text loading

	load_text (s: STRING) is
			-- Display `s'.
		do
				-- Reset the editor state
			reset

				-- Read and parse the file.
			text_displayed.set_first_read_block_size (number_of_lines_displayed)
			text_displayed.load_string (s)

				-- Setup the editor (scrollbar, ...)
			setup_editor
		end

	reset is
			-- Reinitialize `Current' so that it can receive a new content.
		do
				-- First abort our previous actions.
			text_displayed.reset_text
			editor_width := 100
			set_offset (0)
			first_line_displayed := 1
			vertical_scrollbar.set_value (1)
		end

	setup_editor is
			-- Update `Current' as the first page of the new content has been loaded.
		require
			first_page_loaded: text_is_fully_loaded or else number_of_lines >= number_of_lines_displayed
		local
			i: INTEGER
		do
			first_line_displayed := 1
			vertical_scrollbar.set_value (1)

				-- Setup the scroll bars.
			vertical_scrollbar.enable_sensitive
			update_vertical_scrollbar
			update_horizontal_scrollbar

			from
				i := 1
			until
				i = number_of_lines
			loop
				editor_width := editor_width.max (text_displayed.line (i).width)
				i := i + 1
			end

				-- We're all setup, let's display the thing
			set_editor_width (editor_width)
			update_horizontal_scrollbar
			refresh_now
		end

	on_text_loaded is
			-- Finish the panel setup as the entire text has been loaded.
		do
			editor_width := 0
			from
				text_displayed.start
			until
				text_displayed.after
			loop
				editor_width := editor_width.max (text_displayed.current_line.width)
				text_displayed.forth
			end
			editor_width := editor_width + left_margin_width + 50
			set_editor_width (editor_width)
			vertical_scrollbar.enable_sensitive
			update_vertical_scrollbar
			update_horizontal_scrollbar

			refresh_now
		end

	on_text_block_loaded (was_first_block: BOOLEAN) is
			-- Update scroll bar as a new block of text as been loaded.
		do
			update_vertical_scrollbar
		end

feature {NONE} -- implementation

	in_resize: BOOLEAN
			-- Are we a call to on_resize that was not triggered by the function itself.

	text_displayed: TEXT
			-- Text currently displayed on the screen.

	ev_application: EV_APPLICATION is
			-- Current application.
		once
			Result := (create {EV_ENVIRONMENT}).application
		end

	update_scroll_agent: PROCEDURE [like Current, TUPLE]
			-- Agent for scrollbar display updates.

	platform_is_windows: BOOLEAN is
			-- Is this windows the current platform?
		once
			Result := (create {PLATFORM_CONSTANTS}).is_windows
		end

feature -- Memory management

	recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			if ev_application.idle_actions.has (update_scroll_agent) then
				ev_application.idle_actions.prune_all (update_scroll_agent)
			end
			update_scroll_agent := Void
			
			if widget /= Void then
				widget.wipe_out
				widget := Void
			end
			if editor_area /= Void then
				editor_area.destroy
				editor_area := Void
			end
			if scroll_cell /= Void then
				scroll_cell.destroy
				scroll_cell := Void
			end
			if vertical_scrollbar /= Void then
				vertical_scrollbar.destroy
				vertical_scrollbar := Void
			end
			if left_margin_buffered_screen /= Void then
				left_margin_buffered_screen.destroy
				left_margin_buffered_screen := Void
			end
			if update_scroll_agent /= Void then
				update_scroll_agent := Void
			end
			if text_displayed /= Void then
				text_displayed.recycle
				text_displayed := Void
			end
		end

invariant
	text_displayed_exists: text_displayed /= Void
	first_line_number_is_valid: first_line_displayed > 0 and then first_line_displayed <= maximum_top_line_index

end -- class TEXT_PANEL
