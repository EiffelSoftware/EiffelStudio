note
	description: "Selectable editor token grid item."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GRID_EDITOR_ITEM

inherit
	EB_GRID_EDITOR_TOKEN_ITEM
		redefine
			activate_action,
			deactivate,
			initialize
		end

create
	default_create,
	make_with_text

feature -- Access

	editor: detachable EB_GRID_EDITOR
		-- Editor used to display `Current' on `activate'.
		-- Void when `Current' isn't being activated.

	viewport: detachable EV_VIEWPORT
		-- Viewport to hold the editor.

feature -- Action

	deactivate
			-- Cleanup from previous call to activate.
		do
			if not is_destroyed and then is_parented then
				Precursor {EB_GRID_EDITOR_TOKEN_ITEM}
						--| FIXME: On Unix, we postpone the editor recycling until next deactivation to avoid crash.
						--| This is an issue of Vision2, that context menus triggers focus out actions.
						--| See bug#15261 and bug#15841.
				if {PLATFORM}.is_windows then
					if editor /= Void then
						editor.recycle
						editor := Void
					end
					if viewport /= Void then
						viewport.destroy
						viewport := Void
					end
				else
					if attached unrecycled_editor.item as l_editor then
						l_editor.recycle
					end
					unrecycled_editor.replace (editor)
				end
			end
		end

feature {NONE} -- Initialization

	initialize
			-- <precursor>
		do
			Precursor {EB_GRID_EDITOR_TOKEN_ITEM}
			pointer_button_press_actions.extend (agent conditional_activate)
		end

feature {NONE} -- Implementation

	conditional_activate (x_pos, y_pos, button: INTEGER; unused1, unused2, unused3: DOUBLE; a_screen_x, a_screen_y:INTEGER)
			-- Activate when item has been selected.
		do
			if is_selected and then button = 1 then
				activate
			end
		end

	update_popup_dimensions (a_popup: attached EV_POPUP_WINDOW)
			-- Update dimensions and positioning for `a_popup'.
		local
			l_x_offset: INTEGER
			l_width, l_height: INTEGER
			l_widget_y_offset: INTEGER
			l_widget: EV_WIDGET
			l_hidden_upper, l_hidden_lower: INTEGER
		do
			l_widget := a_popup.item
				-- Account for position of text relative to pixmap.
			l_x_offset := 1 -- Segment width
			if pixmap /= Void then
				l_x_offset := l_x_offset + pixmap.width + spacing
			end

			l_width := a_popup.width - l_x_offset
			l_height := height - 2

			l_widget_y_offset := vertical_starting_position (editor_token_text.required_height, alignment_index, True) - 1

			l_widget.set_minimum_width (0)

			l_hidden_upper := (parent.virtual_y_position - virtual_y_position).max (0)
			l_hidden_lower := (virtual_y_position + height - (parent.virtual_y_position + parent.viewable_height)).max (0)

			a_popup.set_x_position (a_popup.x_position + l_x_offset)
			a_popup.set_width (l_width)
			a_popup.set_y_position (a_popup.y_position + l_widget_y_offset + l_hidden_upper)
			a_popup.set_height (l_height - l_hidden_upper - l_hidden_lower)

			viewport.set_y_offset (l_hidden_upper)
		end

	handle_key (a_key: EV_KEY)
			-- Handle the Escape key for cancelling activation.
		require
			a_key_not_void: a_key /= Void
		do
			if a_key.code = {EV_KEY_CONSTANTS}.key_escape then
				deactivate
			end
		end

	activate_action (popup_window: EV_POPUP_WINDOW)
			-- `Current' has been requested to be updated via `popup_window'.
		do
			create editor.make (Void)
				-- one pixel of the separator which is the width of segment.
			editor.set_left_margin_width (left_border - 1)
			editor.set_fonts (label_font_table)
			editor.set_line_height (editor_token_text.actual_line_height)
			check editor_font_set: editor.font /= Void end
			editor.set_font_offset (editor.font.height - 1)
			editor.set_display_scrollbars (False)
			editor.set_auto_scroll (False)
			editor.disable_line_numbers

			editor_token_text.display_on_editor (editor)
			editor.set_read_only (True)

			create viewport
			popup_window.extend (viewport)
			viewport.extend (editor.widget)
			viewport.set_item_size (popup_window.client_width, popup_window.client_height)

				-- Change `popup_window' to suit `Current'.
			update_popup_dimensions (popup_window)

			popup_window.show_actions.extend (agent initialize_actions)
		end

	initialize_actions
			-- Setup the action sequences when the item is shown.
		do
			editor.editor_drawing_area.focus_out_actions.extend (agent deactivate)
			editor.editor_drawing_area.key_press_actions.extend (agent handle_key)
			editor.editor_drawing_area.set_focus
		end

feature {NONE} -- Work around

	unrecycled_editor: CELL [detachable EB_GRID_EDITOR]
		once
			create Result.put (Void)
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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

end
