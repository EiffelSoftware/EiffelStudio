
-- Menu which can be poped up.

indexing

	date: "$Date$";
	revision: "$Revision$"

class POPUP 

inherit

	MENU
		redefine
			implementation
		end

creation

	make

feature {NONE} -- Creation

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a popup menu with `a_name' as identifier,
			-- `a_parent' as parent.
		 require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= clone (a_name);
			implementation := toolkit.popup (Current);
			set_default
		ensure
			parent_set: parent = a_parent;
			name_set: identifier.is_equal (a_name)
		end;
	
feature 

	popup is
			-- Popup Current popup menu.
		do
			implementation.popup
		end

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: POPUP_I;
			-- Implementation of popup menu

feature {NONE}

	set_default is
			-- Set default values of current popup menu.
		do
		end;

end


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
