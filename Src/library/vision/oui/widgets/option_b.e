--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Rectangle which display an option menu when armed.

indexing

	date: "$Date$";
	revision: "$Revision$"

class OPTION_B 

inherit

	BUTTON
		redefine
			implementation, parent
		end

creation

	make

feature -- Creation

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a menu button with `a_name' as label
			-- 'a_parent' as parent and call `set_default'.
		require
			Valid_name: a_name /= Void;
			Valid_parent: a_parent /= Void
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= a_name.duplicate;
			implementation:= toolkit.option_b (Current);
			set_default
		ensure
			Parent_set: parent = a_parent;
			Identifier_set: identifier.is_equal (a_name)
		end;

feature

	parent: COMPOSITE is
			-- Parent of current menu button
		do
			Result ?= widget_manager.parent (Current)
		end;

	selected_button: BUTTON is
			-- Current Push Button selected in the option menu
		do
			Result := implementation.selected_button
		end;

	set_selected_button (button: BUTTON) is
			-- Set `selected_button' to `button'
		require
			button_exists: not (button = Void)
		do
			implementation.set_selected_button (button)
		ensure
			button = selected_button
		end; 

	attach_menu (a_menu: OPT_PULL) is
			-- Attach menu `a_menu' to the menu button, it will
			-- be the menu which will appear when the button
			-- is armed.
		require
			menu_not_void: not (a_menu = Void);
			same_parent: a_menu.parent = parent
		do
			implementation.attach_menu (a_menu)
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: OPTION_B_I;
			-- Implementation of menu button

feature {NONE}

	set_default is
			-- Set default value to current menu button.
		do
		end 

end
