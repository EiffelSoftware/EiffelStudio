indexing
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
		redefine
			interface,
			is_selectable
		end

	HASHABLE

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
		end

	initialize is
			-- Initialize `Current'.
		do
			create subrows
			internal_height := default_row_height
			depth_in_tree := 1
			indent_depth_in_tree := 1
			subrow_count_recursive := 0
			expanded_subrow_count_recursive := 0
			is_expanded := False
			hash_code := -1
			set_is_initialized (True)
		end

feature {EV_GRID_I, EV_GRID_ROW_I} -- Initialization

	index_of_first_item_dirty: BOOLEAN
		-- Should `index_of_first_item' be recalculated.

	flag_index_of_first_item_dirty_if_needed (a_column_index: INTEGER) is
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

	set_index (a_index: INTEGER) is
			-- Set the index of row in grid.
		require
			a_index_greater_than_zero: a_index > 0
		do
			index := a_index
		ensure
			index_set: index = a_index
			indexes_equivalent: parent_i.rows.i_th (index) = Current
			index_less_than_row_count: index <= parent.row_count
		end

	set_subrow_index (a_subrow_index: INTEGER) is
			-- Set the index of row in parent row.
		require
			subrow_index_not_negative: a_subrow_index >= 0
		do
			subrow_index := a_subrow_index
		ensure
			index_set: subrow_index = a_subrow_index
			indexes_equivalent: a_subrow_index > 0 implies parent_row_i.subrows.i_th (subrow_index) = Current
			index_less_than_row_count: subrow_index <= parent_row_i.subrow_count
		end

	set_parent_i (a_grid_i: EV_GRID_I; a_row_id: INTEGER) is
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

	subrow (i: INTEGER): EV_GRID_ROW is
			-- `i'-th child of Current.
		require
			is_parented: parent /= Void
			i_positive: i > 0
			i_less_than_subrow_count: i <= subrow_count
		do
			Result := subrows.i_th (i).interface
		ensure
			subrow_not_void: Result /= Void
			subrow_valid: (Result.parent /= Void) and then has_subrow (Result) and then Result.parent_row = interface
		end

	has_subrow (a_row: EV_GRID_ROW): BOOLEAN is
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

	parent_row: EV_GRID_ROW is
			-- Parent row of Current if any, Void otherwise.
		require
			is_parented: parent /= Void
		do
			if parent_row_i /= Void then
				Result := parent_row_i.interface
			end
		ensure
			result_void_when_tree_node_enabled: (parent = Void) or
				(parent /= Void and then not parent.is_tree_enabled) implies Result = Void
			has_parent: Result /= Void implies Result.has_subrow (interface)
		end

	parent: EV_GRID is
			-- Grid to which current row belongs.
		do
			if parent_i /= Void then
				Result := parent_i.interface
			end
		end

	parent_row_root: EV_GRID_ROW is
			-- Parent row which is the root of the tree structure
			-- in which `Current' is contained. May be `Current' if
			-- `Current' is the root node of a tree structure.
		require
			is_parented: parent /= Void
		local
			current_parent: EV_GRID_ROW_I
		do
			if parent.is_tree_enabled then
					-- If the tree is not enabled then `Result' must be False.
				if parent_row_i /= Void then
					from
						current_parent := parent_row_i
					until
						current_parent.parent_row_i = Void
					loop
						current_parent := current_parent.parent_row_i
					end
					Result := current_parent.interface
				else
						-- In this case, there is no `parent_row_i' as `Current'
						-- is the root node of a tree, so return `interface'
					Result := interface
				end
			end
		ensure
			result_consistent_with_parent_tree_properties: (parent = Void or else not parent.is_tree_enabled) = (Result = Void)
		end

	item (i: INTEGER): EV_GRID_ITEM is
			-- Item at `i'-th column, Void if none.
		require
			i_within_bounds: i > 0 and i <= count
			is_parented: parent /= Void
		do
			Result := parent_i.item (i, index)
		end

	selected_items: ARRAYED_LIST [EV_GRID_ITEM] is
			-- All items selected in `Current'.
		require
			is_parented: parent /= Void
		local
			i, a_count: INTEGER
			a_item: EV_GRID_ITEM_I
			temp_parent_i: like parent_i
		do
			from
				i := 1
				a_count := count
				create Result.make (a_count)
				temp_parent_i := parent_i
			until
				i > a_count
			loop
					-- If `is_selected' then we need to make sure there are no Void items contained within `Current'
				a_item := temp_parent_i.item_internal (i, index)
				if a_item /= Void and then a_item.is_selected then
					Result.extend (a_item.interface)
				end
				i := i + 1
			end
		ensure
			result_not_void: Result /= Void
			valid_count: Result.count <= count
		end

	is_expanded: BOOLEAN
			-- Are subrows of `Current' displayed?

	height: INTEGER is
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

	is_selected: BOOLEAN is
			-- Is objects state set to selected.
		do
			if parent_i /= Void then
				if parent_i.is_row_selection_enabled or else index_of_first_item = 0 then
					Result := internal_is_selected
				else
					Result := internal_are_all_non_void_items_selected
				end
			end
		end

	is_selectable: BOOLEAN is
			-- May the object be selected?
		do
			Result := parent_i /= Void
		end

	internal_is_selected: BOOLEAN
		-- Is `Current' selected in either row selection mode?

	internal_update_selection (a_selection_state: BOOLEAN) is
			-- Set the selection state of all non void items in `Current' to `a_selection_state'.
		local
			a_item: EV_GRID_ITEM_I
			i: INTEGER
			a_count: INTEGER
			a_index: INTEGER
			a_parent_i: EV_GRID_I
		do
			from
				i := 1
				a_index := index
				a_parent_i := parent_i
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

	internal_are_all_non_void_items_selected: BOOLEAN is
			-- Are all the non void items in `Current' selected?
			-- False if no non void items are present.
		local
			a_item: EV_GRID_ITEM_I
			i: INTEGER
			a_count: INTEGER
			non_void_item_found: BOOLEAN
			a_index: INTEGER
			a_parent_i: EV_GRID_I
		do
			from
				i := 1
				Result := True
				a_count := count
				a_index := index
				a_parent_i := parent_i
			until
				not Result or else i > a_count
			loop
				a_item := parent_i.item_internal (i, a_index)
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

	virtual_y_position: INTEGER is
			-- Vertical offset of `Current' in relation to the
			-- the virtual area of `parent' grid in pixels.
			-- `Result' is 0 if `parent' is `Void'.
		do
			if is_locked then
				Result := parent_i.internal_client_y + locked_row.offset
			else
				Result := virtual_y_position_unlocked
			end
		ensure
			parent_void_implies_result_zero: parent = Void implies Result = 0
		end

	virtual_y_position_unlocked: INTEGER is
			-- Vertical offset of unlocked position of `Current', in relation to the
			-- virtual area of `parent' grid in pixels.
			-- If not `is_locked', then `virtual_y_position' = `unlocked_virtual_y_position'.
			-- If `is_locked' then `Result' is the "shadow" position where the row would
			-- be if not locked.
		do
			if parent_i /= Void then
					-- If there is no parent then return 0.

				parent_i.perform_vertical_computation
					-- Recompute vertically if required.

				if parent_i.row_offsets /= Void then
						-- As `row_offsets' exists, we can look it up,
						-- otherwise it must be computed.
					Result := parent_i.row_offsets @ (index)
				else
					Result := (index - 1) * parent_i.row_height
				end
			end
		ensure
			parent_void_implies_result_zero: parent = Void implies Result = 0
		end

	is_expandable: BOOLEAN is
			-- May `Current' be expanded?
		require
			is_parented: parent /= Void
		do
			Result := parent /= Void and (subrow_count > 0 or is_ensured_expandable)
		end

feature -- Status report

	locked_row: EV_GRID_LOCKED_ROW_I
		-- Locked row information for `Current'.
		-- `Void' if not locked.

	subrow_count: INTEGER is
			-- Number of children.
		require
			is_parented: parent /= Void
		do
			Result := subrows.count
		ensure
			subrow_count_non_negative: subrow_count >= 0
			subrow_count_in_range: subrow_count <= (parent.row_count - index)
		end

	subrow_count_recursive: INTEGER
			-- Number of child rows and their child rows recursively.

	index: INTEGER
			-- Position of Current in `parent'.

	subrow_index: INTEGER
			-- Position of `Current' in `parent_row' if any.

	count: INTEGER is
			-- Number of items in current.
		do
			if parent_i /= Void then
				Result := parent_i.columns.count
			end
		ensure
			count_not_negative: count >= 0
		end

	index_of_first_item: INTEGER is
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

	index_of_first_item_value: INTEGER is
			-- Return the index of the first non `Void' item within `Current'
			-- or 0 if none.
		local
			counter: INTEGER
			current_row_list: SPECIAL [EV_GRID_ITEM_I]
			current_row_list_count: INTEGER
			a_item: EV_GRID_ITEM_I
			column_list_area: SPECIAL [EV_GRID_COLUMN_I]
			a_physical_index: INTEGER
			row_count: INTEGER
		do
			current_row_list := parent_i.internal_row_data @ index
			column_list_area := parent_i.columns.area
			current_row_list_count := current_row_list.count
			row_count := count
			from
				counter := 0
			until
				a_item /= Void or else counter = row_count
			loop
				a_physical_index := (column_list_area @ counter).physical_index
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

	background_color: EV_COLOR
			-- Color displayed as background of `Current' except where there are items contained that
			-- have a non-`Void' `background_color'. If `Void', `background_color' of `parent' is displayed..

	foreground_color: EV_COLOR
			-- Color displayed for foreground features of `Current' except where there are items contained that
			-- have a non-`Void' `foreground_color'. If `Void', `foreground_color' of `parent' is displayed.

	is_locked: BOOLEAN
			-- Is `Current' locked so that it no longer scrolls?
			-- Note that this could be implemented as a function
			-- "Result := parent_i.locked_rows.item (index) /= Void" but this has not been done
			-- so for performance reasons.

	locked_position: INTEGER is
			-- Locked position of `Current' from top edge of viewable area of `parent'.
			-- `Result' is 0 if not `is_locked'.
		do
			if is_locked then
				Result := locked_row.offset
			end
		ensure
			not_locked_implies_result_zero: not is_locked implies result = 0
		end

feature -- Status setting

	lock_at_position (a_position: INTEGER) is
			-- Ensure `is_locked' is `True' with the vertical offset from
			-- the top edge of the viewable area of `parent' set to `a_position'.
		do
			if is_locked then
				unlock
			end
			is_locked := True
			create locked_row.make (parent_i, a_position, Current)
			locked_row.set_locked_index (parent_i.locked_indexes.count + 1)
			parent_i.locked_indexes.extend (locked_row)
			parent_i.reposition_locked_row (Current)
			parent_i.redraw_row (Current)
			if parent_i.item_pebble_function /= Void then
				locked_row.drawing_area.set_pebble_function (agent parent_i.user_pebble_function_intermediary_locked (?, ?, locked_row))
			end
			locked_row.drawing_area.drop_actions.set_veto_pebble_function (agent parent_i.veto_pebble_function_intermediary)
			locked_row.drawing_area.drop_actions.extend (agent parent_i.drop_action_intermediary)
		ensure
			is_locked: is_locked
			locked_position_set: locked_position = a_position
		end

	unlock is
			-- Ensure `is_locked' is `False'.
		do
			if is_locked then
				is_locked := False
				parent_i.unlock_row (Current)
				locked_row := Void
			end
		ensure
			not_is_locked: not is_locked
		end

	expand is
			-- Display all subrows of `Current'.
		require
			is_parented: parent /= Void
			is_expandable: is_expandable
		do
			if not is_expanded then
				is_expanded := True
				if subrow_count > 0 then
						-- If `Current' has children then compute and redraw.
						-- If `is_ensured_expandable' then it is possible that there
						-- are no children, so do not perform the calculations.

					update_parent_expanded_node_counts_recursively (contained_expanded_items_recursive)
						-- Update the expanded node counts for `Current' and all parent nodes.

					if displayed_in_grid_tree then
							-- Only recompute the row offsets if `Current' is visible
							-- otherwise the row offsets are already correct.
						parent_i.set_vertical_computation_required (index)
					end
				end

				if parent_i.row_expand_actions_internal /= Void then
						-- The expand actions are fired after we set vertical computation
						-- to ensure that if you query a dimension from within the actions,
						-- they are up to date.
					parent_i.row_expand_actions_internal.call ([interface])
				end
				if expand_actions_internal /= Void then
					expand_actions_internal.call (Void)
				end

				if is_ensured_expandable then
					is_ensured_expandable := False
					is_expanded := subrow_count > 0
				end
				if parent_i /= Void then
					parent_i.redraw_from_row_to_end (Current)
				end
			end
		ensure
			is_expanded: is_expanded or subrow_count = 0
			node_counts_correct: node_counts_correct
		end

	collapse is
			-- Hide all subrows of `Current'.
		require
			is_parented: parent /= Void
		do
			if is_expanded then
				is_expanded := False

				update_parent_expanded_node_counts_recursively (- contained_expanded_items_recursive)
					-- Update the expanded node counts for `Current' and all parent nodes.

				if displayed_in_grid_tree then
						-- Only recompute the row offsets if `Current' is visible
						-- otherwise the row offsets are already correct.
					parent_i.set_vertical_computation_required (index)
				end

				if parent_i.row_collapse_actions_internal /= Void then
						-- The collapse actions are fired after we set vertical computation
						-- to ensure that if you query a dimension from within the actions,
						-- they are up to date.
					parent_i.row_collapse_actions_internal.call ([interface])
				end
				if collapse_actions_internal /= Void then
					collapse_actions_internal.call (Void)
				end
				if parent_i /= Void then
					parent_i.redraw_from_row_to_end (Current)
				end
			end
		ensure
			not_is_expanded: not is_expanded
			node_counts_correct: node_counts_correct
		end

	set_height (a_height: INTEGER) is
			-- Assign `a_height' to `height'.
		require
			is_parented: parent /= Void
		do
			internal_height := a_height
			if not parent_i.is_row_height_fixed then
				parent_i.set_vertical_computation_required (index)
				parent_i.redraw_from_row_to_end (Current)
				if is_locked then
					parent_i.reposition_locked_row (Current)
				end
			end
		ensure
			height_set: height = a_height
		end

	ensure_visible is
			-- Ensure `Current' is visible in viewable area of `parent'.
		require
			parented: parent /= Void
		local
			virtual_y: INTEGER
			l_height: INTEGER
			extra_height: INTEGER
			i: INTEGER
		do
				-- It is necessary to perform the recomputation immediately
				-- as this may show the horizontal or vertical scroll bar
				-- which affects the size of the viewable area in which `Current'
				-- is to be displayed.
			parent_i.recompute_horizontal_scroll_bar
			parent_i.recompute_vertical_scroll_bar

			virtual_y := virtual_y_position
			if parent_i.is_row_height_fixed then
				l_height := parent_i.row_height
			else
				l_height := height
			end
			if virtual_y < parent_i.virtual_y_position then
				parent_i.set_virtual_position (parent_i.virtual_x_position, virtual_y)
			elseif virtual_y + l_height > parent_i.virtual_y_position + parent_i.viewable_height then
				if parent_i.is_vertical_scrolling_per_item then
						-- In this case, we must ensure that it is always the top item that still matches flush to
						-- the top of the viewable area of `parent_i'. There are two cases that we must handle.
					if parent_i.is_row_height_fixed then
						extra_height := parent_i.viewable_height \\ parent_i.row_height
					else
							-- In this case, the only way to determine the extra amount to add in order
							-- for the top row to be flush with the top of the viewable area, is
							-- to loop up until we find the first one that intersects the viewable area.
						from
							i := index
							extra_height := parent_i.viewable_height
						until
							i = 1 or extra_height < 0
						loop
							extra_height := extra_height - parent_i.row (i).height
							i := i - 1
						end
						extra_height := parent_i.row (i + 1).height + extra_height
					end
				end
				if l_height >= parent_i.viewable_height then
						-- In this case, the height of the row is greater than the viewable height
						-- so we simply set it at the top of the viewable area.
					parent_i.set_virtual_position (parent_i.virtual_x_position, virtual_y)
				else
					parent_i.set_virtual_position (parent_i.virtual_x_position, virtual_y + l_height + extra_height - parent_i.viewable_height)
				end
			end
		ensure
			parent_virtual_x_position_unchanged: old parent.virtual_x_position = parent.virtual_x_position
			to_implement_assertion ("old_is_visible_implies_vertical_position_not_changed")
			row_visible_when_heights_fixed_in_parent: parent.is_row_height_fixed implies  virtual_y_position >= parent.virtual_y_position and virtual_y_position + parent.row_height <= parent.virtual_y_position + (parent.viewable_height).max (parent.row_height)
			row_visible_when_heights_not_fixed_in_parent: not parent.is_row_height_fixed implies virtual_y_position >= parent.virtual_y_position and virtual_y_position + height <= parent.virtual_y_position + (parent.viewable_height).max (height)
		end

	set_background_color (a_color: EV_COLOR) is
			-- Set `background_color' with `a_color'.
		require
			is_parented: parent /= Void
		do
			background_color := a_color
			parent_i.redraw_row (Current)
		ensure
			background_color_set: background_color = a_color
		end

	set_foreground_color (a_color: EV_COLOR) is
			-- Set `foreground_color' with `a_color'.
		require
			is_parented: parent /= Void
		do
			foreground_color := a_color
			parent_i.redraw_row (Current)
		ensure
			foreground_color_set: foreground_color = a_color
		end

	ensure_expandable is
			-- Ensure `Current' displays an expand pixmap to simulate a `row_count' greater than 0.
			-- May be used for dynamic behavior by filling subrows upon firing of `grid.row_expand_actions'.
			-- If no items are added to `Current' during the firing of `grid.row_expand_actions' then
			-- `Current' is no longer expandable. This may be re-instated by calling `ensure_expandable' again
			-- from `grid.row_expand_actions'. Note that once a subrow is added to `Current' after a call to
			-- `ensure_expandable', it is no longer be displayed as expandable if all subrows are then removed.
			-- In this case, you must explicitly call `ensure_expandable' again after removing all subrows.
		require
			parented: parent /= Void
			parent_tree_enabled: parent.is_tree_enabled
		do
			is_ensured_expandable := True
			parent_i.redraw_from_row_to_end (Current)
		ensure
			is_expandable: is_expandable
		end

	ensure_non_expandable is
			-- Restore expanded state of `Current' after a call to `ensure_expandable'. Note that if a row
			-- has one or more subrows, it is always drawn as expanded, hence the "no_subrows_contained" precondition.
		require
			parented: parent /= Void
			no_subrows_contained: subrow_count = 0
		do
			is_ensured_expandable := False
			parent_i.redraw_from_row_to_end (Current)
		ensure
			not_is_expandable: not is_expandable
		end

	is_ensured_expandable: BOOLEAN
			-- May current be expanded even through it is empty?

	redraw is
			-- Force all items within `Current' to be re-drawn when next idle.
		require
			parented: parent /= Void
		do
			parent_i.redraw_row (Current)
		end

feature {EV_GRID_ROW, EV_ANY_I}-- Element change

	set_item (i: INTEGER; a_item: EV_GRID_ITEM) is
			-- Set item at `i'-th column to be `a_item'.
			-- If `a_item' is `Void', the current item (if any) is removed.
		require
			i_positive: i > 0
			is_parented: parent /= Void
			valid_tree_structure: a_item /= Void and parent.is_tree_enabled and parent_row /= Void implies i >= parent_row.index_of_first_item
			is_index_valid_for_item_insertion_if_subrow: a_item /= Void and then interface.is_part_of_tree_structure implies interface.is_index_valid_for_item_setting_if_tree_node (i)
			is_index_valid_for_item_removal_if_subrow: a_item = Void and then interface.is_part_of_tree_structure implies interface.is_index_valid_for_item_removal_if_tree_node (i)
		do
			parent_i.set_item (i, index, a_item)
		ensure
			item_set: item (i) = a_item
		end

	add_subrow (a_row: EV_GRID_ROW) is
			-- Make `a_row' a child of Current.
		require
			is_parented: parent /= Void
			a_row_not_void: a_row /= Void
			a_row_is_parented: a_row.parent /= Void
			a_row_is_not_current: a_row /= interface
			a_row_is_not_a_subrow: a_row.parent_row = Void
			same_parent: a_row.parent = parent
			parent_enabled_as_tree: parent.is_tree_enabled
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

	insert_subrows (rows_to_insert, a_subrow_index: INTEGER) is
			-- Add `rows_to_insert' rows to `parent' as a subrow of `Current'
			-- with index in subrows of `Current' given by `a_subrow_index'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
			parent_enabled_as_tree: parent.is_tree_enabled
			rows_to_insert_positive: rows_to_insert >= 1
			valid_subrow_index: a_subrow_index >= 1 and a_subrow_index <= subrow_count + 1
		local
			l_subrow: EV_GRID_ROW_I
			l_index: INTEGER
		do
			if a_subrow_index = 1 then
				l_index := index + 1
			else
					-- There is a subrow before the current insert index so
					-- add at a position in `parent_i' based on the item before the insert
					-- As this item may have rows of it's own the subrow count recursive must also be added.
				l_subrow := subrows.i_th (a_subrow_index - 1)
				l_index := l_subrow.index + l_subrow.subrow_count_recursive + 1
			end
			parent_i.insert_new_rows_parented (rows_to_insert, l_index, interface)
		ensure
			subrow_count_increased: subrow_count = old subrow_count + rows_to_insert
			parent_row_count_increased: parent.row_count = old parent.row_count + rows_to_insert
		end

	remove_subrow (a_row: EV_GRID_ROW) is
			-- Ensure that `a_row' is no longer a child row of `Current'.
			-- Does not remove `a_row' from `parent_i'.
		require
			is_parented: parent /= Void
			a_row_not_void: a_row /= Void
			a_row_is_parented: a_row.parent /= Void
			a_row_is_not_current: a_row /= interface
			a_row_is_a_subrow: a_row.parent_row = interface
			same_parent: a_row.parent = parent
			parent_enabled_as_tree: parent.is_tree_enabled
			row_is_final_subrow_in_tree_structure:
				a_row.index + a_row.subrow_count_recursive = parent_row_root.index + parent_row_root.subrow_count_recursive
		local
			row_imp: EV_GRID_ROW_I
			i, last_changed_subrow_index: INTEGER
		do
			row_imp := a_row.implementation
			subrows.go_i_th (subrow_count)
			subrows.remove
			row_imp.internal_set_parent_row (Void)
			row_imp.set_subrow_index (0)


			if row_imp.subrow_count > 0 then
					-- Now update the depth properties for each subrow of `a_row' (if any).
					-- `a_row' was already handled by the call to `internal_set_parent_row'.
				from
					i := row_imp.index + 1
					last_changed_subrow_index := row_imp.index + row_imp.subrow_count_recursive + 1
				until
					i > last_changed_subrow_index
				loop
					parent_i.rows.i_th (i).update_depths_in_tree
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

				-- Update the hidden node count in the parent grid.
			parent_i.adjust_hidden_node_count ( - ((row_imp.subrow_count_recursive + 1) - row_imp.expanded_subrow_count_recursive))

			parent_i.set_vertical_computation_required (index)
			parent_i.redraw_client_area
		ensure
			removed: a_row.parent_row = Void
			subrow_count_decreased: subrow_count = old subrow_count - 1
		end

	add_subrows_internal (rows_to_insert, row_index: INTEGER; a_subrow_index: INTEGER; inserting_within_tree_structure: BOOLEAN) is
			-- Make `a_row' a child of Current. `inserting_within_tree_structure' determines
			-- if `a_row' is to be added within an existing tree structure and is used to
			-- relax the preconditions that determine if a row may be added.
		require
			is_parented: parent /= Void
			a_row_is_parented: parent.row (row_index).parent /= Void
			a_row_is_not_current: parent.row (row_index) /= interface
			a_row_is_not_a_subrow: parent.row (row_index).parent_row = Void
			same_parent: parent.row (row_index).parent = parent
			parent_enabled_as_tree: parent.is_tree_enabled
			a_row_is_below_current: parent.row (row_index).index > index
			all_rows_between_row_and_current_are_subrows:
				not inserting_within_tree_structure implies parent.row (row_index).index = index + subrow_count_recursive + 1
			row_not_empty_implies_row_index_of_first_item_greater_or_equal_to_index_of_first_item:
				parent.row (row_index).index_of_first_item > 0 implies parent.row (row_index).index_of_first_item >= index_of_first_item
		local
			row_imp: EV_GRID_ROW_I
			i, j, l_subrow_index: INTEGER
			l_original_subrow_count: INTEGER
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
			until
				i = j
			loop
				row_imp := parent_i.row (i).implementation
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

					-- Update the hidden node count in the parent grid.
				parent_i.adjust_hidden_node_count ((row_imp.subrow_count_recursive + 1) - row_imp.expanded_subrow_count_recursive)

				i := i + 1
				l_subrow_index := l_subrow_index + 1
			end
				-- Update all indices of subrows in `Current'.
			update_subrow_indices (a_subrow_index + 1)

			parent_i.set_vertical_computation_required (index)
			parent_i.redraw_client_area
		ensure
			added: parent.row (row_index).parent_row = interface
			subrow (a_subrow_index) = parent.row (row_index)
			node_counts_correct: node_counts_correct
		end

	enable_select is
			-- Select the object.
		local
			l_parent_i: like parent_i
		do
			if not is_selected then
				l_parent_i := parent_i
				if l_parent_i.is_row_selection_enabled or else index_of_first_item = 0 then
					internal_is_selected := True
					l_parent_i.add_row_to_selected_rows (Current)
					if l_parent_i.row_select_actions_internal /= Void then
						l_parent_i.row_select_actions_internal.call ([interface])
					end
					if select_actions_internal /= Void then
						select_actions_internal.call (Void)
					end
				else
					internal_update_selection (True)
				end
				if l_parent_i /= Void then
					l_parent_i.redraw_row (Current)
				end
			end
		end

	disable_select is
			-- Deselect the object.
		do
			if parent_i.is_row_selection_enabled or else index_of_first_item = 0 then
				if internal_is_selected then
					internal_is_selected := False
					parent_i.remove_row_from_selected_rows (Current)
					if parent_i.row_deselect_actions_internal /= Void then
						parent_i.row_deselect_actions_internal.call ([interface])
					end
					if deselect_actions_internal /= Void then
						deselect_actions_internal.call ([Void])
					end
				end
			else
				internal_update_selection (False)
			end
			if parent_i /= Void then
				parent_i.redraw_row (Current)
			end
		end

	destroy is
			-- Destroy `Current'.
		do
			if parent_i /= Void then
				parent_i.remove_row (index)
			end
			set_is_destroyed (True)
		end

	clear is
			-- Remove all items from `Current'.
		require
			is_parented: parent /= Void
		local
			i: INTEGER
			a_parent_i: EV_GRID_I
			a_index: INTEGER
		do
			from
				i := count
				a_parent_i := parent_i
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

	update_for_item_removal (item_index: INTEGER) is
			-- Update `Current' to reflect the fact that item at position
			-- `item_index' has been removed.
		require
			valid_item_index: item_index >= 1 and item_index <= count
		do
			if parent_i.is_tree_enabled and parent_row_i /= Void then
					-- Check and update `indent_depth_in_tree'.
				update_depths_in_tree
			end
		end

	update_for_removal is
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
			if parent_row_i /= Void then
				parent_row_i.update_for_subrow_removal (Current)
			end

			hash_code := -1
			unparent
			parent_row_i := Void
			subrow_index := 0
			index := 0
		ensure
			parent_i_void: parent_i = Void
			parent_row_i_void: parent_row_i = Void
			index_set_to_zero: index = 0
		end

	update_for_subrow_removal (a_subrow: EV_GRID_ROW_I) is
			-- Update `Current' to reflect the fact that `a_subrow'
			-- is being removed from `Current'.
		require
			a_row_not_void: a_subrow /= Void
			a_subrow.parent_row_i = Current
		do
			update_parent_node_counts_recursively (-1)
			if is_expanded then
				update_parent_expanded_node_counts_recursively (-1)

					-- The previous call to `update_parent_expanded_node_counts_recursively'
					-- updates the hidden node count in parent. However, as the row has
					-- actually been removed, we must undo this now.
				fixme (Once "EV_GRID_ROW_I.update_for_subrow_removal Removed the need for the above mentioned work around.")
				parent_i.adjust_hidden_node_count ( -1)
			else
				parent_i.adjust_hidden_node_count ( -1)
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

	update_subrow_indices (a_index: INTEGER) is
			-- Recalculate subsequent subrow indexes starting from `a_index'.
		require
			valid_index: a_index > 0 and then a_index <= subrow_count + 1
		local
			i, a_subrow_count: INTEGER
			row_i: EV_GRID_ROW_I
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

	internal_set_parent_row (a_parent_row: EV_GRID_ROW_I) is
			-- Set the `parent_row' of `Current'
		do
			parent_row_i := a_parent_row
			update_depths_in_tree
		end

	update_depths_in_tree is
			-- Update `depth_in_tree' and `indent_depth_in_tree' based
			-- on `Current' `Parent_row_i'.
		do
			if parent_row_i /= Void then
				depth_in_tree := parent_row_i.depth_in_tree + 1
				indent_depth_in_tree := parent_row_i.indent_depth_in_tree + 1
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

feature {EV_GRID_ITEM_I, EV_GRID_ROW_I, EV_GRID_I} -- Implementation

	subrows: EV_GRID_ARRAYED_LIST [EV_GRID_ROW_I]
		-- All subrows of `Current'.

feature {EV_GRID_I, EV_GRID_DRAWER_I, EV_GRID_ROW_I} -- Implementation

	parent_i: EV_GRID_I
		-- Grid that `Current' resides in.

	parent_row_i: EV_GRID_ROW_I
		-- Row in which `Current' is parented.

	depth_in_tree: INTEGER
		-- Depth of `Current' within a tree structure.

	indent_depth_in_tree: INTEGER

	set_subrow_count_recursive (a_count: INTEGER) is
			-- Assign `a_count' to `subrow_count_recursive'.
		require
			a_count_non_negative: a_count >= 0
		do
			subrow_count_recursive := a_count
		ensure
			subnode_count_set: subrow_count_recursive = a_count
		end

	set_expanded_subrow_count_recursive (a_count: INTEGER) is
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

	update_parent_node_counts_recursively (adjustment_value: INTEGER) is
			-- For `Current' and all parent nodes of `Current' recursively, update their
			-- `subnode_count_recursive' by `adjustment_value'.
		require
			adjustment_value_not_zero: adjustment_value /= 0
		local
			parent_row_imp: EV_GRID_ROW_I
		do
			from
				parent_row_imp := Current
			until
				parent_row_imp = Void
			loop
				parent_row_imp.set_subrow_count_recursive (parent_row_imp.subrow_count_recursive + adjustment_value)
				parent_row_imp := parent_row_imp.parent_row_i
			end
		end

	update_parent_expanded_node_counts_recursively (adjustment_value: INTEGER) is
			-- For `Current' and all parent nodes of `Current' recursively, update their
			-- `subnode_count_recursive' by `adjustment_value'.
		require
			adjustment_value_not_zero: adjustment_value /= 0
		local
			parent_row_imp: EV_GRID_ROW_I
		do
			from
				parent_row_imp := Current
			until
				(parent_row_imp = Void) or (parent_row_imp /= Current and not parent_row_imp.is_expanded)
			loop
				parent_row_imp.set_expanded_subrow_count_recursive (parent_row_imp.expanded_subrow_count_recursive + adjustment_value)
				parent_row_imp := parent_row_imp.parent_row_i
			end
			if parent_row_imp = Void then
				parent_i.adjust_hidden_node_count ( - adjustment_value)
			end
		end

feature {EV_GRID_I} -- Implementation

	reset_tree_structure is
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

	node_counts_correct: BOOLEAN is
			-- Are the node counts for `Current' in a valid state?
			-- This was originally written as class invaraints, but as the node setting
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
			if parent_i.is_tree_enabled then
				Result := Result and parent_i.hidden_node_count <= parent_i.row_count - 1
			end
		end

feature {EV_GRID_I} -- Implementation

	unparent is
			-- Sets` parent_i' to `Void'.
		do
			parent_i := Void
		ensure
			parent_void: parent = Void
		end

feature {NONE} -- Implementation

	hash_code: INTEGER
			-- Number to uniquely identify grid row within `parent_i'.

	contained_expanded_items_recursive: INTEGER is
			-- `Result' is sum of of expanded nodes for each of the child rows
			-- of `Current', and each child row themselves. This is used when expanding
			-- or collapsing items to determine how many nodes are now visible or hidden.
		local
			a_subrow_index: INTEGER
		do
			from
				a_subrow_index := 1
			until
				a_subrow_index > subrow_count
					-- iterate all rows parented within `Current'.
			loop
				Result := Result + 1
					-- Add one for the current row which is now hidden.

				Result := Result + subrows.i_th (a_subrow_index).expanded_subrow_count_recursive
					-- Add the number of expanded items for that row.

				a_subrow_index := a_subrow_index + 1
			end
		ensure
			result_non_negative: result >= 0
		end

	displayed_in_grid_tree: BOOLEAN is
			-- Is `Current' displayed in the tree of `grid'?
			-- If not parented at any level or one of these
			-- parents is not expanded then `Result' is `False'.
		local
			l_parent: EV_GRID_ROW_I
		do
			Result := True
			from
				l_parent := parent_row_i
			until
				l_parent = Void or not Result
			loop
				if not l_parent.is_expanded then
					Result := False
				end
				l_parent := l_parent.parent_row_i
			end
		end

	default_row_height: INTEGER is
			-- Default height of a row, based on the height of the default font.
		once
			Result := (create {EV_LABEL}).minimum_height
			if (create {PLATFORM}).is_windows then
				Result := Result + 3
			else
					-- This matches the gtk default row height used for all GtkTreeView variants.
				Result := Result + 6
			end
		ensure
			result_positive: result > 0
		end

feature {EV_ANY_I, EV_GRID_ROW} -- Implementation

	interface: EV_GRID_ROW
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

invariant
	no_subrows_implies_not_expanded: parent /= Void and then subrow_count = 0 implies not is_expanded
	subrows_not_void: is_initialized implies subrows /= Void
	hash_code_valid: is_initialized implies ((parent = Void and then hash_code = -1) or else (parent /= Void and then hash_code > 0))

indexing
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

