indexing

	description:
			"Fundamental class with geometry.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_RECT_OBJ

inherit

	MEL_RECT_OBJ_RESOURCES
		export
			{NONE} all
		end;

	MEL_FORM_CHILD;

	MEL_FRAME_CHILD;

	MEL_PANED_WINDOW_CHILD

feature -- Access

	real_x: INTEGER is
			-- Horizontal position relative to root window
		do
			Result := xt_real_x (screen_object)
		end;

	real_y: INTEGER is
			-- Vertical position relative to root window
		do
			Result := xt_real_y (screen_object)
		end;

feature -- Status report

	is_ancestor_sensitive: BOOLEAN is
			-- Is a gadget's immediate parent sensitive?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNancestorSensitive)
		end;

	is_input_sensitive: BOOLEAN is
			-- Is Current input sensitive?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNsensitive)
		end;

	border_width: INTEGER is
			-- Width of Current's border
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNBorderWidth)
		ensure
			border_width_large_enough: Result >= 0
		end;

	height: INTEGER is
			-- Window height, excluding the border
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNheight)
		ensure
			height_large_enough: Result >= 0
		end;

	width: INTEGER is
			-- Window width, excluding the border
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNwidth)
		ensure
			width_large_enough: Result >= 0
		end;

	x: INTEGER is
			-- The x-coordinate relative to the parent
		require
			exists: not is_destroyed
		do
			Result := get_xt_position (screen_object, XmNx)
		end;

	y: INTEGER is
			-- The y-coordinate relative to the parent
		require
			exists: not is_destroyed
		do
			Result := get_xt_position (screen_object, XmNy)
		end;

feature -- Status setting

	set_input_sensitive is
			-- Set `is_input_sensitive' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNsensitive, True)
		ensure
			is_sensitive: is_sensitive
		end;

	set_input_insensitive is
			-- Set `is_sensitive' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNsensitive, False)
		ensure
			is_not_sensitive: not is_sensitive
		end;

	set_border_width (a_width: INTEGER) is
			-- Set `border_width' to `a_width'.
		require
			exists: not is_destroyed;
			a_width_large_enough: a_width >= 0
		do
			set_xt_dimension (screen_object, XmNBorderWidth, a_width)
		ensure
			border_width_set: border_width = a_width
		end;

	set_height (a_height: INTEGER) is
			-- Set `height' to `a_height'.
		require
			exists: not is_destroyed;
			a_height_large_enough: a_height >= 0
		do
			set_xt_dimension (screen_object, XmNheight, a_height)
		end;

	set_width (a_width: INTEGER) is
			-- Set `width' to `a_width'.
		require
			exists: not is_destroyed;
			a_width_large_enough: a_width >= 0
		do
			set_xt_dimension (screen_object, XmNwidth, a_width)
		end;

    set_size (new_width:INTEGER; new_height: INTEGER) is
            -- Set `width' to `new_width', and `height' to `new_height'.
        require
			exists: not is_destroyed;
            width_large_enough: new_width >= 0;
            height_large_enough: new_height >= 0
        do
            set_xt_dimension (screen_object, XmNwidth, new_width);
            set_xt_dimension (screen_object, XmNheight, new_height)
        end;

	set_x (a_value: INTEGER) is
			-- Set `x' to `a_value'.
		require
			exists: not is_destroyed
		do
			set_xt_position (screen_object, XmNx, a_value)
		end;

	set_y (a_value: INTEGER) is
			-- Set `y' to `a_value'.
		require
			exists: not is_destroyed
		do
			set_xt_position (screen_object, XmNy, a_value)
		end;

	set_x_y (x_value, y_value: INTEGER) is
			-- Set `x' to `x_value', and `y' to `y_value'.
		require
			exists: not is_destroyed
		do
			set_xt_position (screen_object, XmNx, x_value);
			set_xt_position (screen_object, XmNy, y_value)
		end

	move_to (x_value, y_value: INTEGER) is
			-- Move Current widget to x position `x_value' and
			-- y position to `y_value'. 
			--| The `x_value' and `y_value' will be written into the widget
			--| and if it is realized an `XMoveWindow' is issued on its
			--| window.
		require
			exists: not is_destroyed
		do
			xt_move_widget (screen_object, x_value, y_value)
		end;

feature {NONE} -- External features

    xt_move_widget (w: POINTER; x1, y1: INTEGER) is
        external
            "C (Widget, Position, Position) | <X11/IntrinsicP.h>"
        alias
            "XtMoveWidget"
        end;

	xt_real_y (scr_obj: POINTER): INTEGER is
		external
			"C"
		end;

	xt_real_x (scr_obj: POINTER): INTEGER is
		external
			"C"
		end;

end -- class MEL_RECT_OBJ


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
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

