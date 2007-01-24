indexing
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

	EVS_TEXT_ALIGNABLE
		undefine
			copy,
			default_create
		end

	EVS_BORDERED
		undefine
			copy,
			default_create
		end

	EVS_TEXT_ALIGNABLE
		undefine
			copy,
			default_create
		end

	EVS_GRID_ITEM_HELPER
		undefine
			copy,
			default_create
		end

feature{NONE} -- Initialization

	initialize is
			-- Initialize Current
		do
			create displayed_item_position.make
			Precursor
			set_padding (default_padding)
			expose_actions.extend (agent perform_redraw)
			setting_change_actions.extend (agent safe_redraw)
		end

feature -- Access

	item (a_index: INTEGER): like item_type is
			-- `a_index'-th item in Current
		require
			a_index_valid: a_index > 0 and then a_index <= item_count
		do
			Result := items.i_th (a_index)
		ensure
			result_attached: Result /= Void
		end

	item_count: INTEGER is
			-- Number of components in Current
		do
			Result := items.count
		end

	item_list: LIST [like item_type] is
			-- List of components
		do
			Result := items.twin
		ensure
			result_attached: Result /= Void
		end

	padding: INTEGER
			-- Spacing in pixels between every two components

feature -- Status report

	is_item_pebble_enabled: BOOLEAN
			-- Does every item have its own pebble?

feature -- Item management

	insert_new_item (a_item: like item_type; a_index: INTEGER) is
			-- Insert component `a_item' at `a_index'-th position.
		require
			a_item_valid: a_item /= Void and then not a_item.is_parented
			a_index_valid: a_index > 0 and then a_index <= item_count + 1
		local
			l_items: like items
		do
			l_items := items
			if a_index > item_count then
				l_items.extend (a_item)
			else
				l_items.go_i_th (a_index)
				l_items.put_left (a_item)
			end
			a_item.set_parent (Current)
			set_required_width (required_dimension_for_items.width)
			safe_redraw
		ensure
			a_item_inserted: items.has (a_item) and then a_item.parent = Current
		end

	append_new_item (a_item: like item_type) is
			-- Append `a_item' at the end of `items'.
		require
			a_item_attached: a_item /= Void
		do
			insert_new_item (a_item, item_count + 1)
		end

	remove_item (a_index: INTEGER) is
			-- Remove component at `a_index'-th position.
		require
			a_index_valid: a_index > 0 and then a_index <= item_count
		local
			l_items: like items
		do
			l_items := items
			l_items.go_i_th (a_index)
			l_items.item.set_parent (Void)
			l_items.remove
			set_required_width (required_dimension_for_items.width)
			safe_redraw
		ensure
			item_removed: item_count = old item_count + 1
		end

	wipe_out is
			-- Wipe out all components
		do
			items.do_all (agent (a_item: like item_type) do a_item.set_parent (Void) end)
			items.wipe_out
			set_required_width (required_dimension_for_items.width)
			safe_redraw
		ensure
			components_wiped_out: item_count = 0
		end

feature -- Setting

	set_padding (a_padding: INTEGER) is
			-- Set `padding' with `a_padding'.
		require
			a_padding_non_negative: a_padding > 0
		do
			padding := a_padding
			safe_redraw
		ensure
			padding_set: padding = a_padding
		end

	enable_item_pebble is
			-- Enable that every item can have its own pebble.
		do
			is_item_pebble_enabled := True
		ensure
			is_item_pebble_enabled: is_item_pebble_enabled
		end

	disable_item_pebble is
			-- Disable that every item can have its own pebble.
		do
			is_item_pebble_enabled := False
		ensure
			is_item_pebble_disabled: not is_item_pebble_enabled
		end

feature -- Actions

	on_pick: ANY is
			-- Action to be performed when pick starts
			-- Return value is the picked pabble if any.
		local
			l_coordinate: EV_COORDINATE
			l_pos: like displayed_item_position
			l_item: like item_type
			l_rec: EV_RECTANGLE
		do
			if is_item_pebble_enabled then
				l_coordinate := relative_pointer_position (Current)
				l_pos := displayed_item_position
				last_picked_item := 0
				if not l_pos.is_empty then
					from
						l_pos.start
					until
						l_pos.after or last_picked_item > 0
					loop
						l_rec := l_pos.item
						if l_rec.has_x_y (l_coordinate.x, l_coordinate.y) then
							set_last_picked_item (l_pos.index)
						else
							l_pos.forth
						end
					end
					if last_picked_item > 0 then
						l_item := item (last_picked_item)
						l_item.on_pick (l_coordinate.x - l_rec.x, l_coordinate.y - l_rec.y)
						Result := l_item.last_pebble
						safe_redraw
					end
				end
			end
		end

	on_pick_ends is
			-- Action to be performed hwne pick-and-drop finishes
		do
			if is_item_pebble_enabled and then last_picked_item > 0 and then last_picked_item <= item_count then
				item (last_picked_item).on_pick_ended
				safe_redraw
			end
		end

feature{NONE} -- Implementation

	items: LINKED_LIST [like item_type] is
			-- Components contained in Current
		do
			if items_internal = Void then
				create items_internal.make
			end
			Result := items_internal
		ensure
			result_attached: Result /= Void
		end

	items_internal: like items;
			-- Implementation of `items'

	required_dimension_for_items: TUPLE [width, height: INTEGER] is
			-- Required dimension in pixels for `items'
		local
			l_items: like items
			l_item: like item_type
			l_count: INTEGER
			i: INTEGER
			l_width, l_height: INTEGER
			l_item_height: INTEGER
			l_padding: INTEGER
		do
			from
				l_padding := padding
				l_items := items
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

	perform_redraw (a_drawable: EV_DRAWABLE) is
			-- Redraw Current
		require
			a_drawable_attached: a_drawable /= Void
		do
			display (a_drawable, is_selected, parent.has_focus)
		end

	safe_redraw is
			-- Redraw Current if parented
		do
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

	display (a_drawable: EV_DRAWABLE; a_selected: BOOLEAN; a_focused: BOOLEAN) is
			-- Display Current in `a_drawable'.
		require
			a_drawable_attached: a_drawable /= Void
		local
			x, y: INTEGER
			l_left_width, l_left_height: INTEGER
			l_max_width, l_max_height: INTEGER
			l_items: like items
			l_required_width: INTEGER
			l_required_height: INTEGER
			l_item_width: INTEGER
			l_item: like item_type
			i: INTEGER
			l_count: INTEGER
			l_padding: INTEGER
			l_required_dimension: like required_dimension_for_items
			l_positions: like displayed_item_position
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
			l_padding := padding
			l_max_height := (l_left_height - y).max (1)
			l_max_width := (l_left_width - x).max (1)
			from
				l_items := items
				l_count := l_items.count
				i := 1
				l_positions := displayed_item_position
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

	item_type: ES_GRID_LIST_ITEM_COMPONENT
			-- Anchor type

	default_padding: INTEGER is 10
			-- Default padding in pixel

	last_picked_item: INTEGER
			-- Index of last picked component

	set_last_picked_item (a_index: INTEGER) is
			-- Set `last_picked_item' with `a_index'.
		do
			last_picked_item := a_index
		ensure
			last_picked_item_set: last_picked_item = a_index
		end

	displayed_item_position: LINKED_LIST [EV_RECTANGLE]
			-- List of position of displayed components

invariant
	items_attached: items /= Void
	displayed_item_position_attached: displayed_item_position /= Void

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
