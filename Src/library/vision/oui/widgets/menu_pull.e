
-- Pulldown menu of a menu button, it is attached to a menu button 
-- which is automaticaly created. It can contain all kinds of button.

indexing

	date: "$Date$";
	revision: "$Revision$"

class MENU_PULL 

inherit

	PULLDOWN
		redefine
			parent, implementation
		end;

creation

	make, make_unmanaged

feature {NONE} -- Creation

	make (a_name: STRING; a_parent: MENU) is
			-- Create a pulldown menu with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, True)
		ensure
			parent_set: parent = a_parent;
			identifer_set: identifier.is_equal (a_name);
			managed: managed
		end;
	
	make_unmanaged (a_name: STRING; a_parent: MENU) is
			-- Create an unmanaged pulldown menu with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, True)
		ensure
			parent_set: parent = a_parent;
			identifer_set: identifier.is_equal (a_name);
			not_managed: not managed
		end;
	
	create_ev_widget (a_name: STRING; a_parent: MENU; man: BOOLEAN) is
			-- Create a pulldown menu with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= clone (a_name);
			implementation := toolkit.menu_pull (Current, man);
			set_default
		end;
	
feature -- Menu

	menu_button: MENU_B is
			-- Menu button 
		require
			exists: not destroyed
		do
			Result := implementation.menu_button
		end;

	button: BUTTON is
		do
			Result := menu_button
		end;

	parent: MENU is
			-- Parent of pulldown menu
        do
            Result ?= widget_manager.parent (Current)
        end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: MENU_PULL_I;
			-- Implementation of pulldown menu

feature {NONE}

	set_default is
			-- Set default values to current pulldown menu.
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
