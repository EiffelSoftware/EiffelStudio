indexing
	description:
		"Eiffel Vision color. Gtk implementation%N%
		%Both REAL and 16 bit INTEGER values are stored%N%
		%as attributes and kept up to date."
	status: "See notice at end of file.";
	keywords: "color, pixel, rgb, 8, 16, 24"
	date: "$Date$";
	revision: "$Revision$"

class
	EV_COLOR_IMP

inherit
	EV_COLOR_I
		redefine
			interface,
			set_with_other
		end

create
	make

--| NOTE: This class does lots of bit shuffling. Because Eiffel does not
--| currently support hexidecimal INTEGER literals, integers are duplicated
--| in comments using hexidecimal numbers for clarity.

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create zero intensity color. 
		do
			base_make (an_interface)
			name := clone (Default_name)
		end
	
	initialize is
			-- Do nothing.
		do
			is_initialized := True
		end

feature -- Access

	red: REAL
			-- Intensity of red component.
			-- Range: [0,1]

	green: REAL
			-- Intensity of green component.
			-- Range: [0,1]

	blue: REAL
			-- Intensity of blue component.
			-- Range: [0,1]

	name: STRING
			-- A textual description.
	
feature -- Element change

	set_red (a_red: REAL) is
			-- Assign `a_red' to `red'.
		do
			red := a_red
			-- red_16_bit := (a_red * 0xFFFF)
			red_16_bit := (a_red * 65535).rounded
		end

	set_green (a_green: REAL) is
			-- Assign `a_green' to `green'.
		do
			green := a_green
			-- green_16_bit := (a_green * 0xFFFF)
			green_16_bit := (a_green * 65535).rounded
		end

	set_blue (a_blue: REAL) is
			-- Assign `a_blue' to `blue'.
		do
			blue := a_blue
			-- blue_16_bit := (a_blue * 0xFFFF)
			blue_16_bit := (a_blue * 65535).rounded
		end

	set_name (a_name: STRING) is
			-- Assign `a_name' to `name'.
		do
			name.copy (a_name)
		end

feature -- Conversion

	rgb_24_bit: INTEGER is
			-- `red', `green' and `blue' intensities packed into 24 bits
			-- with 8 bits per colour and blue in the least significant 8 bits.
		do
		--| Result := (red_8_bit * 0x10000) + (green_8_bit * 0x100) + blue_8_bit
			Result := (red_8_bit * 65536) + (green_8_bit * 256) + blue_8_bit
		end

	set_rgb_with_24_bit (a_24_bit_rgb: INTEGER) is
			-- Set intensities from `a_24_bit_rgb' value
			-- with red in the most significant bits and blue in the least.
		do
			--| set_red_16_bit ((a_24_bit_rgb // 0x10000) * 0x101)
			set_red_with_16_bit ((a_24_bit_rgb // 65536) * 257)
			--| set_green_16_bit (((a_24_bit_rgb // 0x100) \\ 0xFF00) * 0x101)
			set_green_with_16_bit (((a_24_bit_rgb // 256) \\ 65280) * 257)
			--| set_blue ((a_24_bit_rgb \\ 0xFFFF00) * 0x101)
			set_blue_with_16_bit ((a_24_bit_rgb \\ 16776960) * 257)
		end

	red_8_bit: INTEGER is
			-- Intensity of `red' component
			-- as an 8 bit unsigned integer.
			-- Range [0,255]
		do
			--| Result := red * 0xFF
			Result := (red * 255).rounded
		end

	green_8_bit: INTEGER is
			-- Intensity of `green' component
			-- as an 8 bit unsigned integer.
			-- Range [0,255]
		do
			--| Result := green * 0xFF
			Result := (green * 255).rounded
		end

	blue_8_bit: INTEGER is
			-- Intensity of `blue' component
			-- as an 8 bit unsigned integer.
			-- Range [0,255]
		do
			--| Result := blue * 0xFF
			Result := (blue * 255).rounded
		end
	
	set_red_with_8_bit (an_8_bit_red: INTEGER) is
			-- Set `red' from `an_8_bit_red' intinsity.
		do
			--| set_red_16_bit (an_8_bit_red * 0x101)
			set_red_with_16_bit (an_8_bit_red * 257)
		end
	
	set_green_with_8_bit (an_8_bit_green: INTEGER) is
			-- Set `green' from `an_8_bit_green' intinsity.
		do
			--| set_green_16_bit (an_8_bit_green * 0x101)
			set_green_with_16_bit (an_8_bit_green * 257)
		end
	
	set_blue_with_8_bit (an_8_bit_blue: INTEGER) is
		do
			--| set_blue_16_bit (an_8_bit_blue * 0x101)
			set_blue_with_16_bit (an_8_bit_blue * 257)
		end

	red_16_bit: INTEGER 
			-- Intensity of red component
			-- as a 16 bit unsigned integer.
			-- Range [0,65535]

	green_16_bit: INTEGER
			-- Intensity of green component
			-- as a 16 bit unsigned integer.
			-- Range [0,65535]

	blue_16_bit: INTEGER
			-- Intensity of blue component
			-- as a 16 bit unsigned integer.
			-- Range [0,65535]

	set_red_with_16_bit (a_16_bit_red: INTEGER) is
			-- Set `red' from `a_8_bit_red' intinsity.
		do
			red_16_bit := a_16_bit_red
			--| red := a_16_bit_red / 0xFFFF
			red := a_16_bit_red / 65535
		end
	
	set_green_with_16_bit (a_16_bit_green: INTEGER) is
			-- Set `green' from `a_16_bit_green' intinsity.
		do
			green_16_bit := a_16_bit_green
			--| green := a_16_bit_green / 0xFFFF
			green := a_16_bit_green / 65535
		end

	set_blue_with_16_bit (a_16_bit_blue: INTEGER) is
			-- Set `blue' from `a_16_bit_blue' intinsity.
		do
			blue_16_bit := a_16_bit_blue
			--| blue := a_16_bit_blue / 0xFFFF
			blue := a_16_bit_blue / 65535
		end

	set_with_other (other: EV_COLOR) is
			-- Take on the appearance of `other'.
		local
			imp: EV_COLOR_IMP
		do
			imp ?= other.implementation
			check
				imp_not_void: imp /= Void
			end
			red_16_bit := imp.red_16_bit
			green_16_bit := imp.green_16_bit
			blue_16_bit := imp.blue_16_bit
			red := imp.red
			green := imp.green
			blue := imp.blue
		end

feature {EV_ANY_I} -- Command

	delta: REAL is
			-- Amount by which two intensities can differ but still be
			-- considered equal by `is_equal'.
		do
			--| FIXME IEK Is this correct for GTK?
			Result := 1 / 255
		end

	destroy is
          		-- Render `Current' unusable.
		do
			is_destroyed := True
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_COLOR

end -- class EV_COLOR_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

