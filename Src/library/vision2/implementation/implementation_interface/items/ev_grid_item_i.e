note
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
			interface,
			is_destroyed
		end

	REFACTORING_HELPER
		undefine
			copy, default_create
		end

	EV_DESELECTABLE_I
		redefine
			interface,
			is_selectable,
			is_destroyed
		end

	EV_GRID_ITEM_ACTION_SEQUENCES_I

	HASHABLE

create
	make

feature {EV_ANY} -- Initialization

	old_make (an_interface: like interface)
			-- Create the widget with `par' as parent.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'.
		do
			hash_code := 0
			set_is_initialized (True)
		end

feature -- Access

	column: EV_GRID_COLUMN
			-- Column to which current item belongs.
		require
			is_parented: is_parented
		local
			l_column_i: like column_i
		do
			l_column_i := column_i
			check l_column_i /= Void end
			Result := l_column_i.attached_interface
		ensure
			column_not_void: Result /= Void
		end

	parent: detachable EV_GRID
			-- Grid to which `Current' is displayed in.
		do
			if attached parent_i as l_parent_i then
				Result := l_parent_i.interface
			end
		end

	row: EV_GRID_ROW
			-- Row to which current item belongs.
		require
			parented: is_parented
		local
			l_row_i: like row_i
		do
			l_row_i := row_i
			check l_row_i /= Void end
			Result := l_row_i.attached_interface
		ensure
			row_not_void: Result /= Void
		end

	virtual_x_position: INTEGER
			-- Horizontal offset of `Current' in relation to the
			-- the virtual area of `parent' grid in pixels.
		require
			parented: parent /= Void
		do
			if column_locked_but_not_obscured_by_locked_row then
				Result := column.virtual_x_position
			else
				Result := column.virtual_x_position_unlocked
			end
			if attached parent_i as l_parent_i then
				Result := Result + l_parent_i.item_indent (Current)
			end
		ensure
			valid_result: attached parent as l_parent implies Result >= 0 and Result <= l_parent.virtual_width - column.width + horizontal_indent
		end

	virtual_y_position: INTEGER
			-- Vertical offset of `Current' in relation to the
			-- the virtual area of `parent' grid in pixels.
		require
			parented: parent /= Void
		do
			if row_locked_but_not_obscured_by_locked_column then
				Result := row.virtual_y_position
			else
				Result := row.virtual_y_position_unlocked
			end
		ensure
			valid_result_when_parent_row_height_fixed: attached parent as l_parent and then l_parent.is_row_height_fixed implies Result >= 0 and Result <= l_parent.virtual_height - l_parent.row_height
			valid_result_when_parent_row_height_not_fixed: attached parent as l_parent2 and then not l_parent2.is_row_height_fixed implies Result >= 0 and Result <= l_parent2.virtual_height - row.height
		end

	horizontal_indent: INTEGER
			-- Horizontal distance in pixels from left edge of `Current' to left edge of `column'.
			-- This may not be set, but the value is determined by the current tree structure
			-- of `parent' and `row'.
		require
			parented: parent /= Void
		do
			if attached parent_i as l_parent_i then
				Result := l_parent_i.item_indent (Current)
			end
		ensure
			parent_attached: attached parent as l_parent
			not_parent_tree_enabled_implies_result_zero: not l_parent.is_tree_enabled implies Result = 0
			parent_tree_enabled_implies_result_greater_or_equal_to_zero: l_parent.is_tree_enabled implies Result >= 0
		end

	required_width: INTEGER
			-- Width in pixels required to fully display contents, based
			-- on current settings.
			-- Note that in some descendents such as EV_GRID_DRAWABLE_ITEM, this
			-- returns 0. For such items, `set_required_width' is available.
		do
			Result := 0
		end

	is_displayed: BOOLEAN
			-- Is `Current' visible on the screen?
			-- `True' when parent displayed.
			-- An item that is_displayed does not necessarily have to be visible on screen at that particular time.
		do
			Result := attached parent_i as l_parent_i and then l_parent_i.is_displayed
				and then attached column_i as l_column_i and then l_column_i.is_show_requested
				and then attached row_i as l_row_i and then l_row_i.is_show_requested
		end

	width: INTEGER
			-- Width of `Current' in pixels.
		require
			parented: is_parented
		do
			if attached column_i as l_column_i then
				Result := (l_column_i.width - horizontal_indent).max (0)
			end
		ensure
			Result_non_negative: Result >= 0
		end

	height: INTEGER
			-- Height of `Current' in pixels.
		require
			parented: is_parented
		do
			if attached parent_i as l_parent_i and then l_parent_i.is_row_height_fixed then
				Result := l_parent_i.row_height
			elseif attached row_i as l_row_i then
				Result := l_row_i.height
			end
		ensure
			Result_non_negative: Result >= 0
		end

	foreground_color: detachable EV_COLOR
			-- Color of foreground features like text.

	background_color: detachable EV_COLOR
			-- Color displayed behind foreground features.

	tooltip: detachable STRING_32
			-- Tooltip displayed on `Current'.
			-- If `Result' is `Void' or `is_empty' then no tooltip is displayed.

	hash_code: INTEGER
			-- Used to uniquely identify grid item within `parent_i'.
			-- Should be set to 0 if `Current' is not parented.

feature -- Status setting

	activate
			-- Setup `Current' for user interactive editing.
		require
			parented: is_parented
		do
			if attached parent_i as l_parent_i then
				l_parent_i.activate_item (attached_interface)
			end
		end

	deactivate
			-- Cleanup from previous call to `activate'.
		require
			parented: is_parented
		do
			if attached parent_i as l_parent_i then
				l_parent_i.deactivate_item (attached_interface)
			end
		end

	enable_select
			-- Set `is_selected' `True'.
		local
			l_selected: BOOLEAN
			l_parent_i: like parent_i
			l_row: like row
			l_column: like column
		do
			l_selected := is_selected
			l_parent_i := parent_i
			check l_parent_i /= Void end
			l_row := row
			l_column := column

			if l_parent_i.is_single_item_selection_enabled then
				l_parent_i.remove_selection
			end
			enable_select_internal

			if not l_selected then
				if
					not l_parent_i.is_row_selection_enabled and then
					l_parent_i.row_select_actions_internal /= Void and then
					not l_parent_i.row_select_actions.is_empty and then
					l_row.is_selected
				then
							-- Call row actions if selecting `Current' selects `row'.
					l_parent_i.row_select_actions.call ([l_row])
				end
				if
					l_parent_i.column_select_actions_internal /= Void and then
					not l_parent_i.column_select_actions.is_empty and then
					l_column.is_selected
				then
						-- Call column actions if selecting `Current' selects `column'.
					l_column.implementation.set_internal_is_selected (False)
					l_parent_i.column_select_actions.call ([l_column])
				end
			end

				-- Request that `Current' be redrawn
			if not l_parent_i.is_destroyed then
				l_parent_i.redraw_item (Current)
			end
		end

	disable_select
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
			check l_parent_i /= Void end
			l_row := row
			l_column := column

			if l_selected then
					-- Check if row deselect actions need calling
				if
					not l_parent_i.is_row_selection_enabled and then
					l_parent_i.row_deselect_actions_internal /= Void and then
					not l_parent_i.row_deselect_actions.is_empty and then
					l_row.is_selected then
							-- Call row deselect actions if deselecting `Current' deselects `row'
						l_call_row_actions := True
				end
				if
					l_parent_i.column_deselect_actions_internal /= Void and then
					not l_parent_i.column_deselect_actions.is_empty and then
					l_column.is_selected then
						l_call_column_actions := True
				end
			end

			disable_select_internal

			if l_call_row_actions then
				l_parent_i.row_deselect_actions.call ([l_row])
			end
			if l_call_column_actions then
				l_parent_i.column_deselect_actions.call ([l_column])
			end

				-- Request that `Current' be redrawn
			if not l_parent_i.is_destroyed then
				l_parent_i.redraw_item (Current)
			end
		end

	ensure_visible
			-- Ensure `Current' is visible in viewable area of `parent'.
		require
			parented: parent /= Void
		local
			virtual_x: INTEGER
			l_width: INTEGER
			extra_width: INTEGER
			i: INTEGER
			l_parent_i: like parent_i
			l_column_i: like column_i
		do
					-- It is necessary to perform the recomputation immediately
				-- as this may show the horizontal or vertical scroll bar
				-- which affects the size of the viewable area in which `Current'
				-- is to be displayed.
			l_parent_i := parent_i
			check l_parent_i /= Void end
			l_parent_i.recompute_horizontal_scroll_bar
			l_parent_i.recompute_vertical_scroll_bar

			l_column_i := column_i
			check l_column_i /= Void end

				-- We can simply call `ensure_visible' on the row first, as the item
				-- always matches the row offsets. However for the column it is not so simple
				-- as we must take into account the indent of the item.
			row.ensure_visible

				-- Nothing to perform if the item is indented past the width of its column
			if horizontal_indent < l_column_i.width then
				virtual_x := virtual_x_position
				l_width := width
				if virtual_x < l_parent_i.virtual_x_position then
					l_parent_i.set_virtual_position (virtual_x, l_parent_i.virtual_y_position)
				elseif virtual_x + l_width > l_parent_i.virtual_x_position + l_parent_i.viewable_width then
					if l_parent_i.is_horizontal_scrolling_per_item then
							-- In this case, we must ensure that it is always the left item that still matches flush to
							-- the left of the viewable area of `parent_i'.
							-- The only way to determine the extra amount to add in order
							-- for the top row to be flush with the top of the viewable area, is
							-- to loop up until we find the first one that intersects the viewable area.
						from
							i := l_column_i.index
							extra_width := l_parent_i.viewable_width
						until
							i = 1 or extra_width < 0
						loop
							extra_width := extra_width - l_parent_i.column (i).width
							i := i - 1
						end
						extra_width := l_parent_i.column (i + 1).width + extra_width
					end
					if l_width >= l_parent_i.viewable_width then
							-- In this case, the width of the column is greater than the viewable width
							-- so we simply set it to the left of the viewable area.
						l_parent_i.set_virtual_position (virtual_x, l_parent_i.virtual_y_position)
					else
						l_parent_i.set_virtual_position (virtual_x + l_width + extra_width - l_parent_i.viewable_width, l_parent_i.virtual_y_position)
					end
				end
			end
		ensure
			parent_not_void: attached parent as l_par
			virtual_x_position_not_changed_if_indent_greater_or_equal_to_column_width: old (horizontal_indent > column.width) implies old virtual_x_position = virtual_x_position
--| FIXME IEK Fix old expressions with attached parent
--			virtual_x_position_not_changed_if_item_already_visible: old (virtual_x_position >= l_par.virtual_x_position) and old (virtual_x_position + width <= l_par.virtual_x_position + l_par.viewable_width) implies old (virtual_x_position = virtual_x_position)
--			virtual_y_position_not_changed_if_item_already_visible: old (virtual_y_position >= l_par.virtual_y_position) and old (virtual_y_position + height <= l_par.virtual_y_position + l_par.viewable_height) implies old (virtual_y_position = virtual_y_position)
			row_visible_when_heights_fixed_in_parent: l_par.is_row_height_fixed implies row.virtual_y_position >= l_par.virtual_y_position and virtual_y_position + l_par.row_height <= l_par.virtual_y_position + (l_par.viewable_height).max (l_par.row_height)
			row_visible_when_heights_not_fixed_in_parent: not l_par.is_row_height_fixed implies row.virtual_y_position >= l_par.virtual_y_position and virtual_y_position + row.height <= l_par.virtual_y_position + (l_par.viewable_height).max (row.height)
			virtual_x_position_visible_if_indent_less_than_row_indent: horizontal_indent < column.width implies virtual_x_position >= l_par.virtual_x_position and virtual_x_position + width <= l_par.virtual_x_position + (l_par.viewable_width).max (width)
		end

	redraw
			-- Force `Current' to be re-drawn when next idle.
		do
			if attached parent_i as l_parent_i then
				l_parent_i.redraw_item (Current)
			end
		end

feature -- Status report

	is_parented: BOOLEAN
			-- Does current item belongs to an EV_GRID?
		do
			Result := parent_i /= Void
		end

	is_selected: BOOLEAN
			-- Is `Current' selected?
		do
			if attached parent_i as l_parent_i and then l_parent_i.is_row_selection_enabled then
				Result := attached row_i as l_row_i and then l_row_i.is_selected
			else
				Result := internal_is_selected
			end
		end

	is_selectable: BOOLEAN
			-- Is `Current' selectable?
		do
			Result := is_parented
		end

	is_destroyed: BOOLEAN
			-- Is `Current' destroyed?
		do
			Result := Precursor {EV_ANY_I} or (is_parented and then attached parent_i as l_parent_i and then l_parent_i.is_destroyed)
		end

feature -- Element change

	set_foreground_color (a_color: like foreground_color)
			-- Set `foreground_color' with `a_color'.
		do
			foreground_color := a_color
			if attached parent as l_parent then
				l_parent.implementation.redraw_item (Current)
			end
		ensure
			foreground_color_assigned: foreground_color = a_color
		end

	set_background_color (a_color: like background_color)
			-- Set `background_color' with `a_color'.
		do
			background_color := a_color
			if attached parent as l_parent then
				l_parent.implementation.redraw_item (Current)
			end
		end

	set_tooltip (a_tooltip: detachable STRING_GENERAL)
			-- Assign `a_tooltip' to `tooltip'.
			-- pass `Void' to remove the tooltip.
		do
				-- The `if' statement is necessary because of the conversion
				-- from STRING_GENERAL to STRING_32
			if a_tooltip = Void then
				tooltip := Void
			else
				tooltip := a_tooltip
			end
		ensure
			tooltip_reset: a_tooltip = Void implies tooltip = Void
			tooltip_set: a_tooltip /= Void and then attached tooltip as l_tooltip implies (
				(l_tooltip.same_type (a_tooltip) implies l_tooltip = a_tooltip) or
				(not l_tooltip.same_type (a_tooltip) implies a_tooltip.is_equal (l_tooltip)))
		end

feature {EV_GRID_I, EV_GRID_ROW_I, EV_GRID_COLUMN_I, EV_GRID_ITEM_I} -- Implementation

	enable_select_internal
			-- Set `is_selected' to True.
			-- Does not ask the grid to be redrawn.
		local
			l_parent_i: like parent_i
		do
			if not is_selected then
				l_parent_i := parent_i
				check l_parent_i /= Void end
				if l_parent_i.is_row_selection_enabled and then attached row_i as l_row_i then
						-- We are in row selection mode so we manipulate the parent row directly
					l_row_i.enable_select
				else
					internal_is_selected := True
					l_parent_i.add_item_to_selected_items (Current)
					if l_parent_i.item_select_actions_internal /= Void then
						l_parent_i.item_select_actions.call ([attached_interface])
					end
					if select_actions_internal /= Void then
						select_actions_internal.call (Void)
					end
				end
			end
		end

	disable_select_internal
			-- Set `is_selected' `False'.
			-- Does not ask the grid to be redrawn.
		do
			if is_selected and then attached parent_i as l_parent_i then
				if l_parent_i.is_row_selection_enabled and then attached row_i as l_row_i then
						-- We are in row selection mode so we manipulate the parent row directly
					l_row_i.disable_select
				else
					internal_is_selected := False
					l_parent_i.remove_item_from_selected_items (Current)
					if l_parent_i.item_deselect_actions_internal /= Void then
						l_parent_i.item_deselect_actions.call ([attached_interface])
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

	set_parents (a_parent_i: EV_GRID_I; a_column_i: EV_GRID_COLUMN_I; a_row_i: EV_GRID_ROW_I; a_item_id: INTEGER)
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

	update_for_removal
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
			hash_code := 0
		ensure
			parent_i_unset: parent_i = Void
			column_i_unset: column_i = Void
			row_i_unset: row_i = Void
		end

feature {EV_GRID_COLUMN_I, EV_GRID_I, EV_GRID_DRAWER_I, EV_GRID_ROW_I, EV_GRID_ITEM_I} -- Implementation

	parent_i: detachable EV_GRID_I
		-- Grid that `Current' resides in if any.

	column_i: detachable EV_GRID_COLUMN_I
		-- Grid column that `Current' resides in if any.

	row_i: detachable EV_GRID_ROW_I
		-- Grid row that `Current' resides in if any.

feature {EV_GRID_I} -- Implementation

	unparent
			-- Sets` parent_i' to `Void'.
		do
			parent_i := Void
		ensure
			parent_void: parent = Void
		end

feature {NONE} -- Implementation

	destroy
			-- Destroy `Current'.
		do
			if attached parent_i as l_parent_i and then attached column_i as l_column_i and then attached row_i as l_row_i then
				l_parent_i.internal_set_item (l_column_i.index, l_row_i.index, Void)
			end
			set_is_destroyed (True)
		end

	internal_rectangle: EV_RECTANGLE
			-- Once access to a rectangle object used by the drawer.
			-- This is re-used to prevent repeatedly creating new objects.
		once
			create Result
		end

	row_locked_but_not_obscured_by_locked_column: BOOLEAN
			-- Is `row' locked and above `column' if also locked?
		do
			if attached row_i as l_row_i and then l_row_i.is_locked and then attached column_i as l_column_i then
				if not l_column_i.is_locked then
					Result := True
				elseif attached l_row_i.locked_row as l_locked_row and then attached l_column_i.locked_column as l_locked_column then
					Result := l_locked_row.locked_index > l_locked_column.locked_index
				end
			end
		end

	column_locked_but_not_obscured_by_locked_row: BOOLEAN
			-- Is `column' locked and above `row' if also locked?
		do
			if column.is_locked then
				if not row.is_locked then
					Result := True
				elseif
					attached column_i as l_column_i and then attached row_i as l_row_i and then
					attached l_column_i.locked_column as l_locked_column and then attached l_row_i.locked_row as l_locked_row
				then
					Result := l_locked_column.locked_index > l_locked_row.locked_index
				end
			end
		end

feature {EV_GRID_DRAWER_I, EV_GRID_ITEM} -- Implementation

	perform_redraw (an_x, a_y, a_width, a_height, an_indent: INTEGER; drawable: EV_DRAWABLE)
			-- Redraw `Current'.
		require
			drawable_large_enough: drawable.width >= a_width + an_indent and drawable.height >= a_height
		local
			back_color: EV_COLOR
			focused: BOOLEAN
			l_parent_i: like parent_i
		do
			l_parent_i := parent_i
			check l_parent_i /= Void end
				-- Retrieve properties from interface
			focused := l_parent_i.drawables_have_focus

			drawable.set_copy_mode
			back_color := displayed_background_color
			if is_selected then
				if focused then
					drawable.set_foreground_color (attached_parent.focused_selection_color)
				else
					drawable.set_foreground_color (attached_parent.non_focused_selection_color)
				end

				drawable.fill_rectangle (0 + an_indent, 0, a_width, a_height)
				if focused then
					drawable.set_foreground_color (l_parent_i.focused_selection_text_color)
				else
					drawable.set_foreground_color (l_parent_i.non_focused_selection_text_color)
				end
			else
				drawable.set_foreground_color (displayed_foreground_color)
			end
			drawable.set_copy_mode
		end

	displayed_background_color: EV_COLOR
			-- `Result' is the background color in which `Current'
			-- should be displayed. Based on the `Void' status of
			-- `background_color', `row_i.background_color' and `parent_i.background_color'.
		local
			l_result: detachable EV_COLOR
		do
			l_result := background_color
			if l_result = Void then
				if attached_parent.are_columns_drawn_above_rows then
					l_result := column.background_color
					if l_result = Void then
						l_result := row.background_color
						if l_result = Void then
							l_result := attached_parent.background_color
						end
					end
				else
					l_result := row.background_color
					if l_result = Void then
						l_result := column.background_color
						if l_result = Void then
							l_result := attached_parent.background_color
						end
					end
				end
				check l_result /= Void end
			end
			Result := l_result
		ensure
			result_not_void: Result /= Void
		end

	displayed_foreground_color: EV_COLOR
			-- `Result' is the foreground color in which `Current'
			-- should be displayed. Based on the `Void'/ non `Void' status of
			-- `foreground_color', `row_i.foreground_color' and `parent_i.foreground_color'.
		local
			l_result: detachable EV_COLOR
		do
			l_result := foreground_color
			if l_result = Void then
				if attached_parent.are_columns_drawn_above_rows then
					l_result := column.foreground_color
					if l_result = Void then
						l_result := row.foreground_color
						if l_result = Void then
							l_result := attached_parent.foreground_color
						end
					end
				else
					l_result := row.foreground_color
					if l_result = Void then
						l_result := column.foreground_color
						if l_result = Void then
							l_result := attached_parent.foreground_color
						end
					end
				end
				check l_result /= Void end
			end
			Result := l_result
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	attached_parent: attached like parent
			-- Attached parent
		require
			parent_attached: parent /= Void
		local
			l_parent: like parent
		do
			l_parent := parent
			check l_parent /= Void end
			Result := l_parent
		end

	attached_parent_i: attached like parent_i
			-- Attached parent_i
		require
			parent_i_attached: parent_i /= Void
		local
			l_parent_i: like parent_i
		do
			l_parent_i := parent_i
			check l_parent_i /= Void end
			Result := l_parent_i
		end

	attached_column_i: attached like column_i
			-- Attached `column_i'
		require
			column_i_attached: column_i /= Void
		local
			l_column_i: like column_i
		do
			l_column_i := column_i
			check l_column_i /= Void end
			Result := l_column_i
		end

feature {EV_ANY, EV_ANY_I, EV_GRID_DRAWER_I} -- Implementation

	interface: detachable EV_GRID_ITEM note option: stable attribute end
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

invariant
	is_parented_implies_parents_set: is_parented implies parent_i /= Void and then column_i /= Void and then row_i /= Void
	not_is_parented_implies_parents_not_set: not is_parented implies parent_i = Void and then column_i = Void and then row_i = Void
	hash_code_valid: is_initialized implies ((not is_parented and hash_code = 0) or (is_parented and then hash_code > 0))

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











