note

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	COLOR_I 

feature -- Access

	allocated_blue: INTEGER
			-- Allocated blue saturation level for `a_widget'
		deferred
		end;

	allocated_green: INTEGER
			-- Allocated green saturation level for `a_widget'
		deferred
		end;

	allocated_red: INTEGER
			-- Allocated red saturation level for `a_widget'
		deferred
		end;

feature -- Status report

	blue: INTEGER
			-- Blue saturation level
		require
			color_not_specified_by_name: (name = Void)
		deferred
		end;

	green: INTEGER
			-- Green saturation level
		require
			color_not_specified_by_name: (name = Void)
		deferred
		end;

	is_white_by_default: BOOLEAN
			-- Default color used in case of failure
			-- to allocate desire color
		deferred
		end;

	name: STRING
			-- name of desired color for current
		deferred
		end;

	red: INTEGER
			-- Red saturation level
		require
			color_not_specified_by_name: (name = Void)
		deferred
		end;

feature -- Status setting

	set_blue (blue_value: INTEGER)
			-- Set blue saturation level to `blue_value'.
		require
			blue_value_small_enough: blue_value  <= 65535;
			blue_value_not_negative: blue_value >= 0
		deferred
		ensure
			no_name: (name = Void);
			blue_set: blue = blue_value
		end;

	set_green (green_value: INTEGER)
			-- Set green saturation level to `green_value'.
		require
			green_value_small_enough: green_value  <= 65535;
			green_value_not_negative: green_value >= 0
		deferred
		ensure
			no_name: (name = Void);
			green_set: green = green_value
		end;

	set_red (red_value: INTEGER)
			-- Set red saturation level to `red_value'.
		require
			red_value_small_enough: red_value  <= 65535;
			red_value_not_negative: red_value >= 0
		deferred
		ensure
			no_name: (name = Void);
			red_set: red = red_value
		end;

	set_name (a_name: STRING)
			-- Set color name to `a_name'.
		require
			a_name_not_void: a_name /= Void
		deferred
		ensure
			name_exists: name /= Void;
			name_set: name.is_equal (a_name)
		end;

	set_rgb (red_value, green_value, blue_value: INTEGER)
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

	set_black_default
			-- Set black color to be used by default if
			-- it is impossible to allocate desire color.
		deferred
		ensure
			black_default: not is_white_by_default
		end;

	set_white_default
			-- Set white color to be used by default if
			-- it is impossible to allocate desire color.
		deferred
		ensure
			white_default: is_white_by_default
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class COLOR_I

