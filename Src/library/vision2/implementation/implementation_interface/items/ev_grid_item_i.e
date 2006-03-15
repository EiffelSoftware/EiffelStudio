indexing
	description: "Item that can be inserted in a cell of an EV_GRID."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_ITEM_I

inherit
	EV_ANY_I
		redefine
			interface
		end

	REFACTORING_HELPER
		undefine
			copy, default_create
		end

	EV_DESELECTABLE_I
		redefine
			interface,
			is_selectable
		end

	EV_GRID_ITEM_ACTION_SEQUENCES_I

	HASHABLE

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the widget with `par' as parent.
		do
			base_make (an_interface)
		end

	initialize is
			-- Initialize `Current'.
		do
			hash_code := -1
			set_is_initialized (True)
		end

feature -- Access

	column: EV_GRID_COLUMN is
			-- Column to which current item belongs.
		require
			is_parented: is_parented
		do
			Result := column_i.interface
		ensure
			column_not_void: Result /= Void
		end

	parent: EV_GRID is
			-- Grid to which `Current' is displayed in.
		do
			if parent_i /= Void then
				Result := parent_i.interface
			end
		end

	row: EV_GRID_ROW is
			-- Row to which current item belongs.
		require
			parented: is_parented
		do
			Result := row_i.interface
		ensure
			row_not_void: Result /= Void
		end

	virtual_x_position: INTEGER is
			-- Horizontal offset of `Current' in relation to the
			-- the virtual area of `parent' grid in pixels.
		require
			parented: parent /= Void
		do
			if column_locked_but_not_obscured_by_locked_row then
				Result := column_i.virtual_x_position
			else
				Result := column_i.virtual_x_position_unlocked
			end
			if parent_i /= Void then
				Result := Result + parent_i.item_indent (Current)
			end
		ensure
			valid_result: parent /= Void implies Result >= 0 and Result <= parent.virtual_width - column.width + horizontal_indent
		end

	virtual_y_position: INTEGER is
			-- Vertical offset of `Current' in relation to the
			-- the virtual area of `parent' grid in pixels.
		require
			parented: parent /= Void
		do
			if row_locked_but_not_obscured_by_locked_column then
				Result := row_i.virtual_y_position
			else
				Result := row_i.virtual_y_position_unlocked
			end
		ensure
			valid_result_when_parent_row_height_fixed: parent /= Void and then parent.is_row_height_fixed implies Result >= 0 and Result <= parent.virtual_height - parent.row_height
			valid_result_when_parent_row_height_not_fixed: parent /= Void and then not parent.is_row_height_fixed implies Result >= 0 and Result <= parent.virtual_height - row.height
		end

	horizontal_indent: INTEGER is
			-- Horizontal distance in pixels from left edge of `Current' to left edge of `column'.
			-- This may not be set, but the value is determined by the current tree structure
			-- of `parent' and `row'.
		require
			parented: parent /= Void
		do
			if parent_i /= Void then
				Result := parent_i.item_indent (Current)
			end
		ensure
			not_parent_tree_enabled_implies_result_zero: not parent.is_tree_enabled implies Result = 0
			parent_tree_enabled_implies_result_greater_or_equal_to_zero: parent.is_tree_enabled implies Result >= 0
		end

	required_width: INTEGER is
			-- Width in pixels required to fully display contents, based
			-- on current settings.
			-- Note that in some descendents such as EV_GRID_DRAWABLE_ITEM, this
			-- returns 0. For such items, `set_required_width' is available.
		do
			Result := 0
		end

	width: INTEGER is
			-- Width of `Current' in pixels.
		require
			parented: is_parented
		do
			Result := (column_i.width - horizontal_indent).max (0)
		ensure
			Result_non_negative: Result >= 0
		end

	height: INTEGER is
			-- Height of `Current' in pixels.
		require
			parented: is_parented
		do
			if parent_i.is_row_height_fixed then
				Result := parent_i.row_height
			else
				Result := row_i.height
			end
		ensure
			Result_non_negative: Result >= 0
		end

	foreground_color: EV_COLOR
			-- Color of foreground features like text.

	background_color: EV_COLOR
			-- Color displayed behind foreground features.

	tooltip: STRING
			-- Tooltip displayed on `Current'.
			-- If `Result' is `Void' or `is_empty' then no tooltip is displayed.

feature -- Status setting

	activate is
			-- Setup `Current' for user interactive editing.
		require
			parented: is_parented
		do
			parent_i.activate_item (interface)
		end

	deactivate is
			-- Cleanup from previous call to `activate'.
		require
			parented: is_parented
		do
			parent_i.deactivate_item (interface)
		end

	enable_select is
			-- Set `is_selected' `True'.
		local
			l_selected: BOOLEAN
			l_parent_i: like parent_i
			l_row: like row
			l_column: like column
		do
			l_selected := is_selected
			l_parent_i := parent_i
			l_row := row
			l_column := column
			enable_select_internal

			if not l_selected then
				if
					not l_parent_i.is_row_selection_enabled and then
					l_parent_i.row_select_actions_internal /= Void and then
					not l_parent_i.row_select_actions_internal.is_empty and then
					l_row.is_selected
				then
							-- Call row actions if selecting `Current' selects `row'.
					l_parent_i.row_select_actions_internal.call ([l_row])
				end
				if
					l_parent_i.column_select_actions_internal /= Void and then
					not l_parent_i.column_select_actions_internal.is_empty and then
					l_column.is_selected
				then
						-- Call column actions if selecting `Current' selects `column'.
					l_column.implementation.set_internal_is_selected (False)
					l_parent_i.column_select_actions_internal.call ([l_column])
				end
			end

				-- Request that `Current' be redrawn
			if parent_i /= Void then
				parent_i.redraw_item (Current)
			end
		end

	disable_select is
			-- Set `is_selected' `False'.
		local
			l_selected: BOOLEAN
			l_call_row_actions, l_call_column_actions: BOOLEAN
			l_parent_i: like parent_i
			l_row: like row
			l_column: like column
		do
			l_selected := is_selected
			l_parent_i := parent_i
			l_row := row
			l_column := column

			if l_selected then
					-- Check if row deselect actions need calling
				if
					not l_parent_i.is_row_selection_enabled and then
					l_parent_i.row_deselect_actions_internal /= Void and then
					not l_parent_i.row_deselect_actions_internal.is_empty and then
					l_row.is_selected then
							-- Call row deselect actions if deselecting `Current' deselects `row'
						l_call_row_actions := True
				end
				if
					l_parent_i.column_deselect_actions_internal /= Void and then
					not l_parent_i.column_deselect_actions_internal.is_empty and then
					l_column.is_selected then
						l_call_column_actions := True
				end
			end

			disable_select_internal

			if l_call_row_actions then
				l_parent_i.row_deselect_actions_internal.call ([l_row])
			end
			if l_call_column_actions then
				l_parent_i.column_deselect_actions_internal.call ([l_column])
			end

				-- Request that `Current' be redrawn
			if parent_i /= Void then
				parent_i.redraw_item (Current)
			end
		end

	ensure_visible is
			-- Ensure `Current' is visible in viewable area of `parent'.
		require
			parented: parent /= Void
		local
			virtual_x: INTEGER
			l_width: INTEGER
			extra_width: INTEGER
			i: INTEGER
		do
					-- It is necessary to perform the recomputation immediately
				-- as this may show the horizontal or vertical scroll bar
				-- which affects the size of the viewable area in which `Current'
				-- is to be displayed.
			parent_i.recompute_horizontal_scroll_bar
			parent_i.recompute_vertical_scroll_bar

				-- We can simply call `ensure_visible' on the row first, as the item
				-- always matches the row offsets. However for the column it is not so simple
				-- as we must take into account the indent of the item.
			row.ensure_visible

				-- Nothing to perform if the item is indented past the width of its column
			if horizontal_indent < column_i.width then
				virtual_x := virtual_x_position
				l_width := width
				if virtual_x < parent_i.virtual_x_position then
					parent_i.set_virtual_position (virtual_x, parent_i.virtual_y_position)
				elseif virtual_x + l_width > parent_i.virtual_x_position + parent_i.viewable_width then
					if parent_i.is_horizontal_scrolling_per_item then
							-- In this case, we must ensure that it is always the left item that still matches flush to
							-- the left of the viewable area of `parent_i'.
							-- The only way to determine the extra amount to add in order
							-- for the top row to be flush with the top of the viewable area, is
							-- to loop up until we find the first one that intersects the viewable area.
						from
							i := column_i.index
							extra_width := parent_i.viewable_width
						until
							i = 1 or extra_width < 0
						loop
							extra_width := extra_width - parent_i.column (i).width
							i := i - 1
						end
						extra_width := parent_i.column (i + 1).width + extra_width
					end
					if l_width >= parent_i.viewable_width then
							-- In this case, the width of the column is greater than the viewable width
							-- so we simply set it to the left of the viewable area.
						parent_i.set_virtual_position (virtual_x, parent_i.virtual_y_position)
					else
						parent_i.set_virtual_position (virtual_x + l_width + extra_width - parent_i.viewable_width, parent_i.virtual_y_position)
					end
				end
			end
		ensure
			virtual_x_position_not_changed_if_indent_greater_or_equal_to_column_width: old (horizontal_indent > column.width) implies old virtual_x_position = virtual_x_position
			virtual_x_position_not_changed_if_item_already_visible: old (virtual_x_position >= parent.virtual_x_position) and old (virtual_x_position + width <= parent.virtual_x_position + parent.viewable_width) implies old (virtual_x_position = virtual_x_position)
			virtual_y_position_not_changed_if_item_already_visible: old (virtual_y_position >= parent.virtual_y_position) and old (virtual_y_position + height <= parent.virtual_y_position + parent.viewable_height) implies old (virtual_y_position = virtual_y_position)
			row_visible_when_heights_fixed_in_parent: parent.is_row_height_fixed implies row.virtual_y_position >= parent.virtual_y_position and virtual_y_position + parent.row_height <= parent.virtual_y_position + (parent.viewable_height).max (parent.row_height)
			row_visible_when_heights_not_fixed_in_parent: not parent.is_row_height_fixed implies row.virtual_y_position >= parent.virtual_y_position and virtual_y_position + row.height <= parent.virtual_y_position + (parent.viewable_height).max (row.height)
			virtual_x_position_visible_if_indent_less_than_row_indent: horizontal_indent < column.width implies virtual_x_position >= parent.virtual_x_position and virtual_x_position + width <= parent.virtual_x_position + (parent.viewable_width).max (width)
		end

	redraw is
			-- Force `Current' to be re-drawn when next idle.
		do
			parent_i.redraw_item (Current)
		end

feature -- Status report

	is_parented: BOOLEAN is
			-- Does current item belongs to an EV_GRID?
		do
			Result := parent_i /= Void
		end

	is_selected: BOOLEAN is
			-- Is `Current' selected?
		do
			if parent_i.is_row_selection_enabled then
				Result := row_i.is_selected
			else
				Result := internal_is_selected
			end
		end

	is_selectable: BOOLEAN is
			-- Is `Current' selectable?
		do
			Result := is_parented
		end

feature -- Element change

	set_foreground_color (a_color: like foreground_color) is
			-- Set `foreground_color' with `a_color'.
		do
			foreground_color := a_color
			if parent /= Void then
				parent.implementation.redraw_item (Current)
			end
		ensure
			foreground_color_assigned: foreground_color = a_color
		end

	set_background_color (a_color: like background_color) is
			-- Set `background_color' with `a_color'.
		do
			background_color := a_color
			if parent /= Void then
				parent.implementation.redraw_item (Current)
			end
		end

	set_tooltip (a_tooltip: STRING) is
			-- Assign `a_tooltip' to `tooltip'.
			-- pass `Void' to remove the tooltip.
		do
			tooltip := a_tooltip
		ensure
			tooltip_assigned: a_tooltip = tooltip
		end

feature {EV_GRID_I, EV_GRID_ROW_I, EV_GRID_COLUMN_I, EV_GRID_ITEM_I} -- Implementation

	enable_select_internal is
			-- Set `is_selected' to True.
			-- Does not ask the grid to be redrawn.
		do
			if not is_selected then
				if parent_i.is_row_selection_enabled then
						-- We are in row selection mode so we manipulate the parent row directly
					row_i.enable_select
				else
					internal_is_selected := True
					parent_i.add_item_to_selected_items (Current)
					if parent_i.item_select_actions_internal /= Void then
						parent_i.item_select_actions_internal.call ([interface])
					end
					if select_actions_internal /= Void then
						select_actions_internal.call (Void)
					end
				end
			end
		end

	disable_select_internal is
			-- Set `is_selected' `False'.
			-- Does not ask the grid to be redrawn.
		do
			if is_selected then
				if parent_i.is_row_selection_enabled then
						-- We are in row selection mode so we manipulate the parent row directly
					row_i.disable_select
				else
					internal_is_selected := False
					parent_i.remove_item_from_selected_items (Current)
					if parent_i.item_deselect_actions_internal /= Void then
						parent_i.item_deselect_actions_internal.call ([interface])
					end
					if deselect_actions_internal /= Void then
						deselect_actions_internal.call (Void)
					end
				end
			end
		end

	internal_is_selected: BOOLEAN
		-- Has `enable_select' been called on `Current'

feature {EV_GRID_I} -- Implementation

	set_parents (a_parent_i: EV_GRID_I; a_column_i: EV_GRID_COLUMN_I; a_row_i: EV_GRID_ROW_I; a_item_id: INTEGER) is
			-- Set the appropriate grid, column and row parents along with item_id to identify `Current' within grid.
		require
			a_parent_i_not_void: a_parent_i /= Void
			a_column_i_not_void: a_column_i /= Void
			a_row_i_not_void: a_row_i /= Void
			a_item_id_valid: a_item_id > 0
		do
			parent_i := a_parent_i
			column_i := a_column_i
			row_i := a_row_i
			hash_code := a_item_id
		ensure
			parent_i_set: parent_i = a_parent_i
			column_i_set: column_i = a_column_i
			row_i_set: row_i = a_row_i
			item_id_set: hash_code = a_item_id
		end

	update_for_removal is
			-- Update settings in `Current' to reflect the fact that
			-- it is being removed from `parent_i'.
		require
			parent_i_not_void: parent_i /= Void
			column_i_not_void: column_i /= Void
			row_i_not_void: row_i /= Void
		do
			parent_i := Void
			column_i := Void
			row_i := Void
			hash_code := -1
		ensure
			parent_i_unset: parent_i = Void
			column_i_unset: column_i = Void
			row_i_unset: row_i = Void
		end

feature {EV_GRID_COLUMN_I, EV_GRID_I, EV_GRID_DRAWER_I, EV_GRID_ROW_I, EV_GRID_ITEM_I} -- Implementation

	hash_code: INTEGER
		-- Used to uniquely identify grid item within `parent_i'.
		-- Should be set to -1 if `Current' is not parented.

	parent_i: EV_GRID_I
		-- Grid that `Current' resides in if any.

	column_i: EV_GRID_COLUMN_I
		-- Grid column that `Current' resides in if any.

	row_i: EV_GRID_ROW_I
		-- Grid row that `Current' resides in if any.

feature {EV_GRID_I} -- Implementation

	unparent is
			-- Sets` parent_i' to `Void'.
		do
			parent_i := Void
		ensure
			parent_void: parent = Void
		end

feature {NONE} -- Implementation

	destroy is
			-- Destroy `Current'.
		do
			if parent_i /= Void then
				parent_i.internal_set_item (column_i.index, row_i.index, Void)
			end
			set_is_destroyed (True)
		end

	internal_rectangle: EV_RECTANGLE is
			-- Once access to a rectangle object used by the drawer.
			-- This is re-used to prevent repeatedly creating new objects.
		once
			create Result
		end

	row_locked_but_not_obscured_by_locked_column: BOOLEAN is
			-- Is `row' locked and above `column' if also locked?
		do
			if row_i.is_locked then
				if not column_i.is_locked then
					Result := True
				else
					Result := row_i.locked_row.locked_index > column_i.locked_column.locked_index
				end
			end
		end

	column_locked_but_not_obscured_by_locked_row: BOOLEAN is
			-- Is `column' locked and above `row' if also locked?
		do
			if column_i.is_locked then
				if not row_i.is_locked then
					Result := True
				else
					Result := column_i.locked_column.locked_index > row_i.locked_row.locked_index
				end
			end
		end

feature {EV_GRID_DRAWER_I, EV_GRID_ITEM} -- Implementation

	perform_redraw (an_x, a_y, a_width, a_height, an_indent: INTEGER; drawable: EV_DRAWABLE) is
			-- Redraw `Current'.
		require
			drawable_large_enough: drawable.width >= a_width + an_indent and drawable.height >= a_height
		local
			back_color: EV_COLOR
			focused: BOOLEAN
		do
				-- Retrieve properties from interface
			focused := parent_i.drawables_have_focus

			drawable.set_copy_mode
			back_color := displayed_background_color
			if is_selected then
				if focused then
					drawable.set_foreground_color (parent_i.focused_selection_color)
				else
					drawable.set_foreground_color (parent_i.non_focused_selection_color)
				end

				drawable.fill_rectangle (0 + an_indent, 0, a_width, a_height)
				if focused then
					drawable.set_foreground_color (parent_i.focused_selection_text_color)
				else
					drawable.set_foreground_color (parent_i.non_focused_selection_text_color)
				end
			else
				drawable.set_foreground_color (displayed_foreground_color)
			end
			drawable.set_copy_mode
		end

	displayed_background_color: EV_COLOR is
			-- `Result' is the background color in which `Current'
			-- should be displayed. Based on the `Void' status of
			-- `background_color', `row_i.background_color' and `parent_i.background_color'.
		do
			Result := background_color
			if Result = Void then
				if parent_i.are_columns_drawn_above_rows then
					Result := column_i.background_color
					if Result = Void then
						Result := row_i.background_color
						if Result = Void then
							Result := parent_i.background_color
						end
					end
				else
					Result := row_i.background_color
					if Result = Void then
						Result := column_i.background_color
						if Result = Void then
							Result := parent_i.background_color
						end
					end
				end
			end
		ensure
			result_not_void: Result /= Void
		end

	displayed_foreground_color: EV_COLOR is
			-- `Result' is the foreground color in which `Current'
			-- should be displayed. Based on the `Void'/ non `Void' status of
			-- `foreground_color', `row_i.foreground_color' and `parent_i.foreground_color'.
		do
			Result := foreground_color
			if Result = Void then
				if parent_i.are_columns_drawn_above_rows then
					Result := column_i.foreground_color
					if Result = Void then
						Result := row_i.foreground_color
						if Result = Void then
							Result := parent_i.foreground_color
						end
					end
				else
					Result := row_i.foreground_color
					if Result = Void then
						Result := column_i.foreground_color
						if Result = Void then
							Result := parent_i.foreground_color
						end
					end
				end
			end
		ensure
			result_not_void: Result /= Void
		end

feature {EV_ANY_I, EV_GRID_DRAWER_I} -- Implementation

	interface: EV_GRID_ITEM
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

invariant
	is_parented_implies_parents_set: is_parented implies parent_i /= Void and then column_i /= Void and then row_i /= Void
	not_is_parented_implies_parents_not_set: not is_parented implies parent_i = Void and then column_i = Void and then row_i = Void
	hash_code_valid: is_initialized implies ((not is_parented and hash_code = -1) or (is_parented and then hash_code > 0))

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

