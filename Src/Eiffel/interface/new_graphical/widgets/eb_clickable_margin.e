note
	description: "Margin for use in clickable editor.  Unlike EB_MARGIN this can deal with mouse clicks and breakpoints."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLICKABLE_MARGIN

inherit
	MARGIN_WIDGET
		redefine
			draw_line_to_screen,
			text_panel,
			user_initialization,
			width,
			text_displayed_type,
			is_show_requested
		end

feature -- Initialization

	user_initialization
			-- Build margin drawable area
		do
			Precursor {MARGIN_WIDGET}
			margin_area.set_pebble_function (agent pebble_from_x_y)
			margin_area.set_drag_and_drop_mode
			margin_area.drop_actions.extend (agent on_breakable_stone_dropped)

			margin_area.pointer_button_release_actions.extend (agent on_mouse_button_release_event (?, ?, ?, ?, ?, ?, ?, ?))
			hide_breakpoints
		end

feature -- Graphical Interface

	text_panel: EB_CLICKABLE_EDITOR
			-- The text panel/editor to which Current is anchored

feature -- Status Setting

	hide_breakpoints
			-- Do not show breakpoints even if there are some.
		do
			hidden_breakpoints := True
		end

	show_breakpoints
			-- Show breakpoints if there are some.
		do
			hidden_breakpoints := False
		end

feature -- Access

	width: INTEGER
			-- Width in pixels calculated based on which tokens should be displayed
		do
		    Result := Precursor
			if not hidden_breakpoints then
				Result := Result + {EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (breakpoint_token_width) + separator_width
			end
		end

	is_show_requested: BOOLEAN
			-- Is `Current' requested to be visible on screen?
		do
			Result := Precursor or not hidden_breakpoints
		end

	hidden_breakpoints: BOOLEAN
			-- Are breakpoints hidden? (Default: True)

feature {EB_CLICKABLE_MARGIN} -- Pick and drop

	breakpoint_token_width: INTEGER
			-- Width in pixel of the bp token
		local
			l_bptok: EDITOR_TOKEN_BREAKPOINT
		once
			create l_bptok.make
			Result := l_bptok.width
		end

	on_breakable_stone_dropped (a_bp: BREAKABLE_STONE)
		local
			l_line: INTEGER
		do
			l_line := line_at (margin_viewport.pointer_position.y_abs + margin_viewport.y_offset)
			if attached breakable_stone_at_line (l_line) as bp then
				bp.drop_bkpt (a_bp)
				ignore_mouse_button_release_event_at_line (l_line)
				refresh_now
			else
				reset_mouse_button_release_event_ignored_state
			end
		end

	pebble_from_x_y (x_pos_with_margin, abs_y_pos: INTEGER): STONE
			-- Stone on (`x_pos', `y_pos').
			-- Process single click on mouse buttons.			
		local
			bpst: like breakable_stone_at_line
		do
			-- The context menu has to be displayed on button release otherwise it may disappear straight away on mouse click.
			bpst := breakable_stone_at_line (line_at (abs_y_pos))
			if bpst /= Void and then bpst.has_associated_user_breakpoint then
				Result := bpst
			end
		end

	line_at (a_abs_y: INTEGER): INTEGER
			-- Line number at position `(0, a_abs_y)'
		local
			l_line_height: INTEGER
		do
			l_line_height := text_panel.line_height
			Result := (a_abs_y - margin_viewport.y_offset + (first_line_displayed * l_line_height)) // l_line_height
		end

	breakable_stone_at_line (a_line: INTEGER): detachable BREAKABLE_STONE
			-- Breakable stone at position `(a_x, a_y)'
		do
			debug
				print ("breakable_stone_at_line (" + a_line.out + ")%N")
			end
			if a_line <= text_panel.number_of_lines then
				if attached {EIFFEL_EDITOR_LINE} text_panel.text_displayed.line (a_line) as ln then
					Result := {like breakable_stone_at_line} / ln.real_first_token.pebble
				end
			end
		end

feature {NONE} -- Implementation

	draw_line_to_screen (x, y: INTEGER; a_line: EDITOR_LINE; xline: INTEGER)
			-- Update display by drawing `line' onto the `editor_drawing_area' directly at co-ordinates x,y.
		local
 			curr_token	: EDITOR_TOKEN
 			spacer_text: STRING
 			max_chars: INTEGER
 			l_line_numbers_visible: BOOLEAN
 		do
 			l_line_numbers_visible := line_numbers_visible
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

					if attached {EDITOR_TOKEN_BREAKPOINT} curr_token as bp_token then
						if not hidden_breakpoints then
							bp_token.display (y, margin_area, text_panel)
						else
							bp_token.hide
						end
					else
						if attached {EDITOR_TOKEN_LINE_NUMBER} curr_token as line_token then
							if l_line_numbers_visible then
								if not hidden_breakpoints and then attached {EIFFEL_EDITOR_LINE} a_line as l_line then
									line_token.display_with_offset (l_line.breakpoint_token.width, y, margin_area, text_panel)
								else
									line_token.display (y, margin_area, text_panel)
								end
							else
								line_token.hide
							end
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

feature {NONE} -- Events control

	mouse_button_release_event_ignored_line: INTEGER
			-- line where mouse button release event should be ignored

	mouse_button_release_event_ignored_at_line (a_line: INTEGER): BOOLEAN
			-- Ignore mouse button release event if `a_line' is same as `next_mouse_button_release_event_ignored_line'
		do
			Result := mouse_button_release_event_ignored_line = a_line
		end

	ignore_mouse_button_release_event_at_line (a_line: INTEGER)
			-- Ignore mouse button release event at line `a_line'
		do
			mouse_button_release_event_ignored_line := a_line
		end

	reset_mouse_button_release_event_ignored_state
			-- Reset any ignore state of mouse button release event (on any line)
		do
			mouse_button_release_event_ignored_line := 0
		end

feature {NONE} -- Events

	on_mouse_button_release_event (abs_x_pos, y_pos, button: INTEGER; unused1,unused2,unused3: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Process single click on mouse buttons.			
		local
			l_line: INTEGER
			bkstn: BREAKABLE_STONE
		do
				-- The context menu has to be displayed on button release otherwise it may disappear straight away on mouse click.
			if
				abs_x_pos <= margin_viewport.width + 3    --| a tolerance of 3 pixel is ok
			then
				if button = 1 or else button = 3 then
					l_line := line_at (y_pos)
					if not mouse_button_release_event_ignored_at_line (l_line) then
						bkstn := breakable_stone_at_line (l_line)
						if bkstn /= Void then
							if button = 1 then
								bkstn.toggle_bkpt
								text_panel.set_focus
							elseif button = 3 then
								bkstn.display_bkpt_menu
							end
						end
					end
				end
			end
			reset_mouse_button_release_event_ignored_state
		end

feature {NONE} -- Implementation

	text_displayed_type: CLICKABLE_TEXT
			-- Type of `text_panel.text_displayed'.
		do
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EB_CLICKABLE_MARGIN
