indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class COLOR_I 

inherit

feature 

	allocated_blue (a_widget: WIDGET_I): INTEGER is
			-- Allocated blue saturation level for `a_widget'
		require
			a_widget_exists: not (a_widget = Void);
			a_widget_realized: a_widget.realized
		deferred
		end; -- allocated_blue

	allocated_green (a_widget: WIDGET_I): INTEGER is
			-- Allocated green saturation level for `a_widget'
		require
			a_widget_exists: not (a_widget = Void);
			a_widget_realized: a_widget.realized
		deferred
		end; -- allocated_green

	allocated_red (a_widget: WIDGET_I): INTEGER is
			-- Allocated red saturation level for `a_widget'
		require
			a_widget_exists: not (a_widget = Void);
			a_widget_realized: a_widget.realized
		deferred
		end; -- allocated_red

	blue: INTEGER is
			-- Blue saturation level
		require
			color_not_specified_by_name: (name = Void)
		deferred
		end; -- blue

	green: INTEGER is
			-- Green saturation level
		require
			color_not_specified_by_name: (name = Void)
		deferred
		end; -- green

	is_white_by_default: BOOLEAN is
			-- Default color used in case of failure
			-- to allocate desire color
		deferred
		end; -- is_white_by_default

	name: STRING is
			-- name of desired color for current
		deferred
		end; -- name

	n_ame: STRING is obsolete "Use ``name''"
			-- name of desired color for current
		do
			Result := name
		end; -- n_ame

	red: INTEGER is
			-- Red saturation level
		require
			color_not_specified_by_name: (name = Void)
		deferred
		end; -- red

	set_black_default is
			-- Set black color to be used by default if
			-- it is impossible to allocate desire color.
		deferred
		ensure
			not is_white_by_default
		end; -- set_black_default

	set_blue (blue_value: INTEGER) is
			-- Set blue saturation level to `blue_value'.
		require
			blue_value_small_enough: blue_value  <= 65535;
			blue_value_not_negative: blue_value >= 0
		deferred
		ensure
			(name = Void);
			blue = blue_value
		end; -- set_blue

	set_green (green_value: INTEGER) is
			-- Set green saturation level to `green_value'.
		require
			green_value_small_enough: green_value  <= 65535;
			green_value_not_negative: green_value >= 0
		deferred
		ensure
			(name = Void);
			green = green_value
		end; -- set_green

	set_name (a_name: STRING) is
			-- Set color name to `a_name'.
		require
			a_name_not_void: not (a_name = Void)
		deferred
		ensure
			not (name = Void);
			name.is_equal (a_name)
		end; -- set_name

	set_red (red_value: INTEGER) is
			-- Set red saturation level to `red_value'.
		require
			red_value_small_enough: red_value  <= 65535;
			red_value_not_negative: red_value >= 0
		deferred
		ensure
			(name = Void);
			red = red_value
		end; -- set_red

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
		deferred
		ensure
			(name = Void);
			red = red_value;
			green = green_value;
			blue = blue_value
		end; -- set_rgb

	set_white_default is
			-- Set white color to be used by default if
			-- it is impossible to allocate desire color.
		deferred
		ensure
			is_white_by_default
		end -- set_white_default

end -- class COLOR_I


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
