--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.	  --
--|	270 Storke Road, Suite 7 Goleta, California 93117		--
--|				   (805) 685-1006							--
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Drawable rectangle with a shadow border.

indexing

	date: "$Date$";
	revision: "$Revision$"

class DRAW_B 

inherit

	BUTTON
		redefine
			implementation
		end;

	DRAWING
		
creation

	make
	
feature -- Creation 

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a draw button with `a_name' as identifier
			-- and `a_parent' as parent.
		require
			Valid_name: a_name /= Void;
			Valid_parent: a_parent /= Void;
			Parent_not_menu_bar: is_valid (a_parent)
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= a_name.duplicate;
			implementation:= toolkit.draw_b (Current);
			set_default
		ensure
			Parent_set: parent = a_parent;
			Identifier_set: identifier.is_equal (a_name)
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: DRAW_B_I;
			-- Implementation of draw button
	
feature {NONE}

	set_default is
			-- Set default values to current drawing button.
		do
		end;

	is_valid (other: COMPOSITE): BOOLEAN is
			-- Is `other' a valid parent?
		local
			a_bar: BAR
		do
			a_bar ?= other;
			Result := (a_bar = Void)
		end;
	
end
