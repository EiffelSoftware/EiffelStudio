indexing
	description: "Column of an EV_GRID, containing EV_GRID_ITEMs."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_COLUMN

inherit
	REFACTORING_HELPER
	
-- EV_SELECTABLE

create {EV_GRID_I}
	make_with_grid_i

feature {NONE} -- Initialization

	make_with_grid_i (a_grid_i: EV_GRID_I) is
			-- Make `Current' associated with `a_grid_i'
		require
			a_grid_i_not_void: a_grid_i /= Void
		do
			parent_grid_i := a_grid_i
		ensure
			parent_grid_i = a_grid_i
		end

feature -- Access

	title: STRING is
			-- Title of Current column. Empty if none.
		require
			is_parented: parent /= Void
		do
			to_implement ("EV_GRID_COLUMN.count")
		ensure
			title_not_void: Result /= Void
		end

	item (i: INTEGER): EV_GRID_ITEM is
			-- Item at `i'-th row
		require
			i_positive: i > 0
			i_less_than_count: i <= count
			is_parented: parent /= Void
		local
			grid_row: SPECIAL [EV_GRID_ITEM]
		do
			grid_row :=  parent_grid_i.row_list @ i
			if grid_row = Void then
					-- The row is new, so no item existed
					
			end
		ensure
			item_not_void: Result /= Void
		end

	parent: EV_GRID is
			-- Grid to which current column belongs
		do
			if parent_grid_i /= Void then
				Result := parent_grid_i.interface
			end
		end
		
	selected_items: ARRAYED_LIST [EV_GRID_ITEM] is
			-- All items selected in `Current'.
		require
			is_parented: parent /= Void
		do
			to_implement ("EV_GRID_COLUMN.selected_items")
		ensure
			result_not_void: Result /= Void
		end
		
	width: INTEGER is
			-- `Result' is width of `Current'.		
		require
			is_parented: parent /= Void
		do
			to_implement ("EV_GRID_COLUMN.width")
		ensure
			Result_non_negative: Result >= 0
		end

feature -- Status report

	index: INTEGER is
			-- Position of Current in `parent'
		require
			is_parented: parent /= Void
		do
			Result := internal_index
		ensure
			index_positive: Result > 0
			index_less_than_column_count: Result <= parent.column_count
		end

	count: INTEGER is
			-- Number of items in current
		require
			is_parented: parent /= Void
		do
			to_implement ("EV_GRID_COLUMN.count")
		ensure
			count_positive: Result > 0
		end
			
feature -- Element change

	set_item (i: INTEGER; a_item: EV_GRID_ITEM) is
			-- Set item at `i'-th row to be `a_item'
		require
			i_positive: i > 0
			a_item_not_void: a_item /= Void
			is_parented: parent /= Void
		do
			to_implement ("EV_GRID_COLUMN.set_item")
		ensure
			item_set: item (i) = a_item
		end

	set_title (a_title: like title) is
			-- a_title_not_void: a_title /= Void
		require
			is_parented: parent /= Void
		do
			to_implement ("EV_GRID_COLUMN.title")
		ensure
			title_set: title = a_title
		end

	set_background_color (a_color: EV_COLOR) is
			-- Set `background_color' with `a_color'
		require
			a_color_not_void: a_color /= Void
			is_parented: parent /= Void
		do
			to_implement ("EV_GRID_COLUMN.background_color")
		ensure
			--background_color_set: forall (item(j).background_color = a_color)
		end
		
	set_width (a_width: INTEGER) is
			-- Assign `a_width' to `width'.
		require
			width_non_negative: a_width >= 0
			is_parented: parent /= Void
		do
			to_implement ("EV_GRID_COLUMN.set_width")
		ensure
			width_set: width = a_width
		end

feature {EV_GRID_I} -- Implementation

	set_index (a_index: INTEGER) is
			-- Set the `index' for `Current'
		require
			a_index_valid: a_index > 0
		do
			internal_index := a_index
		end

	remove_parent_grid_i is
			-- Set `parent_grid_i' to Void
		require
			is_parented: parent /= Void
		do
			parent_grid_i := Void
		ensure
			parent_grid_i_unset: parent_grid_i = Void
		end

feature {EV_GRID_I, EV_GRID_DRAWER_I, EV_GRID_COLUMN} -- Implementation

	internal_index: INTEGER
		-- Index of `Current' in `parent_grid_i'

	parent_grid_i: EV_GRID_I
		-- Grid that `Current' resides in.

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

