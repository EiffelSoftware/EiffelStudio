--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.	  --
--|	270 Storke Road, Suite 7 Goleta, California 93117		--
--|				   (805) 685-1006							--
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Button drawn on screen with an arrow.

indexing

	date: "$Date$";
	revision: "$Revision$"

class ARROW_B 

inherit

	BUTTON
		redefine
			implementation, text, set_text, 
			font, set_font,
			set_left_alignment, set_center_alignment
		end

creation

	make

feature -- Creation 

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create an arrow button with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			Valid_name: a_name /= Void;
			Valid_parent: a_parent /= Void;
			Parent_not_menu_bar: is_valid (a_parent)
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= a_name.duplicate;
			implementation:= toolkit.arrow_b (Current);
			set_default
		ensure
			Parent_set: parent = a_parent;
			Identifier_set: identifier.is_equal (a_name);
			Button_is_up: up
		end;

feature --  Arrow direction 

	down: BOOLEAN is
			-- Is the arrow direction down ?
		do
			Result := implementation.down
		end;

	left: BOOLEAN is
			-- Is the arrow direction left ?
		do
			Result := implementation.left
		end;

	right: BOOLEAN is
			-- Is the arrow direction right ?
		do
			Result := implementation.right
		end;

	up: BOOLEAN is
			-- Is the arrow direction up ?
		do
			Result := implementation.up
		end;

	set_down is
			-- Set the arrow direction to down.
		do
			implementation.set_down
		end;

	set_left is
			-- Set the arrow direction to left.
		do
			implementation.set_left
		end;

	set_right is
			-- Set the arrow direction to right.
		do
			implementation.set_right
		end;

	set_up is
			-- Set the arrow direction to up.
		do
			implementation.set_up
		end;

feature {NONE}

	font: FONT is
			-- Font of arrow button
		do
		end;

	set_font (a_font: FONT) is
			-- Set font to `a_font'.
		do
		end;

feature {NONE}

	text: STRING is
			-- Text of current button
		do
		end;

	set_text (a_text: STRING) is
			-- Do nothing. 
		do
		end;

	set_left_alignment is
			--  Set text alignment to left.
		do
		end; -- set_text
 
	set_center_alignment is
			--  Set text alignment to center.
		do
		end; -- set_text

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: ARROW_B_I;
			-- Implementation of arrow button

feature {NONE} 

	is_valid (other: COMPOSITE): BOOLEAN is
			-- Is `other' a valid parent?
		local
			a_bar: BAR
		do
			a_bar ?= other;
			Result := (a_bar = Void)
		end;

	set_default is
			-- Set default values to current arrow button.
		do
		end;

end
