indexing
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
			line_numbers_visible,
			user_initialization,
			width,
			text_displayed_type
		end

feature -- Initialization

	user_initialization is
			-- Build margin drawable area
		do
			Precursor {MARGIN_WIDGET}
			margin_area.pointer_button_press_actions.extend (agent on_mouse_button_down)
			hide_breakpoints
		end

feature -- Graphical Interface

	text_panel: EB_CLICKABLE_EDITOR
			-- The text panel/editor to which Current is anchored

feature -- Status Setting

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

feature -- Access

	width: INTEGER is
			-- Width in pixels calculated based on which tokens should be displayed
		local
			l_bptok: EDITOR_TOKEN_BREAKPOINT
		do
		    Result := Precursor
			if not hidden_breakpoints then
				create l_bptok.make
				Result := Result + l_bptok.width + separator_width
			end
		end

	hidden_breakpoints: BOOLEAN
			-- Are breakpoints hidden? (Default: True)	

feature -- Query

	line_numbers_visible: BOOLEAN is
			-- Are line numbers hidden?
		do
		    Result := Precursor
		end

feature {NONE} -- Implementation

	draw_line_to_screen (x, y: INTEGER; a_line: EIFFEL_EDITOR_LINE; xline: INTEGER) is
			-- Update display by drawing `line' onto the `editor_drawing_area' directly at co-ordinates x,y.
		local
 			curr_token	: EDITOR_TOKEN
 			line_token  : EDITOR_TOKEN_LINE_NUMBER
 			bp_token: EDITOR_TOKEN_BREAKPOINT
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
 			line_token ?= a_line.number_token
			if line_token /= Void then
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
					bp_token ?= curr_token
					if bp_token /= Void and then not hidden_breakpoints then
						bp_token.display (y, margin_area, text_panel)
					elseif bp_token /= Void then
						bp_token.hide
					else
						line_token ?= curr_token
						if line_token /= Void and then line_numbers_visible then
							if not hidden_breakpoints then
								line_token.display_with_offset (a_line.breakpoint_token.width, y, margin_area, text_panel)
							else
								line_token.display (y, margin_area, text_panel)
							end
						elseif line_token /= Void then
							line_token.hide
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

feature {NONE} -- Events

	on_mouse_button_down (abs_x_pos, y_pos, button: INTEGER; unused1,unused2,unused3: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Process single click on mouse buttons.			
		local
			ln: EIFFEL_EDITOR_LINE
			l_number: INTEGER
			bkstn: BREAKABLE_STONE
		do
			if button = 1 then
				l_number := (y_pos - margin_viewport.y_offset + (first_line_displayed * text_panel.line_height)) // text_panel.line_height

				if l_number <= text_panel.number_of_lines then
					ln ?= text_panel.text_displayed.line (l_number)
					bkstn ?= ln.real_first_token.pebble
					if bkstn /= Void then
						bkstn.toggle_bkpt
					end
					text_panel.on_mouse_button_down (abs_x_pos, y_pos, 1, 0, 0, 0, a_screen_x, a_screen_y)
				end
			elseif button = 3 then
				if not text_panel.text_displayed.is_empty then
					text_panel.on_click_in_text (abs_x_pos - width, y_pos, 3, a_screen_x, a_screen_y)
				end
			end
		end

feature {NONE} -- Implementation

	text_displayed_type: CLICKABLE_TEXT is
			-- Type of `text_panel.text_displayed'.
		do
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_CLICKABLE_MARGIN
