indexing
	description: "Eiffel Vision menu bar. GTK+ implementation."
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
			interface,
			insert_menu_item
		end
	
create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
		do
			base_make (an_interface)
			set_c_object (C.gtk_menu_bar_new)
			C.gtk_widget_show (c_object)
		end
		
feature {EV_WINDOW_IMP} -- Implementation

	set_parent_window (a_wind: EV_WINDOW) is
			-- Set `parent_window' to `a_wind'.
		require
			a_wind_not_void: a_wind /= Void
		do
			parent := a_wind
		end
		
	parent: EV_WINDOW
			-- Parent window of Current.
	
	remove_parent_window is
			-- Set `parent_window' to Void.
		do
			parent := Void
		end

feature {NONE} -- Implementation

	insert_menu_item (an_item_imp: EV_MENU_ITEM_IMP; pos: INTEGER) is
			-- Generic menu item insertion.
		do
			an_item_imp.set_item_parent_imp (Current)
			C.gtk_menu_shell_insert (list_widget, an_item_imp.c_object, pos - 1)
			child_array.go_i_th (pos)
			child_array.put_left (an_item_imp.interface)
		end

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

