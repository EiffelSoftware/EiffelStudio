--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Area which manages children relative to each other
-- according to defined constraints. 

indexing

	date: "$Date$";
	revision: "$Revision$"

class FORM 

inherit

	BULLETIN
		rename
			make as bulletin_make
		redefine
			implementation
		end

creation

	make

feature -- Creation

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a form with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			Valid_name: a_name /= Void;
			Valid_parent: a_parent /= Void
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= a_name.duplicate;
			implementation:= toolkit.form (Current);
			set_default
		ensure
			Parent_set: parent = a_parent;
			Identifer_set: identifier.is_equal (a_name);
			Fraction_base_is_100: fraction_base = 100
		end; 

	
feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: FORM_I;
			-- Implementation of form
	
feature -- Attachments using offet

	attach_right (a_child: WIDGET; right_offset: INTEGER) is
			-- Attach right side of `a_child' to the right side of current form
			-- with `right_offset' spaces between each other.
		require
			Valid_child: a_child /= Void;
			Not_shell_child: is_valid (a_child);
			Child_parent_equal_current: a_child.parent = Current;
			Offset_non_negative: right_offset >= 0
		do
			implementation.attach_right (a_child.implementation, right_offset)
		end;

	attach_left (a_child: WIDGET; left_offset: INTEGER) is
			-- Attach left side of `a_child' to the left side of current form
			-- with `left_offset' spaces between each other.
		require
			Valid_childe: a_child /= Void;
			Not_shell_child: is_valid (a_child);
			Child_parent_equal_current: a_child.parent = Current;
			Offset_non_negative: left_offset >= 0
		do
			implementation.attach_left (a_child.implementation, left_offset)
		end;

	attach_bottom (a_child: WIDGET; bottom_offset: INTEGER) is
			-- Attach bottom side of `a_child' to the bottom side of current form
			-- with `bottom_offset' spaces between each other.
		require
			Valid_child: a_child /= Void;
			Not_shell_child: is_valid (a_child);
			Child_parent_equal_current: a_child.parent = Current;
			Offset_non_negative: bottom_offset >= 0
		do
			implementation.attach_bottom (a_child.implementation, bottom_offset)
		end;

	attach_top (a_child: WIDGET; top_offset: INTEGER) is
			-- Attach top side of `a_child' to the top side of current form
			-- with `top_offset' spaces between each other.
		require
			Valid_child: a_child /= Void;
			Not_shell_child: is_valid (a_child);
			Child_parent_equal_current: a_child.parent = Current;
			Offset_non_negative: top_offset >= 0
		do
			implementation.attach_top (a_child.implementation, top_offset)
		end;

	attach_right_widget (a_widget: WIDGET; a_child: WIDGET; right_offset: INTEGER) is
			-- Attach right side of `a_child' to the left side of 
			-- `a_widget' with `right_offset' spaces between each other.
		require
			Valid_child: a_child /= Void;
			Not_shell_child: is_valid (a_child);
			Valid_widget: a_widget /= Void;
			Child_parent_equal_current: a_child.parent = Current;
			Widget_parent_equal_current: a_widget.parent = Current;
			Offset_non_negative: right_offset >= 0
		do
			implementation.attach_right_widget (a_widget.implementation, a_child.implementation, right_offset)
		end;

	attach_left_widget (a_widget: WIDGET; a_child: WIDGET; left_offset: INTEGER) is
			-- Attach left side of `a_child' to the right side of
			-- `a_widget' with `left_offset' spaces between each other.
		require
			Valid_child: a_child /= Void;
			Not_shell_child: is_valid (a_child);
			Valid_widget: a_widget /= Void;
			Child_parent_equal_current: a_child.parent = Current;
			Widget_parent_equal_current: a_widget.parent = Current;
			Offset_non_negative: left_offset >= 0
		do
			implementation.attach_left_widget (a_widget.implementation, a_child.implementation, left_offset)
		end;

	attach_bottom_widget (a_widget: WIDGET; a_child: WIDGET; bottom_offset: INTEGER) is
			-- Attach bottom side of `a_child' to the top side of
			-- `a_widget' with `bottom_offset' spaces between each other.
		require
			Valid_child: a_child /= Void;
			Not_shell_child: is_valid (a_child);
			Valid_widget: a_widget /= Void;
			Child_parent_equal_current: a_child.parent = Current;
			Widget_parent_equal_current: a_widget.parent = Current;
			Offset_non_negative: bottom_offset >= 0
		do
			implementation.attach_bottom_widget (a_widget.implementation, a_child.implementation, bottom_offset)
		end;

	attach_top_widget (a_widget: WIDGET; a_child: WIDGET; top_offset: INTEGER) is
			-- Attach top side of `a_child' to the bottom side of
			-- `a_widget' with `top_offset' spaces between each other.
		require
			Valid_child: a_child /= Void;
			Not_shell_child: is_valid (a_child);
			not_widget_void: a_widget /= Void;
			Child_parent_equal_current: a_child.parent = Current;
			Widget_parent_equal_current: a_widget.parent = Current;
			Offset_non_negative: top_offset >= 0
		do
			implementation.attach_top_widget (a_widget.implementation, a_child.implementation, top_offset)
		end;

feature -- Attachments using positioning 

	attach_left_position (a_child: WIDGET; a_position: INTEGER) is
			-- Attach left side of `a_child' to a position that is
			-- relative to left side of current form and is a fraction
			-- of the width of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		require
			Valid_child: a_child /= Void;
			Not_shell_child: is_valid (a_child);
			Position_large_enough: a_position >= 0;
			Position_small_enough: a_position <= fraction_base;
			Child_parent_equal_current: a_child.parent = Current
		do
			implementation.attach_left_position (a_child.implementation, a_position)
		end;

	attach_right_position (a_child: WIDGET; a_position: INTEGER) is
			-- Attach right side of `a_child' to a position that is
			-- relative to right side of current form and is a fraction
			-- of the width of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		require
			Valid_child: a_child /= Void;
			Not_shell_child: is_valid (a_child);
			Position_large_enough: a_position >= 0;
			Position_small_enough: a_position <= fraction_base;
			Child_parent_equal_current: a_child.parent = Current
		do
			implementation.attach_right_position (a_child.implementation, a_position)
		end;

	attach_bottom_position (a_child: WIDGET; a_position: INTEGER) is
			-- Attach bottom side of `a_child' to a position that is
			-- relative to bottom side of current form and is a fraction
			-- of the height of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		require
			Valid_child: a_child /= Void;
			Not_shell_child: is_valid (a_child);
			Position_large_enough: a_position >= 0;
			Position_small_enough: a_position <= fraction_base;
			Child_parent_equal_current: a_child.parent = Current
		do
			implementation.attach_bottom_position (a_child.implementation, a_position)
		end;

	attach_top_position (a_child: WIDGET; a_position: INTEGER) is
			-- Attach top side of `a_child' to a position that is
			-- relative to top side of current form and is a fraction
			-- of the height of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		require
			Valid_child: a_child /= Void;
			Not_shell_child: is_valid (a_child);
			Position_large_enough: a_position >= 0;
			Position_small_enough: a_position <= fraction_base;
			Child_parent_equal_current: a_child.parent = Current
		do
			implementation.attach_top_position (a_child.implementation, a_position)
		end;

	fraction_base: INTEGER is
			-- Value used to compute child position with
			-- position attachment
		do
			Result := implementation.fraction_base
		ensure
			Fraction_base_greater_than_zero: Result > 0
		end;

	set_fraction_base (a_value: INTEGER) is
			-- Set fraction_base to `a_value'.
			-- Unsecure to set it after any position attachment,
			-- contradictory constraints could occur.
		require
			Value_greater_than_zero: a_value > 0
		do
			implementation.set_fraction_base (a_value)
		end;

feature -- Detachments

	detach_right (a_child: WIDGET) is
			-- Detach right side of `a_child'.
		require
			Valid_child: a_child /= Void
		do
			implementation.detach_right (a_child.implementation)
		end;

	detach_left (a_child: WIDGET) is
			-- detach left side of `a_child'.
		require
			Valid_child: a_child /= Void
		do
			implementation.detach_left (a_child.implementation)
		end;

	detach_bottom (a_child: WIDGET) is
			-- detach bottom side of `a_child'.
		require
			Valid_child: a_child /= Void
		do
			implementation.detach_bottom (a_child.implementation)
		end; 

	detach_top (a_child: WIDGET) is
			-- detach top side of `a_child'.
		require
			Valid_child: a_child /= Void
		do
			implementation.detach_top (a_child.implementation)
		end;

feature {NONE}

	is_valid (other: WIDGET): BOOLEAN is
			-- Is `other' a valid child?
		do
			Result := true
		end 

end 
