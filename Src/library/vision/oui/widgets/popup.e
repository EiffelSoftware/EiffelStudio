--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

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

feature -- Creation

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a popup menu with `a_name' as identifier,
			-- `a_parent' as parent.
		 require
			Valid_name: a_name /= Void;
			Valid_parent: a_parent /= Void
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= a_name.duplicate;
			implementation := toolkit.popup (Current);
			set_default
		ensure
			Parent_set: parent = a_parent;
			Name_set: identifier.is_equal (a_name)
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
