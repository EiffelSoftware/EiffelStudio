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
			-- Background color of current item
		do
			if internal_background_color /= Void then
				Result := internal_background_color.twin
			else
				create Result
			end
		end

	foreground_color: EV_COLOR is
			-- Foreground color of current item
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
			Result := parent_column_i.interface
		ensure
			column_not_void: Result /= Void
		end

	parent: EV_GRID is
			-- Grid to which `Current' is displayed in
		do
			if parent_i /= Void then
				Result := parent_i.interface
			end
		end

	row: EV_GRID_ROW is
			-- Row to which current item belongs
		require
			parented: is_parented
		do
			Result := parent_row_i.interface
		ensure
			row_not_void: Result /= Void
		end

feature -- Status setting

	enable_select is
			-- Set `is_selected' `True'.
		do
			if not is_selected then
				if parent_i.single_row_selection_enabled or else parent_i.multiple_row_selection_enabled then
						-- We are in row selection mode so we manipulate the parent row directly
					parent_row_i.enable_select
				else
					enable_select_internal
					if parent_row_i.is_selected then
						parent_i.update_row_selection_status (parent_row_i)
					end
					parent_i.update_item_selection_status (Current)
					parent_i.redraw_client_area
					fixme ("Perform a more optimal redraw when available")
				end
			end
		end

	disable_select is
			-- Set `is_selected' `False'.
		do
			if is_selected then
				disable_select_internal
				parent_i.redraw_client_area
				fixme ("Perform a more optimal redraw when available")				
			end
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
			if parent_row_i.is_selected or else parent_column_i.is_selected then
				Result := True
			else
				Result := internal_is_selected
			end
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
		
feature {EV_GRID_I, EV_GRID_ROW_I} -- Implementation

	enable_select_internal is
			-- Set up internal data to signify `Current' has been selected
		require
			item_is_not_selected: not is_selected
		do
			internal_is_selected := True
			parent_row_i.increase_selected_item_count
			parent_column_i.increase_selected_item_count					
		end

	disable_select_internal is
			-- Set up internal data to signify that `Current' has been deselected
		require
			item_is_selected: is_selected
		do
			parent_row_i.decrease_selected_item_count
			parent_column_i.decrease_selected_item_count
			internal_is_selected := False
		end

feature {EV_GRID_I, EV_GRID_ROW_I} -- Implementation

	internal_is_selected: BOOLEAN
		-- Has `enable_select' been called on `Current'

feature {EV_GRID_I} -- Implementation

	set_parents (a_parent_i: EV_GRID_I; a_parent_column_i: EV_GRID_COLUMN_I; a_parent_row_i: EV_GRID_ROW_I) is
			-- Set the appropriate grid, column and row parents
		require
			a_parent_i_not_void: a_parent_i /= Void
			a_parent_column_i_not_void: a_parent_column_i /= Void
			a_parent_row_i_not_void: a_parent_row_i /= Void
		do
			parent_i := a_parent_i
			parent_column_i := a_parent_column_i
			parent_row_i := a_parent_row_i
		ensure
			parent_i_set: parent_i = a_parent_i
			parent_column_i_set: parent_column_i = a_parent_column_i
			parent_row_i_set: parent_row_i = a_parent_row_i
		end

	set_created_from_grid is
			-- Flag `Current' as `created_from_grid' to signify that `Current' hasn't been set by user
		do
			created_from_grid := True
		end

	created_from_grid: BOOLEAN
		-- Was `Current' create from `parent_i'

	parent_i: EV_GRID_I
		-- Grid that `Current' resides in if any.

	parent_column_i: EV_GRID_COLUMN_I
		-- Grid column that `Current' resides in if any

	parent_row_i: EV_GRID_ROW_I
		-- Grid row that `Current' resides in if any
		
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

feature {EV_ANY_I, EV_GRID_DRAWER_I} -- Implementation

	interface: EV_GRID_ITEM
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

invariant
	is_parented_implies_parents_set: is_parented implies parent_i /= Void and then parent_column_i /= Void and then parent_row_i /= Void
	not_is_parented_implies_parents_not_set: not is_parented implies parent_i = Void and then parent_column_i = Void and then parent_row_i = Void
			
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
