indexing
	description: "Item that can be inserted in a cell of an EV_GRID."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_ITEM

inherit
	EV_CONTAINABLE
		redefine
			implementation
		end
	
	REFACTORING_HELPER
		undefine
			copy, default_create
		end
	
	EV_DESELECTABLE
		undefine
			is_in_default_state
		redefine
			implementation
		end

	EV_COLORIZABLE
		redefine
			implementation
		end

create
	default_create

feature -- Access

	column: EV_GRID_COLUMN is
			-- Column to which current item belongs
		require
			not_destroyed: not is_destroyed
			is_parented: is_parented
		do
			Result := implementation.column
		ensure
			column_not_void: Result /= Void
		end

	parent: EV_GRID is
		do
			Result := implementation.parent
		end

	row: EV_GRID_ROW is
			-- Row to which current item belongs
		require
			not_destroyed: not is_destroyed
			parented: is_parented
		do
			Result := implementation.row
		ensure
			row_not_void: Result /= Void
		end
		
	virtual_x_position: INTEGER is
			-- Horizontal offset of `Current' in relation to the
			-- the virtual area of `parent' grid in pixels.
			-- `Result' is 0 if `parent' is `Void'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.virtual_x_position
		ensure
			parent_void_implies_result_zero: parent = Void implies Result = 0
--			valid_result: Result >= 0 and Result <= virtual_width - viewable_width
		end
		
	virtual_y_position: INTEGER is
			-- Vertical offset of `Current' in relation to the
			-- the virtual area of `parent' grid in pixels.
			-- `Result' is 0 if `parent' is `Void'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.virtual_y_position
		ensure
			parent_void_implies_result_zero: parent = Void implies Result = 0
--			valid_result: Result >= 0 and Result <= virtual_height - viewable_height
		end

feature -- Status report

	is_parented: BOOLEAN is
			-- Does current item belongs to an EV_GRID?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_parented
		end

feature {EV_ANY_I, EV_GRID_DRAWER_I} -- Implementation

	implementation: EV_GRID_ITEM_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_GRID_ITEM_I} implementation.make (Current)
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
