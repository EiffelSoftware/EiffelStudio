indexing
	description: "Description of a color"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	COLOR

inherit

	G_ANY

create

	make

feature {NONE} -- Initialization

	make is
			-- Create a color
		do
			create {COLOR_IMP} implementation.make (Current)
		end;

	make_for_screen (a_screen: SCREEN) is
			-- Create a color for `a_screen'.
		require
			valid_screen: a_screen /= Void and then a_screen.is_valid
		do
			create {COLOR_IMP} implementation.make_for_screen (Current, a_screen)
		end;

feature -- Access

	implementation: COLOR_I;
			-- Implementation of color

	blue_from_allocation: INTEGER is
			-- Allocated blue saturation level
		do
			Result := implementation.allocated_blue
		end;

	green_from_allocation: INTEGER is
			-- Allocated green saturation level
		do
			Result := implementation.allocated_green
		end;

	red_from_allocation: INTEGER is
			-- Allocated red saturation level
		do
			Result := implementation.allocated_red
		end;

feature -- Duplication

	duplicate: COLOR is
			-- An independent copy of the color
		do
			create Result.make;
			if (name = Void) then
				Result.set_rgb (red, green, blue);
			else
				Result.set_name (name.twin)
			end
		end;

feature -- Status report

	blue: INTEGER is
			-- Blue saturation level
		require
			color_not_specified_by_name: name = Void
		do
			Result := implementation.blue
		end;

	green: INTEGER is
			-- Green saturation level
		require
			color_not_specified_by_name: name = Void
		do
			Result := implementation.green
		end;

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

	red: INTEGER is
			-- Red saturation level
		require
			color_not_specified_by_name: name = Void
		do
			Result := implementation.red
		end;

feature -- Status setting

	set_blue (blue_value: INTEGER) is
			-- Set blue saturation level to `blue_value'.
		require
			blue_value_small_enough: blue_value <= 65535;
			blue_value_not_negative: blue_value >= 0
		do
			implementation.set_blue (blue_value)
		ensure
			no_name: name = Void;
			blue_set: blue = blue_value
		end;

	set_green (green_value: INTEGER) is
			-- Set green saturation level to `green_value'.
		require
			green_value_small_enough: green_value <= 65535;
			green_value_not_negative: green_value >= 0
		do
			implementation.set_green (green_value)
		ensure
			no_name: name = Void;
			green_set: green = green_value
		end;

	set_red (red_value: INTEGER) is
			-- Set red saturation level to `red_value'.
		require
			red_value_small_enough: red_value <= 65535;
			red_value_not_negative: red_value >= 0
		do
			implementation.set_red (red_value)
		ensure
			no_name: name = Void;
			red_set: red = red_value
		end;

	set_name (a_name: STRING) is
			-- Set color name to `a_name'.
		require
			a_name_not_void: a_name /= Void
		do
			implementation.set_name (a_name)
		ensure
			name_exists: name /= Void;
			name_set: name.is_equal (a_name)
		end;

	set_rgb (red_value, green_value, blue_value: INTEGER) is
			-- Set red, green and blue saturation level respectivly to
			-- `red_value', `green_value' and `blue_value'.
		require
			red_value_not_negative: red_value >= 0;
			green_value_not_negative: green_value >= 0;
			blue_value_not_negative: blue_value >= 0
		do
			implementation.set_rgb (red_value, green_value, blue_value)
		ensure
			no_name: name = Void;
			red_set: red = red_value;
			green_set: green = green_value;
			blue_set: blue = blue_value
		end;

	set_white_default is
			-- Set white color to be used by default if
			-- it is impossible to allocate desire color.
		do
			implementation.set_white_default
		ensure
			white_default: is_white_by_default
		end

	set_black_default is
			-- Set black color to be used by default if
			-- it is impossible to allocate desire color.
		do
			implementation.set_black_default
		ensure
			black_default: not is_white_by_default
		end;

feature -- Obsolete

	allocated_blue (a_widget: WIDGET): INTEGER is
			-- Allocated blue saturation level for `a_widget'
		obsolete
			"Use `blue_from_allocation' instead."
		require
			a_widget_exists: a_widget /= Void
		do
			Result := blue_from_allocation
		end;

	allocated_green (a_widget: WIDGET): INTEGER is
			-- Allocated green saturation level for `a_widget'
		obsolete
			"Use `green_from_allocation' instead."
		require
			a_widget_exists: a_widget /= Void
		do
			Result := green_from_allocation
		end;

	allocated_red (a_widget: WIDGET): INTEGER is
			-- Allocated red saturation level for `a_widget'
		obsolete
			"Use `red_from_allocation' instead."
		require
			a_widget_exists: a_widget /= Void
		do
			Result := red_from_allocation
		end;

invariant

	valid_implementation: implementation /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class COLOR

