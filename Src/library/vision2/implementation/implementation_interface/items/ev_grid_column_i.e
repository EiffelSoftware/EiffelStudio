indexing
	description: "Column of an EV_GRID, containing EV_GRID_ITEMs."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_COLUMN_I

inherit
	REFACTORING_HELPER
	
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
			physical_index := -1
			create header_item
			is_initialized := True
		end

feature {EV_GRID_I} -- Initialization

	set_parent_i (a_grid_i: EV_GRID_I) is
			-- Make `Current' associated with `a_grid_i'
		require
			a_grid_i_not_void: a_grid_i /= Void
		do
			parent_i := a_grid_i
		ensure
			parent_i = a_grid_i
		end

	set_physical_index (a_index: INTEGER) is
			-- Set the physical index of the column
		require
			valid_index: a_index >= 0
			physical_index_not_set: physical_index = -1
		do
			physical_index := a_index
		ensure
			physical_index_set: physical_index = a_index
		end

feature -- Access

	is_displayed: BOOLEAN is
		-- Is `Current' displayable in `parent'
	do
		Result := is_visible
	end

	title: STRING is
			-- Title of Current column. Empty if none.
		require
			is_parented: parent /= Void
		do
			Result := header_item.text
		ensure
			title_not_void: Result /= Void
		end

	item (i: INTEGER): EV_GRID_ITEM is
			-- Item at `i'-th row
		require
			i_positive: i > 0
			i_less_than_count: i <= count
			is_parented: parent /= Void
		do
			Result := parent_i.item (index, i)
		ensure
			item_not_void: Result /= Void
		end

	parent: EV_GRID is
			-- Grid to which current column belongs
		do
			if parent_i /= Void then
				Result := parent_i.interface
			end
		end
		
	selected_items: ARRAYED_LIST [EV_GRID_ITEM] is
			-- All items selected in `Current'.
		require
			is_parented: parent /= Void
		local
			i: INTEGER
			create_if_void: BOOLEAN
			a_item: EV_GRID_ITEM_I
		do
			from
				i := 1
				create_if_void := is_selected
				create Result.make (count)
			until
				i > count
			loop
				a_item := parent_i.item_internal (index, i, create_if_void)
				if a_item /= Void and then a_item.is_selected then
					Result.extend (a_item.interface)
				end
				i := i + 1
			end
		ensure
			result_not_void: Result /= Void
		end
		
	width: INTEGER is
			-- `Result' is width of `Current'.		
		require
			is_parented: parent /= Void
		do
			Result := header_item.width
		ensure
			Result_non_negative: Result >= 0
		end

feature -- Status setting

	hide is
			-- Prevent column from being displayed in `parent'
		require
			is_parented: parent /= Void
		do
			parent.hide_column (index)
		ensure
			not_is_displayed: not is_displayed
		end

	show is
			-- Allow column to be displayable within `parent'
		require
			is_parented: parent /= Void
		do
			parent.show_column (index)
		ensure
			is_displayed: is_displayed
		end

feature -- Status report

	index: INTEGER is
			-- Position of Current in `parent'
		require
			is_parented: parent /= Void
		do
			Result := parent_i.columns.index_of (Current, 1)
		ensure
			index_positive: Result > 0
			index_less_than_column_count: Result <= parent.column_count
		end

	count: INTEGER is
			-- Number of items in current
		require
			is_parented: parent /= Void
		do
			Result := parent_i.row_count
		ensure
			count_positive: Result > 0
		end
		
	is_selected: BOOLEAN is
			-- Is objects state set to selected.
		do
			Result := selected_item_count > 0 and then selected_item_count = count		
		end
			
feature -- Element change

	set_item (i: INTEGER; a_item: EV_GRID_ITEM) is
			-- Set item at `i'-th row to be `a_item'
		require
			i_positive: i > 0
			a_item_not_void: a_item /= Void
			is_parented: parent /= Void
		do
			parent_i.set_item (index, i, a_item)
		ensure
			item_set: item (i) = a_item
		end

	set_title (a_title: like title) is
			-- a_title_not_void: a_title /= Void
		require
			is_parented: parent /= Void
		do
			header_item.set_text (a_title)
		ensure
			title_set: title.is_equal (a_title)
		end

	set_background_color (a_color: EV_COLOR) is
			-- Set `background_color' with `a_color'
		require
			a_color_not_void: a_color /= Void
			is_parented: parent /= Void
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
			--background_color_set: forall (item(j).background_color = a_color)
		end
		
	set_width (a_width: INTEGER) is
			-- Assign `a_width' to `width'.
		require
			width_non_negative: a_width >= 0
			is_parented: parent /= Void
		do
			header_item.set_width (a_width)
			parent_i.header.item_resize_end_actions.call ([header_item])
		ensure
			width_set: width = a_width
		end

feature {EV_GRID_I} -- Implementation

	remove_parent_i is
			-- Set `parent_i' to Void
		require
			is_parented: parent /= Void
		do
			parent_i := Void
		ensure
			parent_i_unset: parent_i = Void
		end

	enable_select is
			-- Select `Current' in `parent_i'
		do
			selected_item_count := count
			parent_i.redraw_client_area
			fixme ("EV_GRID_COLUMN_I:enable_select - Perform a more optimal redraw when available")	
		end

	disable_select is
			-- Deselect `Current' from `parent_i'
		local
			i: INTEGER
			a_item: EV_GRID_ITEM_I
		do
			from
				i := 1
			until
				i > count
			loop
				a_item := parent_i.item_internal (index, i, False)
				if a_item /= Void and then a_item.internal_is_selected then
					a_item.disable_select_internal
				end
				i := i + 1
			end
			selected_item_count := 0
		end

	destroy is
			-- Destroy `Current'.
		do
			to_implement ("EV_GRID_COLUMN_I.destroy")
		end

	set_is_visible (a_visible: BOOLEAN) is
			-- Set `is_visible' to `a_visible'
		do
			is_visible := a_visible
		ensure
			is_visible_set: is_visible = a_visible
		end

feature {EV_GRID_ITEM_I} -- Implementation

	increase_selected_item_count is
			-- Increase `selected_item_count' by 1
		require
			selected_item_count_less_than_count: selected_item_count < count
		do
			selected_item_count := selected_item_count + 1
		ensure
			selected_item_count_increased: selected_item_count = old selected_item_count + 1
		end

	decrease_selected_item_count is
			-- Decrease `selected_item_count' by 1
		require
			selected_item_count_greater_than_zero: selected_item_count > 0
		do
			selected_item_count := selected_item_count - 1
		ensure
			selected_item_count_decreased: selected_item_count = old selected_item_count - 1
			selected_item_count_not_negative: selected_item_count >= 0
		end

	selected_item_count: INTEGER
		-- Number of selected items in `Current'

feature {EV_GRID_I, EV_GRID_DRAWER_I, EV_GRID_COLUMN} -- Implementation

	is_visible: BOOLEAN
		-- Is the column visible in the grid?

	physical_index: INTEGER
		-- Physical index of column row data stored in `parent_i'

	parent_i: EV_GRID_I
		-- Grid that `Current' resides in.
		
	header_item: EV_HEADER_ITEM
		-- Header item associated with `Current'.
		
feature {EV_ANY_I} -- Implementation

	interface: EV_GRID_COLUMN
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.
			
invariant
	header_item_not_void: is_initialized implies header_item /= Void
	selected_item_count_within_bounds: parent /= Void implies selected_item_count >= 0 and then selected_item_count <= selected_items.count
	is_selected_implies_selected_item_count_equals_count: is_selected implies selected_item_count = count
	physical_index_set: parent /= Void implies physical_index >= 0

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
