indexing
	description: "Eiffel Vision menu bar. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_MENU_BAR_IMP

inherit
	EV_MENU_BAR_I
		redefine
			interface
		end

	EV_MENU_ITEM_LIST_IMP
		redefine
			make,
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			Precursor (an_interface)
			wel_make
		end
		
feature {EV_ANY_I} -- Status report

	parent: EV_WINDOW is
			-- Parent of `Current'.
		do
			if parent_imp /= Void then
				Result := parent_imp.interface					
			end
		end

feature {NONE} -- Implementation

	is_sensitive: BOOLEAN is True
			-- `Current' is always sensitive as it cannot be disabled
			-- in the interface.

	destroy is
			-- destroy `Current'.
		do
			if parent_imp /= Void then
				parent_imp.remove_menu_bar
			end
			is_destroyed := True
		end
		
	update_parent_size is
			-- Update size of `Parent_imp'.
		do
			if parent_imp /= Void then
				parent_imp.compute_minimum_size	
			end
		end

feature {NONE} -- Pick and drop support

	--| FIXME All these features to be implemented are required by PND.
	-- Due to the way that windows handles messaging with menu's, implementing
	-- pick and drop may be difficult.
	-- I think that the pick and drop can be done using WM_MENURBUTTONUP,
	-- although drag and drop may be a lot more difficult.
	-- Julian Rogers 08/22/2000

	disable_default_processing is
			-- Disable default window processing.
		do
			check
				pick_and_drop_not_implemented_for_menus: False
			end
		end

	internal_propagate_pointer_press (keys, x_pos, y_pos, button: INTEGER) is
			-- Propagate `keys', `x_pos' and `y_pos' to the appropriate item
			-- event. Called on pointer press.
		do
			check
				pick_and_drop_not_implemented_for_menus: False
			end
		end

	internal_propagate_pointer_double_press
		(keys, x_pos, y_pos, button: INTEGER) is
			-- Propagate `keys', `x_pos' and `y_pos' to the appropriate item
			-- event. Called on pointer double press.
		do
			check
				pick_and_drop_not_implemented_for_menus: False
			end
		end

	find_item_at_position (x_pos, y_pos: INTEGER): EV_MENU_IMP is
			-- `Result' is menu at pixel position `x_pos', `y_pos'.
		do
		end

	screen_x: INTEGER is
			-- Horizontal offset of `Current' relative to screen.
		do
		end

	screen_y: INTEGER is
			-- Vertical offset of `Current' relative to screen.
		do
		end

	set_pointer_style (value: EV_CURSOR) is
			-- Make `value' the new cursor of the widget
		do
			check
				pick_and_drop_not_implemented_for_menus: False
			end
		end

	client_to_screen (a_x, a_y: INTEGER): WEL_POINT is
			-- `Result' is absolute screen coordinates in pixels
			-- of coordinates `a_x', a_y_' on `Current'.
		do
			check
				pick_and_drop_not_implemented_for_menus: False
			end
		end

	cursor_on_widget: CELL [EV_WIDGET_IMP] is
			-- This cell contains the widget_imp that currently
			-- has the pointer of the mouse. As it is a once 
			-- feature, it is a shared data.
			-- it is used for the `mouse_enter' and `mouse_leave'
			-- events.
		do
			check
				pick_and_drop_not_implemented_for_menus: False
			end
		end

	set_heavy_capture is
			-- Grab user input.
			-- Works on all windows threads.
		do
			check
				pick_and_drop_not_implemented_for_menus: False
			end
		end

	release_heavy_capture is
			-- Release user input
			-- Works on all windows threads.
		do
			check
				pick_and_drop_not_implemented_for_menus: False
			end
		end

	set_capture is
			-- Grab user input.
			-- Works only on current windows thread.
		do
			check
				pick_and_drop_not_implemented_for_menus: False
			end
		end

	release_capture is
			-- Release user input.
			-- Works only on current windows thread.
		do
			check
				pick_and_drop_not_implemented_for_menus: False
			end
		end

feature {EV_ANY_I} -- Status Report 
		
	top_level_window_imp: EV_WINDOW_IMP is
			-- Top level window implementation containing `Current'.
		do
			Result := parent_imp
		end

	set_parent_imp (window: EV_WINDOW_IMP) is
			-- Assign `window' to `parent_imp'.
		do
			if window /= Void then
				parent_imp := window
			else
				parent_imp := Void
			end
		end
		
	wel_count_empty: BOOLEAN is
			-- Is `Current' empty?
			--| In some places, we wish to externally query if `Current'
			--| is empty. However, if this is done during a remove_item,
			--| the interface will still return the count as 1. See 
			--|`Extra_minimum_height' from EV_TITLED_WINDOW_IMP.
		do
			Result := wel_count = 0
		end

	parent_imp: EV_WINDOW_IMP
		-- Parent of `Current'.

feature {EV_ANY_I} -- Implementation

	interface: EV_MENU_BAR

end -- class EV_MENU_BAR_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

