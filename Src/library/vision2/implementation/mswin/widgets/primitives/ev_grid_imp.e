indexing
	description: "[
		Widget which is a combination of an EV_TREE and an EV_MULTI_COLUMN_LIST.
		MSWindows implementation.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_IMP
	
inherit

	EV_CELL_IMP
		rename
			item as cell_item,
			set_item as wel_set_item,
			interface as drawing_area_interface,
			pointer_motion_actions as cell_pointer_motion_actions,
			pointer_motion_actions_internal as cell_pointer_motion_actions_internal,
			pointer_double_press_actions as cell_pointer_double_press_actions,
			pointer_double_press_actions_internal as cell_pointer_double_press_actions_internal,
			pointer_enter_actions as cell_pointer_enter_actions,
			pointer_button_press_actions as cell_pointer_button_press_actions,
			pointer_button_release_actions as cell_pointer_button_release_actions,
			pointer_leave_actions as cell_pointer_leave_actions,
			pointer_enter_actions_internal as cell_pointer_enter_actions_internal,
			pointer_button_press_actions_internal as cell_pointer_button_press_actions_internal,
			pointer_button_release_actions_internal as cell_pointer_button_release_actions_internal,
			pointer_leave_actions_internal as cell_pointer_leave_actions_internal
		undefine
			drop_actions
		redefine
			initialize,
			destroy,
			set_background_color, set_foreground_color
		end
	
	EV_GRID_I
		redefine
			interface
		select
			interface
		end
		
create
	make
	
feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_CELL_IMP}
			initialize_grid
			is_initialized := True
		end

feature {NONE} -- Status setting

	set_background_color (color: EV_COLOR) is
			-- Make `color' the new `background_color'
		do
			background_color_imp ?= color.implementation
			redraw_client_area
		end

	set_foreground_color (color: EV_COLOR) is
			-- Make `color' the new `foreground_color'
		do
			foreground_color_imp ?= color.implementation
			redraw_client_area
		end
		
feature {NONE} -- Implementation

	destroy is
			-- Destroy `Current'.
		do
			Precursor {EV_CELL_IMP}
		end
		
feature {EV_ANY_I} -- Implementation

	interface: EV_GRID

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
