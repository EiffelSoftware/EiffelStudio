indexing
	description: "EiffelVision item, gtk implementation";
	status: "See notice at end of class"
	date: "$Date$";
	revision: "$Revision$"

deferred class 
	EV_ITEM_IMP

inherit
	EV_ITEM_I

	EV_GTK_ITEMS_EXTERNALS
		
	EV_WIDGET_IMP
			-- Inheriting from widget,
			-- because items are widget in gtk
		rename
			add_double_click_command as old_add_dblclk,
			remove_double_click_commands as old_remove_dblclk,
			parent_imp as widget_parent_imp,
			set_parent as widget_set_parent,
			parent_set as widget_parent_set
		undefine
			has_parent
		end

feature -- Access

	parent_imp: EV_ITEM_HOLDER_IMP is
			-- The parent of the Current widget
			-- Can be void.
		deferred
		end

	parent_widget: EV_WIDGET is
			-- Parent widget of the current item
		do
			check
				not_yet_implemented: False
			end
		end

feature -- Element Change

	set_parent_with_index (par: like parent; pos: INTEGER) is
			-- Make `par' the new parent of the widget and set
			-- the current button at `pos'.
		do
			set_parent (par)
			set_index (pos)
		end

feature -- Assertion features

	has_parent: BOOLEAN is
			-- True if the widget has a parent, False otherwise
		do
			Result := parent_imp /= void
		end

end -- class EV_ITEM_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------
