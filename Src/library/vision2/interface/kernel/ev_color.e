indexing
	description:
		"Color modeled as red, green, blue intensities%
		%each with range [0,1]."
	keywords: "color, pixel, rgb, 8, 16, 24"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_COLOR

inherit
	EV_ANY
		redefine
			implementation,
			is_equal,
			copy,
			out
		end

	DOUBLE_MATH
		undefine
			default_create,
			is_equal,
			copy,
			out
		end

create
	default_create,
	make_with_8_bit_rgb,
	make_with_rgb

feature {NONE} -- Initialization

	make_with_8_bit_rgb
		(an_8_bit_red, an_8_bit_green, an_8_bit_blue: INTEGER) is
			-- Create with `a_red', `a_green', `a_blue', and default name.
		require
			red_within_range: an_8_bit_red >= 0 and an_8_bit_red <= Max_8_bit
			green_within_range: an_8_bit_green >= 0 and
				 an_8_bit_green <= Max_8_bit
			blue_within_range: an_8_bit_blue >= 0 and
				an_8_bit_blue <= Max_8_bit
		do
			default_create
			set_red_with_8_bit (an_8_bit_red)
			set_green_with_8_bit (an_8_bit_green)
			set_blue_with_8_bit (an_8_bit_blue)
		ensure
			red_assigned: red_8_bit = an_8_bit_red
			green_assigned: green_8_bit = an_8_bit_green
			blue_assigned: blue_8_bit = an_8_bit_blue
		end

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
			red_assigned: (red - a_red).abs <= delta
			green_assigned: (green - a_green).abs <= delta
			blue_assigned: (blue - a_blue).abs <= delta
		end

feature -- Access

	red: REAL is
			-- Intensity of red component. Range: [0,1]
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.red
		ensure
			bridge_ok: Result = implementation.red
		end

	green: REAL is
			-- Intensity of green component. Range: [0,1]
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.green
		ensure
			bridge_ok: Result = implementation.green
		end

	blue: REAL is
			-- Intensity of blue component. Range: [0,1]
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.blue
		ensure
			bridge_ok: Result = implementation.blue
		end

	lightness: REAL is
			-- Lightness of the color
		require
			not_destroyed: not is_destroyed
		local
			max_color	: REAL
			min_color	: REAL
			R,G,B		: REAL
		do
			R := red
			G := green
			B := blue
			max_color := red.max(green).max(blue)
			min_color := red.min(green).min(blue)
			Result := (max_color + min_color) / 2
		end

	saturation: REAL is
			-- Saturation of the color
		require
			not_destroyed: not is_destroyed
		local
			diff_color	: REAL
			sum_color	: REAL
			max_color	: REAL
			min_color	: REAL
			R,G,B		: REAL
		do
			R := red
			G := green
			B := blue
			max_color := R.max(G).max(B)
			min_color := R.min(G).min(B)
			diff_color := max_color - min_color
			if diff_color = 0.0 then
				Result := 0.0
			else
				sum_color := max_color + min_color
				if sum_color < 1 then
					Result := diff_color / sum_color
				else
					Result := diff_color / (2.0 - sum_color)	
				end
			end
		end

	hue: REAL is
			-- Hue of the color
		require
			not_destroyed: not is_destroyed
		local
			diff_color	: REAL
			max_color	: REAL
			min_color	: REAL
			R,G,B		: REAL
		do
			R := red
			G := green
			B := blue
			max_color := R.max(G).max(B)
			min_color := R.min(G).min(B)
			diff_color := max_color - min_color
			if diff_color = 0.0 then
				Result := 0.0
			else
				if max_color = R then
					Result := (G - B) / diff_color
				elseif max_color = G then
					Result := 2.0 + ((B - R) / diff_color)
				elseif max_color = B then
					Result := 4.0 + ((R - G) / diff_color)
				end
			end
		end

feature -- Element change

	set_rgb (a_red, a_green, a_blue: REAL) is
			-- Assign `a_red', `a_green' and `a_blue'
			-- to `red', `green' and `blue' respectively.
		require
			not_destroyed: not is_destroyed
			red_within_range: a_red >= 0 and then a_red <= 1
			green_within_range: a_green >= 0 and then a_green <= 1
			blue_within_range: a_blue >= 0 and then a_blue <= 1
		do
			set_red (a_red)
			set_green (a_green)
			set_blue (a_blue)
		ensure
			red_assigned: (red - a_red).abs <= delta
			green_assigned: (green - a_green).abs <= delta
			blue_assigned: (blue - a_blue).abs <= delta
		end

	set_red (a_red: REAL) is
			-- Assign `a_red' to `red'.
		require
			not_destroyed: not is_destroyed
			within_range: a_red >= 0 and then a_red <= 1
		do
			implementation.set_red (a_red)
		ensure
			red_assigned: (red - a_red).abs <= delta
		end

	set_green (a_green: REAL) is
			-- Assign `a_green' to `green'.
		require
			not_destroyed: not is_destroyed
			within_range: a_green >= 0 and then a_green <= 1
		do
			implementation.set_green (a_green)
		ensure
			green_assigned: (green - a_green).abs <= delta
		end

	set_blue (a_blue: REAL) is
			-- Assign `a_blue' to `blue'.
		require
			not_destroyed: not is_destroyed
			blue_within_range: a_blue >= 0 and then a_blue <= 1
		do
			implementation.set_blue (a_blue)
		ensure
			blue_assigned: (blue - a_blue).abs <= delta
		end

feature -- Conversion

	rgb_24_bit: INTEGER is
			-- `red', `green' and `blue' intensities packed into 24 bits
			-- with 8 bits per colour and blue in the least significant 8 bits.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.rgb_24_bit
		ensure
			bridge_ok: Result = implementation.rgb_24_bit
		end

	set_rgb_with_24_bit (a_24_bit_rgb: INTEGER) is
			-- Set intensities from `a_24_bit_rgb' value
			-- with blue in the least significant 8 bits.
		require
			not_destroyed: not is_destroyed
			within_range: a_24_bit_rgb >= 0 and a_24_bit_rgb <= Max_24_bit
		do
			implementation.set_rgb_with_24_bit (a_24_bit_rgb)
		ensure
			rgb_assigned: rgb_24_bit = a_24_bit_rgb
		end

	set_rgb_with_8_bit (an_8_bit_red, an_8_bit_green, an_8_bit_blue: INTEGER) is
			-- Set intensities  from `an_8_bit_red', `an_8_bit_green', and
			-- `an_8_bit_blue' intensity. (8 bits per channel.)
		require
			not_destroyed: not is_destroyed
			red_within_range: an_8_bit_red >= 0 and an_8_bit_red <= Max_8_bit
			green_within_range: an_8_bit_green >= 0 and
				 an_8_bit_green <= Max_8_bit
			blue_within_range: an_8_bit_blue >= 0 and an_8_bit_blue <= Max_8_bit
		do
			set_red_with_8_bit (an_8_bit_red)
			set_green_with_8_bit (an_8_bit_green)
			set_blue_with_8_bit (an_8_bit_blue)
		ensure
			red_assigned: red_8_bit = an_8_bit_red
			green_assigned: green_8_bit = an_8_bit_green
			blue_assigned: blue_8_bit = an_8_bit_blue
		end

	red_8_bit: INTEGER is
			-- Intensity of `red' component as an 8 bit unsigned integer.
			-- Range [0,255]
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.red_8_bit
		ensure
			bridge_ok: Result = implementation.red_8_bit
		end

	green_8_bit: INTEGER is
			-- Intensity of `green' component as an 8 bit unsigned integer.
			-- Range [0,255]
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.green_8_bit
		ensure
			bridge_ok: Result = implementation.green_8_bit
		end

	blue_8_bit: INTEGER is
			-- Intensity of `blue' component as an 8 bit unsigned integer.
			-- Range [0,255]
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.blue_8_bit
		ensure
			bridge_ok: Result = implementation.blue_8_bit
		end
	
	set_red_with_8_bit (an_8_bit_red: INTEGER) is
			-- Set `red' from `an_8_bit_red' intinsity.
		require
			not_destroyed: not is_destroyed
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
			not_destroyed: not is_destroyed
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
			not_destroyed: not is_destroyed
			within_range:
				an_8_bit_blue >= 0 and then an_8_bit_blue <= Max_8_bit
		do
			implementation.set_blue_with_8_bit (an_8_bit_blue)
		ensure
			blue_assigned: blue_8_bit = an_8_bit_blue
		end
	
	set_rgb_with_16_bit (a_16_bit_red, a_16_bit_green, a_16_bit_blue: INTEGER)
		is
			-- Set intensities  from `a_16_bit_red', `a_16_bit_green', and
			-- `a_16_bit_blue' intensity. (16 bits per channel.)
		require
			not_destroyed: not is_destroyed
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

	red_16_bit: INTEGER is
			-- Intensity of red component as an 16 bit unsigned integer.
			-- Range [0,65535]
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.red_16_bit
		ensure
			bridge_ok: Result = implementation.red_16_bit
		end

	green_16_bit: INTEGER is
			-- Intensity of green component as an 16 bit unsigned integer.
			-- Range [0,65535]
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.green_16_bit
		ensure
			bridge_ok: Result = implementation.green_16_bit
		end

	blue_16_bit: INTEGER is
			-- Intensity of blue component as an 16 bit unsigned integer.
			-- Range [0,65535]
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.blue_16_bit
		ensure
			bridge_ok: Result = implementation.blue_16_bit
		end

	set_red_with_16_bit (a_16_bit_red: INTEGER) is
			-- Set `red' from `a_8_bit_red' intinsity.
		require
			not_destroyed: not is_destroyed
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
			not_destroyed: not is_destroyed
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
			not_destroyed: not is_destroyed
			within_range:
				a_16_bit_blue >= 0 and then a_16_bit_blue <= Max_16_bit
		do
			implementation.set_blue_with_16_bit (a_16_bit_blue)
		ensure
			blue_assigned: blue_16_bit = a_16_bit_blue
		end
	
feature -- Output

	out: STRING is
			-- Textual representation.
		local
			f: FORMAT_DOUBLE
		do
			create f.make (6, 4)
			Result :=
				f.formatted (red) + " " +
				f.formatted (green) + " " +
				f.formatted (blue)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Does `Current' look the same color as `other'?
		do
			Result := (other.red - red).abs < delta and then
				(other.green - green).abs < delta and then
				(other.blue - blue).abs < delta
		end

	copy (other: like Current) is
			-- Update `Current' by setting attributes from `other'.
		do
			if implementation = Void then
				default_create
			end
			implementation.set_with_other (other)
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
			--| FIXME INTEGER is signed!
		
feature {NONE} -- Contract support

	delta: REAL is
			-- Amount by which two intensities can differ but still be
			-- considered equal by `is_equal'.
		do
			Result := implementation.delta
		end

feature {EV_ANY_I, EV_STOCK_COLORS_IMP} -- Implementation

	implementation: EV_COLOR_I
			-- Responsible for interaction with the native graphics toolkit.
			
feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_COLOR_IMP} implementation.make (Current)
		end
	
feature -- Obsolete

	name: STRING is
			-- A textual description.
		obsolete
			"use out"
		do
			Result := out
		end
		
	set_name (a_name: STRING) is
			-- Assign `a_name' to `name'.
		obsolete
			"if you still need this mail vision2@eiffel.com"
		require
			name_not_void: a_name /= Void
		do
			implementation.set_name (a_name)
		ensure
			name_assigned: name.is_equal (a_name)
		end

invariant
	red_within_range: red >= 0 and red <= 1
	green_within_range: green >= 0 and green <= 1
	blue_within_range: blue >= 0 and blue <= 1
	red_8_bit_within_range: red_8_bit >= 0 and red_8_bit <= Max_8_bit
	green_8_bit_within_range: green_8_bit >= 0 and green_8_bit <= Max_8_bit
	blue_8_bit_within_range: blue_8_bit >= 0 and blue_8_bit <= Max_8_bit
	red_16_bit_within_range: red_16_bit >= 0 and red_16_bit <= Max_16_bit
	green_16_bit_within_range: green_16_bit >= 0 and green_16_bit <= Max_16_bit
	blue_16_bit_within_range: blue_16_bit >= 0 and blue_16_bit <= Max_16_bit
	rgb_24_bit_within_range: rgb_24_bit >= 0 and rgb_24_bit <= Max_24_bit
	red_16_bit_conversion: ((red * Max_16_bit) - red_16_bit).abs <=
		delta * Max_16_bit
	red_8_bit_conversion: ((red * Max_8_bit) - red_8_bit).abs <=
		delta * Max_8_bit
	green_16_bit_conversion: ((green * Max_16_bit) - green_16_bit).abs <=
		delta * Max_16_bit
	green_8_bit_conversion: ((green * Max_8_bit) - green_8_bit).abs <
		delta * Max_8_bit
	blue_16_bit_conversion: ((blue * Max_16_bit) - blue_16_bit).abs <
		delta * Max_16_bit
	blue_8_bit_conversion: ((blue * Max_8_bit) - blue_8_bit).abs <
		delta * Max_8_bit
		
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
