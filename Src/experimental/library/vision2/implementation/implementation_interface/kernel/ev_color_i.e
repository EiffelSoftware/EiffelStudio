note
	description:
		"Eiffel Vision color. Implementation interface.%N%
		%See ev_color.e"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	keywords: "color, pixel, rgb, 8, 16, 24"
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_COLOR_I

inherit
	EV_ANY_I
		export
			{ANY} attached_interface
		redefine
			interface
		end

feature -- Initialization

	old_make (an_interface: like interface)
			-- Create zero intinsity color.
		deferred
		ensure then
			default_name_assigned: name.is_equal (Default_name)
			red_zero: red = 0
			green_zero: green = 0
			blue_zero: blue = 0
		end

feature {EV_COLOR} -- Access

	red: REAL
			-- Intensity of red component.
			-- Range: [0,1]
		deferred
		ensure
			within_range: Result >= 0 and Result <= 1
		end

	green: REAL
			-- Intensity of green component.
			-- Range: [0,1]
		deferred
		ensure
			within_range: Result >= 0 and Result <= 1
		end

	blue: REAL
			-- Intensity of blue component.
			-- Range: [0,1]
		deferred
		ensure
			within_range: Result >= 0 and Result <= 1
		end

	name: STRING_32
			-- A textual description.
		deferred
		ensure
			not_void: Result /= Void
		end

feature {EV_COLOR} -- Element change

	set_red (a_red: REAL)
			-- Assign `a_red' to `red'.
		require
			within_range: a_red >= 0 and a_red <= 1
		deferred
		ensure
			red_assigned: (red - a_red).abs <= delta
		end

	set_green (a_green: REAL)
			-- Assign `a_green' to `green'.
		require
			within_range: a_green >= 0 and a_green <= 1
		deferred
		ensure
			green_assigned: (green - a_green).abs <= delta
		end

	set_blue (a_blue: REAL)
			-- Assign `a_blue' to `blue'.
		require
			blue_within_range: a_blue >= 0 and a_blue <= 1
		deferred
		ensure
			blue_assigned: (blue - a_blue).abs <= delta
		end

	set_name (a_name: STRING_GENERAL)
			-- Assign `a_name' to `name'.
		require
			name_not_void: a_name /= Void
		deferred
		ensure
			name_assigned: name /= Void and then name.is_equal (a_name)
		end

feature {EV_COLOR} -- Conversion

	rgb_24_bit: INTEGER
			-- `red', `green' and `blue' intensities packed into 24 bits
			-- with 8 bits per colour and blue in the least significant 8 bits.
		deferred
		ensure
			within_range: Result >= 0 and result <= {EV_COLOR}.Max_24_bit
		end

	set_rgb_with_24_bit (a_24_bit_rgb: INTEGER)
			-- Set intensities from `a_24_bit_rgb' value
			-- with blue in the least significant 8 bits.
		require
			within_range: a_24_bit_rgb >= 0 and
				a_24_bit_rgb <= {EV_COLOR}.Max_24_bit
		deferred
		ensure
			rgb_assigned: rgb_24_bit = a_24_bit_rgb
		end

	red_8_bit: INTEGER
			-- Intensity of `red' component
			-- as an 8 bit unsigned integer.
			-- Range [0,255]
		deferred
		ensure
			within_range: Result >= 0 and Result <= {EV_COLOR}.Max_8_bit
		end

	green_8_bit: INTEGER
			-- Intensity of `green' component
			-- as an 8 bit unsigned integer.
			-- Range [0,255]
		deferred
		ensure
			within_range: Result >= 0 and Result <= {EV_COLOR}.Max_8_bit
		end

	blue_8_bit: INTEGER
			-- Intensity of `blue' component
			-- as an 8 bit unsigned integer.
			-- Range [0,255]
		deferred
		ensure
			within_range: Result >= 0 and Result <= {EV_COLOR}.Max_8_bit
		end

	set_red_with_8_bit (an_8_bit_red: INTEGER)
			-- Set `red' from `an_8_bit_red' intinsity.
		require
			within_range: an_8_bit_red >= 0 and
				an_8_bit_red <= {EV_COLOR}.Max_8_bit
		deferred
		ensure
			red_assigned: red_8_bit = an_8_bit_red
		end

	set_green_with_8_bit (an_8_bit_green: INTEGER)
			-- Set `green' from `an_8_bit_green' intinsity.
		require
			within_range: an_8_bit_green >= 0 and
				an_8_bit_green <= {EV_COLOR}.Max_8_bit
		deferred
		ensure
			green_assigned: green_8_bit = an_8_bit_green
		end

	set_blue_with_8_bit (an_8_bit_blue: INTEGER)
			-- Set `blue' from `an_8_bit_blue' intinsity.
		require
			within_range: an_8_bit_blue >= 0 and
				an_8_bit_blue <= {EV_COLOR}.Max_8_bit
		deferred
		ensure
			blue_assigned: blue_8_bit = an_8_bit_blue
		end

	red_16_bit: INTEGER
			-- Intensity of red component
			-- as a 16 bit unsigned integer.
			-- Range [0,65535]
		deferred
		ensure
			within_range: Result >= 0 and Result <= {EV_COLOR}.Max_16_bit
		end

	green_16_bit: INTEGER
			-- Intensity of green component
			-- as a 16 bit unsigned integer.
			-- Range [0,65535]
		deferred
		ensure
			within_range: Result >= 0 and Result <= {EV_COLOR}.Max_16_bit
		end

	blue_16_bit: INTEGER
			-- Intensity of blue component
			-- as a 16 bit unsigned integer.
			-- Range [0,65535]
		deferred
		ensure
			within_range: Result >= 0 and Result <= {EV_COLOR}.Max_16_bit
		end

	set_red_with_16_bit (a_16_bit_red: INTEGER)
			-- Set `red' from `a_8_bit_red' intinsity.
		require
			within_range: a_16_bit_red >= 0 and
				a_16_bit_red <= {EV_COLOR}.Max_16_bit
		deferred
		ensure
			red_assigned: red_16_bit = a_16_bit_red
		end

	set_green_with_16_bit (a_16_bit_green: INTEGER)
			-- Set `green' from `a_16_bit_green' intinsity.
		require
			within_range: a_16_bit_green >= 0 and
				a_16_bit_green <= {EV_COLOR}.Max_16_bit
		deferred
		ensure
			green_assigned: green_16_bit = a_16_bit_green
		end

	set_blue_with_16_bit (a_16_bit_blue: INTEGER)
			-- Set `blue' from `a_16_bit_blue' intinsity.
		require
			within_range: a_16_bit_blue >= 0 and
				a_16_bit_blue <= {EV_COLOR}.Max_16_bit
		deferred
		ensure
			blue_assigned: blue_16_bit = a_16_bit_blue
		end

	set_with_other (other: EV_COLOR)
			-- Take on the appearance of `other'.
		do
			set_red (other.red)
			set_green (other.green)
			set_blue (other.blue)
		end

feature -- Implementation

	Default_name: STRING = "noname"
			-- To be used as `name' when none is supplied.

	interface: detachable EV_COLOR note option: stable attribute end
			-- Interface of the current color.

	delta: REAL
			-- Amount by which two intensities can differ but still be
			-- considered equal by `is_equal'.
		deferred
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




end -- class EV_COLOR_I









