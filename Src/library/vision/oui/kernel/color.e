indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class COLOR 

inherit

	G_ANY

creation

	make

feature 

	duplicate: COLOR is
			-- An independent copy of the color
		do
			!!Result.make;
			if (name = Void) then
				Result.set_rgb (red, green, blue);
			else
				Result.set_name ( clone (name))
			end
		end;

	allocated_blue (a_widget: WIDGET): INTEGER is
			-- Allocated blue saturation level for `a_widget'
		require
			a_widget_exists: not (a_widget = Void);
			a_widget_realized: a_widget.realized
		do
			Result := implementation.allocated_blue (a_widget.implementation)
		end;

	allocated_green (a_widget: WIDGET): INTEGER is
			-- Allocated green saturation level for `a_widget'
		require
			a_widget_exists: not (a_widget = Void);
			a_widget_realized: a_widget.realized
		do
			Result := implementation.allocated_green (a_widget.implementation)
		end;

	allocated_red (a_widget: WIDGET): INTEGER is
			-- Allocated red saturation level for `a_widget'
		require
			a_widget_exists: not (a_widget = Void);
			a_widget_realized: a_widget.realized
		do
			Result := implementation.allocated_red (a_widget.implementation)
		end;

	blue: INTEGER is
			-- Blue saturation level
		require
			color_not_specified_by_name: (name = Void)
		do
			Result := implementation.blue
		end;

	make is
			-- Create a color
		do
			implementation := toolkit.color (Current)
		end;

	green: INTEGER is
			-- Green saturation level
		require
			color_not_specified_by_name: (name = Void)
		do
			Result := implementation.green
		end;

	implementation: COLOR_I;
			-- Implementation of color

	is_white_by_default: BOOLEAN is
			-- Default color used in case of failure
			-- to allocate desire color
		do
			Result := implementation.is_white_by_default
		end;

	name: STRING is
			-- name of desired color for current
		do
			Result := implementation.name
		end;

	n_ame: STRING is obsolete "Use ``name''"
			-- name of desired color for current
		do
			Result := name
		end;

	red: INTEGER is
			-- Red saturation level
		require
			color_not_specified_by_name: (name = Void)
		do
			Result := implementation.red
		end;

	set_black_default is
			-- Set black color to be used by default if
			-- it is impossible to allocate desire color.
		do
			implementation.set_black_default
		ensure
			not is_white_by_default
		end;

	set_blue (blue_value: INTEGER) is
			-- Set blue saturation level to `blue_value'.
		require
			blue_value_small_enough: blue_value  <= 65535;
			blue_value_not_negative: blue_value >= 0
		do
			implementation.set_blue (blue_value)
		ensure
			(name = Void);
			blue = blue_value
		end;

	set_green (green_value: INTEGER) is
			-- Set green saturation level to `green_value'.
		require
			green_value_small_enough: green_value  <= 65535;
			green_value_not_negative: green_value >= 0
		do
			implementation.set_green (green_value)
		ensure
			(name = Void);
			green = green_value
		end;

	set_name (a_name: STRING) is
			-- Set color name to `a_name'.
		require
			a_name_not_void: not (a_name = Void)
		do
			implementation.set_name (a_name)
		ensure
			not (name = Void);
			name.is_equal (a_name)
		end;

	set_red (red_value: INTEGER) is
			-- Set red saturation level to `red_value'.
		require
			red_value_small_enough: red_value  <= 65535;
			red_value_not_negative: red_value >= 0
		do
			implementation.set_red (red_value)
		ensure
			(name = Void);
			red = red_value
		end;

	set_rgb (red_value, green_value, blue_value: INTEGER) is
			-- Set red, green and blue saturation level respectivly to
			-- `red_value', `green_value' and `blue_value'.
		require
			red_value_small_enough: red_value  <= 65535;
			red_value_not_negative: red_value >= 0;
			green_value_small_enough: green_value  <= 65535;
			green_value_not_negative: green_value >= 0;
			blue_value_small_enough: blue_value  <= 65535;
			blue_value_not_negative: blue_value >= 0
		do
			implementation.set_rgb (red_value, green_value, blue_value)
		ensure
			(name = Void);
			red = red_value;
			green = green_value;
			blue = blue_value
		end;

	set_white_default is
			-- Set white color to be used by default if
			-- it is impossible to allocate desire color.
		do
			implementation.set_white_default
		ensure
			is_white_by_default
		end

invariant

	valid_implementation: implementation /= Void

end


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
