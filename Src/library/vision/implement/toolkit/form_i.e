indexing

	description: "General form implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class FORM_I 

inherit

	BULLETIN_I
	
feature 

	attach_right (a_child: WIDGET_I; right_offset: INTEGER) is
			-- Attach right side of `a_child' to the right side of current form
			-- with `right_offset' spaces between each other.
		require
			not_child_void: not (a_child = Void);
			not_shell_child: is_valid (a_child);
			offset_non_negative: right_offset >= 0
		deferred
		end; -- attach_right

	attach_left (a_child: WIDGET_I; left_offset: INTEGER) is
			-- Attach left side of `a_child' to the left side of current form
			-- with `left_offset' spaces between each other.
		require
			not_child_void: not (a_child = Void);
			not_shell_child: is_valid (a_child);
			offset_non_negative: left_offset >= 0
		deferred
		end; -- attach_left

	attach_bottom (a_child: WIDGET_I; bottom_offset: INTEGER) is
			-- Attach bottom side of `a_child' to the bottom side of current form
			-- with `bottom_offset' spaces between each other.
		require
			not_child_void: not (a_child = Void);
			not_shell_child: is_valid (a_child);
			offset_non_negative: bottom_offset >= 0
		deferred
		end; -- attach_bottom

	attach_top (a_child: WIDGET_I; top_offset: INTEGER) is
			-- Attach top side of `a_child' to the top side of current form
			-- with `top_offset' spaces between each other.
		require
			not_child_void: not (a_child = Void);
			not_shell_child: is_valid (a_child);
			offset_non_negative: top_offset >= 0
		deferred
		end; -- attach_top

	attach_right_widget (a_widget: WIDGET_I; a_child: WIDGET_I; right_offset: INTEGER) is
			-- Attach right side of `a_child' to the left side of
			-- `a_widget' with `right_offset' spaces between each other.
		require
			not_child_void: not (a_child = Void);
			not_shell_child: is_valid (a_child);
			not_widget_void: not (a_widget = Void);
			offset_non_negative: right_offset >= 0
		deferred
		end; -- attach_right_widget

	attach_left_widget (a_widget: WIDGET_I; a_child: WIDGET_I; left_offset: INTEGER) is
			-- Attach left side of `a_child' to the right side of
			-- `a_widget' with `left_offset' spaces between each other.
		require
			not_child_void: not (a_child = Void);
			not_shell_child: is_valid (a_child);
			not_widget_void: not (a_widget = Void);
			offset_non_negative: left_offset >= 0
		deferred
		end; -- attach_left_widget

	attach_bottom_widget (a_widget: WIDGET_I; a_child: WIDGET_I; bottom_offset: INTEGER) is
			-- Attach bottom side of `a_child' to the top side of
			-- `a_widget' with `bottom_offset' spaces between each other.
		require
			not_child_void: not (a_child = Void);
			not_shell_child: is_valid (a_child);
			not_widget_void: not (a_widget = Void);
			offset_non_negative: bottom_offset >= 0
		deferred
		end; -- attach_bottom_widget

	attach_top_widget (a_widget: WIDGET_I; a_child: WIDGET_I; top_offset: INTEGER) is
			 -- Attach top side of `a_child' to the bottom side of
			-- `a_widget' with `top_offset' spaces between each other.
		require
			not_child_void: not (a_child = Void);
			not_shell_child: is_valid (a_child);
			not_widget_void: not (a_widget = Void);
			offset_non_negative: top_offset >= 0
		deferred
		end; -- attach_top_widget

	attach_left_position (a_child: WIDGET_I; a_position: INTEGER) is
			-- Attach left side of `a_child' to a position that is
			-- relative to left side of current form and is a fraction
			-- of the width of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		require
			not_child_void: not (a_child = Void);
			not_shell_child: is_valid (a_child);
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= fraction_base
		deferred
		end; -- attach_left_position

	attach_right_position (a_child: WIDGET_I; a_position: INTEGER) is
			-- Attach right side of `a_child' to a position that is
			-- relative to right side of current form and is a fraction
			-- of the width of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		require
			not_child_void: not (a_child = Void);
			not_shell_child: is_valid (a_child);
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= fraction_base
		deferred
		end; -- attach_right_position

	attach_bottom_position (a_child: WIDGET_I; a_position: INTEGER) is
			-- Attach bottom side of `a_child' to a position that is
			-- relative to bottom side of current form and is a fraction
			-- of the height of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		require
			not_child_void: not (a_child = Void);
			not_shell_child: is_valid (a_child);
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= fraction_base
		deferred
		end; -- attach_bottom_position

	attach_top_position (a_child: WIDGET_I; a_position: INTEGER) is
			-- Attach top side of `a_child' to a position that is
			-- relative to top side of current form and is a fraction
			-- of the height of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		require
			not_child_void: not (a_child = Void);
			not_shell_child: is_valid (a_child);
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= fraction_base
		deferred
		end; -- attach_top_position

	detach_right (a_child: WIDGET_I) is
			-- Detach right side of `a_child'.
		require
			not_child_void: not (a_child = Void)
		deferred
		end; -- detach_right;

	detach_left (a_child: WIDGET_I) is
			-- Detach left side of `a_child'.
		require
			not_child_void: not (a_child = Void)
		deferred
		end; -- detach_left;

	detach_bottom (a_child: WIDGET_I) is
			-- Detach bottom side of `a_child'.
		require
			not_child_void: not (a_child = Void)
		deferred
		end; -- detach_bottom;

	detach_top (a_child: WIDGET_I) is
			-- Detach top side of `a_child'.
		require
			not_child_void: not (a_child = Void)
		deferred
		end; -- detach_top;

	set_fraction_base (a_value: INTEGER) is
			-- Set fraction_base to `a_value'.
			-- Unsecure to set it after any position attachment,
			-- contradictory constraints could occur.
		require
			a_value_strictly_greater_than_zero: a_value > 0
		deferred
		end; -- set_fraction_base

	fraction_base: INTEGER is
			-- Value used to compute child position with
			-- position attachment
		deferred
		ensure
			fraction_base_strictly_greater_than_zero: Result > 0
		end; -- fraction_base

	
feature 

	is_valid (other: WIDGET_I): BOOLEAN is
			-- Is `other' a valid child?
		do
			Result := true
		end -- is_valid

end -- class FORM_I


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
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
