indexing

	description:
		"Area which manages children relative to each other %
		%according to defined constraints"; 
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	FORM 

inherit

	BULLETIN
		redefine
			make, make_unmanaged, create_ev_widget,
			implementation
		end

creation

	make, make_unmanaged

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a form with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			create_ev_widget (a_name, a_parent, True)
		ensure then
			--default_fraction_base_is_100: fraction_base = 100
		end; 

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE) is
			-- Create an unmanaged form with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			create_ev_widget (a_name, a_parent, False)
		ensure then
			--default_fraction_base_is_100: fraction_base = 100
		end; 

	create_ev_widget (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAN) is
			-- Create a form with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier := clone (a_name);
			!FORM_IMP!implementation.make (Current, man, a_parent);
			implementation.set_widget_default;
			set_default
		end; 
	
feature -- Access

	fraction_base: INTEGER is
			-- Value used to compute child position with
			-- position attachment
		require
			exists: not destroyed
		do
			Result := implementation.fraction_base
		ensure
			Fraction_base_greater_than_zero: Result > 0
		end;

feature -- Status report

	is_valid (other: WIDGET): BOOLEAN is
			-- Is `other' a valid child?
		do
			Result := true
		end 

feature -- Element change

	set_fraction_base (a_value: INTEGER) is
			-- Set fraction_base to `a_value'.
			-- Unsecure to set it after any position attachment,
			-- contradictory constraints could occur.
		require
			exists: not destroyed;
			value_greater_than_zero: a_value > 0
		do
			implementation.set_fraction_base (a_value)
		end;

feature -- Basic operations

	attach_right (a_child: WIDGET; right_offset: INTEGER) is
			-- Attach right side of `a_child' to the right side of current form
			-- with `right_offset' spaces between each other.
		require
			exists: not destroyed;
			valid_child: a_child /= Void;
			not_shell_child: is_valid (a_child);
			child_parent_equal_current: a_child.parent = Current;
			offset_non_negative: right_offset >= 0
		do
			implementation.attach_right (a_child.implementation, right_offset)
		end;

	attach_left (a_child: WIDGET; left_offset: INTEGER) is
			-- Attach left side of `a_child' to the left side of current form
			-- with `left_offset' spaces between each other.
		require
			exists: not destroyed;
			valid_childe: a_child /= Void;
			not_shell_child: is_valid (a_child);
			child_parent_equal_current: a_child.parent = Current;
			offset_non_negative: left_offset >= 0
		do
			implementation.attach_left (a_child.implementation, left_offset)
		end;

	attach_bottom (a_child: WIDGET; bottom_offset: INTEGER) is
			-- Attach bottom side of `a_child' to the bottom side of current form
			-- with `bottom_offset' spaces between each other.
		require
			exists: not destroyed;
			valid_child: a_child /= Void;
			not_shell_child: is_valid (a_child);
			child_parent_equal_current: a_child.parent = Current;
			offset_non_negative: bottom_offset >= 0
		do
			implementation.attach_bottom (a_child.implementation, bottom_offset)
		end;

	attach_top (a_child: WIDGET; top_offset: INTEGER) is
			-- Attach top side of `a_child' to the top side of current form
			-- with `top_offset' spaces between each other.
		require
			exists: not destroyed;
			valid_child: a_child /= Void;
			not_shell_child: is_valid (a_child);
			child_parent_equal_current: a_child.parent = Current;
			offset_non_negative: top_offset >= 0
		do
			implementation.attach_top (a_child.implementation, top_offset)
		end;

	attach_right_widget (a_widget: WIDGET; a_child: WIDGET; right_offset: INTEGER) is
			-- Attach right side of `a_child' to the left side of 
			-- `a_widget' with `right_offset' spaces between each other.
		require
			exists: not destroyed;
			valid_child: a_child /= Void;
			not_shell_child: is_valid (a_child);
			valid_widget: a_widget /= Void;
			child_parent_equal_current: a_child.parent = Current;
			widget_parent_equal_current: a_widget.parent = Current;
			offset_non_negative: right_offset >= 0
		do
			implementation.attach_right_widget (a_widget.implementation, a_child.implementation, right_offset)
		end;

	attach_left_widget (a_widget: WIDGET; a_child: WIDGET; left_offset: INTEGER) is
			-- Attach left side of `a_child' to the right side of
			-- `a_widget' with `left_offset' spaces between each other.
		require
			exists: not destroyed;
			valid_child: a_child /= Void;
			not_shell_child: is_valid (a_child);
			valid_widget: a_widget /= Void;
			child_parent_equal_current: a_child.parent = Current;
			widget_parent_equal_current: a_widget.parent = Current;
			offset_non_negative: left_offset >= 0
		do
			implementation.attach_left_widget (a_widget.implementation, a_child.implementation, left_offset)
		end;

	attach_bottom_widget (a_widget: WIDGET; a_child: WIDGET; bottom_offset: INTEGER) is
			-- Attach bottom side of `a_child' to the top side of
			-- `a_widget' with `bottom_offset' spaces between each other.
		require
			exists: not destroyed;
			valid_child: a_child /= Void;
			not_shell_child: is_valid (a_child);
			valid_widget: a_widget /= Void;
			child_parent_equal_current: a_child.parent = Current;
			widget_parent_equal_current: a_widget.parent = Current;
			offset_non_negative: bottom_offset >= 0
		do
			implementation.attach_bottom_widget (a_widget.implementation, a_child.implementation, bottom_offset)
		end;

	attach_top_widget (a_widget: WIDGET; a_child: WIDGET; top_offset: INTEGER) is
			-- Attach top side of `a_child' to the bottom side of
			-- `a_widget' with `top_offset' spaces between each other.
		require
			exists: not destroyed;
			valid_child: a_child /= Void;
			not_shell_child: is_valid (a_child);
			not_widget_void: a_widget /= Void;
			child_parent_equal_current: a_child.parent = Current;
			widget_parent_equal_current: a_widget.parent = Current;
			offset_non_negative: top_offset >= 0
		do
			implementation.attach_top_widget (a_widget.implementation, a_child.implementation, top_offset)
		end;

	attach_left_position (a_child: WIDGET; a_position: INTEGER) is
			-- Attach left side of `a_child' to a position that is
			-- relative to left side of current form and is a fraction
			-- of the width of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		require
			exists: not destroyed;
			valid_child: a_child /= Void;
			not_shell_child: is_valid (a_child);
			position_large_enough: a_position >= 0;
			position_small_enough: a_position <= fraction_base;
			child_parent_equal_current: a_child.parent = Current
		do
			implementation.attach_left_position (a_child.implementation, a_position)
		end;

	attach_right_position (a_child: WIDGET; a_position: INTEGER) is
			-- Attach right side of `a_child' to a position that is
			-- relative to right side of current form and is a fraction
			-- of the width of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		require
			exists: not destroyed;
			valid_child: a_child /= Void;
			not_shell_child: is_valid (a_child);
			position_large_enough: a_position >= 0;
			position_small_enough: a_position <= fraction_base;
			child_parent_equal_current: a_child.parent = Current
		do
			implementation.attach_right_position (a_child.implementation, a_position)
		end;

	attach_bottom_position (a_child: WIDGET; a_position: INTEGER) is
			-- Attach bottom side of `a_child' to a position that is
			-- relative to bottom side of current form and is a fraction
			-- of the height of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		require
			exists: not destroyed;
			valid_child: a_child /= Void;
			not_shell_child: is_valid (a_child);
			position_large_enough: a_position >= 0;
			position_small_enough: a_position <= fraction_base;
			child_parent_equal_current: a_child.parent = Current
		do
			implementation.attach_bottom_position (a_child.implementation, a_position)
		end;

	attach_top_position (a_child: WIDGET; a_position: INTEGER) is
			-- Attach top side of `a_child' to a position that is
			-- relative to top side of current form and is a fraction
			-- of the height of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		require
			exists: not destroyed;
			valid_child: a_child /= Void;
			not_shell_child: is_valid (a_child);
			position_large_enough: a_position >= 0;
			position_small_enough: a_position <= fraction_base;
			child_parent_equal_current: a_child.parent = Current
		do
			implementation.attach_top_position (a_child.implementation, a_position)
		end;

	detach_right (a_child: WIDGET) is
			-- Detach right side of `a_child'.
		require
			exists: not destroyed;
			valid_child: a_child /= Void
		do
			implementation.detach_right (a_child.implementation)
		end;

	detach_left (a_child: WIDGET) is
			-- detach left side of `a_child'.
		require
			exists: not destroyed;
			valid_child: a_child /= Void
		do
			implementation.detach_left (a_child.implementation)
		end;

	detach_bottom (a_child: WIDGET) is
			-- detach bottom side of `a_child'.
		require
			exists: not destroyed;
			valid_child: a_child /= Void
		do
			implementation.detach_bottom (a_child.implementation)
		end; 

	detach_top (a_child: WIDGET) is
			-- detach top side of `a_child'.
		require
			exists: not destroyed;
			valid_child: a_child /= Void
		do
			implementation.detach_top (a_child.implementation)
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: FORM_I;
			-- Implementation of form
	
end -- class FORM



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

