--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

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
		end

creation

	make

feature -- Creation

	make (a_name: STRING; a_parent: MENU) is
			-- Create a pulldown menu with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			Valid_name: a_name /= Void;
			Valid_parent: a_parent /= Void
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= a_name.duplicate;
			implementation := toolkit.menu_pull (Current);
			set_default
		ensure
			Parent_set: parent = a_parent;
			Identifer_set: identifier.is_equal (a_name)
		end;
	
feature -- Menu

	menu_button: MENU_B is
			-- Menu button 
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
        end

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: MENU_PULL_I;
			-- Implementation of pulldown menu

feature {NONE}

	set_default is
			-- Set default values to current pulldown menu.
		do
		end;

end 

