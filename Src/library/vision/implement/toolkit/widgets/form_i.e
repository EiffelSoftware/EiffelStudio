indexing

	description: "General form implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	FORM_I 

inherit

	BULLETIN_I
	
feature -- Access

	fraction_base: INTEGER is
			-- Value used to compute child position with
			-- position attachment
		deferred
		ensure
			fraction_base_strictly_greater_than_zero: Result > 0
		end;

feature -- Status report

	is_valid (other: WIDGET_I): BOOLEAN is
			-- Is `other' a valid child?
		do
			Result := True
		end

feature -- Basic operations

	attach_right (a_child: WIDGET_I; right_offset: INTEGER) is
			-- Attach right side of `a_child' to the right side of current form
			-- with `right_offset' spaces between each other.
		require
			not_child_void: a_child /= Void
			not_shell_child: is_valid (a_child);
			offset_non_negative: right_offset >= 0
		deferred
		end;

	attach_left (a_child: WIDGET_I; left_offset: INTEGER) is
			-- Attach left side of `a_child' to the left side of current form
			-- with `left_offset' spaces between each other.
		require
			not_child_void: a_child /= Void
			not_shell_child: is_valid (a_child);
			offset_non_negative: left_offset >= 0
		deferred
		end;

	attach_bottom (a_child: WIDGET_I; bottom_offset: INTEGER) is
			-- Attach bottom side of `a_child' to the bottom side of current form
			-- with `bottom_offset' spaces between each other.
		require
			not_child_void: a_child /= Void
			not_shell_child: is_valid (a_child);
			offset_non_negative: bottom_offset >= 0
		deferred
		end;

	attach_top (a_child: WIDGET_I; top_offset: INTEGER) is
			-- Attach top side of `a_child' to the top side of current form
			-- with `top_offset' spaces between each other.
		require
			not_child_void: a_child /= Void
			not_shell_child: is_valid (a_child);
			offset_non_negative: top_offset >= 0
		deferred
		end;

	attach_right_widget (a_widget: WIDGET_I; a_child: WIDGET_I; right_offset: INTEGER) is
			-- Attach right side of `a_child' to the left side of
			-- `a_widget' with `right_offset' spaces between each other.
		require
			not_child_void: a_child /= Void;
			not_shell_child: is_valid (a_child);
			not_widget_void: a_widget /= Void;
			offset_non_negative: right_offset >= 0
		deferred
		end;

	attach_left_widget (a_widget: WIDGET_I; a_child: WIDGET_I; left_offset: INTEGER) is
			-- Attach left side of `a_child' to the right side of
			-- `a_widget' with `left_offset' spaces between each other.
		require
			not_child_void: a_child /= Void;
			not_shell_child: is_valid (a_child);
			not_widget_void: a_widget /= Void;
			offset_non_negative: left_offset >= 0
		deferred
		end;

	attach_bottom_widget (a_widget: WIDGET_I; a_child: WIDGET_I; bottom_offset: INTEGER) is
			-- Attach bottom side of `a_child' to the top side of
			-- `a_widget' with `bottom_offset' spaces between each other.
		require
			not_child_void: a_child /= Void;
			not_shell_child: is_valid (a_child);
			not_widget_void: a_widget /= Void;
			offset_non_negative: bottom_offset >= 0
		deferred
		end;

	attach_top_widget (a_widget: WIDGET_I; a_child: WIDGET_I; top_offset: INTEGER) is
			 -- Attach top side of `a_child' to the bottom side of
			-- `a_widget' with `top_offset' spaces between each other.
		require
			not_child_void: a_child /= Void;
			not_shell_child: is_valid (a_child);
			not_widget_void: a_widget /= Void;
			offset_non_negative: top_offset >= 0
		deferred
		end;

	attach_left_position (a_child: WIDGET_I; a_position: INTEGER) is
			-- Attach left side of `a_child' to a position that is
			-- relative to left side of current form and is a fraction
			-- of the width of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		require
			not_child_void: a_child /= Void;
			not_shell_child: is_valid (a_child);
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= fraction_base
		deferred
		end;

	attach_right_position (a_child: WIDGET_I; a_position: INTEGER) is
			-- Attach right side of `a_child' to a position that is
			-- relative to right side of current form and is a fraction
			-- of the width of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		require
			not_child_void: a_child /= Void;
			not_shell_child: is_valid (a_child);
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= fraction_base
		deferred
		end;

	attach_bottom_position (a_child: WIDGET_I; a_position: INTEGER) is
			-- Attach bottom side of `a_child' to a position that is
			-- relative to bottom side of current form and is a fraction
			-- of the height of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		require
			not_child_void: a_child /= Void;
			not_shell_child: is_valid (a_child);
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= fraction_base
		deferred
		end;

	attach_top_position (a_child: WIDGET_I; a_position: INTEGER) is
			-- Attach top side of `a_child' to a position that is
			-- relative to top side of current form and is a fraction
			-- of the height of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		require
			not_child_void: a_child /= Void;
			not_shell_child: is_valid (a_child);
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= fraction_base
		deferred
		end;

	detach_right (a_child: WIDGET_I) is
			-- Detach right side of `a_child'.
		require
			not_child_void: a_child /= Void
		deferred
		end;

	detach_left (a_child: WIDGET_I) is
			-- Detach left side of `a_child'.
		require
			not_child_void: a_child /= Void
		deferred
		end;

	detach_bottom (a_child: WIDGET_I) is
			-- Detach bottom side of `a_child'.
		require
			not_child_void: a_child /= Void
		deferred
		end;

	detach_top (a_child: WIDGET_I) is
			-- Detach top side of `a_child'.
		require
			not_child_void: a_child /= Void
		deferred
		end;

feature -- Element change

	set_fraction_base (a_value: INTEGER) is
			-- Set fraction_base to `a_value'.
			-- Unsecure to set it after any position attachment,
			-- contradictory constraints could occur.
		require
			a_value_strictly_greater_than_zero: a_value > 0
		deferred
		end;

end -- class FORM_I



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

