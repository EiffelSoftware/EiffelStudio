indexing
	description:
		"Eiffel Vision color. Implementation interface.%N%
		%See ev_color.e"
	status: "See notice at end of class";
	keywords: "color, pixel, rgb, 8, 16, 24"
	date: "$Date$";
	revision: "$Revision$"

deferred class 
	EV_COLOR_I

inherit
	EV_ANY_I
		redefine
			interface
		end

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create zero intinsity color. 
		deferred
		ensure then
			default_name_assigned: name.is_equal (Default_name)
			red_zero: red = 0
			green_zero: green = 0
			blue_zero: blue = 0
		end

feature {EV_COLOR} -- Access

	red: REAL is
			-- Intensity of red component.
			-- Range: [0,1]
		deferred
		ensure
			within_range: Result >= 0 and Result <= 1
		end

	green: REAL is
			-- Intensity of green component.
			-- Range: [0,1]
		deferred
		ensure
			within_range: Result >= 0 and Result <= 1
		end

	blue: REAL is
			-- Intensity of blue component.
			-- Range: [0,1]
		deferred
		ensure
			within_range: Result >= 0 and Result <= 1
		end

	name: STRING is
			-- A textual description.
		deferred
		ensure
			not_void: Result /= Void
		end

feature {EV_COLOR} -- Element change

	set_red (a_red: REAL) is
			-- Assign `a_red' to `red'.
		require
			within_range: a_red >= 0 and a_red <= 1
		deferred
		ensure
			red_assigned: (red - a_red).abs <= delta
		end

	set_green (a_green: REAL) is
			-- Assign `a_green' to `green'.
		require
			within_range: a_green >= 0 and a_green <= 1
		deferred
		ensure
			green_assigned: (green - a_green).abs <= delta
		end

	set_blue (a_blue: REAL) is
			-- Assign `a_blue' to `blue'.
		require
			blue_within_range: a_blue >= 0 and a_blue <= 1
		deferred
		ensure
			blue_assigned: (blue - a_blue).abs <= delta
		end

	set_name (a_name: STRING) is
			-- Assign `a_name' to `name'.
		require
			name_not_void: a_name /= Void
		deferred
		ensure
			name_assigned: name /= Void and then name.is_equal (a_name)
		end

feature {EV_COLOR} -- Conversion

	rgb_24_bit: INTEGER is
			-- `red', `green' and `blue' intensities packed into 24 bits
			-- with 8 bits per colour and blue in the least significant 8 bits.
		deferred
		ensure
			within_range: Result >= 0 and result <= interface.Max_24_bit
		end

	set_rgb_with_24_bit (a_24_bit_rgb: INTEGER) is
			-- Set intensities from `a_24_bit_rgb' value
			-- with blue in the least significant 8 bits.
		require
			within_range: a_24_bit_rgb >= 0 and
				a_24_bit_rgb <= interface.Max_24_bit
		deferred
		ensure
			rgb_assigned: rgb_24_bit = a_24_bit_rgb
		end

	red_8_bit: INTEGER is
			-- Intensity of `red' component
			-- as an 8 bit unsigned integer.
			-- Range [0,255]
		deferred
		ensure
			within_range: Result >= 0 and Result <= interface.Max_8_bit
		end

	green_8_bit: INTEGER is
			-- Intensity of `green' component
			-- as an 8 bit unsigned integer.
			-- Range [0,255]
		deferred
		ensure
			within_range: Result >= 0 and Result <= interface.Max_8_bit
		end

	blue_8_bit: INTEGER is
			-- Intensity of `blue' component
			-- as an 8 bit unsigned integer.
			-- Range [0,255]
		deferred
		ensure
			within_range: Result >= 0 and Result <= interface.Max_8_bit
		end
	
	set_red_with_8_bit (an_8_bit_red: INTEGER) is
			-- Set `red' from `an_8_bit_red' intinsity.
		require
			within_range: an_8_bit_red >= 0 and
				an_8_bit_red <= interface.Max_8_bit
		deferred
		ensure
			red_assigned: red_8_bit = an_8_bit_red
		end
	
	set_green_with_8_bit (an_8_bit_green: INTEGER) is
			-- Set `green' from `an_8_bit_green' intinsity.
		require
			within_range: an_8_bit_green >= 0 and
				an_8_bit_green <= interface.Max_8_bit
		deferred
		ensure
			green_assigned: green_8_bit = an_8_bit_green
		end
	
	set_blue_with_8_bit (an_8_bit_blue: INTEGER) is
			-- Set `blue' from `an_8_bit_blue' intinsity.
		require
			within_range: an_8_bit_blue >= 0 and
				an_8_bit_blue <= interface.Max_8_bit
		deferred
		ensure
			blue_assigned: blue_8_bit = an_8_bit_blue
		end

	red_16_bit: INTEGER is
			-- Intensity of red component
			-- as a 16 bit unsigned integer.
			-- Range [0,65535]
		deferred
		ensure
			within_range: Result >= 0 and Result <= interface.Max_16_bit
		end

	green_16_bit: INTEGER is
			-- Intensity of green component
			-- as a 16 bit unsigned integer.
			-- Range [0,65535]
		deferred
		ensure
			within_range: Result >= 0 and Result <= interface.Max_16_bit
		end

	blue_16_bit: INTEGER is
			-- Intensity of blue component
			-- as a 16 bit unsigned integer.
			-- Range [0,65535]
		deferred
		ensure
			within_range: Result >= 0 and Result <= interface.Max_16_bit
		end

	set_red_with_16_bit (a_16_bit_red: INTEGER) is
			-- Set `red' from `a_8_bit_red' intinsity.
		require
			within_range: a_16_bit_red >= 0 and
				a_16_bit_red <= interface.Max_16_bit
		deferred
		ensure
			red_assigned: red_16_bit = a_16_bit_red
		end
	
	set_green_with_16_bit (a_16_bit_green: INTEGER) is
			-- Set `green' from `a_16_bit_green' intinsity.
		require
			within_range: a_16_bit_green >= 0 and
				a_16_bit_green <= interface.Max_16_bit
		deferred
		ensure
			green_assigned: green_16_bit = a_16_bit_green
		end
	
	set_blue_with_16_bit (a_16_bit_blue: INTEGER) is
			-- Set `blue' from `a_16_bit_blue' intinsity.
		require
			within_range: a_16_bit_blue >= 0 and
				a_16_bit_blue <= interface.Max_16_bit
		deferred
		ensure
			blue_assigned: blue_16_bit = a_16_bit_blue
		end

	set_with_other (other: EV_COLOR) is
			-- Take on the appearance of `other'.
		do
			set_red (other.red)
			set_green (other.green)
			set_blue (other.blue)
		end

feature --{EV_COLOR_I, EV_COLOR} -- Implementation

	Default_name: STRING is "noname"
			-- To be used as `name' when none is supplied.

	interface: EV_COLOR
			-- Interface of the current color.

	delta: REAL is
			-- Amount by which two intensities can differ but still be
			-- considered equal by `is_equal'.
		deferred
		end


invariant
	red_within_range: red >= 0 and red <= 1
	green_within_range: green >= 0 and green <= 1
	blue_within_range: blue >= 0 and blue <= 1
	red_8_bit_within_range: red_8_bit >= 0 and red_8_bit <= interface.Max_8_bit
	green_8_bit_within_range: green >= 0 and green_8_bit <= interface.Max_8_bit
	blue_8_bit_within_range:
		blue_8_bit >= 0 and blue_8_bit <= interface.Max_8_bit
	red_16_bit_within_range:
		red_16_bit >= 0 and red_16_bit <= interface.Max_16_bit
	green_16_bit_within_range:
		green_16_bit >= 0 and green_16_bit <= interface.Max_16_bit
	blue_16_bit_within_range:
		blue_16_bit >= 0 and blue_16_bit <= interface.Max_16_bit
	rgb_24_bit_within_range:
		rgb_24_bit >= 0 and rgb_24_bit <= interface.Max_24_bit
	red_16_bit_conversion: ((red * interface.Max_16_bit) - red_16_bit).abs <= delta * interface.Max_16_bit
	red_8_bit_conversion: ((red * interface.Max_8_bit) - red_8_bit).abs <= delta * interface.Max_8_bit
	green_16_bit_conversion: ((green * interface.Max_16_bit) - green_16_bit).abs <= delta * interface.Max_16_bit
	green_8_bit_conversion: ((green * interface.Max_8_bit) - green_8_bit).abs < delta * interface.Max_8_bit
	blue_16_bit_conversion: ((blue * interface.Max_16_bit) - blue_16_bit).abs < delta * interface.Max_16_bit
	blue_8_bit_conversion: ((blue * interface.Max_8_bit) - blue_8_bit).abs < delta * interface.Max_8_bit
	name_not_void: name /= Void

end -- class EV_COLOR_I

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.10  2001/06/07 23:08:08  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.5.4.2  2000/05/16 22:21:58  rogers
--| Added delta. Assertions and postconditions now ensure that colors are equal
--| to within delta.
--|
--| Revision 1.5.4.1  2000/05/03 19:08:56  oconnor
--| mergred from HEAD
--|
--| Revision 1.8  2000/05/02 18:26:13  oconnor
--| Optimised copy
--|
--| Revision 1.7  2000/02/22 18:39:40  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.6  2000/02/14 11:40:34  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.5.6.7  2000/02/04 04:15:55  oconnor
--| release
--|
--| Revision 1.5.6.6  2000/01/27 19:29:54  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.5.6.5  1999/12/17 18:51:35  rogers
--| changed set_*_*_bit to set_*_with_*_bit. Fixed postcondition on set_name.
--|
--| Revision 1.5.6.4  1999/12/15 04:46:49  oconnor
--| formatting
--|
--| Revision 1.5.6.3  1999/12/07 18:28:15  brendel
--| Commented out problematic invariant.
--|
--| Revision 1.5.6.2  1999/12/05 03:05:59  oconnor
--| fixed rounding error
--|
--| Revision 1.5.6.1  1999/11/24 17:30:04  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.5.2.6  1999/11/04 23:09:39  oconnor
--| fixed invariant
--|
--| Revision 1.5.2.5  1999/11/04 02:24:53  oconnor
--| more invariants
--|
--| Revision 1.5.2.4  1999/11/03 20:05:17  oconnor
--| added invariants, fixed types
--|
--| Revision 1.5.2.3  1999/11/03 18:15:43  oconnor
--| added conversion features
--|
--| Revision 1.5.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
