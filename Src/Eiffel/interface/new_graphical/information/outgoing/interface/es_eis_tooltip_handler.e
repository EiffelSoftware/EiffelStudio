note
	description: "EIS tooltip handler"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIS_TOOLTIP_HANDLER

inherit
	ANY

	ES_TOOLTIP_HANDLER
		redefine
			show_tooltip_possible,
			hide_tooltip
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

feature -- Operation

	hide_tooltip
			-- <Precuror>
		do
			Precursor
			last_context := Void
		end

feature -- Query

	show_tooltip_possible (a_token: detachable EDITOR_TOKEN): BOOLEAN
			-- Is it possible to show tooltip?
		do
			Result := attached {EIS_LINK_STONE} a_token.pebble
		end

	visit_eis_resource (a_token: EDITOR_TOKEN)
			-- Visit resource attached to `a_token'.
		do
			if attached {EIS_LINK_STONE} a_token.pebble as l_pebble then
				if attached l_pebble.link as l_context then
					show_help (l_context)
				end
			end
		end

	show_hint_tooltip  (a_token: EDITOR_TOKEN; a_x, a_y: INTEGER)
			-- Visit resource attached to `a_token'.
		local
			l_tooltip_window: like tooltip
			l_widget: like create_tooltip_widget
			l_rec: EV_RECTANGLE
			l_screen: EV_SCREEN
			l_pointer: EV_COORDINATE
		do
			create l_screen
			if attached {EIS_LINK_STONE} a_token.pebble as l_pebble then
				if
					attached {ES_EIS_ENTRY_HELP_CONTEXT} l_pebble.link as l_context and then
					last_context /= l_context
				then
					l_tooltip_window := tooltip
					l_widget := create_hint_tooltip_widget
					last_context := l_context
					l_tooltip_window.set_popup_widget (l_widget)

					if attached show_position_callback as l_c and then attached l_c.item ([a_x, a_y]) as l_p then
						create l_rec.make (l_p.x, l_p.y, 0, 0)
					else
						create l_rec.make (l_pointer.x, l_pointer.y, 0, 0)
					end

					l_tooltip_window.show_on_side (l_rec, 0, 0)
				end
			end
		end

feature {NONE} -- Implementation

	show_tooltip (a_token: EDITOR_TOKEN)
			-- Show debug tooltip
		local
			l_tooltip_window: like tooltip
			l_widget: like create_tooltip_widget
			l_rec: EV_RECTANGLE
			l_screen: EV_SCREEN
			l_pointer: EV_COORDINATE
		do
			create l_screen
			l_pointer := l_screen.pointer_position
				-- Ensure expression has not been changed under the mouse pointer.
			if attached {EIS_LINK_STONE} a_token.pebble as l_pebble then
				if
					attached {ES_EIS_ENTRY_HELP_CONTEXT} l_pebble.link as l_context and then
					(last_context /= l_context or else not attached tooltip as l_tooltip or else
					not l_tooltip.is_shown)
				then
					l_tooltip_window := tooltip
					l_widget := create_tooltip_widget (l_context)
					last_context := l_context
					l_tooltip_window.set_popup_widget (l_widget)

					if attached show_position_callback as l_c and then attached l_c.item ([l_pointer.x, l_pointer.y]) as l_p then
						create l_rec.make (l_p.x, l_p.y, 0, 0)
					else
						create l_rec.make (l_pointer.x, l_pointer.y, 0, 0)
					end

					l_tooltip_window.show_on_side (l_rec, 0, 0)
				end
			end
		end

	create_tooltip_widget (a_context: ES_EIS_ENTRY_HELP_CONTEXT): EV_VERTICAL_BOX
			-- Create object grid
		require
			a_context_not_void: a_context /= Void
		local
			l_label: EV_LINK_LABEL
			l_browser_context: ES_EIS_ENTRY_HELP_CONTEXT
			l_sep: EV_VERTICAL_SEPARATOR
			l_hbox: EV_HORIZONTAL_BOX
		do
			create Result
			extend_padding (Result, True)

			create l_hbox
			Result.extend (l_hbox)

			extend_padding (l_hbox, False)

			create l_label.make_with_text (interface_names.b_open)
			create l_browser_context.make_from_other (a_context)
			l_browser_context.set_is_shown_in_es (a_context.is_http_link and then a_context.is_web_browser_tool_usable)
			l_label.select_actions.extend (agent show_help (l_browser_context))
			l_hbox.extend (l_label)
			setup_pointer_actions (l_label)

			extend_padding (l_hbox, False)

			if a_context.is_http_link and then a_context.is_web_browser_tool_usable then
				create l_sep
				l_hbox.extend (l_sep)
				setup_pointer_actions (l_sep)

				extend_padding (l_hbox, False)

				create l_browser_context.make_from_other (a_context)
				l_browser_context.set_is_shown_in_es (False)
				create l_label.make_with_text (interface_names.m_open_in_brower)
				l_label.select_actions.extend (agent show_help (l_browser_context))
				l_hbox.extend (l_label)
				setup_pointer_actions (l_label)

				extend_padding (l_hbox, False)
			end

			extend_padding (Result, True)

			color_propogator.propagate_colors (Result, Void, background_color, Void)
		ensure
			Result_not_void: Result /= Void
		end

	create_hint_tooltip_widget: EV_VERTICAL_BOX
			-- Create hint tooltip
		local
			l_label: EV_LABEL
			l_hbox: EV_HORIZONTAL_BOX
		do
			create Result
			extend_padding (Result, True)

			create l_hbox
			Result.extend (l_hbox)

			extend_padding (l_hbox, False)

			create l_label.make_with_text (interface_names.l_press_ctrl_enter_to_open)
			l_label.set_foreground_color (hint_text_color)
			l_label.set_font (hint_text_font)
			l_hbox.extend (l_label)

			extend_padding (l_hbox, False)

			extend_padding (Result, True)

			color_propogator.propagate_colors (Result, Void, background_color, Void)
		end

	extend_padding (a_list: EV_BOX; a_vertical: BOOLEAN)
			-- Extend padding
		local
			l_padding: EV_CELL
		do
			create l_padding
			if a_vertical then
				l_padding.set_minimum_height ({ES_UI_CONSTANTS}.label_vertical_padding)
			else
				l_padding.set_minimum_width ({ES_UI_CONSTANTS}.label_horizontal_padding)
			end
			l_padding.set_background_color (background_color)
			a_list.extend (l_padding)
			a_list.disable_item_expand (l_padding)
			setup_pointer_actions (l_padding)
		end

	show_help (a_context: HELP_CONTEXT_I)
			-- Show help
		do
			hide_tooltip
			if attached (create {SERVICE_CONSUMER [HELP_PROVIDERS_S]}).service as s then
				s.show_help (a_context)
			end
		end

	hint_text_color: EV_COLOR
			-- Text color of the hint
		local
			l_stock: EV_STOCK_COLORS
		once
			create l_stock
			Result := l_stock.dark_gray
		end

	hint_text_font: EV_FONT
			-- Text color of the hint
		local
			l_label: EV_LABEL
		once
			create l_label
			Result := l_label.font
			Result.set_shape ({EV_FONT_CONSTANTS}.Shape_italic)
		end

	background_color: EV_COLOR
			-- Background color
		local
			l_stock: EV_STOCK_COLORS
		once
			create l_stock
			Result := l_stock.white
		end

	color_propogator: ES_COLOR_PROPAGATOR
			-- Color propogator
		once
			create Result
		end

	last_context: detachable HELP_CONTEXT_I;
			-- Last context to show the tooltip

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
