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
	
	EV_SELECTABLE_I
		redefine
			interface
		end

	EV_COLORIZABLE_I
		redefine
			interface
		end

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
			is_initialized := True
		end

feature -- Access

	background_color: EV_COLOR is
			-- Background color of current item if any
		do
			if internal_background_color /= Void then
				Result := internal_background_color.twin
			else
				create Result
			end
		end

	foreground_color: EV_COLOR is
			-- Foreground color of current item if any
		do
			if internal_foreground_color /= Void then
				Result := internal_foreground_color.twin
			else
				create Result
			end
		end

	column: EV_GRID_COLUMN is
			-- Column to which current item belongs
		require
			is_parented: is_parented
		do
			to_implement ("EV_GRID_ITEM_I.column")
		ensure
			column_not_void: Result /= Void
		end

	parent: EV_GRID is
		do
			if parent_grid_i /= Void then
				Result := parent_grid_i.interface
			end
		end

	row: EV_GRID_ROW is
			-- Row to which current item belongs
		require
			parented: is_parented
		do
			to_implement ("EV_GRID_ITEM_I.row")
		ensure
			row_not_void: Result /= Void
		end

feature -- Status setting

	enable_select is
			-- Set `is_selected' `True'.
		do
			to_implement ("EV_GRID_ITEM_I.enable_select")
		end

	disable_select is
			-- Set `is_selected' `False'.
		do
			to_implement ("EV_GRID_ITEM_I.disable_select")
		end

feature -- Status report

	is_parented: BOOLEAN is
			-- Does current item belongs to an EV_GRID?
		do
			Result := parent_grid_i /= Void
		end
		
	is_selected: BOOLEAN is
			-- Is `Current' selected?
		do
			to_implement ("EV_GRID_ITEM_I.is_selected")
		end

feature -- Element change

	set_foreground_color (a_color: like foreground_color) is
			-- Set `foreground_color' with `a_color'
		do
			internal_foreground_color := a_color.twin
		end

	set_background_color (a_color: like background_color) is
			-- Set `background_color' with `a_color'
		do
			internal_background_color := a_color.twin
		end
		
feature {EV_GRID_I} -- Implementation

	set_parent_grid_i (a_parent_grid_i: EV_GRID_I) is
			-- Set `parent_grid_i' to `a_parent_grid_i'
		require
			a_parent_grid_i_not_void: a_parent_grid_i /= Void
		do
			parent_grid_i := a_parent_grid_i
		ensure
			parent_grid_i_set: parent_grid_i = a_parent_grid_i
		end

	parent_grid_i: EV_GRID_I
		-- Grid that `Current' resides in if any.
		
feature {NONE} -- Implementation

	destroy is
			-- Destroy `Current'.
		do
			to_implement ("EV_GRID_ITEM_I.destroy")
		end

feature {EV_GRID_DRAWER_I} -- Implementation

	internal_background_color: EV_COLOR
		-- Foreground color used for `Current'
	
	internal_foreground_color: EV_COLOR
		-- Background color used for `Current'
		
	redraw (an_x, a_y, a_width, a_height: INTEGER; drawable: EV_DRAWABLE) is
			-- Redraw `Current'.
		do
			-- Nothing to do here as this is the dummy item.
		end

feature {NONE} -- Implementation

	set_default_colors is
			-- Reset the colors used to display `Current'
		do
			internal_background_color := Void
			internal_foreground_color := Void
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_GRID_ITEM
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'
			
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
