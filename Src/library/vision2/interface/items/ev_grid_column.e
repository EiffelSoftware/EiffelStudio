indexing
	description: "Column of an EV_GRID, containing EV_GRID_ITEMs."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_COLUMN

inherit
	REFACTORING_HELPER
		undefine
			default_create, copy, is_equal
		end
	
	EV_DESELECTABLE
		redefine
			implementation
		end
		
create
	{EV_GRID_I} default_create

feature -- Access

	is_displayed: BOOLEAN is
		-- May `Current' be displayed when its `parent' is?
		-- Will return False if `hide' has been called on `Current'.
		-- A column that `is_displayed' does not necessarily have to be visible on screen at that particular time.
		do
			Result := implementation.is_displayed
		end

	title: STRING is
			-- Title of Current column. Empty if none.
		require
			is_parented: parent /= Void
		do
			Result := implementation.title
		ensure
			title_not_void: Result /= Void
		end

	item (i: INTEGER): EV_GRID_ITEM is
			-- Item at `i'-th row, Void if none.
		require
			i_positive: i > 0
			i_less_than_count: i <= count
			is_parented: parent /= Void
		do
			Result := implementation.item (i)
		end

	parent: EV_GRID is
			-- Grid to which current column belongs.
		do
			Result := implementation.parent
		end

	selected_items: ARRAYED_LIST [EV_GRID_ITEM] is
			-- All items selected in `Current'.
		require
			is_parented: parent /= Void
		do
			Result := implementation.selected_items
		ensure
			result_not_void: Result /= Void
		end

	width: INTEGER is
			-- `Result' is width of `Current'.
		require
			is_parented: parent /= Void
		do
			Result := implementation.width
		ensure
			Result_non_negative: Result >= 0
		end

feature -- Status setting

	hide is
			-- Prevent column from being shown in `parent'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.hide
		ensure
			not_is_displayed: not is_displayed
		end

	show is
			-- Allow column to be displayed when `parent' is.
			-- Does not signify that the column will be visible on screen but that it will be visible within its parent.
		require
			not_destroyed: not is_destroyed
		do
			implementation.show
		ensure
			is_displayed: is_displayed
		end

feature -- Status report

	index: INTEGER is
			-- Position of Current in `parent'.
		require
			is_parented: parent /= Void
		do
			Result := implementation.index
		ensure
			index_positive: Result > 0
			index_less_than_column_count: Result <= parent.column_count
		end

	count: INTEGER is
			-- Number of items in current.
		require
			is_parented: parent /= Void
		do
			Result := implementation.count
		ensure
			count_positive: Result > 0
		end
			
feature -- Element change

	set_item (i: INTEGER; a_item: EV_GRID_ITEM) is
			-- Set item at `i'-th row to be `a_item'.
		require
			i_positive: i > 0
			a_item_not_void: a_item /= Void
			is_parented: parent /= Void
		do
			implementation.set_item (i, a_item)
		ensure
			item_set: item (i) = a_item
		end

	set_title (a_title: like title) is
			-- a_title_not_void: a_title /= Void.
		require
			is_parented: parent /= Void
		do
			implementation.set_title (a_title)
		ensure
			title_set: title.is_equal (a_title)
		end

	set_background_color (a_color: EV_COLOR) is
			-- Set `background_color' with `a_color'.
		require
			a_color_not_void: a_color /= Void
			is_parented: parent /= Void
		do
			implementation.set_background_color (a_color)
		ensure
			--background_color_set: forall (item(j).background_color = a_color)
		end
		
	set_width (a_width: INTEGER) is
			-- Assign `a_width' to `width'.
		require
			width_non_negative: a_width >= 0
			is_parented: parent /= Void
		do
			implementation.set_width (a_width)
		ensure
			width_set: width = a_width
		end
		
feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_GRID_COLUMN_I
		-- Responsible for interaction with native graphics toolkit.
	
feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_GRID_COLUMN_I} implementation.make (Current)
		end

invariant
	is_selected_implies_selected_items_count_equals_count: is_selected implies selected_items.count = count

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

