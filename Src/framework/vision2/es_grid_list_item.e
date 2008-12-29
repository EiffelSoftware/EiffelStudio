note
	description: "Grid item in which a list of components can be displayed"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_GRID_LIST_ITEM

inherit
	EV_GRID_DRAWABLE_ITEM
		redefine
			initialize
		end

	ES_GRID_LISTABLE_ITEM
		undefine
			copy,
			default_create
		end

feature{NONE} -- Initialization

	initialize
			-- Initialize Current
		do
			Precursor
			initialize_item
			set_component_padding (default_padding)
			expose_actions.extend (agent perform_redraw)
			setting_change_actions.extend (agent safe_redraw)
		end

feature -- Access

	grid_item: EV_GRID_ITEM
			-- Grid item
		do
			Result := Current
		end

	pebble_at_position: ANY
			-- Pebble at pointer position
			-- Void if no pebble found at that position
		local
			l_component_index: INTEGER
			l_component: like component
			l_pointer_position: EV_COORDINATE
			l_component_position: EV_RECTANGLE
		do
			if is_component_pebble_enabled then
				l_component_index := component_index_at_pointer_position
				if l_component_index > 0 and then l_component_index <= component_count and then l_component_index <= component_position.count then
					l_component := component (l_component_index)
					l_pointer_position := relative_pointer_position (grid_item)
					l_component_position := component_position.i_th (l_component_index)
					Result := l_component.pebble_at_position (l_pointer_position.x - l_component_position.x, l_pointer_position.y - l_component_position.y)
				end
			end
		end

feature -- Actions

	on_pick: ANY
			-- Action to be performed when pick starts
			-- Return value is the picked pebble if any.
		do
			if is_component_pebble_enabled then
				set_last_picked_item (component_index_at_pointer_position)
				if last_picked_item > 0 then
					Result := pick_component (last_picked_item)
					if Result = Void then
						set_last_picked_item (0)
					end
					safe_redraw
				end
			end
		end

	on_pick_ends
			-- Action to be performed when pick-and-drop finishes
		do
			if is_component_pebble_enabled and then last_picked_item > 0 and then last_picked_item <= component_count then
				component (last_picked_item).on_pick_ended
				safe_redraw
			end
		end

feature{NONE} -- Implementation

	required_dimension_for_items: TUPLE [width, height: INTEGER]
			-- Required dimension in pixels for `items'
		local
			l_items: like components
			l_item: like component_type
			l_count: INTEGER
			i: INTEGER
			l_width, l_height: INTEGER
			l_item_height: INTEGER
			l_padding: INTEGER
		do
			from
				l_padding := component_padding
				l_items := components
				l_count := l_items.count
				i := 1
				l_items.start
			until
				l_items.after
			loop
				l_item := l_items.item
				l_width := l_width + l_item.required_width
				if i < l_count then
					l_width := l_width + l_padding
				end
				l_item_height := l_item.required_height
				if l_item_height > l_height then
					l_height := l_item_height
				end
				l_items.forth
				i := i + 1
			end
			l_width := l_width + left_border + right_border + border_line_width * 2
			l_height := l_height + top_border + bottom_border + border_line_width * 2
			Result := [l_width, l_height]
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Implementation/Redraw

	perform_redraw (a_drawable: EV_DRAWABLE)
			-- Redraw Current
		require
			a_drawable_attached: a_drawable /= Void
		do
			display (a_drawable, is_selected, parent.has_focus)
		end

	safe_redraw
			-- Redraw Current if parented
		do
			set_required_width (required_dimension_for_items.width)
			if is_parented then
				redraw
			end
		end

	prepare_background_area (a_drawable: EV_DRAWABLE; a_x, a_y, a_width, a_height: INTEGER)
			-- Prepare area in `a_drawable' for drawing current item.
			-- i.e., clean area and draw background and draw borders.
		require
			a_drawable_attached: a_drawable /= Void
		local
			l_parent: EV_GRID
		do
			l_parent := parent
			if is_selected then
				if l_parent.has_focus then
					a_drawable.set_foreground_color (l_parent.focused_selection_color)
				else
					a_drawable.set_foreground_color (l_parent.non_focused_selection_color)
				end
			else
				if background_color /= Void then
					a_drawable.set_foreground_color (background_color)
				elseif row.background_color /= Void then
					a_drawable.set_foreground_color (row.background_color)
				else
					a_drawable.set_foreground_color (parent.background_color)
				end
			end
			a_drawable.fill_rectangle (a_x, a_y, a_width, a_height)
		end

	display (a_drawable: EV_DRAWABLE; a_selected: BOOLEAN; a_focused: BOOLEAN)
			-- Display Current in `a_drawable'.
		require
			a_drawable_attached: a_drawable /= Void
		local
			x, y: INTEGER
			l_left_width, l_left_height: INTEGER
			l_max_width, l_max_height: INTEGER
			l_items: like components
			l_required_width: INTEGER
			l_required_height: INTEGER
			l_item_width: INTEGER
			l_item: like component_type
			i: INTEGER
			l_count: INTEGER
			l_padding: INTEGER
			l_required_dimension: like required_dimension_for_items
			l_positions: like component_position
		do
			prepare_background_area (a_drawable, 0, 0, width, height)
			l_left_width := (width - left_border - right_border - border_line_width * 2).max (1)
			l_left_height := (height - top_border - bottom_border - border_line_width * 2).max (1)
			l_required_dimension := required_dimension_for_items
			l_required_width := l_required_dimension.width
			l_required_height := l_required_dimension.height

			x := left_border + border_line_width
			if is_center_aligned then
				x := x + ((l_left_width - l_required_width).max (0)) // 2
			elseif is_right_aligned then
				x := x + (l_left_width - l_required_width).max (0)
			end
			y := top_border + border_line_width
			if is_vertically_center_aligned then
				y := y + ((l_left_height - l_required_height).max (0)) // 2
			elseif is_bottom_aligned then
				y := y + (l_left_height - l_required_height).max (0)
			end
			l_padding := component_padding
			l_max_height := (l_left_height - y).max (1)
			l_max_width := (l_left_width - x).max (1)
			from
				l_items := components
				l_count := l_items.count
				i := 1
				l_positions := component_position
				l_positions.wipe_out
				l_items.start
			until
				l_items.after or l_max_width = 0
			loop
				l_item := l_items.item
				l_item.display (a_drawable, x, y, l_max_width, l_max_height)
				l_item_width := (l_item.required_width).min (l_max_width)
				l_positions.extend (create {EV_RECTANGLE}.make (x, y, l_item_width, l_max_height))
				if i < l_count then
					l_max_width := (l_max_width - l_item_width - l_padding).max (0)
				end
				x := x + l_item_width + l_padding
				l_items.forth
				i := i + 1
			end
		end

	default_padding: INTEGER = 10
			-- Default padding in pixel

invariant
	displayed_item_position_attached: component_position /= Void

note
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
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
