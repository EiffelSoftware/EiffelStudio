note
	description: "Objects that represents a span grid label."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_EDITABLE_SPAN_LABEL_ITEM

inherit
	EV_GRID_SPAN_LABEL_ITEM
		redefine
			activate_action,
			deactivate
		end

create
	make_span, make_master

feature -- Element change

	set_text_validation_agent (a_validation_agent: FUNCTION [ANY, TUPLE [STRING_32], BOOLEAN])
			-- Set the agent that validates the text of `text_field' on `deactivate'.
			-- If `a_validation_agent' is Void then no validation is performed before setting `text'.
		do
			validation_agent := a_validation_agent
		ensure
			validation_agent_set: validation_agent = a_validation_agent
		end

feature -- Access

	validation_agent: detachable FUNCTION [ANY, TUPLE [STRING_32], BOOLEAN]
		-- Agent used to validate `text_field' text.


	text_field: detachable EV_TEXT_FIELD
		-- Text field used to edit `Current' on `activate'.
		-- Void when `Current' isn't being activated.

feature -- Action

	deactivate
			-- Cleanup from previous call to activate.
		do
			if attached text_field as l_text_field then
				l_text_field.focus_out_actions.wipe_out
				if not user_cancelled_activation and then (validation_agent = Void or else (attached validation_agent as l_validation_agent and then l_validation_agent.item ([l_text_field.text]))) then
					set_text (l_text_field.text)
				end
			end
			Precursor {EV_GRID_SPAN_LABEL_ITEM}
			if attached text_field as l_text_field then
				l_text_field.destroy
				text_field := Void
			end
		end

feature {NONE} -- Implementation

	update_popup_dimensions (a_popup: EV_POPUP_WINDOW)
			-- Update dimensions and positioning for `a_popup'.
		require
			a_popup_not_void: a_popup /= Void
		local
			l_x_coord: INTEGER
			l_parent: like parent
			l_first, l_last: detachable EV_GRID_SPAN_LABEL_ITEM
			i: INTEGER
			x_coord, y_coord: INTEGER
			a_screen_x, a_screen_y: INTEGER
			a_width, boundary_x, item_width, item_height: INTEGER
			x_delta: INTEGER
		do
				-- Account for position of text relative to pixmap.

			l_parent := parent
			check l_parent /= Void end

			if attached row as l_row then
				from
					i := 1
				until
					i > l_row.count
				loop
					if attached {EV_GRID_SPAN_LABEL_ITEM} l_row.item (i) as l_item then
						if l_item.is_displayed then
							if l_first = Void then
								l_first := l_item
							else
								l_last := l_item
							end
						end
					end
					i := i + 1
				end
				if l_first /= Void and l_last /= Void then
					a_screen_x := l_parent.screen_x
					a_screen_y := l_parent.screen_y
					x_coord := a_screen_x - l_parent.virtual_x_position + l_first.virtual_x_position
					if x_coord < a_screen_x then
						x_delta := a_screen_x - x_coord
						x_coord := a_screen_x
					end
					y_coord := a_screen_y - l_parent.virtual_y_position + l_first.virtual_y_position + l_parent.viewable_y_offset

					boundary_x := a_screen_x + l_parent.width
					if l_parent.vertical_scroll_bar.is_displayed then
						boundary_x := boundary_x - l_parent.vertical_scroll_bar.width
					end
					if l_parent.is_row_height_fixed then
						item_height := l_parent.row_height
					else
						item_height := l_row.height
					end
						-- Set default size and position.
					a_width := (l_last.virtual_x_position + l_last.width - l_first.virtual_x_position).max (0)
					item_width := a_width - x_delta
					if x_coord + item_width > boundary_x then
							-- If column extends beyond the visible part of the grid, the size of the activate_window is clipped.
						item_width := boundary_x - x_coord
					end

					a_popup.set_position (x_coord, y_coord)
					a_popup.set_size (item_width, item_height)
				end
			end
		end

	handle_key (a_key: EV_KEY)
			-- Handle the Escape key for cancelling activation.
		require
			a_key_not_void: a_key /= Void
		do
			if a_key.code = {EV_KEY_CONSTANTS}.key_escape then
				user_cancelled_activation := True
				deactivate
			end
		end

	user_cancelled_activation: BOOLEAN
		-- Did the user cancel the activation using the Esc key?

	activate_action (popup_window: EV_POPUP_WINDOW)
			-- `Current' has been requested to be updated via `popup_window'.
		local
			l_text_field: like text_field
			l_bg_color: EV_COLOR
		do
			create l_text_field
			text_field := l_text_field
				-- Hide the border of the text field.
			l_text_field.implementation.hide_border
			if attached font as l_font then
				l_text_field.set_font (l_font)
			end

			l_text_field.set_text (text)

			l_bg_color := implementation.displayed_background_color
			l_text_field.set_background_color (l_bg_color)
			popup_window.set_background_color (l_bg_color)
			l_text_field.set_foreground_color (implementation.displayed_foreground_color)

			popup_window.extend (l_text_field)
				-- Change `popup_window' to suit `Current'.
			update_popup_dimensions (popup_window)

			popup_window.show_actions.extend (agent initialize_actions)
		end

	initialize_actions
			-- Setup the action sequences when the item is shown.
		local
			l_text_field: detachable like text_field
		do
			l_text_field := text_field
			check l_text_field /= Void end
			l_text_field.return_actions.extend (agent deactivate)
			l_text_field.focus_out_actions.extend (agent deactivate)
			l_text_field.set_focus
			user_cancelled_activation := False
			l_text_field.key_press_actions.extend (agent handle_key)
		end

invariant
	text_field_parented_during_activation: attached text_field as l_text_field implies l_text_field.parent /= Void

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

end
