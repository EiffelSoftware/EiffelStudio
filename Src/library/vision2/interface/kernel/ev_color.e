indexing
	description:
		"Color modeled as red, green, blue and alpha intensities%
		%each with range [0,1]."
	keywords: "color, pixel, rgb, 8, 16, 24"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

--|FIXME propogate alpha features into _I.

class 
	EV_COLOR

inherit
	EV_ANY
		redefine
			implementation,
			is_equal,
			copy
		end

create
	default_create,
	make_with_rgb

feature -- Initialization

	make_with_rgb (a_red, a_green, a_blue: REAL) is
			-- Create with `a_red', `a_green', `a_blue', and default name.
		require
			a_red_within_range: a_red >= 0 and then a_red <= 1
			a_green_within_range: a_green >= 0 and then a_green <= 1
			a_blue_within_range: a_blue >= 0 and then a_blue <= 1
		do
			default_create
			set_red (a_red)
			set_green (a_green)
			set_blue (a_blue)
		ensure
			red_assigned: red = a_red
			green_assigned: green = a_green
			blue_assigned: blue = a_blue
		end

feature -- Access

	red: REAL is
			-- Intensity of red component. Range: [0,1]
		do
			Result := implementation.red
		ensure
			bridge_ok: Result = implementation.red
		end

	green: REAL is
			-- Intensity of green component. Range: [0,1]
		do
			Result := implementation.green
		ensure
			bridge_ok: Result = implementation.green
		end

	blue: REAL is
			-- Intensity of blue component. Range: [0,1]
		do
			Result := implementation.blue
		ensure
			bridge_ok: Result = implementation.blue
		end

	alpha: REAL is
			-- Intensity of alpha component. Range [0,1]
			-- 0 is opauqe, 1 is transparent.
		do
--|FIXME Not yet implemented.	
--|			Result := implementation.alpha
--|		ensure
--|			bridge_ok: Result = implementation.alpha
		end

	name: STRING is
			-- A textual description.
		do
			Result := implementation.name
		ensure
			bridge_ok: Result.is_equal (implementation.name)
		end

feature -- Element change

	set_rgb (a_red, a_green, a_blue: REAL) is
			-- Assign `a_red', `a_green' and `a_blue'
			-- to `red', `green' and `blue' respectively.
		require
			red_within_range: a_red >= 0 and then a_red <= 1
			green_within_range: a_green >= 0 and then a_green <= 1
			blue_within_range: a_blue >= 0 and then a_blue <= 1
		do
			set_red (a_red)
			set_green (a_green)
			set_blue (a_blue)
		ensure
			red_assigned: red = a_red
			green_assigned: green = a_green
			blue_assigned: blue = a_blue
		end

	set_red (a_red: REAL) is
			-- Assign `a_red' to `red'.
		require
			within_range: a_red >= 0 and then a_red <= 1
		do
			implementation.set_red (a_red)
		ensure
			red_assigned: red = a_red
		end

	set_green (a_green: REAL) is
			-- Assign `a_green' to `green'.
		require
			within_range: a_green >= 0 and then a_green <= 1
		do
			implementation.set_green (a_green)
		ensure
			green_assigned: green = a_green
		end

	set_blue (a_blue: REAL) is
			-- Assign `a_blue' to `blue'.
		require
			blue_within_range: a_blue >= 0 and then a_blue <= 1
		do
			implementation.set_blue (a_blue)
		ensure
			blue_assigned: blue = a_blue
		end

	set_alpha (an_alpha: REAL) is
			-- Assign `an_alpha' to `alpha'.
--|FIXME not yet implemented
--|		require
--|			alpha_within_range: an_alpha >= 0 and then an_alpha <= 1
		do
--|			implementation.set_alpha (an_alpha)
--|		ensure
--|			blue_assigned: alpha = an_alpha
			check
				not_implemented: false
			end
		end

	set_name (a_name: STRING) is
			-- Assign `a_name' to `name'.
		require
			name_not_void: a_name /= Void
		do
			implementation.set_name (a_name)
		ensure
			name_assigned: name.is_equal (a_name)
		end

feature -- Conversion

	rgb_24_bit: INTEGER is
			-- `red', `green' and `blue' intensities packed into 24 bits
			-- with 8 bits per colour and blue in the least significant 8 bits.
		do
			Result := implementation.rgb_24_bit
		ensure
			bridge_ok: Result = implementation.rgb_24_bit
		end

	rgba_32_bit: INTEGER is
			-- `red', `green', `blue' and `alpha' intensities packed into 32
			-- bits with 8 bits per colour and alpha in the least significant
			-- 8 bits.
--| FIXME not implemented.
		do
			check
				not_implemented: false
			end
--|		ensure
--|			bridge_ok: Result = implementation.rgba_32_bit
		end

	set_rgb_with_24_bit (a_24_bit_rgb: INTEGER) is
			-- Set intensities from `a_24_bit_rgb' value
			-- with blue in the least significant 8 bits.
		require
			within_range: a_24_bit_rgb >= 0 and a_24_bit_rgb <= Max_24_bit
		do
			implementation.set_rgb_with_24_bit (a_24_bit_rgb)
		ensure
			rgb_assigned: rgb_24_bit = a_24_bit_rgb
		end

	set_rgba_with_32_bit (a_32_bit_rgba: INTEGER) is
			-- Set intensities from `a_32_bit_rgba' value
			-- with alpha in the least significant 8 bits.
--| FIXME Not implemented
--|		require
--|			within_range: a_32_bit_rgba >= 0 and a_32_bit_rgba <= Max_32_bit
		do
			check
				not_implemented: false
			end
--|			implementation.set_rgb_with_24_bit (a_24_bit_rgb)
--|		ensure
--|			rgba_assigned: rgba_32_bit = a_32_bit_rgba
		end

	set_rgb_with_8_bit (an_8_bit_red, an_8_bit_green, an_8_bit_blue: INTEGER) is
			-- Set intensities  from `an_8_bit_red', `an_8_bit_green', and
			-- `an_8_bit_blue' intensity. (8 bits per channel.)
		require
			red_within_range: an_8_bit_red >= 0 and an_8_bit_red <= Max_8_bit
			green_within_range: an_8_bit_green >= 0 and
				 an_8_bit_green <= Max_8_bit
			blue_within_range: an_8_bit_blue >= 0 and an_8_bit_blue <= Max_8_bit
		do
			set_red_with_8_bit (an_8_bit_red)
			set_green_with_8_bit (an_8_bit_green)
			set_blue_with_8_bit (an_8_bit_green)
		ensure
			red_assigned: red_8_bit = an_8_bit_red
			green_assigned: green_8_bit = an_8_bit_green
			blue_assigned: blue_8_bit = an_8_bit_blue
		end

	set_rgba_with_8_bit (an_8_bit_red, an_8_bit_green, an_8_bit_blue,
		an_8_bit_alpha: INTEGER) is
			-- Set intensities  from `an_8_bit_red', `an_8_bit_green',
			-- `an_8_bit_blue' and `an_8_bit_alpha' intensity.
			-- (8 bits per channel.)
		require
			red_within_range: an_8_bit_red >= 0 and an_8_bit_red <= Max_8_bit
			green_within_range: an_8_bit_green >= 0 and
				an_8_bit_green <= Max_8_bit
			blue_within_range: an_8_bit_blue >= 0 and an_8_bit_blue <= Max_8_bit
			alpha_within_range: an_8_bit_alpha >= 0 and
				an_8_bit_alpha <= Max_8_bit
		do
			set_red_with_8_bit (an_8_bit_red)
			set_green_with_8_bit (an_8_bit_green)
			set_blue_with_8_bit (an_8_bit_green)
			set_alpha_with_8_bit (an_8_bit_alpha)
		ensure
			red_assigned: red_8_bit = an_8_bit_red
			green_assigned: green_8_bit = an_8_bit_green
			blue_assigned: blue_8_bit = an_8_bit_blue
			alpha_assigned: alpha_8_bit = an_8_bit_alpha
		end

	red_8_bit: INTEGER is
			-- Intensity of `red' component as an 8 bit unsigned integer.
			-- Range [0,255]
		do
			Result := implementation.red_8_bit
		ensure
			bridge_ok: Result = implementation.red_8_bit
		end

	green_8_bit: INTEGER is
			-- Intensity of `green' component as an 8 bit unsigned integer.
			-- Range [0,255]
		do
			Result := implementation.green_8_bit
		ensure
			bridge_ok: Result = implementation.green_8_bit
		end

	blue_8_bit: INTEGER is
			-- Intensity of `blue' component as an 8 bit unsigned integer.
			-- Range [0,255]
		do
			Result := implementation.blue_8_bit
		ensure
			bridge_ok: Result = implementation.blue_8_bit
		end

	alpha_8_bit: INTEGER is
			-- Intensity of `alpha' component as an 8 bit unsigned integer.
			-- Range [0,255]
		do
			check
				not_implemented: false
			end
--| FIXME not implemented
--|			Result := implementation.alpha_8_bit
--|		ensure
--|			bridge_ok: Result = implementation.alpha_8_bit
		end
	
	set_red_with_8_bit (an_8_bit_red: INTEGER) is
			-- Set `red' from `an_8_bit_red' intinsity.
		require
			within_range:
				an_8_bit_red >= 0 and then an_8_bit_red <= Max_8_bit
		do
			implementation.set_red_with_8_bit (an_8_bit_red)
		ensure
			red_assigned: red_8_bit = an_8_bit_red
		end
	
	set_green_with_8_bit (an_8_bit_green: INTEGER) is
			-- Set `green' from `an_8_bit_green' intinsity.
		require
			within_range:
				an_8_bit_green >= 0 and then an_8_bit_green <= Max_8_bit
		do
			implementation.set_green_with_8_bit (an_8_bit_green)
		ensure
			green_assigned: green_8_bit = an_8_bit_green
		end
	
	set_blue_with_8_bit (an_8_bit_blue: INTEGER) is
			-- Set `blue' from `an_8_bit_blue' intinsity.
		require
			within_range:
				an_8_bit_blue >= 0 and then an_8_bit_blue <= Max_8_bit
		do
			implementation.set_blue_with_8_bit (an_8_bit_blue)
		ensure
			blue_assigned: blue_8_bit = an_8_bit_blue
		end
	
	set_alpha_with_8_bit (an_8_bit_alpha: INTEGER) is
			-- Set `alpha' from `an_8_bit_alpha' intinsity.
		require
			within_range:
				an_8_bit_alpha >= 0 and then an_8_bit_alpha <= Max_8_bit
		do
			check
				not_implemented: false
			end
--| FIXME not implemented
--|			implementation.set_alpha_with_8_bit (an_8_bit_alpha)
--|		ensure
--|			blue_assigned: alpha_8_bit = an_8_bit_alpha
		end

	set_rgb_with_16_bit (a_16_bit_red, a_16_bit_green, a_16_bit_blue: INTEGER)
		is
			-- Set intensities  from `a_16_bit_red', `a_16_bit_green', and
			-- `a_16_bit_blue' intensity. (16 bits per channel.)
		require
			red_within_range: a_16_bit_red >= 0 and a_16_bit_red <= Max_16_bit
			green_within_range: a_16_bit_green >= 0 and
				a_16_bit_green <= Max_16_bit
			blue_within_range: a_16_bit_blue >= 0 and
				a_16_bit_blue <= Max_16_bit
		do
			set_red_with_16_bit (a_16_bit_red)
			set_green_with_16_bit (a_16_bit_green)
			set_blue_with_16_bit (a_16_bit_blue)
		ensure
			red_assigned: red_16_bit = a_16_bit_red
			green_assigned: green_16_bit = a_16_bit_green
			blue_assigned: blue_16_bit = a_16_bit_blue
		end

	set_rgba_with_16_bit (a_16_bit_red, a_16_bit_green, a_16_bit_blue,
		a_16_bit_alpha: INTEGER) is
			-- Set intensities  from `a_16_bit_red', `a_16_bit_green',
			-- `a_16_bit_blue' and `a_16_bit_alpha' intensity.
			-- (16 bits per channel.)
		require
			red_within_range: a_16_bit_red >= 0 and a_16_bit_red <= Max_16_bit
			green_within_range: a_16_bit_green >= 0 and
				a_16_bit_green <= Max_16_bit
			blue_within_range: a_16_bit_blue >= 0 and
				a_16_bit_blue <= Max_16_bit
			alpha_within_range: a_16_bit_alpha >= 0 and
				a_16_bit_alpha <= Max_16_bit
		do
			set_red_with_16_bit (a_16_bit_red)
			set_green_with_16_bit (a_16_bit_green)
			set_blue_with_16_bit (a_16_bit_green)
			set_alpha_with_16_bit (a_16_bit_alpha)
		ensure
			red_assigned: red_16_bit = a_16_bit_red
			green_assigned: green_16_bit = a_16_bit_green
			blue_assigned: blue_16_bit = a_16_bit_blue
			alpha_assigned: alpha_16_bit = a_16_bit_alpha
		end

	red_16_bit: INTEGER is
			-- Intensity of red component as an 16 bit unsigned integer.
			-- Range [0,65535]
		do
			Result := implementation.red_16_bit
		ensure
			bridge_ok: Result = implementation.red_16_bit
		end

	green_16_bit: INTEGER is
			-- Intensity of green component as an 16 bit unsigned integer.
			-- Range [0,65535]
		do
			Result := implementation.green_16_bit
		ensure
			bridge_ok: Result = implementation.green_16_bit
		end

	blue_16_bit: INTEGER is
			-- Intensity of blue component as an 16 bit unsigned integer.
			-- Range [0,65535]
		do
			Result := implementation.blue_16_bit
		ensure
			bridge_ok: Result = implementation.blue_16_bit
		end

	alpha_16_bit: INTEGER is
			-- Intensity of `alpha' component as an 16 bit unsigned integer.
			-- Range [0,65535]
		do
			check
				not_implemented: false
			end
--| FIXME not implemented
--|			Result := implementation.alpha_16_bit
--|		ensure
--|			bridge_ok: Result = implementation.alpha_16_bit
		end

	set_red_with_16_bit (a_16_bit_red: INTEGER) is
			-- Set `red' from `a_8_bit_red' intinsity.
		require
			within_range:
				a_16_bit_red >= 0 and then a_16_bit_red <= Max_16_bit
		do
			implementation.set_red_with_16_bit (a_16_bit_red)
		ensure
			red_assigned: red_16_bit = a_16_bit_red
		end
	
	set_green_with_16_bit (a_16_bit_green: INTEGER) is
			-- Set `green' from `a_16_bit_green' intinsity.
		require
			within_range:
				a_16_bit_green >= 0 and then a_16_bit_green <= Max_16_bit
		do
			implementation.set_green_with_16_bit (a_16_bit_green)
		ensure
			green_assigned: green_16_bit = a_16_bit_green
		end
	
	set_blue_with_16_bit (a_16_bit_blue: INTEGER) is
			-- Set `blue' from `a_16_bit_blue' intinsity.
		require
			within_range:
				a_16_bit_blue >= 0 and then a_16_bit_blue <= Max_16_bit
		do
			implementation.set_blue_with_16_bit (a_16_bit_blue)
		ensure
			blue_assigned: blue_16_bit = a_16_bit_blue
		end
	
	set_alpha_with_16_bit (a_16_bit_alpha: INTEGER) is
			-- Set `alpha' from `a_16_bit_alpha' intinsity.
		require
			within_range:
				a_16_bit_alpha >= 0 and then a_16_bit_alpha <= Max_16_bit
		do
			check
				not_implemented: false
			end
--| FIXME not implemented
--|			implementation.set_alpha_with_16_bit (a_16_bit_alpha)
--|		ensure
--|			blue_assigned: alpha_16_bit = a_16_bit_alpha
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Does `Current' look the same color as `other'?
		do
			Result := (other.red - red).abs < delta and then
				(other.green - green).abs < delta and then
				(other.blue - blue).abs < delta and then
				(other.alpha - alpha).abs < delta
		end

	copy (other: like Current) is
			-- Update `Current' by setting attributes from `other'.
		do
			set_red (other.red)
			set_green (other.green)
			set_blue (other.blue)
			set_alpha (other.alpha)
		end

feature -- Constants

	Max_8_bit: INTEGER is 255
			-- Maximum value for 8 bit unsigned integers.

	Max_16_bit: INTEGER is 65535
			-- Maximum value for 16 bit unsigned integers.

	Max_24_bit: INTEGER is 16777215
			-- Maximum value for 24 bit unsigned integers.

	Max_32_bit: INTEGER is 4294967295
			-- Maximum value for 32 bit unsigned integers.

feature {EV_ANY_I, EV_DEFAULT_COLORS_IMP} -- Implementation

	implementation: EV_COLOR_I
			-- Responsible for interaction with the native graphics toolkit.

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_COLOR_IMP} implementation.make (Current)
		end

	delta: REAL is 0.05
			-- Amount by which two intensities can differ but still be
			-- considered equal by `is_equal'.

invariant
--|FIXME uncomment alpha invariants
	red_within_range: red >= 0 and red <= 1
	green_within_range: green >= 0 and green <= 1
	blue_within_range: blue >= 0 and blue <= 1
	alpha_within_range: alpha >= 0 and alpha <= 1
	red_8_bit_within_range: red_8_bit >= 0 and red_8_bit <= Max_8_bit
	green_8_bit_within_range: green_8_bit >= 0 and green_8_bit <= Max_8_bit
	blue_8_bit_within_range: blue_8_bit >= 0 and blue_8_bit <= Max_8_bit
--| alpha_8_bit_within_range: alpha_8_bit >= 0 and alpha_8_bit <= Max_8_bit
	red_16_bit_within_range: red_16_bit >= 0 and red_16_bit <= Max_16_bit
	green_16_bit_within_range: green_16_bit >= 0 and green_16_bit <= Max_16_bit
	blue_16_bit_within_range: blue_16_bit >= 0 and blue_16_bit <= Max_16_bit
--|	alpha_16_bit_within_range: alpha_16_bit >= 0 and alpha_16_bit <= Max_16_bit
	rgb_24_bit_within_range: rgb_24_bit >= 0 and rgb_24_bit <= Max_24_bit
	rgba_32_bit_within_range: rgba_32_bit >= 0 and rgba_32_bit <= Max_32_bit
	red_16_bit_conversion: (red * Max_16_bit).rounded = red_16_bit
	red_8_bit_conversion: (red * Max_8_bit).rounded = red_8_bit
	green_16_bit_conversion: (green * Max_16_bit).rounded = green_16_bit
	green_8_bit_conversion: (green * Max_8_bit).rounded = green_8_bit
	blue_16_bit_conversion: (blue * Max_16_bit).rounded = blue_16_bit
	blue_8_bit_conversion: (blue * Max_8_bit).rounded = blue_8_bit
--|	alpha_16_bit_conversions_consistent: (alpha * 65535).rounded = alpha_16_bit
--|	alpha_8_bit_conversions_consistent: (alpha * 255).rounded = alpha_8_bit
	name_not_void: name /= Void

end -- class EV_COLOR

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
--| Revision 1.12  2000/03/16 01:12:10  oconnor
--| Added alpha chanel features.
--|
--| Revision 1.11  2000/02/22 18:39:48  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.10  2000/02/14 11:40:47  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.9.4.13  2000/02/04 05:38:17  oconnor
--| removed not default_create_called precondition
--|
--| Revision 1.9.4.12  2000/02/04 03:14:08  oconnor
--| formatting
--|
--| Revision 1.9.4.11  2000/01/28 20:02:20  oconnor
--| released
--|
--| Revision 1.9.4.10  2000/01/27 19:30:42  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.9.4.9  2000/01/21 20:07:51  brendel
--| Added feature `copy'.
--| Increased value of `delta'.
--|
--| Revision 1.9.4.8  1999/12/17 21:02:17  rogers
--| set_*_*_bit has been changed to set_*_with_*_bit.
--|
--| Revision 1.9.4.7  1999/12/15 04:36:14  oconnor
--| formatting
--|
--| Revision 1.9.4.6  1999/12/10 00:25:14  brendel
--| Checked spelling.
--| Added `then' whenever `and' was encountered.
--|
--| Revision 1.9.4.5  1999/12/07 17:54:06  brendel
--| Commented out invariant about 8-bit-color consistent conversion.
--|
--| Revision 1.9.4.4  1999/12/05 03:06:00  oconnor
--| fixed rounding error
--|
--| Revision 1.9.4.3  1999/12/03 02:33:00  brendel
--| Changed `make_rgb' to `make_with_rgb'.r
--|
--| Revision 1.9.4.2  1999/11/30 22:41:43  oconnor
--| oops, fixed: set_blue_16_bit (a_16_bit_green)
--|
--| Revision 1.9.4.1  1999/11/24 17:30:44  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.8.2.7  1999/11/04 02:25:42  oconnor
--| added set_rgb_16_bit and conversion checking invariants
--|
--| Revision 1.8.2.6  1999/11/03 20:04:50  oconnor
--| added invariants
--|
--| Revision 1.8.2.5  1999/11/03 18:38:27  oconnor
--| fixed broken types
--|
--| Revision 1.8.2.4  1999/11/03 18:00:16  oconnor
--| added conversion features
--|
--| Revision 1.8.2.3  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
