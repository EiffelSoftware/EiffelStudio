indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	COLOR_I 

feature -- Access

	allocated_blue: INTEGER is
			-- Allocated blue saturation level for `a_widget'
		deferred
		end;

	allocated_green: INTEGER is
			-- Allocated green saturation level for `a_widget'
		deferred
		end;

	allocated_red: INTEGER is
			-- Allocated red saturation level for `a_widget'
		deferred
		end;

feature -- Status report

	blue: INTEGER is
			-- Blue saturation level
		require
			color_not_specified_by_name: (name = Void)
		deferred
		end;

	green: INTEGER is
			-- Green saturation level
		require
			color_not_specified_by_name: (name = Void)
		deferred
		end;

	is_white_by_default: BOOLEAN is
			-- Default color used in case of failure
			-- to allocate desire color
		deferred
		end;

	name: STRING is
			-- name of desired color for current
		deferred
		end;

	red: INTEGER is
			-- Red saturation level
		require
			color_not_specified_by_name: (name = Void)
		deferred
		end;

feature -- Status setting

	set_blue (blue_value: INTEGER) is
			-- Set blue saturation level to `blue_value'.
		require
			blue_value_small_enough: blue_value  <= 65535;
			blue_value_not_negative: blue_value >= 0
		deferred
		ensure
			no_name: (name = Void);
			blue_set: blue = blue_value
		end;

	set_green (green_value: INTEGER) is
			-- Set green saturation level to `green_value'.
		require
			green_value_small_enough: green_value  <= 65535;
			green_value_not_negative: green_value >= 0
		deferred
		ensure
			no_name: (name = Void);
			green_set: green = green_value
		end;

	set_red (red_value: INTEGER) is
			-- Set red saturation level to `red_value'.
		require
			red_value_small_enough: red_value  <= 65535;
			red_value_not_negative: red_value >= 0
		deferred
		ensure
			no_name: (name = Void);
			red_set: red = red_value
		end;

	set_name (a_name: STRING) is
			-- Set color name to `a_name'.
		require
			a_name_not_void: a_name /= Void
		deferred
		ensure
			name_exists: name /= Void;
			name_set: name.is_equal (a_name)
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
		deferred
		ensure
			no_name: (name = Void);
			red_set: red = red_value;
			green_set: green = green_value;
			blue_set: blue = blue_value
		end;

	set_black_default is
			-- Set black color to be used by default if
			-- it is impossible to allocate desire color.
		deferred
		ensure
			black_default: not is_white_by_default
		end;

	set_white_default is
			-- Set white color to be used by default if
			-- it is impossible to allocate desire color.
		deferred
		ensure
			white_default: is_white_by_default
		end

end -- class COLOR_I



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

