indexing
	description: "Column of an EV_GRID, containing EV_GRID_ITEMs."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_COLUMN

inherit
	REFACTORING_HELPER
	
-- EV_SELECTABLE

feature -- Access

	title: STRING is
			-- Title of Current column. Empty if none.
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
		do
			to_implement ("EV_GRID_COLUMN.item")
		ensure
			item_not_void: Result /= Void
		end

	parent: EV_GRID is
			-- Grid to which current column belongs
		do
			to_implement ("EV_GRID_COLUMN.parent")
		end
		
	selected_items: ARRAYED_LIST [EV_GRID_ITEM] is
			-- All items selected in `Current'.
		do
			to_implement ("EV_GRID_COLUMN.selected_items")
		ensure
			result_not_void: Result /= Void
		end
		
	width: INTEGER is
			-- `Result' is width of `Current'.
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
			to_implement ("EV_GRID_COLUMN.index")
		ensure
			index_positive: Result > 0
			index_less_than_column_count: Result <= parent.column_count
		end

	count: INTEGER is
			-- Number of items in current
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
		do
			to_implement ("EV_GRID_COLUMN.set_item")
		ensure
			item_set: item (i) = a_item
		end

	set_title (a_title: like title) is
			-- a_title_not_void: a_title /= Void
		do
			to_implement ("EV_GRID_COLUMN.title")
		ensure
			title_set: title = a_title
		end

	set_background_color (a_color: EV_COLOR) is
			-- Set `background_color' with `a_color'
		require
			a_color_not_void: a_color /= Void
		do
			to_implement ("EV_GRID_COLUMN.background_color")
		ensure
			--background_color_set: forall (item(j).background_color = a_color)
		end
		
	set_width (a_width: INTEGER) is
			-- Assign `a_width' to `width'.
		require
			width_non_negative: a_width >= 0
		do
			to_implement ("EV_GRID_COLUMN.set_width")
		ensure
			width_set: width = a_width
		end

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

