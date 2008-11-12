indexing
	description: "Object that represents a tooltip in which drop-and-pickable editor tokens are displayed"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_EDITOR_TOKEN_TOOLTIPABLE

inherit
	EVS_GENERAL_TOOLTIPABLE
		redefine
			set_tooltip_maximum_width,
			set_tooltip_maximum_height,
			set_tooltip_maximum_size,
			tooltip_widget
		end

	EB_EDITOR_TOKEN_TEXT
		rename
			set_tokens as set_tooltip_text
		export
			{NONE}all
			{ANY}
				enable_text_wrap,
				disable_text_wrap,
				set_overriden_font,
				remove_overriden_font,
				set_overriden_line_height,
				remove_overriden_line_height,
				is_overriden_font_set,
				is_overriden_line_height_set,
				is_text_wrap_enabled
		redefine
			set_tooltip_text
		end

	EVS_BORDERED
		export
			{NONE} all
			{ANY}
				set_border_line_color,
				set_border_line_width,
				set_left_border,
				set_right_border,
				set_top_border,
				set_bottom_border
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

feature -- Access

	required_tooltip_width: INTEGER is
			-- Required width in pixel to display tooltip
			-- If `max_tooltip_width' is larger than this, `max_tooltip_width' will be used when
			-- tooltip is displayed.
		do
			Result := required_width + border_line_width * 2 + left_border + right_border
		end

	required_tooltip_height: INTEGER is
			-- Required height in pixel to display tooltip
			-- If `max_tooltip_height' is larger than this, `max_tooltip_height' will be used when
			-- tooltip is displayed.
		do
			Result := required_height + border_line_width * 2 + top_border + bottom_border
		end

feature -- Setting

	set_tooltip_text (a_tokens: LIST [EDITOR_TOKEN]) is
			-- Set `tokens' with `a_tokens'.
			-- If `a_tokens' is Void or an empty list, this feature will disable tooltip after set `tokens' with an empty editor token list.
		require else
			True
		do
			if a_tokens = Void or else a_tokens.is_empty then
				Precursor (create{ARRAYED_LIST [EDITOR_TOKEN]}.make (0))
			else
				Precursor (a_tokens)
			end
		end

	set_tooltip_maximum_width (a_width: INTEGER) is
			-- Set `maximum_width' with `a_width'.
		do
			lock_update
			max_tooltip_width := a_width
			set_maximum_width (max_tooltip_width - left_border - border_line_width * 2 - right_border)
			unlock_update
			try_call_setting_change_actions
		end

	set_tooltip_maximum_height (a_height: INTEGER) is
			-- Set `maximum_height' with `a_height'.
		do
			lock_update
			max_tooltip_height := a_height
			set_maximum_height (max_tooltip_height - top_border - border_line_width * 2 - bottom_border)
			unlock_update
			try_call_setting_change_actions
		end

	set_tooltip_maximum_size (a_width: INTEGER; a_height: INTEGER) is
			-- Set `maximum_width' with `a_width' and `maximum_height' with `a_height'.
		do
			lock_update
			max_tooltip_width := a_width
			max_tooltip_height := a_height
			set_maximum_size (
				max_tooltip_width - left_border - border_line_width * 2 - right_border,
				max_tooltip_height - top_border - border_line_width * 2 - bottom_border)
			unlock_update
			try_call_setting_change_actions
		end

feature{NONE} -- Token position

	last_picked_item_index: INTEGER
			-- Index of last picked item in `token_tooltip'

	set_last_picked_item_index (a_index: INTEGER) is
			-- Set `last_picked_item_index' with `a_index'.
		require
		do
			last_picked_item_index := a_index
		ensure
			last_picked_item_index_set: last_picked_item_index = a_index
		end

feature{NONE} -- Implementation

	tooltip_widget: EV_WIDGET is
			-- Widget of current tooltip
		do
			if drawing_area = Void then
				create drawing_area
				drawing_area.expose_actions.extend (agent redraw_tooltip_portion)
				drawing_area.set_pebble_function (agent editor_token_pebble_at_position)
				drawing_area.pick_actions.extend (agent on_pick_start)
				drawing_area.pick_ended_actions.extend (agent on_pick_end)
				setting_change_actions.extend (agent adjust_tooltip_layout (True))
				adjust_tooltip_layout (False)
			end
			Result := drawing_area
		end

feature{NONE} -- Implementation

	drawing_area: EV_DRAWING_AREA
			-- Drawing area to draw tooltip

	actual_tooltip_width: INTEGER is
			-- Actual width in pixel of tooltip
		local
			l_max, l_required: INTEGER
		do
			l_max := max_tooltip_width
			l_required := required_tooltip_width
			if l_max > 0 and then l_max < l_required then
				Result := max_tooltip_width
			else
				Result := required_tooltip_width
			end
		end

	actual_tooltip_height: INTEGER is
			-- Actual height in pixel of tooltip
		local
			l_max, l_required: INTEGER
		do
			l_max := max_tooltip_height
			l_required := required_tooltip_height
			if l_max > 0 and then l_max < l_required then
				Result := l_max
			else
				Result := required_tooltip_height
			end
		end

	editor_token_pebble_at_position (x, y: INTEGER): ANY is
			-- Pebble of editor token at position (x, y).
			-- Return Void if no token is available at position (x, y).
		require
			tooltip_enabled: is_tooltip_enabled
			tooltip_displayed: is_my_tooltip_displayed
		local
			l_index: INTEGER
		do
			l_index := token_index_at_position (x, y)
			if l_index > 0 then
				Result := pebble (l_index)
				if Result /= Void then
					set_last_picked_item_index (l_index)
				end
			end
		end

	on_pick_start (x, y: INTEGER) is
			-- Action to be performed when pick from tooltip window starts
		require
			tooltip_enabled: is_tooltip_enabled
			tooltip_displayed: is_my_tooltip_displayed
		local
			l_region: EV_RECTANGLE
			l_stone: STONE
		do
			set_picking_from_tooltip (True)
			if last_picked_item_index > 0 then
					-- Set pointer cursor in picking mode.
				l_stone ?= pebble (last_picked_item_index)
				if l_stone /= Void then
					drawing_area.set_accept_cursor (l_stone.stone_cursor)
					drawing_area.set_deny_cursor (l_stone.x_stone_cursor)
				end
					-- Redraw picked token in its selected status.
				l_region := token_position.i_th (last_picked_item_index)
				redraw_tooltip_portion (l_region.x, l_region.y, l_region.width, l_region.height)
			end
		end

	on_pick_end (a_pickable: EV_ABSTRACT_PICK_AND_DROPABLE) is
			-- Action to be performed when pick from tooltip ends
		require
			tooltip_enabled: is_tooltip_enabled
			tooltip_displayed: is_my_tooltip_displayed
		local
			l_region: EV_RECTANGLE
		do
			set_picking_from_tooltip (False)
			if last_picked_item_index > 0 then
				l_region := token_position.i_th (last_picked_item_index)
				set_last_picked_item_index (0)
				redraw_tooltip_portion (l_region.x, l_region.y, l_region.width, l_region.height)
			else
				redraw_tooltip_portion (0, 0, drawing_area.width, drawing_area.height)
			end
		ensure
			last_picked_item_index_reset: last_picked_item_index = 0
		end

	adjust_tooltip_layout (should_redraw: BOOLEAN) is
			-- Adjust tooltip layout according to changes such as border color/width, maximum height/width...
			-- If `should_redraw' is True, redraw whole tooltip region after adjustment.
		do
			lock_update
			set_x_y_offset (border_line_width + left_border, border_line_width + top_border)
			unlock_update
			if drawing_area /= Void then
				drawing_area.set_minimum_size (actual_tooltip_width, actual_tooltip_height)
				if should_redraw and then drawing_area.is_displayed then
					redraw_tooltip_portion (0, 0, drawing_area.width, drawing_area.height)
				end
			end
		end

	redraw_tooltip_portion (x, y, a_width, a_height: INTEGER) is
			-- Redraw tooltip portion in region defined by `x', `y', `a_width' and `a_height'.
		local
			l_editor_bg_color, l_editor_fg_color: EV_COLOR
		do
			l_editor_bg_color := preferences.editor_data.normal_background_color
			l_editor_fg_color := preferences.editor_data.normal_text_color
				-- Clear area that needs redraw.
			if l_editor_bg_color.is_equal (white) then
				drawing_area.set_background_color (actual_tooltip_background_color)
			else
				drawing_area.set_background_color (l_editor_bg_color)
			end

			drawing_area.clear_rectangle (x, y, a_width, a_height)

				-- Redraw tooltip border
			drawing_area.set_foreground_color (l_editor_fg_color)
			drawing_area.set_line_width (border_line_width)
			drawing_area.draw_rectangle (0, 0, drawing_area.width, drawing_area.height)

				-- Redraw tooltip text
			display_within_region (x, y, a_width, a_height, drawing_area, last_picked_item_index, True)
		end

	white: EV_COLOR
			-- White
		once
			Result := (create {EV_STOCK_COLORS}).white
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

end
