--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "Eiffel Vision color. Mswindows implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	EV_COLOR_IMP

inherit
	EV_COLOR_I

	WEL_COLOR_REF
		rename
			make as wel_make,
			red as red_8_bit,
			green as green_8_bit,
			blue as blue_8_bit,
			set_red as wel_set_red,
			set_blue as wel_set_blue,
			set_green as wel_set_green
		end

creation
	make

feature -- Initialization

	initialize is
		do
			is_initialized := True
		end

	make (an_interface: like interface) is
			-- Create a color. 
		do
			base_make (an_interface)
			wel_make
			name := default_name
		end

feature {EV_COLOR} -- Access

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

feature {EV_COLOR} -- Element change

	set_red (a_red: REAL) is
			-- Assign `a_red' to `red'.
		do
			set_red_with_8_bit ((a_red * 255).rounded)
			red := a_red
		end

	set_green (a_green: REAL) is
			-- Assign `a_green' to `green'.
		do
			set_green_with_8_bit ((a_green * 255).rounded)
			green := a_green
		end

	set_blue (a_blue: REAL) is
			-- Assign `a_blue' to `blue'.
		do
			set_blue_with_8_bit ((a_blue * 255).rounded)
			blue := a_blue
		end

	set_name (a_name: STRING) is
			-- Assign `a_name' to `name'.
		do
			name.copy (a_name)
		end

feature {EV_ANY_I, EV_DEFAULT_COLORS_IMP}

	set_with_system_id (id: INTEGER) is
		local
			wcr: WEL_COLOR_REF
		do
			create wcr.make_system (id)
			set_red_with_8_bit (wcr.red)
			set_green_with_8_bit (wcr.green)
			set_blue_with_8_bit (wcr.blue)
		end

feature {EV_COLOR} -- Conversion

	rgb_24_bit: INTEGER is
			-- `red', `green' and `blue' intensities packed into 24 bits
			-- with 8 bits per colour and blue in the least significant 8 bits.
		do
			Result := (red_8_bit *65536) + (green_8_bit * 256) + blue_8_bit
		end

	set_rgb_with_24_bit (a_24_bit_rgb: INTEGER) is
			-- Set intensities from `a_24_bit_rgb' value
			-- with blue in the least significant 8 bits.
		local
			counter: INTEGER
		do
			counter := a_24_bit_rgb
			set_red_with_8_bit (counter // 65536)
			counter := counter - (counter // 65536)
			set_green_with_8_bit (counter // 256)
			counter := counter - (counter // 256)
			set_blue_with_8_bit (counter)
		end
	
	set_red_with_8_bit (an_8_bit_red: INTEGER) is
			-- Set `red' from `an_8_bit_red' intinsity.
		do
			wel_set_red (an_8_bit_red)
			red := an_8_bit_red / 255
		end
	
	set_green_with_8_bit (an_8_bit_green: INTEGER) is
			-- Set `green' from `an_8_bit_green' intinsity.
		do
			wel_set_green (an_8_bit_green)
			green := an_8_bit_green / 255
		end
	
	set_blue_with_8_bit (an_8_bit_blue: INTEGER) is
			-- Set `blue' from `an_8_bit_blue' intinsity.
		do
			wel_set_blue (an_8_bit_blue)
			blue := an_8_bit_blue / 255
		end

	red_16_bit: INTEGER is
			-- Intensity of red component
			-- as a 16 bit unsigned integer.
			-- Range [0,65535]
		do
			Result := (red * 65535).rounded
		end

	green_16_bit: INTEGER is
			-- Intensity of green component
			-- as a 16 bit unsigned integer.
			-- Range [0,65535]
		do
			Result := (green * 65535).rounded
		end
	
	blue_16_bit: INTEGER is
			-- Intensity of blue component
			-- as a 16 bit unsigned integer.
			-- Range [0,65535]
		do
			Result := (blue * 65535).rounded
		end
	
	set_red_with_16_bit (a_16_bit_red: INTEGER) is
			-- Set `red' from `a_8_bit_red' intinsity.
		do
			--|FIXMEred_16_bit := a_16_bit_red
			wel_set_red (a_16_bit_RED // 256)
			red := a_16_bit_red / 65535	
		end
	
	set_green_with_16_bit (a_16_bit_green: INTEGER) is
			-- Set `green' from `a_16_bit_green' intinsity.
		do
			--|FIXMEgreen_16_bit := a_16_bit_green
			wel_set_green (a_16_bit_green // 256)
			green := a_16_bit_green / 65535
		end
	
	set_blue_with_16_bit (a_16_bit_blue: INTEGER) is
			-- Set `blue' from `a_16_bit_blue' intinsity.
		do
			--|FIXMEblue_16_bit := a_16_bit_blue
			wel_set_blue (a_16_bit_blue // 256)
			blue := a_16_bit_blue
		end

feature -- Status setting

	destroy is
			-- Render `Current' unusable.
			-- No externals to deallocate, just set the flags.
		do
			is_destroyed := True
			destroy_just_called := True
		end

end -- class EV_COLOR_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.4  2000/02/14 11:40:40  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.10.3  2000/01/27 19:30:10  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.10.2  1999/12/17 17:26:39  rogers
--| Altered to fit in with the review branch. Make now takes an interface. Colors now take reals, but can be returned in a variety of formats.
--|
--| Revision 1.3.10.1  1999/11/24 17:30:17  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.6.3  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
