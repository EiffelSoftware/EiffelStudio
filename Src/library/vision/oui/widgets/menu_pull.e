indexing

	description:
		"Pulldown menu of a menu button, it is attached to a menu button %
		%which is automatically created. It can contain all kinds of buttons";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	MENU_PULL 

inherit

	PULLDOWN
		redefine
			parent, implementation
		end;

creation

	make, make_unmanaged

feature {NONE} -- Initialization

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
			create_ev_widget (a_name, a_parent, False)
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
			identifier := clone (a_name);
			!MENU_PULL_IMP!implementation.make (Current, man, a_parent);
			implementation.set_widget_default;
			set_default
		end;
	
feature -- Access

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

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: MENU_PULL_I;
			-- Implementation of pulldown menu

feature {NONE} -- Implementation

	set_default is
			-- Set default values to current pulldown menu.
		do
		end;

end -- class MENU_PULL



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

