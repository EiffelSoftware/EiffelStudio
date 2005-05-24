indexing
	description: "Item that can be inserted in a cell of an EV_GRID."
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
			Result := column_i.virtual_x_position
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
			Result := row_i.virtual_y_position
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

	width: INTEGER is
			-- Width of `Current' in pixels.
		require
			parented: is_parented
		do
			Result := column_i.width - horizontal_indent
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
		do
			enable_select_internal
				-- Request that `Current' be redrawn
			parent_i.redraw_item (Current)
		end

	disable_select is
			-- Set `is_selected' `False'.
		do
			disable_select_internal
				-- Request that `Current' be redrawn
			parent_i.redraw_item (Current)
		end
		
	ensure_visible is
			-- Ensure `Current' is visible in viewable area of `parent'.
		require
			parented: parent /= Void
		do
			row.ensure_visible
			column.ensure_visible
		ensure
			to_implement_assertion ("old_is_visible_implies_positions_not_changed")
			row_visible_when_heights_fixed_in_parent: parent.is_row_height_fixed implies row.virtual_y_position >= parent.virtual_y_position and virtual_y_position + parent.row_height <= parent.virtual_y_position + (parent.viewable_height).max (parent.row_height)
			row_visible_when_heights_not_fixed_in_parent: not parent.is_row_height_fixed implies row.virtual_y_position >= parent.virtual_y_position and virtual_y_position + row.height <= parent.virtual_y_position + (parent.viewable_height).max (row.height)
			column_visible: column.virtual_x_position >= parent.virtual_x_position and column.virtual_x_position + column.width <= parent.virtual_x_position + (parent.viewable_width).max (column.width)
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
		
feature {NONE} -- Implementation

	destroy is
			-- Destroy `Current'.
		do
			to_implement ("EV_GRID_ITEM_I.destroy")
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
			focused := parent_i.drawable.has_focus

			drawable.set_copy_mode
			back_color := displayed_background_color
			drawable.set_foreground_color (back_color)
			drawable.fill_rectangle (an_indent, 0, a_width, a_height)
			if is_selected then
				if focused then
					drawable.set_foreground_color (parent_i.focused_selection_color)
				else
					drawable.set_foreground_color (parent_i.non_focused_selection_color)
				end
				fixme ("EV_GRID_LABEL.perform_redraw - For now, perform no inversion of selection.")
--				drawable.set_and_mode

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
