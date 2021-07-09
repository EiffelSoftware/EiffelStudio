note
	description: "Objects that draw the EV_GRID widget as required."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_DRAWER_I

inherit
	REFACTORING_HELPER

create
	make_with_grid

feature {NONE} -- Initialization

	make_with_grid (a_grid: EV_GRID_I)
			-- Create `Current' associated to `grid' `a_grid'.
		require
			a_grid_not_void: a_grid /= Void
		do
			grid := a_grid
			create temp_rectangle
		ensure
			grid_set: grid = a_grid
		end

feature -- Access

	grid: EV_GRID_I

feature -- Basic operations

	items_spanning_horizontal_span (an_x, a_width: INTEGER): ARRAYED_LIST [INTEGER]
			-- For a virtual position starting at `an_x' with a width of `a_width',
			-- return all of the column indexes which intersect this width.
		require
			a_width_non_negative: a_width >= 0
		local
			internal_client_x: INTEGER
			horizontal_buffer_offset: INTEGER
			physical_column_indexes: SPECIAL [INTEGER]
			first_column_index: INTEGER
			last_column_index: INTEGER
			first_column_index_set, last_column_index_set: BOOLEAN
			column_offsets: ARRAYED_LIST [INTEGER]
			invalid_x_start, invalid_x_end: INTEGER
			i: INTEGER
			internal_client_width: INTEGER
			g: like grid
		do
			g := grid
			create Result.make (20)

			physical_column_indexes := g.physical_column_indexes

			internal_client_x := g.internal_client_x
			internal_client_width := g.viewable_width

			horizontal_buffer_offset := g.viewport_x_offset


			if g.column_count > 0 then
					-- If the grid has no columns, then there may not be any column indexes
					-- which span the area, so do nothing.

				invalid_x_start := an_x
				invalid_x_end := an_x + a_width
				if invalid_x_end >= 0 and invalid_x_start <= g.virtual_width then
						-- There is nothing to perform if the positions to be checked
						-- fall completely outside of the virtual width.

						-- Limit the positions chacked to the virtual width if the area is intersected.
					invalid_x_start := invalid_x_start.max (0)
					invalid_x_end := invalid_x_end.min (g.virtual_width)

					column_offsets := g.column_offsets
						-- Retrieve the offsets of all columns from `grid'.

						-- Calculate the columns that must be displayed.
					from
						column_offsets.start
					until
						last_column_index_set or column_offsets.index > g.column_count + 1
					loop
						i := column_offsets.item
						if not first_column_index_set and then i > invalid_x_start then
							first_column_index := column_offsets.index - 1
							first_column_index_set := True
						end
						if first_column_index_set and g.column_displayed (column_offsets.index - 1) then
							Result.extend (column_offsets.index - 1)
						end
						if not last_column_index_set and then invalid_x_end < i then
							last_column_index := column_offsets.index - 1
							last_column_index_set := True
						end
						column_offsets.forth
					end
					if last_column_index = 0 then
						last_column_index := g.column_count
					end
					if first_column_index = 0 then
						first_column_index := g.column_count
					end
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

	items_spanning_vertical_span (a_y, a_height: INTEGER): ARRAYED_LIST [INTEGER]
			-- For a virtual position starting at `a_y' with a height of `a_height',
			-- return all of the row indexes which intersect this height.
		require
			a_height_non_negative: a_height >= 0
		local
			first_row_index: INTEGER
			last_row_index: INTEGER
			l_row_offsets: detachable ARRAYED_LIST [INTEGER]
			invalid_y_start, invalid_y_end: INTEGER
			i: INTEGER
			l_row_count: INTEGER
			l_grid_row_count: INTEGER
			probe, high, low: INTEGER
			l_first_visible: INTEGER
			l_visible_cumulative_height: INTEGER
			l_found_index: INTEGER
			l_found_row_offset: INTEGER
			l_visible_indexes_to_row_indexes: detachable EV_GRID_ARRAYED_LIST [INTEGER]
			l_row_indexes_to_visible_indexes: detachable EV_GRID_ARRAYED_LIST [INTEGER]
			l_is_row_height_fixed: BOOLEAN
			l_row_height: INTEGER
			g: like grid
		do
			g := grid
			create Result.make (20)
			if not g.header.is_empty then

					-- Calculate the rows that must be displayed.
					-- Compute the virtual positions of the invalidated area.
				invalid_y_start := a_y
				invalid_y_end := a_y + a_height
				l_grid_row_count := g.row_count

				if invalid_y_end >= 0 and invalid_y_start < g.total_row_height then
						-- There is nothing to perform if the positions to be checked
						-- fall completely outside of the virtual height.

						-- Limit the positions chacked to the virtual height if the area is intersected.
					invalid_y_start := invalid_y_start.max (0)
					invalid_y_end := invalid_y_end.min (g.virtual_height)

					if not g.uses_row_offsets then
							-- If row heights are fixed we can calculate instead of searching.
							-- Note that we cannot calculate if there is tree functionality enabled in
							-- the grid as nodes may be expanded or collapsed.
						first_row_index := (((invalid_y_start) // g.row_height) + 1)
						last_row_index := (((invalid_y_end) // g.row_height) + 1).min (l_grid_row_count)

						if first_row_index <= l_grid_row_count then
							l_row_count := l_grid_row_count
							from
								i := first_row_index
							until
								i > last_row_index
							loop
								Result.extend (i)
								check
									i_positive: i >= 0
								end
								i := i + 1
							end
						end
					else
						l_visible_indexes_to_row_indexes := g.visible_indexes_to_row_indexes
						check l_visible_indexes_to_row_indexes /= Void then end
						l_row_offsets := g.row_offsets
						check l_row_offsets /= Void then end
							-- We now perform a binary search on `row_offsets' to find the highest row index with a vertical offset
							-- that is less than `invalid_y_start'.
						from
							high := l_grid_row_count
							low := 0
						until
							not (high - low > 1)
						loop
							probe := (low + high) // 2
							if l_row_offsets.i_th (probe) <= invalid_y_start then
								low := probe
							else
								high := probe
							end
						end
						l_found_row_offset := l_row_offsets.i_th (high)
						if l_found_row_offset <= invalid_y_start then
							l_found_index := high
						else
							l_found_index := low.max (1)
							l_found_row_offset := l_row_offsets.i_th (l_found_index)
						end

							-- There may be multiple rows that are represented in `row_offsets' with the same row offset if rows are hidden or trees are used in the grid.
							-- If the row offset of row `l_found_index' has multiple entries in `row_offsets', then `l_found_index' will be set to the higest of these rows,
							-- even though the row may not actually be the visible row with this offset (The one we are looking for).
							-- We first determine if this is the case below and then if so, have to perform another binary search to resolve which row is the actually displayed
							-- row with that offset. We perform this with a binary search on `visible_indexes_to_row_indexes' to find the entry that is equal or
							-- lower to `l_found_index' This is the one that is actually displayed.

						if (l_found_index > 1 and then l_row_offsets.i_th (l_found_index - 1) = l_found_row_offset) then
							check
								duplicates_found_implies_next_offset_greater: l_found_index < g.row_count + 1 implies l_row_offsets.i_th (l_found_index + 1) > l_found_row_offset
							end
							from
								high := g.visible_row_count
								low := 0
							until
								not (high - low > 1)
							loop
								probe := (low + high) // 2
								if l_visible_indexes_to_row_indexes.i_th (probe) < l_found_index then
									low := probe
								else
									high := probe
								end
							end
							if l_visible_indexes_to_row_indexes.i_th (high) <= l_found_index then
								l_found_index := l_visible_indexes_to_row_indexes.i_th (high)
							else
								l_found_index := l_visible_indexes_to_row_indexes.i_th (low.max (1))
							end
						end
							-- We have now found the first item that intersects the span, so we can iterate the visible indexes, constructing `result'
							-- until we have passed the span length.
						l_row_indexes_to_visible_indexes := g.row_indexes_to_visible_indexes
						check l_row_indexes_to_visible_indexes /= Void then end
						l_first_visible := l_row_indexes_to_visible_indexes.i_th (l_found_index) + 1
						l_found_index := l_visible_indexes_to_row_indexes.i_th (l_first_visible)
						Result.extend (l_found_index)

						l_is_row_height_fixed := g.is_row_height_fixed
						l_row_height := g.row_height

						l_visible_cumulative_height := l_row_offsets.i_th (l_found_index)
						if l_is_row_height_fixed then
								-- If the row height is fixed then we add the grid row height.
							l_visible_cumulative_height := l_visible_cumulative_height + l_row_height
						else
							l_visible_cumulative_height := l_visible_cumulative_height + g.row (l_found_index).height
						end

						from
							i := l_first_visible + 1
						until
							(l_visible_cumulative_height > invalid_y_end) or i > g.computed_visible_row_count
						loop
							l_found_index := l_visible_indexes_to_row_indexes.i_th (i)
							Result.extend (l_found_index)
							if l_is_row_height_fixed then
									-- If the row height is fixed then we add the grid row height.
								l_visible_cumulative_height := l_visible_cumulative_height + l_row_height
							else
								l_visible_cumulative_height := l_visible_cumulative_height + g.row (l_found_index).height
							end
							i := i + 1
						end
					end
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

	item_at_virtual_position (an_x, a_y: INTEGER): detachable EV_GRID_ITEM_I
			-- `Result' is item at virtual position `an_x', `a_y' relative to the top
			-- left hand corner of the virtual size.
		local
			g: like grid
		do
			g := grid
			Result := item_at_position (an_x - g.internal_client_x + g.viewport_x_offset, a_y - g.internal_client_y + g.viewport_y_offset)
		end

	row_at_virtual_position (a_y: INTEGER; ignore_locked_rows: BOOLEAN): detachable EV_GRID_ROW_I
			-- `Result' is row at virtual y position, `a_y' relative to the top
			--  of the virtual size.
		do
			Result := row_at_position (a_y - grid.internal_client_y + grid.viewport_y_offset, ignore_locked_rows)
		end

	column_at_virtual_position (a_x: INTEGER): detachable EV_GRID_COLUMN_I
			-- `Result' is row at virtual x position, `a_x' relative to the left
			--  of the virtual size.
		do
			Result := column_at_position (a_x - grid.internal_client_x + grid.viewport_x_offset)
		end

	item_coordinates_at_position (an_x, a_y: INTEGER): detachable EV_COORDINATE
			-- `Result' is coordinates of item at position `an_x', `a_y' relative to the top left corner
			-- of the `grid.drawable' in which the grid is displayed. The bounded item
			-- incorporates the tree node if any. No checking of whether the item at this posibion is `Void'.
		local

			l_item_i: detachable EV_GRID_ITEM_I
		do
			l_item_i := item_at_position (an_x, a_y)
			if l_item_i /= Void then
				create Result.make (l_item_i.column.index, l_item_i.row.index)
			end
		end

	item_at_position (an_x, a_y: INTEGER): detachable EV_GRID_ITEM_I
			-- `Result' is item at position `an_x', `a_y' relative to the top left corner
			-- of the `grid.drawable' in which the grid is displayed. The bounded item
			-- incorporates the tree node if any.
		local
			horizontal_span_items, vertical_span_items: ARRAYED_LIST [INTEGER]
			g: like grid
		do
			g := grid
			g.perform_horizontal_computation
			g.perform_vertical_computation
			Result := locked_item_at_position (an_x, a_y)
			if Result = Void then
					-- Recompute vertical row heights and scroll bar positions before
					-- querying the item positions
				horizontal_span_items := items_spanning_horizontal_span (drawable_x_to_virtual_x (an_x), 0)
				vertical_span_items := items_spanning_vertical_span (drawable_y_to_virtual_y (a_y), 0)
				if not horizontal_span_items.is_empty and not vertical_span_items.is_empty then
					Result := g.item_internal (horizontal_span_items.first, vertical_span_items.first)
					if Result /= Void then
						if Result.column.is_locked or Result.row.is_locked then
							Result := Void
						end
					end
				end
			end
		end

	row_at_position (a_y: INTEGER; ignore_locked_rows: BOOLEAN): detachable EV_GRID_ROW_I
			-- `Result' is row at position `a_y' relative to the top
			-- of the `grid.drawable' in which the grid is displayed.
		local
			vertical_span_items: ARRAYED_LIST [INTEGER]
			g: like grid
		do
			g := grid
			g.perform_horizontal_computation
			g.perform_vertical_computation
			if not ignore_locked_rows then
				Result := locked_row_at_position (a_y)
			end
			if Result = Void then
					-- Recompute vertical row heights and scroll bar positions before
					-- querying the item positions
				vertical_span_items := items_spanning_vertical_span (drawable_y_to_virtual_y (a_y), 0)
				if not vertical_span_items.is_empty then
					Result := g.row_internal (vertical_span_items.first)
					if not ignore_locked_rows then
						debug
							if Result.is_locked then
						end
							Result := Void
						end
					end
				end
			end
		end

	column_at_position (a_x: INTEGER): detachable EV_GRID_COLUMN_I
			-- `Result' is column at position `a_x' relative to the left
			-- of the `grid.drawable' in which the grid is displayed.
		local
			horizontal_span_items: ARRAYED_LIST [INTEGER]
			g: like grid
		do
			g := grid
			g.perform_horizontal_computation
			g.perform_vertical_computation
			Result := locked_column_at_position (a_x)
			if Result = Void then
					-- Recompute vertical row heights and scroll bar positions before
					-- querying the item positions
				horizontal_span_items := items_spanning_horizontal_span (drawable_x_to_virtual_x (a_x), 0)
				if not horizontal_span_items.is_empty then
					Result := g.column_internal (horizontal_span_items.first)
					if Result.is_locked then
						Result := Void
					end
				end
			end
		end

	item_at_position_strict (an_x, a_y: INTEGER): detachable EV_GRID_ITEM_I
			-- `Result' is item at position `an_x', `a_y' relative to the top left corner
			-- of the `grid.drawable' in which the grid is displayed. This version
			-- returns `Void' if the pointed_part of the item is part of a tree node.
		local
			item_indent: INTEGER
		do
			Result := item_at_position (an_x, a_y)
			if Result /= Void then
				item_indent := grid.item_indent (Result)
				if an_x - Result.virtual_x_position < 0 then
					Result := Void
				end
			end
		end

	locked_item_at_position (an_x, a_y: INTEGER): detachable EV_GRID_ITEM_I
			-- `Result' is locked item at position `an_x', `a_y' relative to the top left corner
			-- of the `grid.drawable' in which the grid is displayed.
		local
			locked_items: ARRAYED_LIST [EV_GRID_LOCKED_I]
			locked_row: detachable EV_GRID_LOCKED_ROW_I
			locked_column: detachable EV_GRID_LOCKED_COLUMN_I
			row_height: INTEGER
			column_width: INTEGER
			horizontal_span_items, vertical_span_items: ARRAYED_LIST [INTEGER]
			intersection_found: BOOLEAN
			l_cursor: CURSOR
			g: like grid
		do
			g := grid
			locked_items := g.locked_indexes

				-- We iterate in reverse as we wish to find the topmost item
				-- first, ignoring all those beneath
			from
				l_cursor := locked_items.cursor
				locked_items.finish
			until
				locked_items.off or intersection_found
			loop
				locked_row ?= locked_items.item
				if locked_row /= Void then
					if g.is_row_height_fixed then
						row_height := g.row_height
					else
						row_height := locked_row.row_i.height
					end
					if a_y >= g.viewport_y_offset + locked_row.offset and a_y < g.viewport_y_offset + locked_row.offset + row_height then
						intersection_found := True
						horizontal_span_items := items_spanning_horizontal_span (drawable_x_to_virtual_x (an_x), 0)
						if not horizontal_span_items.is_empty then
							Result := g.item_internal (horizontal_span_items.first, locked_row.row_i.index)
							if Result /= Void then
								if Result.column.is_locked and then attached Result.column.implementation.locked_column as l_locked_column and then l_locked_column.locked_index > locked_row.locked_index then
									Result := Void
								end
							end
						end
					end
				else
					locked_column ?= locked_items.item
					if locked_column /= Void then
						column_width := locked_column.column_i.width
						if an_x >= g.viewport_x_offset + locked_column.offset and an_x < g.viewport_x_offset + locked_column.offset + column_width then
							intersection_found := True
							vertical_span_items := items_spanning_vertical_span (drawable_y_to_virtual_y (a_y), 0)
							if not vertical_span_items.is_empty then
								Result := g.item_internal (locked_column.column_i.index, vertical_span_items.first)
								if Result /= Void then
									if Result.row.is_locked and then attached Result.row.implementation.locked_row as l_locked_row  and then l_locked_row.locked_index > locked_column.locked_index then
										Result := Void
									end
								end
							end
						end
					end
				end
				locked_items.back
			end
			locked_items.go_to (l_cursor)
		end

	locked_row_at_position (a_y: INTEGER): detachable EV_GRID_ROW_I
			-- `Result' is locked row at position `a_y' relative to the top
			-- of the `grid.drawable' in which the grid is displayed.
		local
			locked_items: ARRAYED_LIST [EV_GRID_LOCKED_I]
			locked_row: detachable EV_GRID_LOCKED_ROW_I
			row_height: INTEGER
			intersection_found: BOOLEAN
			l_cursor: CURSOR
			g: like grid
		do
			g := grid
			locked_items := g.locked_indexes

				-- We iterate in reverse as we wish to find the topmost item
				-- first, ignoring all those beneath
			from
				l_cursor := locked_items.cursor
				locked_items.finish
			until
				locked_items.off or intersection_found
			loop
				locked_row ?= locked_items.item
				if locked_row /= Void then
					if g.is_row_height_fixed then
						row_height := g.row_height
					else
						row_height := locked_row.row_i.height
					end
					if a_y >= g.viewport_y_offset + locked_row.offset and a_y < g.viewport_y_offset + locked_row.offset + row_height then
						Result := locked_row.row_i
					end
				end
				locked_items.back
			end
			locked_items.go_to (l_cursor)
		end

	locked_column_at_position (an_x: INTEGER): detachable EV_GRID_COLUMN_I
			-- `Result' is locked column at position `an_x' relative to the left
			-- of the `grid.drawable' in which the grid is displayed.
		local
			locked_items: ARRAYED_LIST [EV_GRID_LOCKED_I]
			locked_column: detachable EV_GRID_LOCKED_COLUMN_I
			column_width: INTEGER
			intersection_found: BOOLEAN
			l_cursor: CURSOR
			g: like grid
		do
			g := grid
			locked_items := g.locked_indexes

				-- We iterate in reverse as we wish to find the topmost item
				-- first, ignoring all those beneath
			from
				l_cursor := locked_items.cursor
				locked_items.finish
			until
				locked_items.off or intersection_found
			loop
				locked_column ?= locked_items.item
				if locked_column /= Void then
					column_width := locked_column.column_i.width
					if an_x >= g.viewport_x_offset + locked_column.offset and an_x < g.viewport_x_offset + locked_column.offset + column_width then
						Result := locked_column.column_i
					end
				end
				locked_items.back
			end
			locked_items.go_to (l_cursor)
		end


	redraw_area_in_virtual_coordinates (an_x, a_y, a_width, a_height: INTEGER)
			-- Redraw grid contents at coordinates `an_x', `a_y', `a_width', `a_height'
			-- relative to the upper left corner of the virtual area.
		do
			redraw_area_in_drawable_coordinates_wrapper (an_x - grid.internal_client_x + grid.viewable_x_offset, a_y - grid.internal_client_y + grid.viewport_y_offset, a_width, a_height)
		end

	redraw_area_in_drawable_coordinates_wrapper (an_x, a_y, a_width, a_height: INTEGER)
			--
		do
			redraw_area_in_drawable_coordinates (an_x, a_y, a_width, a_height, grid.drawable, grid.viewport, Void)
		end

	redraw_area_in_drawable_coordinates (an_x, a_y, a_width, a_height: INTEGER; drawable: EV_DRAWABLE; viewport: EV_VIEWPORT; locked: detachable EV_GRID_LOCKED_I)
			-- Redraw grid contents at coordinates `an_x', `a_y', `a_width', `a_height'
			-- relative to the upper left corner of the `drawable' widget of `grid'.
--		require
--			an_x_positive: an_x >= 0
--			a_y_positive: a_y >= 0
--			a_width_positive: a_width >= 0
--			a_height_positive: a_height >= 0
		local
			internal_client_x, internal_client_y: INTEGER
			vertical_buffer_offset: INTEGER
			horizontal_buffer_offset: INTEGER
			column_widths: ARRAYED_LIST [INTEGER]

			current_row_list: detachable SPECIAL [detachable EV_GRID_ITEM_I]
			current_row: detachable EV_GRID_ROW_I

			physical_column_indexes: SPECIAL [INTEGER]
			first_column_index, first_row_index: INTEGER
			last_column_index: INTEGER
			grid_item: detachable EV_GRID_ITEM_I
			grid_item_interface: detachable EV_GRID_ITEM
			current_column_index, current_row_index: INTEGER
			column_offsets, row_offsets: detachable ARRAYED_LIST [INTEGER]
			current_column_width, current_row_height: INTEGER
			rectangle_width, rectangle_height: INTEGER
			grid_item_exists: BOOLEAN
			current_item_y_position, current_item_x_position: INTEGER
			current_tree_adjusted_item_x_position, current_tree_adjusted_column_width: INTEGER
			dynamic_content_function: detachable FUNCTION [INTEGER, INTEGER, EV_GRID_ITEM]
			internal_client_width, internal_client_height: INTEGER
			current_subrow_indent: INTEGER
			visible_column_indexes: ARRAYED_LIST [INTEGER]
			visible_row_indexes: ARRAYED_LIST [INTEGER]
			standard_subrow_indent: INTEGER
			drawing_subrow, drawing_parentrow: BOOLEAN
			node_index, parent_node_index: INTEGER
			parent_subrow_indent: INTEGER
			parent_x_indent_position: INTEGER
			tree_node_spacing: INTEGER
			total_tree_node_width: INTEGER
			collapse_pixmap, expand_pixmap: detachable EV_PIXMAP
			first_tree_node_indent: INTEGER
			node_pixmap_width, node_pixmap_height: INTEGER
			parent_row_i: detachable EV_GRID_ROW_I
			l_pixmap: EV_PIXMAP

			row_vertical_center: INTEGER
			row_vertical_bottom: INTEGER
			vertical_node_pixmap_top_offset: INTEGER
			vertical_node_pixmap_bottom_offset: INTEGER
			horizontal_node_pixmap_left_offset: INTEGER
			node_pixmap_vertical_center: INTEGER
			l_x_start, l_x_end: INTEGER
			current_horizontal_pos: INTEGER
			loop_current_row, loop_parent_row: detachable EV_GRID_ROW_I
			loop_parent_row_last_displayed_subrow: EV_GRID_ROW
			are_tree_node_connectors_shown: BOOLEAN
			current_physical_column_index: INTEGER
			translated_parent_x_indent_position: INTEGER
			tree_node_connector_color: EV_COLOR
			grid_rows_data_list: EV_GRID_ARRAYED_LIST [detachable SPECIAL [detachable EV_GRID_ITEM_I]]
			current_column: detachable EV_GRID_COLUMN_I
			row_count, row_height: INTEGER
			is_tree_enabled, is_content_partially_dynamic : BOOLEAN
			first_item_in_row_drawn: BOOLEAN
			current_parent_row: detachable EV_GRID_ROW_I
			v_y: INTEGER
			locked_column: detachable EV_GRID_LOCKED_COLUMN_I
			locked_row: detachable EV_GRID_LOCKED_ROW_I
			l_subrow_index: INTEGER
			l_parent_row: EV_GRID_ROW
			g: like grid
		do
			g := grid
			if not g.is_locked then
				-- Perform no re-drawing if the update of the grid is locked.
				drawable.start_drawing_session
				g.reset_redraw_object_counter
					-- Although this feature is connected to the `expose_actions' of a drawing area,
					-- there is currently a bug/feature on Windows where it is possible for the Wm_paint
					-- message to be generated even though there is no invalid area (width and height are 0).
					-- Therefore, we protect against this case and perform no re-drawing if there is no area
					-- to be re-drawn.
				if a_width > 0 and a_height > 0 then
					item_buffer_pixmap.set_copy_mode
					dynamic_content_function := g.dynamic_content_function

					g.perform_horizontal_computation
					g.perform_vertical_computation
						-- Recompute vertical row heights and scroll bar positions before
						-- calculating the draw positions. The recomputation is only
						-- performed internally if they are flagged as requiring a re-compute.

					create column_widths.make (8)
					column_widths.extend (0)

					expand_pixmap := g.expand_node_pixmap
					collapse_pixmap := g.collapse_node_pixmap

					are_tree_node_connectors_shown := g.are_tree_node_connectors_shown
					tree_node_connector_color := g.tree_node_connector_color

					tree_node_spacing := g.tree_node_spacing
						-- Retrieve the spacing around each node.

						-- Retrieve properties for drawing from the grid.
					node_pixmap_width := g.node_pixmap_width
					node_pixmap_height := expand_pixmap.height
					standard_subrow_indent := g.tree_subrow_indent
					total_tree_node_width := g.total_tree_node_width
					first_tree_node_indent := g.first_tree_node_indent

					physical_column_indexes := g.physical_column_indexes

					if locked = Void then
						internal_client_x := g.internal_client_x
						internal_client_y := g.internal_client_y
					else
						locked_column ?= locked
						locked_row ?= locked
						if locked_column /= Void then
							internal_client_x := locked_column.column_i.virtual_x_position
							internal_client_y := locked.internal_client_y
						elseif locked_row /= Void then
							internal_client_y := locked_row.row_i.virtual_y_position
							internal_client_x := locked.internal_client_x
						else
							check False end
						end
					end
					internal_client_width := g.viewable_width
					internal_client_height := g.viewable_height

					vertical_buffer_offset := g.viewport_y_offset
					horizontal_buffer_offset := g.viewport_x_offset
					row_count := g.row_count
					is_tree_enabled := g.is_tree_enabled
					is_content_partially_dynamic := g.is_content_partially_dynamic
					row_height := g.row_height

					if row_count > 0 and g.column_count > 0 then
						column_offsets := g.column_offsets
						row_offsets := g.row_offsets

							-- Note that here we need to remove 1 from `a_width' and `a_height' before
							-- calculating the visible column and row indexes, as one of the pixels
							-- is already included within the offset pixel.
						if locked_column = Void then
							visible_column_indexes := items_spanning_horizontal_span (drawable_x_to_virtual_x (an_x), a_width - 1)
						else
							create visible_column_indexes.make (1)
							visible_column_indexes.extend (locked_column.column_i.index)
						end
						if locked_row = Void then
							visible_row_indexes := items_spanning_vertical_span (drawable_y_to_virtual_y (a_y), a_height - 1)
						else
							create visible_row_indexes.make (1)
							visible_row_indexes.extend (locked_row.row_i.index)
						end
						if not (visible_column_indexes.is_empty or visible_row_indexes.is_empty) then
							first_column_index := visible_column_indexes.first
							last_column_index := visible_column_indexes.last


							first_row_index := visible_row_indexes.first
							current_item_y_position := 0

							from
								visible_row_indexes.start
								grid_rows_data_list := g.internal_row_data
							until
								visible_row_indexes.off
							loop
								current_row_index := visible_row_indexes.item
									-- Retrieve information regarding the rows that we must draw.
								current_row := g.row_internal (current_row_index)
								current_row_list := grid_rows_data_list @ (current_row_index)
								check current_row_list /= Void end

								if not g.uses_row_offsets then
									current_item_y_position := (row_height * (current_row_index - 1)) - (internal_client_y - vertical_buffer_offset)
									current_row_height := row_height
								elseif row_offsets /= Void then
									current_item_y_position := (row_offsets @ (current_row_index)) - (internal_client_y - vertical_buffer_offset)
									if g.is_row_height_fixed then
										current_row_height := row_height
									else
										current_row_height := current_row.height
									end
								else
									check row_offsets /= Void end
								end

								if is_tree_enabled then
									-- Only perform the following calculations if the tree is enabled
									-- as otherwise, they are not required.
									-- Note that `current_row' may be Void if we are in partially dynamic mode
									-- and a tree is enabled. If subrows were set, it is not possible for `current_row' to be Void.

									parent_row_i := current_row.parent_row_i

									drawing_subrow := parent_row_i /= Void
										-- Are we drawing a subrow of the tree?

									drawing_parentrow := current_row.is_expandable
										-- Are we drawing a row that is a parent of other rows?

									if drawing_subrow or drawing_parentrow then
										-- We are now about to draw a row that is a subrow of another row, so
										-- perform any calculations required.

										node_index := retrieve_node_index (current_row)

										if parent_row_i /= Void then
											parent_node_index := retrieve_node_index (parent_row_i)
											from
												current_parent_row := parent_row_i
											until
												current_parent_row = Void
											loop
												parent_node_index := parent_node_index.max (current_parent_row.index_of_first_item)
												current_parent_row := current_parent_row.parent_row_i
											end
											parent_subrow_indent := g.item_cell_indent (parent_node_index, parent_row_i.index) + ((node_pixmap_width + 1) // 2)
											parent_x_indent_position := parent_subrow_indent
											node_index := node_index.max (parent_node_index)
										end
									else
										node_index := 1
									end

										-- Now compute variables required for drawing tree structures.
										-- Note that here we only compute the vertical variables because as each row
										-- has a fixed height, they can be computed outside of the inner row iteration.
										-- The horizontal offsets must be computed within the inner loop.
									row_vertical_center := (current_row_height // 2)
									row_vertical_bottom := current_row_height

									vertical_node_pixmap_top_offset := ((current_row_height - node_pixmap_height + 1)// 2)
									vertical_node_pixmap_bottom_offset := vertical_node_pixmap_top_offset + node_pixmap_height

									current_subrow_indent := subrow_indent (current_row)
								end

								from
									visible_column_indexes.start
									current_item_x_position := 0
									first_item_in_row_drawn := False
								until
									visible_column_indexes.off
								loop
									check
										lists_valid_lengths: physical_column_indexes.count >= visible_column_indexes.count
									end
									current_column_index := visible_column_indexes.item
									current_column := g.columns @ current_column_index
									if current_column = Void then
										check current_column /= Void then end
									end
									current_column_width := column_offsets @ (current_column_index + 1) - column_offsets @ (current_column_index)

										-- If the current column has a width of 0, then there is no need to
										-- perform any drawing. This is especially beneficial to dynamic content
										-- in the grid as the dynamic content function is not called until
										-- the width of the column necessitates this.
									if current_column_width > 0 then
										current_physical_column_index := physical_column_indexes.item (visible_column_indexes.item - 1)


											-- Assume that there is no grid item at the current position.
											-- It is not possible to simply set `grid_item' to Void within the loop as otherwise
											-- this effectively inserts `Void' at the grid item's position within the grid's
											-- data structures. So we use a BOOLEAN to determine this instead.
										grid_item_exists := False

										if current_row_list /= Void and then current_physical_column_index < current_row_list.count then
												-- If the grid is set to retrieve completely dynamic content, then we do not execute this code
												-- as the current contents of the grid are never used. We also check that the current row and
												-- current row position are valid.

											grid_item := current_row_list @ (current_physical_column_index)
												-- In this case, we have found the grid item so we flag this fact
												-- so that the calculations for the partial dynamic content know that
												-- a new item must not be retrieved.
											if grid_item /= Void then
												grid_item_exists := True
											end
										end


										current_item_x_position := (column_offsets @ (current_column_index)) - (internal_client_x - horizontal_buffer_offset)

										if is_content_partially_dynamic and then not grid_item_exists and dynamic_content_function /= Void then
												-- If we are dynamically computing the contents of the grid and we have not already retrieved an item for
												-- the grid, then we execute this code.

											grid_item_interface := dynamic_content_function.item ([current_column_index, current_row_index])

													-- We now check that the set item is the same as the one returned. If you both
													-- set an item and return a different item from the dynamic function, this is invalid
													-- so the following check prevents this:
											check
												item_set_implies_set_item_is_returned_item: g.item_internal (visible_column_indexes.item, visible_row_indexes.item) /= Void
													implies g.item_internal (visible_column_indexes.item, visible_row_indexes.item) = grid_item_interface.implementation
											end

											if grid_item_interface /= Void then
												grid_item := grid_item_interface.implementation

													-- Note that the item is added to the grid in both partial and complete dynamic modes.
													-- It is possible that a user called `set_item' with the returned item, as well
													-- as returning it, so in this case, we only call `set_item' if it was not set.
												if g.item (visible_column_indexes.item, visible_row_indexes.item) = Void then
													g.set_item (visible_column_indexes.item, visible_row_indexes.item, grid_item.interface)
												end

												grid_item_exists := True
											end
												-- We must now recompute the tree status of the current row as during the
												-- dynamic computation, a user may have performed something which modified the
												-- tree structure, therby invalidating our previously calculated tree information.
												-- Unfortunately, this must be computed for every item that is retrieved dynamically
												-- as it is not possible for us to know which item may modify the tree structure.
												-- The overhead of this should not be too high, but it is unfortunate. Julian
											if is_tree_enabled then
												parent_row_i := current_row.parent_row_i

												drawing_subrow := parent_row_i /= Void
													-- Are we drawing a subrow of the tree?

												drawing_parentrow := current_row.is_expandable
													-- Are we drawing a row that is a parent of other rows?

												if drawing_subrow or drawing_parentrow then
													-- We are now about to draw a row that is a subrow of another row, so
													-- perform any calculations required.

													node_index := retrieve_node_index (current_row)

													if parent_row_i /= Void then
														parent_node_index := retrieve_node_index (parent_row_i)
														from
															current_parent_row := parent_row_i
														until
															current_parent_row = Void
														loop
															parent_node_index := parent_node_index.max (current_parent_row.index_of_first_item)
															current_parent_row := current_parent_row.parent_row_i
														end
														parent_subrow_indent := g.item_cell_indent (parent_node_index, parent_row_i.index) + ((node_pixmap_width + 1) // 2)
														parent_x_indent_position := parent_subrow_indent
														node_index := node_index.max (parent_node_index)
													end
												else
													node_index := 1
												end

													-- Now compute variables required for drawing tree structures.
													-- Note that here we only compute the vertical variables because as each row
													-- has a fixed height, they can be computed outside of the inner row iteration.
													-- The horizontal offsets must be computed within the inner loop.
												row_vertical_center := (current_row_height // 2)
												row_vertical_bottom := current_row_height

												vertical_node_pixmap_top_offset := ((current_row_height - node_pixmap_height + 1)// 2)
												vertical_node_pixmap_bottom_offset := vertical_node_pixmap_top_offset + node_pixmap_height

												current_subrow_indent := subrow_indent (current_row)
											end

												-- Now retrieve `current_row_list' again. This is because as an item is added,
												-- the row list is resized, which produces a new object.
											current_row_list := grid_rows_data_list @ (current_row_index)
										end
											-- Resize the buffer if required. The buffer is only every increased and never decreased
											-- as this prevents us from having to continuously change its size, which is an
											-- unecessary overhead.
										if item_buffer_pixmap.width < current_column_width or item_buffer_pixmap.height < current_row_height then
											item_buffer_pixmap.set_size (current_column_width, current_row_height)
										end

											-- Now compute horizontal variables for tree drawing.
										if drawing_parentrow then
											horizontal_node_pixmap_left_offset := current_subrow_indent - (tree_node_spacing * 2) - node_pixmap_width
										elseif drawing_subrow then
											horizontal_node_pixmap_left_offset := current_subrow_indent
										else
											horizontal_node_pixmap_left_offset := current_column_width
										end
										node_pixmap_vertical_center := current_subrow_indent - (tree_node_spacing * 2) - (node_pixmap_width + 1) // 2

										current_tree_adjusted_item_x_position := current_item_x_position
										current_tree_adjusted_column_width := current_column_width

										if grid_item_exists and then attached grid_item then
											item_buffer_pixmap.set_foreground_color (grid_item.displayed_background_color)
										else
											item_buffer_pixmap.set_foreground_color (g.displayed_background_color (current_column_index, current_row_index))
										end
										item_buffer_pixmap.fill_rectangle (0, 0, current_column_width, current_row_height)

											-- Fire the `pre_draw_overlay_actions' which enable a user to draw on top of the background
											-- but bloe the features of drawn grid items before they are displayed.
										if g.pre_draw_overlay_actions_internal /= Void then
											if grid_item_exists and then attached grid_item then
												g.pre_draw_overlay_actions.call ([item_buffer_pixmap, grid_item.interface, current_column_index, current_row_index])
											else
												g.pre_draw_overlay_actions.call ([item_buffer_pixmap, Void, current_column_index, current_row_index])
											end
										end

										if is_tree_enabled then
											if current_column_index = node_index then
												current_tree_adjusted_item_x_position := current_tree_adjusted_item_x_position + current_subrow_indent
												current_tree_adjusted_column_width := current_tree_adjusted_column_width - current_subrow_indent
													-- We adjust the horizontal position and width of the current item by the space required
													-- for the tree node.

													-- If the indent of the tree is less than `current_column_width', it must be visible so draw it.
												if current_row.is_expandable then
														-- Note we add 1 to account for rounding errors when odd values.
													if current_row.is_expanded then
														l_pixmap := collapse_pixmap
													else
														l_pixmap := expand_pixmap
													end
														-- Now check if we must clip the pixmap vertically
													debug ("refactor_fixme")
														fixme (Once "Add horizontal clipping for pixmaps.")
													end
													if horizontal_node_pixmap_left_offset < current_column_width then
														if node_pixmap_height > current_row_height then
																-- In this situation, the height of the expand image is greater than the current row height,
																-- so we only draw the part that fits within the node.
															temp_rectangle.move_and_resize (0, (node_pixmap_height - current_row_height) // 2, node_pixmap_height, current_row_height)
															item_buffer_pixmap.draw_sub_pixmap (horizontal_node_pixmap_left_offset, 0, l_pixmap, temp_rectangle)
														else
															item_buffer_pixmap.draw_pixmap (horizontal_node_pixmap_left_offset, vertical_node_pixmap_top_offset, l_pixmap)
														end
													end
												end
													-- We must now draw the lines for the tree structure.
												if are_tree_node_connectors_shown then
													if drawing_parentrow or drawing_subrow then
														l_x_start := current_subrow_indent
														if current_row.is_expandable then
															l_x_end := horizontal_node_pixmap_left_offset + node_pixmap_width
														else
															if parent_node_index = node_index then
																l_x_end := node_pixmap_vertical_center
															else
																l_x_end := 0
															end
														end
														item_buffer_pixmap.set_foreground_color (tree_node_connector_color)
														if l_x_start < current_column_width then
																-- If the edge of the horizontal line from the left edge of the item is within the position
																-- of the column, we must draw it, otherwise it is clipped below in the "elseif"

															item_buffer_pixmap.draw_segment (l_x_start, row_vertical_center, l_x_end, row_vertical_center)
																-- Draw a horizontal line from the left edge of the item to the either the node horizontal offset or the edge of the actual item position
															 	-- if the node to which we are connected is within a different column.

															 if parent_node_index > 0 and then parent_node_index /= node_index and current_row.is_expandable then
															 		-- Draw the horizontal line from the left edge of the expand icon to the start of
															 		-- the grid cell as the horizontal line spans into other grid cells.
															 	item_buffer_pixmap.draw_segment (0, row_vertical_center, horizontal_node_pixmap_left_offset, row_vertical_center)
															 end
														elseif l_x_end.min (current_item_x_position + current_column_width) /= current_item_x_position + current_column_width then
																-- Now we must clip the horizontal segment and draw.
															item_buffer_pixmap.draw_segment (l_x_end.min (current_column_width), row_vertical_center, current_column_width, row_vertical_center)
														end
													end
													if drawing_subrow and then parent_node_index = current_column_index then
														current_horizontal_pos := node_pixmap_vertical_center
														if are_tree_node_connectors_shown then
															item_buffer_pixmap.set_foreground_color (tree_node_connector_color)
															if current_horizontal_pos < column_offsets @ (node_index + 1) then
																	-- Draw the vertical line at the node, connecting the top and bottom
																	-- of the tree row.
																if parent_row_i /= Void and then parent_row_i.subrow (parent_row_i.subrow_count) = current_row.interface then
																		-- We are the last row in our parents structure.
																	if current_row.is_expandable then
																		item_buffer_pixmap.draw_segment (node_pixmap_vertical_center, vertical_node_pixmap_top_offset - 1, node_pixmap_vertical_center, 0)
																	else
																		item_buffer_pixmap.draw_segment (node_pixmap_vertical_center, row_vertical_center, node_pixmap_vertical_center, 0)
																	end
																else
																	if current_row.is_expandable then
																		item_buffer_pixmap.draw_segment (node_pixmap_vertical_center, vertical_node_pixmap_top_offset - 1, node_pixmap_vertical_center, 0)
																		item_buffer_pixmap.draw_segment (node_pixmap_vertical_center, vertical_node_pixmap_bottom_offset, node_pixmap_vertical_center, row_vertical_bottom)
																	else
																		item_buffer_pixmap.draw_segment (node_pixmap_vertical_center, 0, node_pixmap_vertical_center, row_vertical_bottom)
																	end
																end
															end
																-- Now we draw all of the horizontal lines required to fill in the lines of parents at any level.
																-- We iterate backwards from the current position and for each subsequent parent node, determine
																-- if a line must be drawn.
															from
																check parent_row_i /= Void then end
																loop_current_row := parent_row_i
																loop_parent_row := parent_row_i.parent_row_i
															until
																current_horizontal_pos < current_item_x_position or loop_parent_row = Void
															loop
																current_horizontal_pos := current_horizontal_pos - standard_subrow_indent
																if current_horizontal_pos < current_item_x_position + current_column_width then
																		-- It is possible that the current vertical line segment that we must draw is outside the right hand
																		-- edge of the item. In this case, we simply do not draw it. This reduces flicker and time spent
																		-- drawing.
																	l_parent_row := loop_parent_row.attached_interface
																	l_subrow_index := l_parent_row.subrow_count
																	if l_subrow_index > 0 then
																		loop_parent_row_last_displayed_subrow := l_parent_row.subrow (l_subrow_index)
																		if not loop_parent_row_last_displayed_subrow.is_show_requested then
																				-- The final subrow of the parent row is not displayed, so we must iterate until we find the last that is.
																			from
																			until
																				loop_parent_row_last_displayed_subrow.is_show_requested
																			loop
																				l_subrow_index := l_subrow_index - 1
																				loop_parent_row_last_displayed_subrow := l_parent_row.subrow (l_subrow_index)
																			end
																		end
																		if loop_parent_row_last_displayed_subrow.index > loop_current_row.index then
																				-- If the current item is not the last visible item contained within the parent then a line must be drawn.
																			item_buffer_pixmap.draw_segment (current_horizontal_pos, row_vertical_bottom, current_horizontal_pos, 0)
																				-- Draw the vertical line from the bottom of the item to the top.
																		end
																	end
																end
																	-- Move one position upwards within the parenting node structure
																loop_current_row := loop_parent_row
																loop_parent_row := loop_parent_row.parent_row_i
															end
														end
													end
												end
											elseif drawing_subrow and then current_column_index < node_index then
													-- We may have to draw grandparent connection nodes.
												from
													check parent_row_i /= Void then end
													loop_parent_row := parent_row_i.parent_row_i
													Item_buffer_pixmap.set_foreground_color (tree_node_connector_color)
												until
													loop_parent_row = Void
												loop
													l_parent_row := loop_parent_row.attached_interface
													l_subrow_index := l_parent_row.subrow_count
													if l_subrow_index > 0 and then l_parent_row.index_of_first_item = current_column_index then
														loop_parent_row_last_displayed_subrow := l_parent_row.subrow (l_subrow_index)
														if not loop_parent_row_last_displayed_subrow.is_show_requested then
																-- The final subrow of the parent row is not displayed, so we must iterate until we find the last that is.
															from
															until
																loop_parent_row_last_displayed_subrow.is_show_requested
															loop
																l_subrow_index := l_subrow_index - 1
																loop_parent_row_last_displayed_subrow := l_parent_row.subrow (l_subrow_index)
															end
														end
														if loop_parent_row_last_displayed_subrow.index > current_row.index then
																-- If the last displayed subrow is below us then we can drawn the connecting line.
															l_x_start := subrow_indent (loop_parent_row) + ((node_pixmap_width) // 2)
															item_buffer_pixmap.draw_segment (l_x_start, row_vertical_bottom, l_x_start, 0)
																-- Draw the vertical line from the bottom of the item to the top.
														end
													end
														-- Move one position upwards within the parenting node structure
													loop_parent_row := loop_parent_row.parent_row_i
												end
											end
										end
										if grid_item_exists and then attached grid_item then
											if current_tree_adjusted_item_x_position - current_item_x_position < current_column_width then
												if current_column_index = node_index then
													grid_item.perform_redraw (current_tree_adjusted_item_x_position, current_item_y_position, current_tree_adjusted_column_width, current_row_height, current_subrow_indent, item_buffer_pixmap)
												else
													grid_item.perform_redraw (current_tree_adjusted_item_x_position, current_item_y_position, current_tree_adjusted_column_width, current_row_height, 0, item_buffer_pixmap)
												end
											end
											first_item_in_row_drawn := True
										else
											translated_parent_x_indent_position := (parent_x_indent_position + g.subrow_indent - 1)

											if parent_node_index < current_column_index then
												translated_parent_x_indent_position := 0
											end

											item_buffer_pixmap.set_foreground_color (tree_node_connector_color)
											if drawing_subrow and ((current_column_index = current_row.index_of_first_item)) then
													-- Here we must extend the line drawn from the horizontal offsets of the parent to the start of this item.
													-- As the item is `Void', we set the end to the right hand edge of the column.
												l_x_end := current_column_width
												if parent_node_index /= current_column_index then
														-- In this case, there is no parent node connection from within this cell, so we
														-- set the left edge for drawing to the very left edge of the column.
													l_x_start := 0
												end
												item_buffer_pixmap.draw_segment (l_x_start, row_vertical_center, l_x_end, row_vertical_center)
											end
											if are_tree_node_connectors_shown and (drawing_subrow or drawing_parentrow) and current_column_index /= node_index and current_column_index >= parent_node_index then

													-- We must now draw the lines for the tree structure, as although there is no item
													-- at this location in the grid, a tree line may cross it horizontally.
												if current_column_index < node_index then

													item_buffer_pixmap.draw_segment (translated_parent_x_indent_position.min (current_column_width), row_vertical_center, current_column_width, row_vertical_center)
														-- The background area for the tree node must always be refreshed, even if the node is not visible.
														-- We draw no wider than `current_column_width' to ensure this.
												end
												if drawing_subrow and then (parent_node_index = current_column_index) and (translated_parent_x_indent_position < current_column_width) then
														-- If the grid column being drawn matches that in which the
														-- node of `parent_row_i' is contained, then vertical lines must be drawn
														-- to connect the lines.
													check parent_row_i /= Void then end
													if current_row = parent_row_i.subrows [parent_row_i.subrow_count] then
															-- We are drawing the last subrow of `parent_row_i' so we only draw the vertical line to the center of the line.
														item_buffer_pixmap.draw_segment (translated_parent_x_indent_position, row_vertical_center, translated_parent_x_indent_position, 0)
													else
															-- Draw a vertical line down to the next item
														item_buffer_pixmap.draw_segment (translated_parent_x_indent_position, row_vertical_bottom, translated_parent_x_indent_position, 0)
													end
												end
											end
										end
											-- Now draw the border for `grid_item'.
										draw_item_border (current_column, current_row, grid_item, current_item_x_position, current_item_y_position, current_column_width, current_row_height)

											-- Now call the post draw overlay actions on the grid, permitting overdraw as required.
										if attached g.post_draw_overlay_actions_internal then
											if grid_item_exists and then attached grid_item then
												g.post_draw_overlay_actions.call ([item_buffer_pixmap, grid_item.interface, current_column_index, current_row_index])
											else
												g.post_draw_overlay_actions.call ([item_buffer_pixmap, Void, current_column_index, current_row_index])
											end
										end

											-- Now blit the buffered drawing for the item to `drawable'.
										temp_rectangle.move_and_resize (0, 0, current_column_width, current_row_height)
										if locked = Void then
											if current_column.is_locked or current_row.is_locked then--(not current_column.is_locked) or (not current_row.is_locked) then
												drawable.set_foreground_color (gray)
												drawable.fill_rectangle (current_item_x_position, current_item_y_position, current_column_width, current_row_height)
											else
												drawable.draw_sub_pixmap (current_item_x_position, current_item_y_position, item_buffer_pixmap, temp_rectangle)
											end
										else
											if locked_column /= Void then
												if g.row_internal (current_row_index).is_locked and then attached g.row_internal (current_row_index).locked_row as l_locked_row and then l_locked_row.locked_index > locked_column.locked_index then
													if attached current_column.background_color as l_background_color then
														drawable.set_foreground_color (l_background_color)
													else
														drawable.set_foreground_color (gray)
													end
													drawable.fill_rectangle (0, current_item_y_position, current_column_width, current_row_height)
												else
													drawable.draw_sub_pixmap (0, current_item_y_position, item_buffer_pixmap, temp_rectangle)
												end
											elseif locked_row /= Void then
												if g.column_internal (current_column_index).is_locked and then attached g.column_internal (current_column_index).locked_column as l_locked_column and then l_locked_column.locked_index > locked_row.locked_index then
													if attached current_row.background_color as l_background_color then
														drawable.set_foreground_color (l_background_color)
													else
														drawable.set_foreground_color (gray)
													end
													drawable.fill_rectangle (current_item_x_position, 0, current_column_width, current_row_height)
												else
													drawable.draw_sub_pixmap (current_item_x_position, 0, item_buffer_pixmap, temp_rectangle)
												end
											else
												check False end
											end
										end
									end
									visible_column_indexes.forth
								end
								visible_row_indexes.forth
							end
						end
							-- Now draw in the background area where no items were displayed if required.
							-- Note that we perform the vertical and horizontal drawing separately so there may be overlap if both are
							-- being drawn at once. This does not matter as it is simpler to implement, has no real performance impact as
							-- it is simply drawing a rectangle and does not flicker.

						rectangle_width := internal_client_width - (column_offsets @ (column_offsets.count) - internal_client_x)
							-- We compute the rectangle width based on the position of the final item within `column_offsets'.
						if rectangle_width > 0 then
							if item_buffer_pixmap.width < rectangle_width or item_buffer_pixmap.height < internal_client_height then
								item_buffer_pixmap.set_size (rectangle_width, internal_client_height)
							end
								-- Check to see if we must draw the background to the right of the items.
							if g.fill_background_actions_internal /= Void and then not g.fill_background_actions.is_empty then
								g.fill_background_actions.call ([item_buffer_pixmap, column_offsets @ (column_offsets.count), internal_client_y, rectangle_width, internal_client_height])
							else
								item_buffer_pixmap.set_foreground_color (g.background_color)
								item_buffer_pixmap.fill_rectangle (0, 0, rectangle_width, internal_client_height)
							end
							temp_rectangle.move_and_resize (0, 0, rectangle_width, internal_client_height)
							if locked_row = Void then
								drawable.draw_sub_pixmap  (horizontal_buffer_offset + internal_client_width - rectangle_width, vertical_buffer_offset, item_buffer_pixmap, temp_rectangle)
							else
								drawable.draw_sub_pixmap  (horizontal_buffer_offset + internal_client_width - rectangle_width, 0, item_buffer_pixmap, temp_rectangle)
							end
						end
						if current_row = Void or else current_row.index >= g.visible_row_count then
							if not g.uses_row_offsets then
									-- Special handling for fixed row heights as `row_offsets' does not exist.
								v_y := (row_height * (row_count))
								rectangle_height := internal_client_height - (v_y - internal_client_y)
							else
								check row_offsets /= Void then end
								v_y := row_offsets @ (row_count + 1)
								rectangle_height := internal_client_height - (v_y - internal_client_y)
							end
							if rectangle_height > 0 then
								-- Check to see if must draw the background below the items.

								if item_buffer_pixmap.width < internal_client_width or item_buffer_pixmap.height < rectangle_height then
									item_buffer_pixmap.set_size (internal_client_width, rectangle_height)
								end
								if g.fill_background_actions_internal /= Void and then not g.fill_background_actions.is_empty then
									g.fill_background_actions.call ([item_buffer_pixmap, internal_client_x, v_y , internal_client_width, rectangle_height])
								else
									item_buffer_pixmap.set_foreground_color (g.background_color)
									item_buffer_pixmap.fill_rectangle (0, 0, internal_client_width, rectangle_height)
								end
								temp_rectangle.move_and_resize (0, 0, internal_client_width, rectangle_height)
								if locked_column = Void then
									drawable.draw_sub_pixmap (horizontal_buffer_offset, vertical_buffer_offset + internal_client_height - rectangle_height, item_buffer_pixmap, temp_rectangle)
								else
									drawable.draw_sub_pixmap (0, vertical_buffer_offset + internal_client_height - rectangle_height, item_buffer_pixmap, temp_rectangle)
								end
							end
						end
					else
							-- In this situation, the grid is completely empty, so we simply fill the background color.
						if g.fill_background_actions_internal /= Void and then not g.fill_background_actions.is_empty then
							if item_buffer_pixmap.width < a_width or item_buffer_pixmap.height < a_height then
							   item_buffer_pixmap.set_size (a_width, a_height)
							end
							g.fill_background_actions.call ([item_buffer_pixmap, internal_client_x, internal_client_y, a_width, a_height])
							temp_rectangle.move_and_resize (0, 0, a_width, a_height)
							drawable.draw_sub_pixmap (an_x, a_y, item_buffer_pixmap, temp_rectangle)
						else
							drawable.set_foreground_color (g.background_color)
							drawable.fill_rectangle (an_x, a_y, a_width, a_height)
						end
					end
					if not g.is_column_resize_immediate and g.is_header_item_resizing and g.is_resizing_divider_enabled then
							-- Put the resizing line back on the redrawn area so that it can be correctly erased
							-- by being inverted later.
						g.redraw_resizing_line
					end
				end
				drawable.end_drawing_session
			end
		end

feature {EV_GRID_DRAWABLE_ITEM_I} -- Implementation

	drawable_item_buffer_pixmap: EV_PIXMAP
			-- Once access to a pixmap used for drawing into for drawable items.
			-- We do not use `item_buffer_pixmap' for this as this pixmap is exposed to
			-- the interface so, must be resized exactly to the size of the item before
			-- a user retrieves it. They can then query its dimensions to know where to draw to.
		once
			create Result
		end

feature {NONE} -- Implementation

	subrow_indent (current_row: EV_GRID_ROW_I): INTEGER
			-- `Result' is indent of `current_row'.
		require
			current_row_not_void: current_row /= Void
		do
			Result := grid.item_cell_indent (current_row.index_of_first_item, current_row.index)
		ensure
			result_non_negative: Result >= 0
		end

	retrieve_node_index (current_row: EV_GRID_ROW_I): INTEGER
			-- `Result' is index of first non-`Void' item within `current_row'
			-- or `grid.column_count' if none.
		require
			current_row_not_void: current_row /= Void
		do
			Result := current_row.index_of_first_item
			if Result = 0 then
				Result := 1
			end
		ensure
			valid_result: Result > 0 and Result <= grid.column_count
		end

	draw_item_border (current_column: EV_GRID_COLUMN_I; current_row: EV_GRID_ROW_I; current_item: detachable EV_GRID_ITEM_I; current_item_x_position, current_item_y_position, current_column_width, current_row_height: INTEGER)
			-- Draw a border for `current_item' with a position at `current_item_x_position', `current_item_y_position' and dimensions
			-- of `current_column_width' and `current_row_height'.
		require
			current_column_not_void: current_column /= Void
			current_row_not_void: current_row /= Void
			current_column_width_greater_than_zero: current_column_width > 0
		local
			drawable: EV_DRAWING_AREA
			all_remaining_columns_minimized: BOOLEAN
			g: like grid
		do
			g := grid
			drawable := g.drawable
			item_buffer_pixmap.set_foreground_color (g.separator_color)
			if g.are_column_separators_enabled then
				if current_column.index > 1 then
					item_buffer_pixmap.draw_segment (0, 0, 0, current_row_height - 1)
				end
				if current_column.index < g.column_count then
					if g.column_offsets.i_th (current_column.index + 1) = g.column_offsets.i_th (g.column_count + 1) then
						all_remaining_columns_minimized := True
					end
				end
				if current_column.index = g.column_count or all_remaining_columns_minimized then
					item_buffer_pixmap.draw_segment (current_column_width - 1, 0,  current_column_width - 1, current_row_height - 1)
				end
			end
			if g.are_row_separators_enabled then
				item_buffer_pixmap.draw_segment (0, current_row_height - 1, current_column_width, current_row_height - 1)
			end
		end

	white: EV_COLOR
			-- Once access to the color white.
		once
			Result := (create {EV_STOCK_COLORS}).white
		end

	black: EV_COLOR
			-- Once access to the color black.
		once
			Result := (create {EV_STOCK_COLORS}).black
		end

	gray: EV_COLOR
			--
		once
			Result := (create {EV_STOCK_COLORS}).gray
		end

	horizontal_border_width: INTEGER = 3
		-- Border from edge of text to edge of grid items.

	pre_search_iteration_size: INTEGER = 1000
		-- When searching for an offset in `row_offsets', this is the value
		-- user to pre-search the data when looking for the first index to start the
		-- iteration from. By performing an intial loop, we can reduce the number of
		-- iterations to be performed in the main loop. Together, the total
		-- number of iterations of both loops is far less. There may be a better
		-- value, but this should give fairly good results.
		-- The maximum number of iterations is given by (`row_count' / pre_search_iteration_size) + pre_search_iteration_size
		-- Julian 05/16/05

	item_buffer_pixmap: EV_PIXMAP
			-- Once access to a pixmap used for buffering the drawing to prevent flicker.
		once
			create Result
			Result.set_size (100, 16)
		end

	temp_rectangle: EV_RECTANGLE
		-- A rectangle used temporarily by the drawing code.
		-- Prevents the need to keep creating new rectangle objects
		-- which may be a strain on the debugger as many are created unecessarily.

	drawable_x_to_virtual_x (an_x: INTEGER): INTEGER
			-- Convert `an_x' in drawable coordinates to a virtual x coordinate.
		do
			Result := grid.internal_client_x + an_x - grid.viewport_x_offset
		end

	drawable_y_to_virtual_y (a_y: INTEGER): INTEGER
			-- Convert `a_y' in drawable coordinates to a virtual y coordinate.
		do
			Result := grid.internal_client_y + a_y - grid.viewport_y_offset
		end

invariant
	grid_not_void: grid /= Void
	temp_rectangle_not_void: temp_rectangle /= Void

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
