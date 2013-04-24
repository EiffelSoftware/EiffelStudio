note
	description:
		"[
		  Eiffel Vision color. Cocoa implementation
		  Both REAL and 16 bit INTEGER values are stored
		  as attributes and kept up to date.
		  In Cocoa colors have an Alpha value in addition to the RGB or can even be a pattern
		 ]"
	author: "Daniel Furrer"
	keywords: "color, pixel, rgb, 8, 16, 24"
	date: "$Date$";
	revision: "$Revision$"

class
	EV_COLOR_IMP

inherit
	EV_COLOR_I
		redefine
			set_with_other
		end

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: like interface)
			-- Create zero intensity color.
		do
			assign_interface (an_interface)
		end

	make
			-- Do nothing.
		do
			name := Default_name.twin
			set_is_initialized (True)
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

	name: STRING_32
			-- A textual description.

feature -- Element change

	set_red (a_red: REAL)
			-- Assign `a_red' to `red'.
		do
			red := a_red
			red_16_bit := (a_red * 0xFFFF).rounded
		end

	set_green (a_green: REAL)
			-- Assign `a_green' to `green'.
		do
			green := a_green
			green_16_bit := (a_green * 0xFFFF).rounded
		end

	set_blue (a_blue: REAL)
			-- Assign `a_blue' to `blue'.
		do
			blue := a_blue
			blue_16_bit := (a_blue * 0xFFFF).rounded
		end

	set_name (a_name: READABLE_STRING_GENERAL)
			-- Assign `a_name' to `name'.
		do
			name.wipe_out
			name.append_string_general (a_name)
		end

feature -- Conversion

	rgb_24_bit: INTEGER
			-- `red', `green' and `blue' intensities packed into 24 bits
			-- with 8 bits per colour and blue in the least significant 8 bits.
		do
			Result := (red_8_bit * 0x10000) + (green_8_bit * 0x100) + blue_8_bit
		end

	set_rgb_with_24_bit (a_24_bit_rgb: INTEGER)
			-- Set intensities from `a_24_bit_rgb' value
			-- with red in the most significant bits and blue in the least.
		do
			set_red_with_16_bit ((a_24_bit_rgb // 0x10000) * 0x101)
			set_green_with_16_bit (((a_24_bit_rgb // 0x100) \\ 0xFF00) * 0x101)
			set_blue_with_16_bit ((a_24_bit_rgb \\ 0xFFFF00) * 0x101)
		end

	red_8_bit: INTEGER
			-- Intensity of `red' component
			-- as an 8 bit unsigned integer.
			-- Range [0,255]
		do
			Result := (red * 0xFF).rounded
		end

	green_8_bit: INTEGER
			-- Intensity of `green' component
			-- as an 8 bit unsigned integer.
			-- Range [0,255]
		do
			Result := (green * 0xFF).rounded
		end

	blue_8_bit: INTEGER
			-- Intensity of `blue' component
			-- as an 8 bit unsigned integer.
			-- Range [0,255]
		do
			Result := (blue * 0xFF).rounded
		end

	set_red_with_8_bit (an_8_bit_red: INTEGER)
			-- Set `red' from `an_8_bit_red' intinsity.
		do
			set_red_with_16_bit (an_8_bit_red * 0x101)
		end

	set_green_with_8_bit (an_8_bit_green: INTEGER)
			-- Set `green' from `an_8_bit_green' intinsity.
		do
			set_green_with_16_bit (an_8_bit_green * 0x101)
		end

	set_blue_with_8_bit (an_8_bit_blue: INTEGER)
		do
			set_blue_with_16_bit (an_8_bit_blue * 0x101)
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

	set_red_with_16_bit (a_16_bit_red: INTEGER)
			-- Set `red' from `a_8_bit_red' intinsity.
		do
			red_16_bit := a_16_bit_red
			red := (a_16_bit_red / 0xFFFF).truncated_to_real
		end

	set_green_with_16_bit (a_16_bit_green: INTEGER)
			-- Set `green' from `a_16_bit_green' intinsity.
		do
			green_16_bit := a_16_bit_green
			green := (a_16_bit_green / 0xFFFF).truncated_to_real
		end

	set_blue_with_16_bit (a_16_bit_blue: INTEGER)
			-- Set `blue' from `a_16_bit_blue' intinsity.
		do
			blue_16_bit := a_16_bit_blue
			blue := (a_16_bit_blue / 0xFFFF).truncated_to_real
		end

	set_with_other (other: EV_COLOR)
			-- Take on the appearance of `other'.
		do
			if attached {EV_COLOR_IMP} other.implementation as imp then
				red_16_bit := imp.red_16_bit
				green_16_bit := imp.green_16_bit
				blue_16_bit := imp.blue_16_bit
				red := imp.red
				green := imp.green
				blue := imp.blue
			else
				check
					imp_void: False
				end
			end
		end

feature {EV_ANY_I} -- Command

	delta: REAL
			-- Amount by which two intensities can differ but still be
			-- considered equal by `is_equal'.
		do
			Result := (1 / 255).truncated_to_real
		end

	destroy
          		-- Render `Current' unusable.
		do
			set_is_destroyed (True)
		end

feature {EV_ANY_I, ANY} -- Implementation

	color: NS_COLOR
		do
			create Result.color_with_calibrated_red_green_blue_alpha (red, green, blue, (1.0).truncated_to_real)
		end

end -- class EV_COLOR_IMP
