--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Rectangle which display a submenu when armed, and also
-- changes its visuals from a 2-D to a 3-D look.

indexing

	date: "$Date$";
	revision: "$Revision$"

class MENU_B 

inherit

	BUTTON
		redefine
			implementation, parent
		end

creation

	make

feature -- Creation

	make (a_name: STRING; a_parent: MENU) is
			-- Create a menu button with `a_name' as label
			-- 'a_parent' as parent and call `set_default'.
		require
			Valid_name: a_name /= Void;
			Valid_parent: a_parent /= Void
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= a_name.duplicate;
			implementation:= toolkit.menu_b (Current);
			set_default
		ensure
			Parent_set: parent = a_parent;
			Identifier_set: identifier.is_equal (a_name)
		end;

feature -- Attach menus

	parent: MENU is
			-- Parent of current menu button
		do
			Result ?= widget_manager.parent (Current)
		end;

	attach_menu (a_menu: MENU_PULL) is
			-- Attach menu `a_menu' to the menu button, it will
			-- be the menu which will appear when the button
			-- is armed.
			-- TO_FIX : to remove
		require
			Valid_menu: a_menu /= Void;
			Same_parent: a_menu.parent = parent
		do
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: MENU_B_I;
			-- Implementation of menu button

feature {NONE}

	set_default is
			-- Set default value to current menu button.
		do
		end

end
