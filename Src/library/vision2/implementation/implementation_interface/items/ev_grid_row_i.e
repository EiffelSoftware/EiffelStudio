indexing
	description: "Representation of a row of an EV_GRID"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_ROW_I

inherit
	REFACTORING_HELPER
		undefine
			default_create, copy, is_equal
		end
	
	EV_GRID_ROW_ACTION_SEQUENCES
	
	EV_DESELECTABLE_I
		redefine
			interface
		end

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
			create subrows.make
			internal_height := 16
			depth_in_tree := 1
			indent_depth_in_tree := 1
			subnode_count_recursive := 0
			expanded_subnode_count_recursive := 0
			is_expanded := False
			is_initialized := True
		end

feature {EV_GRID_I, EV_GRID_ROW_I} -- Initialization

	internal_index: INTEGER
			-- Index of `Current' in parent grid.

	set_internal_index (a_index: INTEGER) is
			-- Set the internal index of row
		require
			a_index_greater_than_zero: a_index > 0
		do
			internal_index := a_index
		end

	set_parent_i (a_grid_i: EV_GRID_I) is
			-- Make `Current' associated with `a_grid_i'.
		require
			a_grid_i_not_void: a_grid_i /= Void
			grid_not_already_set: parent_i = Void
		do
			parent_i := a_grid_i
		ensure
			parent_i = a_grid_i
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
			-- Parent of Current if any, Void otherwise.
		do
			if parent_row_i /= Void then
				Result := parent_row_i.interface
			end
		ensure
			has_parent: Result /= Void implies Result.has_subrow (interface)
		end

	parent: EV_GRID is
			-- Grid to which current row belongs.
		do
			if parent_i /= Void then
				Result := parent_i.interface
			end
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
			i: INTEGER
			a_item: EV_GRID_ITEM_I
			temp_parent_i: like parent_i
		do
			from
				i := 1
				create Result.make (count)
				temp_parent_i := parent_i
			until
				i > count
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
			fixme ("Needs to be properly computed")
		ensure
			result_not_negative: Result >= 0
		end
		
	internal_height: INTEGER
		
	is_selected: BOOLEAN is
			-- Is objects state set to selected.
		do
			Result := selected_item_count > 0 and then selected_item_count = count
		end

feature -- Status report

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

	index: INTEGER is
			-- Position of Current in `parent'.
		require
			is_parented: parent /= Void
		do
			Result := internal_index
		ensure
			index_positive: Result > 0
			indexes_equivalent: parent_i.rows.i_th (internal_index) = Current
			index_less_than_row_count: Result <= parent.row_count
		end

	count: INTEGER is
			-- Number of items in current.
		do
			if parent_i /= Void then
				Result := parent_i.column_count
			end
		ensure
			count_not_negative: count >= 0
		end
		
feature -- Status setting

	expand is
			-- Display all subrows of `Current'.
		require
			has_subrows: subrow_count > 0
			is_parented: parent /= Void
		do
			if not is_expanded then
				is_expanded := True
					
				update_parent_expanded_node_counts_recursively (contained_expanded_items_recursive)
					-- Update the expanded node counts for `Current' and all parent nodes.
			
				if displayed_in_grid_tree then
						-- Only recompute the row offsets if `Current' is visible
						-- otherwise the row offsets are already correct.
					parent_i.set_vertical_computation_required
				end
			
				if parent_i.row_expand_actions_internal /= Void then
						-- The expand actions are fired after we set vertical computation
						-- to ensure that if you query a dimension from within the actions,
						-- they are up to date.
					parent_i.row_expand_actions_internal.call ([interface])
				end
				
				parent_i.redraw_client_area
			end
		ensure
			is_expanded: is_expanded
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
					parent_i.set_vertical_computation_required
				end
				
				if parent_i.row_collapse_actions_internal /= Void then
						-- The collapse actions are fired after we set vertical computation
						-- to ensure that if you query a dimension from within the actions,
						-- they are up to date.
					parent_i.row_collapse_actions_internal.call ([interface])
				end
				
				parent_i.redraw_client_area
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
				parent_i.set_vertical_computation_required
				parent_i.redraw_client_area
			end
		ensure
			height_set: height = a_height
		end

feature {EV_GRID_ROW, EV_ANY_I}-- Element change

	set_item (i: INTEGER; a_item: EV_GRID_ITEM) is
			-- Set item at `i'-th column to be `a_item'.
		require
			i_positive: i > 0
			a_item_not_void: a_item /= Void
			is_parented: parent /= Void
		do
			parent_i.set_item (i, index, a_item)
		ensure
			item_set: item (i) = a_item
		end

	remove_subrow (a_row: EV_GRID_ROW) is
			-- Unparent `a_row' from `Current'.
		require
			is_parented: parent /= Void
			a_row_not_void: a_row /= Void
			is_child: a_row.parent_row = interface
		local
			row_imp: EV_GRID_ROW_I
		do
			row_imp := a_row.implementation
			subrows.prune_all (row_imp)
			row_imp.internal_set_parent_row (Void)
		end

	add_subrow (a_row: EV_GRID_ROW) is
			-- Make `a_row' a child of Current.
		require
			is_parented: parent /= Void
			a_row_not_void: a_row /= Void
			a_row_is_parented: a_row.parent /= Void
			a_row_is_not_current: a_row /= interface
			a_row_is_not_a_subrow: a_row.parent_row = Void
			current_is_parented: parent /= Void
			same_parent: a_row.parent = parent
			parent_enabled_as_tree: parent.is_tree_enabled
			a_row_is_below_current: a_row.index > index
			valid_parent: parent.row (a_row.index - 1) = interface or
				True -- for (i in index .. a_row.index - 1) there exists i where
				-- parent.row (i).parent_row = Current
		local
			row_imp: EV_GRID_ROW_I
		do
			row_imp := a_row.implementation
			subrows.extend (row_imp)
			row_imp.internal_set_parent_row (Current)
			
				-- Increase the node count for `Current' and all parents by 1 + the node count
				-- for the added subrow as this may also be a tree structure.
			update_parent_node_counts_recursively (row_imp.subnode_count_recursive + 1)
			
				-- If `Current' is expanded then we must also update the expanded node count by
				-- 1 + the node count of the added subrow as this may also be a tree structure.
			if is_expanded then
				update_parent_expanded_node_counts_recursively (row_imp.expanded_subnode_count_recursive + 1)
			end
			
				-- Update the hidden node count in the parent grid.
			parent_i.adjust_hidden_node_count ((row_imp.subnode_count_recursive + 1) - row_imp.expanded_subnode_count_recursive)
			
			parent_i.set_vertical_computation_required
			parent_i.redraw_client_area
		ensure
			added: a_row.parent_row = interface
			subrow (subrow_count) = a_row
			node_counts_correct: node_counts_correct
		end

	set_background_color (a_color: EV_COLOR) is
			-- Set `a_color' to all items in Current.
		require
			is_parented: parent /= Void
			a_color_not_void: a_color /= Void
		local
			item_index: INTEGER
		do
			from
				item_index := 1
			until
				item_index > count
			loop
				item (item_index).set_background_color (a_color)
				item_index := item_index + 1
			end
		ensure
			--color_set: forall (item(i).background_color  = a_color)
		end
		
	enable_select is
			-- Select the object.
		do
			selected_item_count := count
			parent_i.update_row_selection_status (Current)
			parent_i.redraw_client_area
			fixme ("EV_GRID_ROW_I:enable_select - Perform a more optimal redraw when available")	
		end

	disable_select is
			-- Deselect the object.
		do
			disable_select_internal
			parent_i.update_row_selection_status (Current)
			parent_i.redraw_client_area
			fixme ("EV_GRID_ROW_I:disable_select - Perform a more optimal redraw when available")	
		end

	destroy is
			-- Destroy `Current'.
		do
			to_implement ("EV_GRID_ROW_I.destroy")
		end

feature {EV_GRID_I} -- Implementation

	remove_parent_i  is
			-- Set `parent_i' to `Void.
		require
			is_parented: parent /= Void
		do
			parent_i := Void
			internal_index := 0
		ensure
			parent_i_unset: parent_i = Void
		end

feature {EV_GRID_ROW_I, EV_GRID_I} -- Implementation

	internal_set_parent_row (a_parent_row: EV_GRID_ROW_I) is
			-- Set the `parent_row' of `Current'
		do
			parent_row_i := a_parent_row
			if parent_row_i /= Void then
				depth_in_tree := a_parent_row.depth_in_tree + 1
				indent_depth_in_tree := a_parent_row.indent_depth_in_tree + 1
				if parent_row_i.first_set_item_index /= first_set_item_index then
					indent_depth_in_tree := 1
				end				
			else
				depth_in_tree := 0
				indent_depth_in_tree := 0
			end
		end

	first_set_item_index : INTEGER is
			-- Return the first item within `Current' that has been set.
		local
			counter: INTEGER
			current_row_list: SPECIAL [EV_GRID_ITEM_I]
			current_row_count: INTEGER
		do
			current_row_list := parent_i.row_list @ (index - 1)
			current_row_count := current_row_list.count
			from
				counter := 0
			until
				counter = current_row_count or Result > 0
			loop
				if current_row_list.item (counter) /= Void then
					Result := counter + 1
				end
				counter := counter + 1
			end
		ensure
			result_positive: Result >= 0
		end

feature {EV_GRID_ITEM_I} -- Implementation

	increase_selected_item_count is
			-- Increase `selected_item_count' by 1.
		require
			selected_item_count_less_than_count: selected_item_count < count
		do
			selected_item_count := selected_item_count + 1
		ensure
			selected_item_count_increased: selected_item_count = old selected_item_count + 1
		end

	decrease_selected_item_count is
			-- Decrease selected_item_count by 1.
		require
			selected_item_count_greater_than_zero: selected_item_count > 0
		do
			selected_item_count := selected_item_count - 1
		ensure
			selected_item_count_decreased: selected_item_count = old selected_item_count - 1
			selected_item_count_not_negative: selected_item_count >= 0
		end

	selected_item_count: INTEGER
		-- Number of selected items in `Current'.
		
	subrows: EV_GRID_ARRAYED_LIST [EV_GRID_ROW_I]
		-- All subrows of `Current'.

feature {EV_GRID_I} -- Implementation
		
	disable_select_internal is
			-- Set internal data to signify that `Current' is unselected.
		local
			i: INTEGER
			a_item: EV_GRID_ITEM_I
		do
			from
				i := 1
			until
				i > count
			loop
				a_item := parent_i.item_internal (i, index)
				if a_item /= Void and then a_item.internal_is_selected then
					a_item.disable_select_internal
				end
				i := i + 1
			end
				-- Set selected item count to zero
			selected_item_count := 0			
		end

feature {EV_GRID_I, EV_GRID_DRAWER_I, EV_GRID_ROW_I} -- Implementation

	parent_i: EV_GRID_I
		-- Grid that `Current' resides in.
		
	parent_row_i: EV_GRID_ROW_I
		-- Row in which `Current' is parented.
		
	depth_in_tree: INTEGER
		-- Depth of `Current' within a tree structure.
		
	indent_depth_in_tree: INTEGER
		
	set_subnode_count_recursive (a_count: INTEGER) is
			-- Assign `a_count' to `subnode_count_recursive'.
		require
			a_count_non_negative: a_count > 0
		do
			subnode_count_recursive := a_count
		ensure
			subnode_count_set: subnode_count_recursive = a_count
		end
		
	set_expanded_subnode_count_recursive (a_count: INTEGER) is
			-- Assign `a_count' to `expanded_subnode_count_recursive'.
		require
			a_count_non_negative: a_count >= 0
		do
			expanded_subnode_count_recursive := a_count
		ensure
			expanded_subnode_count_set: expanded_subnode_count_recursive = a_count
		end
	
	subnode_count_recursive: INTEGER
		-- Number of subnodes contained within `Current' recursively.
		
	expanded_subnode_count_recursive: INTEGER
		-- Number of expanded subnodes contained within `Current' recursively.
		
	update_parent_node_counts_recursively (adjustment_value: INTEGER) is
			-- For `Current' and all parent nodes of `Current' recursively, update their
			-- `subnode_count_recursive' by `adjustment_value'.
		require
			has_subrows: subrow_count > 0
			adjustment_value_not_zero: adjustment_value /= 0
		local
			parent_row_imp: EV_GRID_ROW_I
		do
			from
				parent_row_imp := Current
			until
				parent_row_imp = Void
			loop
				parent_row_imp.set_subnode_count_recursive (parent_row_imp.subnode_count_recursive + adjustment_value)
				parent_row_imp := parent_row_imp.parent_row_i
			end
		end
		
	update_parent_expanded_node_counts_recursively (adjustment_value: INTEGER) is
			-- For `Current' and all parent nodes of `Current' recursively, update their
			-- `subnode_count_recursive' by `adjustment_value'.
		require
			has_subrows: subrow_count > 0
			adjustment_value_not_zero: adjustment_value /= 0
		local
			parent_row_imp: EV_GRID_ROW_I
		do
			from
				parent_row_imp := Current
			until
				(parent_row_imp = Void) or (parent_row_imp /= Current and not parent_row_imp.is_expanded)
			loop
				parent_row_imp.set_expanded_subnode_count_recursive (parent_row_imp.expanded_subnode_count_recursive + adjustment_value)
				parent_row_imp := parent_row_imp.parent_row_i
			end
			if parent_row_imp = Void then
				parent_i.adjust_hidden_node_count ( - adjustment_value)
			end
		end
		
feature {NONE} -- Implementation

	node_counts_correct: BOOLEAN is
			-- Are the node counts for `Current' in a valid state?
			-- This was originally written as class invaraints, but as the node setting
			-- is performed recursively, we would need a global variable to turn this checking
			-- off. Instead we now check this function from the postcondition of and feature
			-- that may modify the expanded states of nodes.
		do
			Result := True
			if is_initialized and then subrows.count = 0 then
				Result := subnode_count_recursive = 0
			end
			if is_initialized and then subrows.count = 0 then
				Result := Result and expanded_subnode_count_recursive = 0
			end
			if is_initialized and then subrow_count > 0 then
				Result := Result and subnode_count_recursive >= subrow_count
			end
			if is_initialized and then subrow_count > 0 and then is_expanded then
				Result := Result and expanded_subnode_count_recursive >= subrow_count
			end
			if is_initialized and then subrow_count > 0 and then not is_expanded then
				Result := Result and expanded_subnode_count_recursive >= 0
			end
			Result := Result and expanded_subnode_count_recursive <= subnode_count_recursive
			if parent_i.is_tree_enabled then
				Result := Result and parent_i.hidden_node_count <= parent_i.row_count - 1
			end
		end
		
	contained_expanded_items_recursive: INTEGER is
			-- `Result' is sum of of expanded nodes for each of the child rows
			-- of `Current', and each child row themselves. This is used when expanding
			-- or collapsing items to determine how many nodes are now visible or hidden.
		local
			subrow_index: INTEGER
		do
			from
				subrow_index := 1
			until
				subrow_index > subrow_count
					-- iterate all rows parented within `Current'.
			loop
				Result := Result + 1
					-- Add one for the current row which is now hidden.
					
				Result := Result + subrows.i_th (subrow_index).expanded_subnode_count_recursive
					-- Add the number of expanded items for that row.
					
				subrow_index := subrow_index + 1
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
		
feature {EV_ANY_I, EV_GRID_ROW} -- Implementation

	interface: EV_GRID_ROW
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.
			
invariant
	no_subrows_implies_not_expanded: parent /= Void and then subrow_count = 0 implies not is_expanded
	selected_item_count_valid: is_initialized implies selected_item_count >= 0 and then selected_item_count <= count
	subrows_not_void: is_initialized implies subrows /= Void
end

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------
