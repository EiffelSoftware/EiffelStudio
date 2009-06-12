note
	description: "Representation of a row of an EV_GRID"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_ROW_I

inherit
	REFACTORING_HELPER
		undefine
			default_create, copy, is_equal
		end

	EV_GRID_ROW_ACTION_SEQUENCES_I
		export
			{EV_GRID_I}
				deselect_actions_internal
		end

	EV_DESELECTABLE_I
		export
			{EV_ANY, EV_ANY_I, EV_GRID_DRAWER_I} attached_interface
		redefine
			interface,
			is_selectable
		end

	HASHABLE

create
	make

feature {EV_ANY} -- Initialization

	old_make (an_interface: like interface)
			-- Create `Current' with interface `an_interface'.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'.
		do
			create subrows
			internal_height := default_row_height
			depth_in_tree := 1
			indent_depth_in_tree := 1
			subrow_count_recursive := 0
			expanded_subrow_count_recursive := 0
			is_expanded := False
			hash_code := 0
			is_show_requested := True
			set_is_initialized (True)
		end

feature {EV_GRID_I, EV_GRID_ROW_I} -- Initialization

	index_of_first_item_dirty: BOOLEAN
		-- Should `index_of_first_item' be recalculated.

	flag_index_of_first_item_dirty_if_needed (a_column_index: INTEGER)
			-- Flag `index_of_first_item' to be recalculated on next call if needed based on `a_column_index'.
		require
			a_column_index_valid: a_column_index > 0 and then a_column_index <= count + 1
		do
			if not index_of_first_item_dirty then
					-- We do not want to reset if already True.
				index_of_first_item_dirty := a_column_index <= index_of_first_item_internal or else index_of_first_item_internal = 0
			end
		end

	index_of_first_item_internal: INTEGER
		-- Previous result of call to `index_of_first_item'.

	set_index (a_index: INTEGER)
			-- Set the index of row in grid.
		require
			a_index_greater_than_zero: a_index > 0
		do
			index := a_index
		ensure
			index_set: index = a_index
			indexes_equivalent: attached parent_i as l_parent_i and then l_parent_i.rows.i_th (index) = Current
			index_less_than_row_count: attached parent as l_parent and then index <= l_parent.row_count
		end

	set_subrow_index (a_subrow_index: INTEGER)
			-- Set the index of row in parent row.
		require
			subrow_index_not_negative: a_subrow_index >= 0
		do
			subrow_index := a_subrow_index
		ensure
			index_set: subrow_index = a_subrow_index
			indexes_equivalent: attached parent_row_i as l_parent_row_i and then a_subrow_index > 0 implies l_parent_row_i.subrows.i_th (subrow_index) = Current
			index_less_than_row_count: attached parent_row_i as l_parent_row_i and then subrow_index <= l_parent_row_i.subrow_count
		end

	set_parent_i (a_grid_i: EV_GRID_I; a_row_id: INTEGER)
			-- Make `Current' associated with `a_grid_i'.
		require
			a_grid_i_not_void: a_grid_i /= Void
			grid_not_already_set: parent_i = Void
			a_row_id_valid: a_row_id > 0
		do
			parent_i := a_grid_i
			hash_code := a_row_id
		ensure
			parent_set: parent_i = a_grid_i
			row_id_set: hash_code = a_row_id
		end

feature -- Access

	subrow (i: INTEGER): EV_GRID_ROW
			-- `i'-th child of Current.
		require
			is_parented: parent /= Void
			i_positive: i > 0
			i_less_than_subrow_count: i <= subrow_count
		local
			l_row: detachable EV_GRID_ROW_I
		do
			l_row := subrows.i_th (i)
			check l_row /= Void end
			Result := l_row.attached_interface
		ensure
			subrow_not_void: Result /= Void
			subrow_valid: (Result.parent /= Void) and then has_subrow (Result) and then Result.parent_row = attached_interface
		end

	has_subrow (a_row: EV_GRID_ROW): BOOLEAN
			-- Is `a_row' a child of Current?
		require
			a_row_not_void: a_row /= Void
			is_parented: parent /= Void
		do
			Result := subrows.has (a_row.implementation)
		ensure
			has_subrow_same_parent: Result implies
				((a_row.parent /= Void and parent /= Void) and then a_row.parent = parent)
		end

	parent_row: detachable EV_GRID_ROW
			-- Parent row of Current if any, Void otherwise.
		require
			is_parented: parent /= Void
		do
			if attached parent_row_i as l_parent_row_i then
				Result := l_parent_row_i.interface
			end
		ensure
			result_void_when_tree_node_enabled: (parent = Void) or
				(attached parent as l_parent and then not l_parent.is_tree_enabled) implies Result = Void
			has_parent: Result /= Void implies Result.has_subrow (attached_interface)
		end

	parent: detachable EV_GRID
			-- Grid to which current row belongs.
		do
			if attached parent_i as l_parent_i then
				Result := l_parent_i.interface
			end
		end

	parent_row_root: detachable EV_GRID_ROW
			-- Parent row which is the root of the tree structure
			-- in which `Current' is contained. May be `Current' if
			-- `Current' is the root node of a tree structure.
		require
			is_parented: parent /= Void
		local
			current_parent: EV_GRID_ROW_I
		do
			if attached parent as l_parent and then l_parent.is_tree_enabled then
					-- If the tree is not enabled then `Result' must be False.
				if attached parent_row_i as l_parent_row_i then
					from
						current_parent := l_parent_row_i
					until
						current_parent.parent_row_i = Void
					loop
						if attached current_parent.parent_row_i as l_par_row_i then
							current_parent := l_par_row_i
						end
					end
					Result := current_parent.attached_interface
				else
						-- In this case, there is no `parent_row_i' as `Current'
						-- is the root node of a tree, so return `interface'
					Result := attached_interface
				end
			end
		ensure
			result_consistent_with_parent_tree_properties: (parent = Void or else (attached parent as l_parent and then not l_parent.is_tree_enabled)) = (Result = Void)
		end

	item (i: INTEGER): detachable EV_GRID_ITEM
			-- Item at `i'-th column, Void if none.
		require
			i_within_bounds: i > 0 and i <= count
			is_parented: parent /= Void
		do
			if attached parent_i as l_parent_i then
				Result := l_parent_i.item (i, index)
			end
		end

	selected_items: ARRAYED_LIST [EV_GRID_ITEM]
			-- All items selected in `Current'.
		require
			is_parented: parent /= Void
		local
			i, a_count: INTEGER
			a_item: detachable EV_GRID_ITEM_I
			temp_parent_i: like parent_i
		do
			from
				i := 1
				a_count := count
				create Result.make (a_count)
				temp_parent_i := parent_i
				check temp_parent_i /= Void end
			until
				i > a_count
			loop
					-- If `is_selected' then we need to make sure there are no Void items contained within `Current'
				a_item := temp_parent_i.item_internal (i, index)
				if a_item /= Void and then a_item.is_selected then
					Result.extend (a_item.attached_interface)
				end
				i := i + 1
			end
		ensure
			result_not_void: Result /= Void
			valid_count: Result.count <= count
		end

	is_expanded: BOOLEAN
			-- Are subrows of `Current' displayed?

	height: INTEGER
			-- Height of `Current' when displayed in a `parent'
			-- that has `is_row_height_fixed' set to `False'.
			-- Note that `height' is ignored if the parent has
			-- `is_row_height_fixed' set to `True' and then all rows
			-- are displayed with identical heights set to `parent.row_height'.
		require
			is_parented: parent /= Void
		do
			Result := internal_height
		ensure
			result_not_negative: Result >= 0
		end

	internal_height: INTEGER

	is_selected: BOOLEAN
			-- Is objects state set to selected.
		do
			if attached parent_i as l_parent_i then
				if l_parent_i.is_row_selection_enabled or else index_of_first_item = 0 then
					Result := internal_is_selected
				else
					Result := internal_are_all_non_void_items_selected
				end
			end
		end

	is_selectable: BOOLEAN
			-- May the object be selected?
		do
			Result := parent_i /= Void
		end

	internal_is_selected: BOOLEAN
		-- Is `Current' selected in either row selection mode?

	internal_update_selection (a_selection_state: BOOLEAN)
			-- Set the selection state of all non void items in `Current' to `a_selection_state'.
		local
			a_item: detachable EV_GRID_ITEM_I
			i: INTEGER
			a_count: INTEGER
			a_index: INTEGER
			a_parent_i: detachable EV_GRID_I
		do
			from
				i := 1
				a_index := index
				a_parent_i := parent_i
				check a_parent_i /= Void end
				a_count := count
			until
				i > a_count
			loop
				a_item := a_parent_i.item_internal (i, a_index)
				if a_item /= Void then
					if a_selection_state then
						a_item.enable_select_internal
					else
						a_item.disable_select_internal
					end
				end
				i := i + 1
			end
		end

	internal_are_all_non_void_items_selected: BOOLEAN
			-- Are all the non void items in `Current' selected?
			-- False if no non void items are present.
		local
			a_item: detachable EV_GRID_ITEM_I
			i: INTEGER
			a_count: INTEGER
			non_void_item_found: BOOLEAN
			a_index: INTEGER
			l_parent_i: detachable EV_GRID_I
		do
			from
				i := 1
				Result := True
				a_count := count
				a_index := index
				l_parent_i := parent_i
				check l_parent_i /= Void end
			until
				not Result or else i > a_count
			loop
				a_item := l_parent_i.item_internal (i, a_index)
				if a_item /= Void then
					non_void_item_found := True
					Result := a_item.is_selected
				end
				i := i + 1
			end
			if not non_void_item_found then
					-- If there are no non-void items in row then it cannot be selected
				Result := False
			end
		end

	virtual_y_position: INTEGER
			-- Vertical offset of `Current' in relation to the
			-- the virtual area of `parent' grid in pixels.
			-- `Result' is 0 if `parent' is `Void'.
		do
			if is_locked and then attached parent_i as l_parent_i and then attached locked_row as l_locked_row then
				Result := l_parent_i.internal_client_y + l_locked_row.offset
			else
				Result := virtual_y_position_unlocked
			end
		ensure
			parent_void_implies_result_zero: parent = Void implies Result = 0
		end

	virtual_y_position_unlocked: INTEGER
			-- Vertical offset of unlocked position of `Current', in relation to the
			-- virtual area of `parent' grid in pixels.
			-- If not `is_locked', then `virtual_y_position' = `unlocked_virtual_y_position'.
			-- If `is_locked' then `Result' is the "shadow" position where the row would
			-- be if not locked.
		do
			if attached parent_i as l_parent_i then
					-- If there is no parent then return 0.

				l_parent_i.perform_vertical_computation
					-- Recompute vertically if required.

				if attached l_parent_i.row_offsets as l_row_offsets then
						-- As `row_offsets' exists, we can look it up,
						-- otherwise it must be computed.
					Result := l_row_offsets @ (index)
				else
					Result := (index - 1) * l_parent_i.row_height
				end
			end
		ensure
			parent_void_implies_result_zero: parent = Void implies Result = 0
		end

	is_expandable: BOOLEAN
			-- May `Current' be expanded?
		require
			is_parented: parent /= Void
		do
			Result := parent /= Void and (subrow_count > 0 or is_ensured_expandable)
		end

	hash_code: INTEGER
			-- Number to uniquely identify grid row within `parent_i'.
			-- Should be set to 0 if `Current' is not parented.

feature -- Status report

	locked_row: detachable EV_GRID_LOCKED_ROW_I
		-- Locked row information for `Current'.
		-- `Void' if not locked.

	subrow_count: INTEGER
			-- Number of children.
		require
			is_parented: parent /= Void
		do
			Result := subrows.count
		ensure
			subrow_count_non_negative: subrow_count >= 0
			subrow_count_in_range: attached parent as l_parent and then subrow_count <= (l_parent.row_count - index)
		end

	subrow_count_recursive: INTEGER
			-- Number of child rows and their child rows recursively.

	index: INTEGER
			-- Position of Current in `parent'.

	subrow_index: INTEGER
			-- Position of `Current' in `parent_row' if any.

	count: INTEGER
			-- Number of items in current.
		do
			if attached parent_i as l_parent_i then
				Result := l_parent_i.columns.count
			end
		ensure
			count_not_negative: count >= 0
		end

	index_of_first_item: INTEGER
			-- Return the index of the first non `Void' item within `Current'
			-- or 0 if none.
		do
			if index_of_first_item_dirty then
				index_of_first_item_internal := index_of_first_item_value
				index_of_first_item_dirty := False
			end
			Result := index_of_first_item_internal
		ensure
			valid_result: Result >= 0 and Result <= count
			value_valid: index_of_first_item_internal = index_of_first_item_value
		end

	index_of_first_item_value: INTEGER
			-- Return the index of the first non `Void' item within `Current'
			-- or 0 if none.
		local
			counter: INTEGER
			current_row_list: detachable SPECIAL [detachable EV_GRID_ITEM_I]
			current_row_list_count: INTEGER
			a_item: detachable EV_GRID_ITEM_I
			column_list_area: SPECIAL [detachable EV_GRID_COLUMN_I]
			a_column: detachable EV_GRID_COLUMN_I
			a_physical_index: INTEGER
			row_count: INTEGER
			l_parent_i: like parent_i
		do
			l_parent_i := parent_i
			check l_parent_i /= Void end
			current_row_list := l_parent_i.internal_row_data @ index
			check current_row_list /= Void end
			column_list_area := l_parent_i.columns.area
			current_row_list_count := current_row_list.count
			row_count := count
			from
				counter := 0
			until
				a_item /= Void or else counter = row_count
			loop
				a_column := (column_list_area @ counter)
				check a_column /= Void end
				a_physical_index := a_column.physical_index
				if a_physical_index < current_row_list_count then
					a_item := current_row_list @ a_physical_index
				end
				counter := counter + 1
			end
			if a_item /= Void then
				Result := counter
			end
		ensure
			valid_result: Result >= 0 and Result <= count
		end

	background_color: detachable EV_COLOR
			-- Color displayed as background of `Current' except where there are items contained that
			-- have a non-`Void' `background_color'. If `Void', `background_color' of `parent' is displayed..

	foreground_color: detachable EV_COLOR
			-- Color displayed for foreground features of `Current' except where there are items contained that
			-- have a non-`Void' `foreground_color'. If `Void', `foreground_color' of `parent' is displayed.

	is_locked: BOOLEAN
			-- Is `Current' locked so that it no longer scrolls?
			-- Note that this could be implemented as a function
			-- "Result := parent_i.locked_rows.item (index) /= Void" but this has not been done
			-- so for performance reasons.

	locked_position: INTEGER
			-- Locked position of `Current' from top edge of viewable area of `parent'.
			-- `Result' is 0 if not `is_locked'.
		do
			if is_locked and then attached locked_row as l_locked_row then
				Result := l_locked_row.offset
			end
		ensure
			not_locked_implies_result_zero: not is_locked implies result = 0
		end

feature -- Status setting

	lock_at_position (a_position: INTEGER)
			-- Ensure `is_locked' is `True' with the vertical offset from
			-- the top edge of the viewable area of `parent' set to `a_position'.
		local
			l_parent_i: like parent_i
			l_locked_row: like locked_row
		do
			l_parent_i := parent_i
			check l_parent_i /= Void end
			if is_locked then
				unlock
			end
			is_locked := True
			create l_locked_row.make (l_parent_i, a_position, Current)
			locked_row := l_locked_row
			l_locked_row.set_locked_index (l_parent_i.locked_indexes.count + 1)
			l_parent_i.locked_indexes.extend (l_locked_row)
			l_parent_i.reposition_locked_row (Current)
			l_parent_i.redraw_row (Current)
			if l_parent_i.item_pebble_function /= Void then
				l_locked_row.drawing_area.set_pebble_function (agent l_parent_i.user_pebble_function_intermediary_locked (?, ?, l_locked_row))
			end
			l_locked_row.drawing_area.drop_actions.set_veto_pebble_function (agent l_parent_i.veto_pebble_function_intermediary)
			l_locked_row.drawing_area.drop_actions.extend (agent l_parent_i.drop_action_intermediary)
			l_locked_row.drawing_area.set_accept_cursor (l_parent_i.attached_interface.accept_cursor)
			l_locked_row.drawing_area.set_deny_cursor (l_parent_i.attached_interface.deny_cursor)
		ensure
			is_locked: is_locked
			locked_position_set: locked_position = a_position
		end

	unlock
			-- Ensure `is_locked' is `False'.
		do
			if is_locked and then attached parent_i as l_parent_i then
				is_locked := False
				l_parent_i.unlock_row (Current)
				locked_row := Void
			end
		ensure
			not_is_locked: not is_locked
		end

	expand
			-- Display all subrows of `Current'.
		require
			is_parented: parent /= Void
			is_expandable: is_expandable
		local
			l_parent_i: like parent_i
		do
			if not is_expanded then
				is_expanded := True
				l_parent_i := parent_i
				check l_parent_i /= Void end
				if subrow_count > 0 then
						-- If `Current' has children then compute and redraw.
						-- If `is_ensured_expandable' then it is possible that there
						-- are no children, so do not perform the calculations.

					update_parent_expanded_node_counts_recursively (contained_expanded_items_recursive)
						-- Update the expanded node counts for `Current' and all parent nodes.

					if displayed_in_grid_tree then
							-- Only recompute the row offsets if `Current' is visible
							-- otherwise the row offsets are already correct.
						l_parent_i.set_vertical_computation_required (index)
					end
				end

				if l_parent_i.row_expand_actions_internal /= Void then
						-- The expand actions are fired after we set vertical computation
						-- to ensure that if you query a dimension from within the actions,
						-- they are up to date.
					l_parent_i.row_expand_actions.call ([attached_interface])
				end
				if expand_actions_internal /= Void then
					expand_actions.call (Void)
				end

				if is_ensured_expandable then
					is_ensured_expandable := False
					is_expanded := subrow_count > 0
				end
				if l_parent_i /= Void then
					l_parent_i.redraw
				end
			end
		ensure
			is_expanded: is_expanded or subrow_count = 0
			node_counts_correct: node_counts_correct
		end

	collapse
			-- Hide all subrows of `Current'.
		require
			is_parented: parent /= Void
		local
			l_parent_i: like parent_i
		do
			if is_expanded then
				l_parent_i := parent_i
				check l_parent_i /= Void end
				is_expanded := False

				update_parent_expanded_node_counts_recursively (- contained_expanded_items_recursive)
					-- Update the expanded node counts for `Current' and all parent nodes.

				if displayed_in_grid_tree then
						-- Only recompute the row offsets if `Current' is visible
						-- otherwise the row offsets are already correct.
					l_parent_i.set_vertical_computation_required (index)
				end

				if l_parent_i.row_collapse_actions_internal /= Void then
						-- The collapse actions are fired after we set vertical computation
						-- to ensure that if you query a dimension from within the actions,
						-- they are up to date.
					l_parent_i.row_collapse_actions.call ([attached_interface])
				end
				if collapse_actions_internal /= Void then
					collapse_actions_internal.call (Void)
				end
				if l_parent_i /= Void then
					l_parent_i.redraw
				end
			end
		ensure
			not_is_expanded: not is_expanded
			node_counts_correct: node_counts_correct
		end

	set_height (a_height: INTEGER)
			-- Assign `a_height' to `height'.
		require
			is_parented: parent /= Void
		do
			internal_height := a_height
			if attached parent_i as l_parent_i and then not l_parent_i.is_row_height_fixed then
				l_parent_i.set_vertical_computation_required (index)
				l_parent_i.redraw
				if is_locked then
					l_parent_i.reposition_locked_row (Current)
				end
			end
		ensure
			height_set: height = a_height
		end

	ensure_visible
			-- Ensure `Current' is visible in viewable area of `parent'.
		require
			parented: parent /= Void
		local
			virtual_y: INTEGER
			l_height: INTEGER
			extra_height: INTEGER
			i: INTEGER
			l_parent_i: like parent_i
		do
				-- It is necessary to perform the recomputation immediately
				-- as this may show the horizontal or vertical scroll bar
				-- which affects the size of the viewable area in which `Current'
				-- is to be displayed.
			l_parent_i := parent_i
			check l_parent_i /= Void end
			l_parent_i.recompute_horizontal_scroll_bar
			l_parent_i.recompute_vertical_scroll_bar

			virtual_y := virtual_y_position
			if l_parent_i.is_row_height_fixed then
				l_height := l_parent_i.row_height
			else
				l_height := height
			end
			if virtual_y < l_parent_i.virtual_y_position then
				l_parent_i.set_virtual_position (l_parent_i.virtual_x_position, virtual_y)
			elseif virtual_y + l_height > l_parent_i.virtual_y_position + l_parent_i.viewable_height then
				if l_parent_i.is_vertical_scrolling_per_item then
						-- In this case, we must ensure that it is always the top item that still matches flush to
						-- the top of the viewable area of `parent_i'. There are two cases that we must handle.
					if l_parent_i.is_row_height_fixed then
						extra_height := l_parent_i.viewable_height \\ l_parent_i.row_height
					else
							-- In this case, the only way to determine the extra amount to add in order
							-- for the top row to be flush with the top of the viewable area, is
							-- to loop up until we find the first one that intersects the viewable area.
						from
							i := index
							extra_height := l_parent_i.viewable_height
						until
							i = 1 or extra_height < 0
						loop
							extra_height := extra_height - l_parent_i.row (i).height
							i := i - 1
						end
						extra_height := l_parent_i.row (i + 1).height + extra_height
					end
				end
				if l_height >= l_parent_i.viewable_height then
						-- In this case, the height of the row is greater than the viewable height
						-- so we simply set it at the top of the viewable area.
					l_parent_i.set_virtual_position (l_parent_i.virtual_x_position, virtual_y)
				else
					l_parent_i.set_virtual_position (l_parent_i.virtual_x_position, virtual_y + l_height + extra_height - l_parent_i.viewable_height)
				end
			end
		ensure
			parent_virtual_x_position_unchanged: attached old parent as l_old_parent and then attached parent as l_parent and then l_old_parent.virtual_x_position = l_parent.virtual_x_position
			to_implement_assertion ("old_is_visible_implies_vertical_position_not_changed")
			row_visible_when_heights_fixed_in_parent: l_parent.is_row_height_fixed implies  virtual_y_position >= l_parent.virtual_y_position and virtual_y_position + l_parent.row_height <= l_parent.virtual_y_position + (l_parent.viewable_height).max (l_parent.row_height)
			row_visible_when_heights_not_fixed_in_parent: not l_parent.is_row_height_fixed implies virtual_y_position >= l_parent.virtual_y_position and virtual_y_position + height <= l_parent.virtual_y_position + (l_parent.viewable_height).max (height)
		end

	set_background_color (a_color: EV_COLOR)
			-- Set `background_color' with `a_color'.
		require
			is_parented: parent /= Void
		do
			background_color := a_color
			if attached parent_i as l_parent_i then
				l_parent_i.redraw_row (Current)
			end
		ensure
			background_color_set: background_color = a_color
		end

	set_foreground_color (a_color: EV_COLOR)
			-- Set `foreground_color' with `a_color'.
		require
			is_parented: parent /= Void
		do
			foreground_color := a_color
			if attached parent_i as l_parent_i then
				l_parent_i.redraw_row (Current)
			end
		ensure
			foreground_color_set: foreground_color = a_color
		end

	ensure_expandable
			-- Ensure `Current' displays an expand pixmap to simulate a `row_count' greater than 0.
			-- May be used for dynamic behavior by filling subrows upon firing of `grid.row_expand_actions'.
			-- If no items are added to `Current' during the firing of `grid.row_expand_actions' then
			-- `Current' is no longer expandable. This may be re-instated by calling `ensure_expandable' again
			-- from `grid.row_expand_actions'. Note that once a subrow is added to `Current' after a call to
			-- `ensure_expandable', it is no longer be displayed as expandable if all subrows are then removed.
			-- In this case, you must explicitly call `ensure_expandable' again after removing all subrows.
		require
			parented: attached parent as l_parent
			parent_tree_enabled: l_parent.is_tree_enabled
		do
			is_ensured_expandable := True
			redraw
		ensure
			is_expandable: is_expandable
		end

	ensure_non_expandable
			-- Restore expanded state of `Current' after a call to `ensure_expandable'. Note that if a row
			-- has one or more subrows, it is always drawn as expanded, hence the "no_subrows_contained" precondition.
		require
			parented: parent /= Void
			no_subrows_contained: subrow_count = 0
		do
			is_ensured_expandable := False
			redraw
		ensure
			not_is_expandable: not is_expandable
		end

	is_ensured_expandable: BOOLEAN
			-- May current be expanded even through it is empty?

	redraw
			-- Force all items within `Current' to be re-drawn when next idle.
		require
			parented: parent /= Void
		do
			if attached parent_i as l_parent_i then
				l_parent_i.redraw_row (Current)
			end
		end

	hide
			-- Prevent `Current' from being shown in `parent'.
		require
			parented: parent /= Void
		do
			if is_show_requested then
				if is_locked and then attached locked_row as l_locked_row then
					l_locked_row.widget.hide
				end
				is_show_requested := False
				if attached parent_i as l_parent_i then
					l_parent_i.adjust_non_displayed_row_count (1)
					if l_parent_i.non_displayed_row_count = 1 then
						l_parent_i.set_vertical_computation_required (1)
					else
						l_parent_i.set_vertical_computation_required (index)
					end
					l_parent_i.redraw
				end
			end
		end

	show
			-- Ensure `Current' is shown in `parent'.
		require
			parented: parent /= Void
		do
			if not is_show_requested then
				if is_locked and then  attached locked_row as l_locked_row then
					l_locked_row.widget.show
				end
				is_show_requested := True
				if is_locked and then attached locked_row as l_locked_row then
					l_locked_row.widget.show
				end
				if attached parent_i as l_parent_i then
					l_parent_i.adjust_non_displayed_row_count (-1)
					l_parent_i.set_vertical_computation_required (index)
					l_parent_i.redraw
				end
			end
		end

	is_show_requested: BOOLEAN
			-- May `Current' be displayed?
			-- Will return `False' if `hide' has been called on `Current'.

	is_displayed: BOOLEAN
			-- Is `Current' visible on the screen?
			-- `True' when show requested and parent displayed.
			-- A row that is_displayed does not necessarily have to be visible on screen at that particular time.
		do
			Result := is_show_requested and then attached parent_i as l_parent_i and then l_parent_i.is_displayed
		end

feature {EV_GRID_ROW, EV_ANY_I}-- Element change

	set_item (i: INTEGER; a_item: EV_GRID_ITEM)
			-- Set item at `i'-th column to be `a_item'.
			-- If `a_item' is `Void', the current item (if any) is removed.
		require
			i_positive: i > 0
			a_item_not_parented: a_item /= Void implies a_item.parent = Void
			is_parented: attached parent as l_parent
			valid_tree_structure: a_item /= Void and l_parent.is_tree_enabled and attached parent_row as l_parent_row implies i >= l_parent_row.index_of_first_item
		do
			if attached parent_i as l_parent_i then
				l_parent_i.set_item (i, index, a_item)
			end
		ensure
			item_set: item (i) = a_item
		end

	add_subrow (a_row: EV_GRID_ROW)
			-- Make `a_row' a child of Current.
		require
			is_parented: attached parent as l_parent
			a_row_not_void: a_row /= Void
			a_row_is_parented: a_row.parent /= Void
			a_row_is_not_current: a_row /= interface
			a_row_is_not_a_subrow: a_row.parent_row = Void
			same_parent: a_row.parent = parent
			parent_enabled_as_tree: l_parent.is_tree_enabled
			a_row_is_below_current: a_row.index > index
			all_rows_between_row_and_current_are_subrows:
				a_row.index = index + subrow_count_recursive + 1
			row_not_empty_implies_row_index_of_first_item_greater_or_equal_to_index_of_first_item:
				a_row.index_of_first_item > 0 implies a_row.index_of_first_item >= index_of_first_item
		do
			add_subrows_internal (1, a_row.index, subrow_count + 1, False)
		ensure
			added: a_row.parent_row = interface
			subrow (subrow_count) = a_row
			node_counts_correct: node_counts_correct
		end

	insert_subrows (rows_to_insert, a_subrow_index: INTEGER)
			-- Add `rows_to_insert' rows to `parent' as a subrow of `Current'
			-- with index in subrows of `Current' given by `a_subrow_index'.
		require
			not_destroyed: not is_destroyed
			is_parented: attached parent as l_parent
			parent_enabled_as_tree: l_parent.is_tree_enabled
			rows_to_insert_positive: rows_to_insert >= 1
			valid_subrow_index: a_subrow_index >= 1 and a_subrow_index <= subrow_count + 1
		local
			l_subrow: detachable EV_GRID_ROW_I
			l_index: INTEGER
		do
			if a_subrow_index = 1 then
				l_index := index + 1
			else
					-- There is a subrow before the current insert index so
					-- add at a position in `parent_i' based on the item before the insert
					-- As this item may have rows of it's own the subrow count recursive must also be added.
				l_subrow := subrows.i_th (a_subrow_index - 1)
				check l_subrow /= Void end
				l_index := l_subrow.index + l_subrow.subrow_count_recursive + 1
			end
			if attached parent as l_parent_i then
				l_parent_i.insert_new_rows_parented (rows_to_insert, l_index, attached_interface)
			end
		ensure
			subrow_count_increased: subrow_count = old subrow_count + rows_to_insert
			parent_row_count_increased: attached parent as l_parent and then l_parent.row_count = old attached_parent.row_count + rows_to_insert
		end

	remove_subrow (a_row: EV_GRID_ROW)
			-- Ensure that `a_row' is no longer a child row of `Current'.
			-- Does not remove `a_row' from `parent_i'.
		require
			is_parented: attached parent as l_parent
			a_row_not_void: a_row /= Void
			a_row_is_parented: a_row.parent /= Void
			a_row_is_not_current: a_row /= interface
			a_row_is_a_subrow: a_row.parent_row = interface
			same_parent: a_row.parent = parent
			parent_enabled_as_tree: l_parent.is_tree_enabled
			row_is_final_subrow_in_tree_structure: attached parent_row_root as l_parent_row_root and then
				(a_row.index + a_row.subrow_count_recursive = l_parent_row_root.index + l_parent_row_root.subrow_count_recursive)
		local
			row_imp: EV_GRID_ROW_I
			l_row_i: detachable EV_GRID_ROW_I
			i, last_changed_subrow_index: INTEGER
			l_parent_i: like parent_i
		do
			row_imp := a_row.implementation
			subrows.go_i_th (subrow_count)
			subrows.remove
			row_imp.internal_set_parent_row (Void)
			row_imp.set_subrow_index (0)

			l_parent_i := parent_i
			check l_parent_i /= Void end

			if row_imp.subrow_count > 0 then
					-- Now update the depth properties for each subrow of `a_row' (if any).
					-- `a_row' was already handled by the call to `internal_set_parent_row'.
				from
					i := row_imp.index + 1
					last_changed_subrow_index := row_imp.index + row_imp.subrow_count_recursive + 1
				until
					i > last_changed_subrow_index
				loop
					l_row_i := l_parent_i.rows.i_th (i)
					check l_row_i /= Void end
					l_row_i.update_depths_in_tree
					i := i + 1
				end
			end

				-- Decrease the node count for `Current' and all parents by 1 + the node count
				-- for the added subrow as this may also be a tree structure.
			update_parent_node_counts_recursively (- (row_imp.subrow_count_recursive + 1))

				-- If `Current' is expanded then we must also decrease the expanded node count by
				-- 1 + the node count of the added subrow as this may also be a tree structure.
			if is_expanded then
				update_parent_expanded_node_counts_recursively ( - (row_imp.expanded_subrow_count_recursive + 1))
			end

			l_parent_i.set_vertical_computation_required (index)
			l_parent_i.redraw_client_area
		ensure
			removed: a_row.parent_row = Void
			subrow_count_decreased: subrow_count = old subrow_count - 1
		end

	add_subrows_internal (rows_to_insert, row_index: INTEGER; a_subrow_index: INTEGER; inserting_within_tree_structure: BOOLEAN)
			-- Make `a_row' a child of Current. `inserting_within_tree_structure' determines
			-- if `a_row' is to be added within an existing tree structure and is used to
			-- relax the preconditions that determine if a row may be added.
		require
			is_parented: attached parent as l_parent
			a_row_is_parented: l_parent.row (row_index).parent /= Void
			a_row_is_not_current: l_parent.row (row_index) /= interface
			a_row_is_not_a_subrow: l_parent.row (row_index).parent_row = Void
			same_parent: l_parent.row (row_index).parent = l_parent
			parent_enabled_as_tree: l_parent.is_tree_enabled
			a_row_is_below_current: l_parent.row (row_index).index > index
			all_rows_between_row_and_current_are_subrows:
				not inserting_within_tree_structure implies l_parent.row (row_index).index = index + subrow_count_recursive + 1
			row_not_empty_implies_row_index_of_first_item_greater_or_equal_to_index_of_first_item:
				l_parent.row (row_index).index_of_first_item > 0 implies l_parent.row (row_index).index_of_first_item >= index_of_first_item
		local
			row_imp: EV_GRID_ROW_I
			i, j, l_subrow_index: INTEGER
			l_original_subrow_count: INTEGER
			l_parent_i: like parent_i
		do
				-- Reset `is_ensured_expandable'
			is_ensured_expandable := False


			from
				i := row_index
				j := row_index + rows_to_insert
				l_subrow_index := a_subrow_index
				l_original_subrow_count := subrows.count
				subrows.resize (subrows.count + rows_to_insert)
				if a_subrow_index < l_original_subrow_count + 1 then
						-- Move the existing items as required to make space for the new.
					subrows.shift_items (a_subrow_index, a_subrow_index + rows_to_insert, l_original_subrow_count - a_subrow_index + 1)
				end
				l_parent_i := parent_i
				check l_parent_i /= Void end
			until
				i = j
			loop
				row_imp := l_parent_i.row (i).implementation
				subrows.put_i_th (row_imp, l_subrow_index)
				row_imp.internal_set_parent_row (Current)
				row_imp.set_subrow_index (l_subrow_index)

					-- Increase the node count for `Current' and all parents by 1 + the node count
					-- for the added subrow as this may also be a tree structure.
				update_parent_node_counts_recursively (row_imp.subrow_count_recursive + 1)

					-- If `Current' is expanded then we must also update the expanded node count by
					-- 1 + the node count of the added subrow as this may also be a tree structure.
				if is_expanded then
					update_parent_expanded_node_counts_recursively (row_imp.expanded_subrow_count_recursive + 1)
				end

				i := i + 1
				l_subrow_index := l_subrow_index + 1
			end
				-- Update all indices of subrows in `Current'.
			update_subrow_indices (a_subrow_index + 1)

			l_parent_i.set_vertical_computation_required (index)
			l_parent_i.redraw_client_area
		ensure
			added: attached parent as l_parent and then l_parent.row (row_index).parent_row = interface
			subrow (a_subrow_index) = l_parent.row (row_index)
			node_counts_correct: node_counts_correct
		end

	enable_select
			-- Select the object.
		local
			l_parent_i: like parent_i
		do
			if not is_selected then
				l_parent_i := parent_i
				check l_parent_i /= Void end
				if l_parent_i.is_row_selection_enabled or else index_of_first_item = 0 then
					if l_parent_i.is_single_row_selection_enabled then
						l_parent_i.remove_selection
					end
					internal_is_selected := True
					l_parent_i.add_row_to_selected_rows (Current)
					if l_parent_i.row_select_actions_internal /= Void then
						l_parent_i.row_select_actions.call ([attached_interface])
					end
					if select_actions_internal /= Void then
						select_actions_internal.call (Void)
					end
				else
					internal_update_selection (True)
				end
				l_parent_i.redraw_row (Current)
			end
		end

	disable_select
			-- Deselect the object.
		do
			if attached parent_i as l_parent_i and then (l_parent_i.is_row_selection_enabled or else index_of_first_item = 0) then
				if internal_is_selected then
					internal_is_selected := False
					l_parent_i.remove_row_from_selected_rows (Current)
					if l_parent_i.row_deselect_actions_internal /= Void then
						l_parent_i.row_deselect_actions.call ([attached_interface])
					end
					if deselect_actions_internal /= Void then
						deselect_actions_internal.call ([Void])
					end
				end
			else
				internal_update_selection (False)
			end
			if attached parent_i as l_parent_i then
				l_parent_i.redraw_row (Current)
			end
		end

	destroy
			-- Destroy `Current'.
		do
			if attached parent_i as l_parent_i then
				l_parent_i.remove_row (index)
			end
			set_is_destroyed (True)
		end

	clear
			-- Remove all items from `Current'.
		require
			is_parented: parent /= Void
		local
			i: INTEGER
			a_parent_i: detachable EV_GRID_I
			a_index: INTEGER
		do
			from
				i := count
				a_parent_i := parent_i
				check a_parent_i /= Void end
				a_index := index
			until
				i = 0
			loop
				a_parent_i.internal_set_item (i, a_index, Void)
				i := i - 1
			end
		ensure
			cleared: index_of_first_item = 0
		end

feature {EV_GRID_I, EV_GRID_ROW_I} -- Implementation

	update_for_item_removal (item_index: INTEGER)
			-- Update `Current' to reflect the fact that item at position
			-- `item_index' has been removed.
		require
			valid_item_index: item_index >= 1 and item_index <= count
		do
			if attached parent_i as l_parent_i and then l_parent_i.is_tree_enabled and parent_row_i /= Void then
					-- Check and update `indent_depth_in_tree'.
				update_depths_in_tree
			end
		end

	update_for_removal
			-- Update settings in `Current' to reflect the fact that
			-- it is being removed from `parent_i'.
		require
			is_parented: parent /= Void
		do
			if is_locked then
				unlock
			end
			clear
				-- Make sure row is unselected from grid before removal
			disable_select
			if attached parent_row_i as l_parent_row_i then
				l_parent_row_i.update_for_subrow_removal (Current)
			end
			unparent
			parent_row_i := Void
			subrow_index := 0
			index := 0
		ensure
			parent_i_void: parent_i = Void
			parent_row_i_void: parent_row_i = Void
			index_set_to_zero: index = 0
		end

	update_for_subrow_removal (a_subrow: EV_GRID_ROW_I)
			-- Update `Current' to reflect the fact that `a_subrow'
			-- is being removed from `Current'.
		require
			a_row_not_void: a_subrow /= Void
			a_subrow.parent_row_i = Current
		do
			update_parent_node_counts_recursively (-1)
			if is_expanded then
				update_parent_expanded_node_counts_recursively (-1)
			end
			subrows.go_i_th (a_subrow.subrow_index)
			subrows.remove
			update_subrow_indices (a_subrow.subrow_index)

				-- Set the expanded state to `False' if no subrows.
			if subrow_count = 0 then
				is_expanded := False
			end
		ensure
			subrow_count_decreased: subrow_count = old subrow_count - 1
			subrow_count_recursive_decreased: subrow_count_recursive = old subrow_count_recursive - 1
			subrow_not_contained_in_subrows: not subrows.has (a_subrow)
			not_expanded_when_no_subrows: subrow_count = 0 implies not is_expanded
		end

	update_subrow_indices (a_index: INTEGER)
			-- Recalculate subsequent subrow indexes starting from `a_index'.
		require
			valid_index: a_index > 0 and then a_index <= subrow_count + 1
		local
			i, a_subrow_count: INTEGER
			row_i: detachable EV_GRID_ROW_I
			temp_rows: like subrows
		do
				-- Set subsequent indexes to their new values
			temp_rows := subrows
			from
				i := a_index
				a_subrow_count := temp_rows.count
			until
				i > a_subrow_count
			loop
				row_i := temp_rows @ i
				if row_i /= Void then
					row_i.set_subrow_index (i)
				end
				i := i + 1
			end
		end

feature {EV_GRID_ROW_I, EV_GRID_I} -- Implementation

	internal_set_parent_row (a_parent_row: detachable EV_GRID_ROW_I)
			-- Set the `parent_row' of `Current'
		do
			parent_row_i := a_parent_row
			update_depths_in_tree
		end

	update_depths_in_tree
			-- Update `depth_in_tree' and `indent_depth_in_tree' based
			-- on `Current' `Parent_row_i'.
		do
			if attached parent_row_i as l_parent_row_i then
				depth_in_tree := l_parent_row_i.depth_in_tree + 1
				indent_depth_in_tree := l_parent_row_i.indent_depth_in_tree + 1
--				if parent_row_i.index_of_first_item /= 0 and index_of_first_item /= 0 and then parent_row_i.index_of_first_item /= index_of_first_item then
--					indent_depth_in_tree := 1
--				end
			else
				depth_in_tree := 1
				indent_depth_in_tree := 1
			end
		ensure
			no_parent_implies_depths_set_to_one: parent_row_i = Void implies depth_in_tree = 1 and indent_depth_in_tree = 1
		end

feature {EV_GRID_ITEM_I, EV_GRID_ROW_I, EV_GRID_I, EV_GRID_DRAWER_I} -- Implementation

	subrows: EV_GRID_ARRAYED_LIST [detachable EV_GRID_ROW_I]
		-- All subrows of `Current'.

feature {EV_GRID_I, EV_GRID_DRAWER_I, EV_GRID_ROW_I} -- Implementation

	parent_i: detachable EV_GRID_I
		-- Grid that `Current' resides in.

	parent_row_i: detachable EV_GRID_ROW_I
		-- Row in which `Current' is parented.

	depth_in_tree: INTEGER
		-- Depth of `Current' within a tree structure.

	indent_depth_in_tree: INTEGER

	set_subrow_count_recursive (a_count: INTEGER)
			-- Assign `a_count' to `subrow_count_recursive'.
		require
			a_count_non_negative: a_count >= 0
		do
			subrow_count_recursive := a_count
		ensure
			subnode_count_set: subrow_count_recursive = a_count
		end

	set_expanded_subrow_count_recursive (a_count: INTEGER)
			-- Assign `a_count' to `expanded_subrow_count_recursive'.
		require
			a_count_non_negative: a_count >= 0
		do
			expanded_subrow_count_recursive := a_count
		ensure
			expanded_subrow_count_set: expanded_subrow_count_recursive = a_count
		end

	expanded_subrow_count_recursive: INTEGER
		-- Number of expanded subrows contained within `Current' recursively.

	update_parent_node_counts_recursively (adjustment_value: INTEGER)
			-- For `Current' and all parent nodes of `Current' recursively, update their
			-- `subnode_count_recursive' by `adjustment_value'.
		require
			adjustment_value_not_zero: adjustment_value /= 0
		local
			parent_row_imp: detachable EV_GRID_ROW_I
		do
			from
				parent_row_imp := Current
			until
				parent_row_imp = Void
			loop
				check parent_row_imp /= Void end
				parent_row_imp.set_subrow_count_recursive (parent_row_imp.subrow_count_recursive + adjustment_value)
				parent_row_imp := parent_row_imp.parent_row_i
			end
		end

	update_parent_expanded_node_counts_recursively (adjustment_value: INTEGER)
			-- For `Current' and all parent nodes of `Current' recursively, update their
			-- `subnode_count_recursive' by `adjustment_value'.
		require
			adjustment_value_not_zero: adjustment_value /= 0
		local
			parent_row_imp: detachable EV_GRID_ROW_I
		do
			from
				parent_row_imp := Current
			until
				(parent_row_imp = Void) or (parent_row_imp /= Current and not parent_row_imp.is_expanded)
			loop
				check parent_row_imp /= Void end
				parent_row_imp.set_expanded_subrow_count_recursive (parent_row_imp.expanded_subrow_count_recursive + adjustment_value)
				parent_row_imp := parent_row_imp.parent_row_i
			end
		end

feature {EV_GRID_I} -- Implementation

	reset_tree_structure
			-- Restore all properties of `Current' associated with tree structures
			-- for disabling of the tree. This is far quicker than simply calling
			-- `remove_subrow' as parent depths do not need to be taken into
			-- account which requires iteration.
		do
			subrows.wipe_out
			depth_in_tree := 1
			indent_depth_in_tree := 1
			subrow_count_recursive := 0
			expanded_subrow_count_recursive := 0
			is_expanded := False
			parent_row_i := Void
		end

feature {EV_ANY_I} -- Contract support

	node_counts_correct: BOOLEAN
			-- Are the node counts for `Current' in a valid state?
			-- This was originally written as class invariants, but as the node setting
			-- is performed recursively, we would need a global variable to turn this checking
			-- off. Instead we now check this function from the postcondition of and feature
			-- that may modify the expanded states of nodes.
		do
			Result := True
			if is_initialized and then subrows.count = 0 then
				Result := subrow_count_recursive = 0
			end
			if is_initialized and then subrows.count = 0 then
				Result := Result and expanded_subrow_count_recursive = 0
			end
			if is_initialized and then subrow_count > 0 then
				Result := Result and subrow_count_recursive >= subrow_count
			end
			if is_initialized and then subrow_count > 0 and then is_expanded then
				Result := Result and expanded_subrow_count_recursive >= subrow_count
			end
			if is_initialized and then subrow_count > 0 and then not is_expanded then
				Result := Result and expanded_subrow_count_recursive >= 0
			end
			Result := Result and expanded_subrow_count_recursive <= subrow_count_recursive
			if attached parent_i as l_parent_i and then l_parent_i.uses_row_offsets then
				Result := Result and l_parent_i.visible_row_count >= 0
				Result := Result and l_parent_i.visible_row_count <= l_parent_i.row_count
			end
		end

feature {EV_GRID_I} -- Implementation

	unparent
			-- Sets` parent_i' to `Void'.
		do
			parent_i := Void
				-- Reset hash_code to respect invariant.
			hash_code := 0
		ensure
			parent_void: parent = Void
		end

feature {NONE} -- Implementation

	contained_expanded_items_recursive: INTEGER
			-- `Result' is sum of of expanded nodes for each of the child rows
			-- of `Current', and each child row themselves. This is used when expanding
			-- or collapsing items to determine how many nodes are now visible or hidden.
		local
			a_subrow_index: INTEGER
			l_row: detachable EV_GRID_ROW_I
		do
			from
				a_subrow_index := 1
			until
				a_subrow_index > subrow_count
					-- iterate all rows parented within `Current'.
			loop
				Result := Result + 1
					-- Add one for the current row which is now hidden.
				l_row := subrows.i_th (a_subrow_index)
				check l_row /= Void end
				Result := Result + l_row.expanded_subrow_count_recursive
					-- Add the number of expanded items for that row.

				a_subrow_index := a_subrow_index + 1
			end
		ensure
			result_non_negative: result >= 0
		end

	displayed_in_grid_tree: BOOLEAN
			-- Is `Current' displayed in the tree of `grid'?
			-- If not parented at any level or one of these
			-- parents is not expanded then `Result' is `False'.
		local
			l_parent: detachable EV_GRID_ROW_I
		do
			Result := True
			from
				l_parent := parent_row_i
			until
				l_parent = Void or not Result
			loop
				check l_parent /= Void end
				if not l_parent.is_expanded then
					Result := False
				end
				l_parent := l_parent.parent_row_i
			end
		end

	default_row_height: INTEGER
			-- Default height of a row, based on the height of the default font.
		once
			Result := (create {EV_LABEL}).minimum_height + 3
		ensure
			result_positive: result > 0
		end

feature -- Contract Support

	attached_parent: EV_GRID
			-- Grid to which current row belongs.
			-- Used for old evaluation
		require
			parent_i_attached: attached parent
		local
			l_parent: like parent
		do
			l_parent := parent
			check l_parent /= Void end
			Result := l_parent
		end

feature {EV_ANY, EV_ANY_I, EV_GRID_DRAWER_I} -- Implementation

	interface: detachable EV_GRID_ROW note option: stable attribute end
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

invariant
--	We currently cannot hold this invariant during expand/collapse, thus
--	it is commented until we find a better way to express it:
--	no_subrows_implies_not_expanded: parent /= Void and then subrow_count = 0 implies not is_expanded
	subrows_not_void: is_initialized implies subrows /= Void
	hash_code_valid: is_initialized implies ((parent = Void and then hash_code = 0) or else (parent /= Void and then hash_code > 0))

note
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
		Eiffel Software
		356 Storke Road, Goleta, CA 93117 USA
		Telephone 805-685-1006, Fax 805-685-6869
		Website http://www.eiffel.com
		Customer support http://support.eiffel.com
	]"

end










