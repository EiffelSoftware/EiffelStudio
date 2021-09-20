note
	description: "Margin control for use with TEXT_PANEL."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MARGIN_WIDGET

inherit
	TEXT_OBSERVER
		export
			{NONE} all
		undefine
			copy,
			is_equal
		end

	SHARED_EDITOR_DATA
		undefine
			copy,
			is_equal
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

create
	make_with_panel

feature {NONE}-- Initialization

	make_with_panel (a_text_panel: like text_panel)
			-- Associate an text panel/editor
		require
			text_panel_not_void: a_text_panel /= Void
		do
				-- Create all widgets.
			create margin_viewport
			create margin_area

				-- Build_widget_structure.
			margin_viewport.extend (margin_area)
			margin_area.set_minimum_width (1)
			margin_area.set_minimum_height (1)

				-- Call `user_initialization'.
			user_initialization

				-- Associate panel.
			set_text_panel (a_text_panel)
		end

	set_text_panel (a_text_panel: like text_panel)
			-- Associate an text panel/editor
		require
			text_panel_not_void: a_text_panel /= Void
		do
			text_panel := a_text_panel
			a_text_panel.text_displayed.add_lines_observer (Current)
			a_text_panel.text_displayed.add_edition_observer (Current)
			margin_area.set_minimum_size (buffered_drawable_width, buffered_drawable_height)
				-- Set focus to `text_panel' anytime we receives the focus since from
				-- the user point of view the margin and the editor are one.
			margin_area.focus_in_actions.extend (agent text_panel.set_focus)
		end

	user_initialization
		do
			margin_area.expose_actions.extend (agent on_repaint)
			update_width_cell
		end

feature -- Access

	is_show_requested: BOOLEAN
			-- Is `Current' requested to be visible on screen?
		do
			Result := line_numbers_enabled and then line_numbers_visible
		end

	width: INTEGER
			-- Width in pixels calculated based on which tokens should be displayed
		do
			if line_numbers_enabled and then line_numbers_visible then
				Result := Result + internal_line_number_area_width
			end
		end

	line_numbers_visible: BOOLEAN
			-- Are line numbers requested to be displayed?
		do
		    Result := text_panel.line_numbers_visible
		end

	line_numbers_enabled: BOOLEAN
			-- Are line numbers enabled?

feature -- Status setting

	enable_line_numbers
			-- Enable line numbers
		do
			line_numbers_enabled := True
		ensure
			line_numbers_enabled: line_numbers_enabled = True
		end

	disable_line_numbers
			-- Disable line numbers
		do
			line_numbers_enabled := False
		ensure
			line_numbers_disabled: line_numbers_enabled = False
		end

	set_margin_width (a_width: INTEGER)
			-- If `a_width' is greater than `width', assign `a_width' to `width'
			-- update display if necessary.
		do
			margin_viewport.set_minimum_width (a_width)
		end

	synch_with_panel
			-- Sync the offset of Current margin with the one from the text_panel.
		do
 			margin_viewport.set_y_offset (text_panel.editor_viewport.y_offset)
 			flip_count := text_panel.flip_count
		end

	update_size_with_panel
			-- Update the size of Current margin using buffer sizes from the text_panel.
			-- especially the height as the width is fixed.
		do
			margin_area.set_minimum_size (buffered_drawable_width, buffered_drawable_height)
		end

feature -- Graphical Interface

	text_panel: TEXT_PANEL
			-- The text panel/editor to which Current is anchored

	margin_viewport: EV_VIEWPORT
	margin_area: EV_DRAWING_AREA

feature -- Basic operations

	show
			-- Show `Current'.
		do
			margin_viewport.show
		end

	destroy
			-- Destroy
		do
			margin_viewport.destroy
			margin_area.destroy
				-- Detach the original object.
			create margin_area
		end

	refresh
			-- Refresh
		do
			set_margin_width (width)
			margin_area.redraw
		end

	refresh_now
			-- Update display without waiting for next idle
		do
			refresh
			margin_area.flush
		end

	setup_margin
			-- Update `Current' as the first page of the new content has been loaded.
		do
			refresh_now
		end

	on_font_changed
			-- Font was changed so must update some internal values
		do
				-- Width cell
			update_width_cell
			synch_with_panel
		end

feature {NONE} -- Implementation

	in_resize: BOOLEAN
			-- Are we in a call to on_resize that was not triggered by the function itself?

	first_line_displayed: INTEGER
			-- First line currently displayed
		do
			Result := text_panel.first_line_displayed
		end

	default_width: INTEGER = 5
			-- Default character width of margin for when number of lines is less than 100,000

	default_line_number_area_width_cell: CELL [INTEGER]
			-- Value of line number area width for files with less than 100,000 lines).
		once
			create Result.put (0)
		end

	update_width_cell
			-- Update `default_line_number_area_width_cell'.
		local
			l_max_token: EDITOR_TOKEN_LINE_NUMBER
			l_spacer: STRING
		do
			create l_max_token.make
			create l_spacer.make_filled ('0', default_width)
			l_max_token.set_internal_image (l_spacer)
			l_max_token.update_width
			default_line_number_area_width_cell.put (l_max_token.width)
		end

	internal_line_number_area_width: INTEGER
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

	viewable_height: INTEGER
			-- Height of `Current' available to view displayed items. Does
			-- not include width of any displayed scroll bars and/or header if shown.
		do
			Result := margin_viewport.height
		end

	updating_line: BOOLEAN
			-- Is line updating?

	in_scroll: BOOLEAN

	flip_count: INTEGER

	buffered_drawable_width: INTEGER = 500

	buffered_drawable_height: INTEGER
			-- Default size of `drawable' used for scrolling purposes.
		do
			Result := text_panel.buffered_drawable_height
		end

	separator_width: INTEGER = 1
			-- Width of vertical separator

	separator_color: EV_COLOR
			-- Color of separator between margin and editor
		do
			Result := editor_preferences.margin_separator_color
		end

feature {TEXT_PANEL} -- Display functions

	on_repaint (x, y, a_width, a_height: INTEGER)
			-- Repaint the part of the panel between in the rectangle between
			-- (`x', `y') and (`x' + `a_width', `y' + `a_height').
			--| Actually, rectangle defined by (0, y) -> (margin_area.width, y + height) is redrawn.
		do
			on_paint := True
			if a_width /= 0 and a_height /= 0 then
				update_area (y, y + a_height, False)
			end
			on_paint := False
		end

	update_area (top: INTEGER; bottom: INTEGER; buffered: BOOLEAN)
 			-- Update buffered pixmap between lines number `top' and `bottom'.
 		require
 			in_synch_with_panel: margin_viewport.y_offset = text_panel.editor_viewport.y_offset
	 		on_paint: on_paint
 		local
 			first_line_to_draw	: INTEGER
 			last_line_to_draw	: INTEGER
 			view_y_offset		: INTEGER
 			y_offset: INTEGER
 			l_height: INTEGER
 		do
			view_y_offset := margin_viewport.y_offset

 				-- Draw all lines
 			first_line_to_draw := (first_line_displayed + (top - view_y_offset) // text_panel.line_height).max (1)
 			last_line_to_draw := ((first_line_displayed + (bottom - view_y_offset) // text_panel.line_height).min (text_panel.text_displayed.number_of_lines)).max (1)

			check
				not_too_many_lines: (bottom = top) implies first_line_to_draw = last_line_to_draw
				lines_valid: first_line_to_draw <= last_line_to_draw or last_line_to_draw = text_panel.text_displayed.number_of_lines or text_panel.text_displayed.number_of_lines = 0
				first_line_valid: first_line_to_draw >= 1
				last_line_valid: last_line_to_draw >= 1
			end

 			if text_panel.text_displayed.number_of_lines > 0 then
				if first_line_to_draw > last_line_to_draw then
					update_lines (last_line_to_draw, last_line_to_draw, buffered)
				else
					update_lines (first_line_to_draw, last_line_to_draw, buffered)
				end
			end

 			if last_line_to_draw = text_panel.text_displayed.number_of_lines or text_panel.text_displayed.number_of_lines = 0 then
	 				-- The file is too small for the screen, so we fill in the last portion of the screen.
	 			y_offset := margin_viewport.y_offset + ((last_line_to_draw - first_line_displayed + (text_panel.text_displayed.number_of_lines.min (1))) * text_panel.line_height)
				margin_area.set_background_color (editor_preferences.margin_background_color)
				debug ("editor")
					draw_flash (0, y_offset, width, (viewable_height - (y_offset - view_y_offset)).abs, False)
				end
				l_height := y_offset + viewable_height - (y_offset - view_y_offset)
				margin_area.clear_rectangle (0, y_offset, width, l_height)

					-- Display the separator
				margin_area.set_background_color (separator_color)
				margin_area.clear_rectangle (width - separator_width, y_offset, separator_width, l_height)
				margin_area.set_background_color (editor_preferences.margin_background_color)

 			end
 			in_scroll := False
 		end

	update_lines (first, last: INTEGER; buffered: BOOLEAN)
			-- Update the lines from `first' to `last'.  If `buffered' then draw to `buffered_line'
 			-- before drawing to screen, otherwise draw straight to screen.
		require
			lines_valid: first <= last
			first_line_valid: first >= 1
			last_line_valie: last >= 1
		local
 			curr_line,
 			y_offset,
 			l_line_height: INTEGER
 			l_text_displayed: like text_displayed_type
 			l_line: detachable EDITOR_LINE
		do
			l_text_displayed := text_panel.text_displayed
			if l_text_displayed /= Void and then last <= l_text_displayed.number_of_lines then
				updating_line := True
				l_text_displayed.go_i_th (first)
				l_line_height := text_panel.line_height

				from
	 				curr_line := first
	 				y_offset := margin_viewport.y_offset + ((curr_line - first_line_displayed) * l_line_height)
	 			until
	 				curr_line > last or else l_text_displayed.after
	 			loop
	 				if buffered then
	 					-- We do not currently buffer for the margin
					else
						l_line := l_text_displayed.line (curr_line)
						check l_line /= Void end -- Implied by not `l_text_displayed.after'
						draw_line_to_screen (0, y_offset, l_line, curr_line)
					end
	 				curr_line := curr_line + 1
					y_offset := y_offset + l_line_height
	 				l_text_displayed.forth
	 			end

	 			updating_line := False
			end
		end

	draw_line_to_screen (x, y: INTEGER; a_line: EDITOR_LINE; xline: INTEGER)
			-- Update display by drawing `line' onto the `editor_drawing_area' directly at co-ordinates x,y.
		local
 			curr_token	: EDITOR_TOKEN
 			spacer_text: STRING
 			max_chars: INTEGER
 		do
 			if text_panel.text_displayed.number_of_lines > 99999 then
	 			max_chars := text_panel.number_of_lines.out.count
 			else
	 			max_chars := default_width
 			end
 			create spacer_text.make_filled ('0', max_chars - xline.out.count)

 				-- Set the correct image for line number
			if attached {EDITOR_TOKEN_LINE_NUMBER} a_line.number_token as line_token then
				line_token.set_internal_image (spacer_text + xline.out)
			end

  			from
					-- Display the first applicable token in the margin
				a_line.start
				curr_token := a_line.item
				margin_area.set_background_color (editor_preferences.margin_background_color)
				debug ("editor")
					draw_flash (x, y, width, text_panel.line_height, False)
				end
				margin_area.clear_rectangle (
						x,
						y,
						width,
						text_panel.line_height
					)
 			until
 				a_line.after or else not curr_token.is_margin_token
 			loop
				if curr_token.is_margin_token then
					if attached {EDITOR_TOKEN_LINE_NUMBER} curr_token as l_num_token then
						if line_numbers_visible then
							l_num_token.display (y, margin_area, text_panel)
						else
							l_num_token.hide
						end
					end
				end
				a_line.forth
				curr_token := a_line.item
			end
			margin_area.set_background_color (separator_color)
			margin_area.clear_rectangle (width - separator_width, y, separator_width, editor_preferences.line_height)
			margin_area.set_background_color (editor_preferences.margin_background_color)
		end

 	draw_flash (x, y, a_width, height: INTEGER; buffered: BOOLEAN)
 			--
 		do
 			if buffered then
 				margin_area.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (200, 20, 20))
 			else
 				margin_area.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (20, 20, 200))
 			end
 			margin_area.clear_rectangle (x, y, 1000, height)
 			ev_application.sleep (50)
 			margin_area.set_background_color (editor_preferences.margin_background_color)
 		end

	on_paint: BOOLEAN

feature {NONE} -- Implementation

	text_displayed_type: TEXT
			-- Type of `text_panel.text_displayed'.
		do
			check should_not_be_called: False end
			Result := text_panel.text_displayed
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class MARGIN_WIDGET
