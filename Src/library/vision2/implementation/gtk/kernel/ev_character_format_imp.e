indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHARACTER_FORMAT_IMP

inherit
	EV_CHARACTER_FORMAT_I

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create character format 
		do
			base_make (an_interface)
		end
	
	initialize is
			-- Do nothing
		do
			is_initialized := True
		end
		
feature -- Access

	font: EV_FONT is
			-- Font of the current format
		do
			create Result
		end
	
	color: EV_COLOR is
			-- Color of the current format
		do
			create Result
		end

	background_color: EV_COLOR is
			-- Color of the current format
		do
			create Result
		end
		
	effects: EV_CHARACTER_FORMAT_EFFECTS is
			-- Character format effects applicable to `font'
		do
			create Result
		end

feature -- Status setting
		
	set_font (a_font: EV_FONT) is
			-- Make `value' the new font
		do
		end

	set_color (a_color: EV_COLOR) is
			-- Make `value' the new color
		do
		end

	set_background_color (a_color: EV_COLOR) is
			-- Make `value' the new color
		do
		end
		
	set_effects (an_effect: EV_CHARACTER_FORMAT_EFFECTS) is
			-- Make `an_effect' the new `effects'
		do
		end

feature {NONE} -- Implementation

	name: STRING
			-- Face name used by `Current'.
		
	family: INTEGER
			-- Family used by `Current'.
		
	height: INTEGER
			--  Height of `Current' in screen pixels.

	height_in_points: INTEGER
			-- Height of `Current' in points
		
	weight: INTEGER
			-- Weight of `Current'.
		
	is_bold: BOOLEAN
			-- Is `Current' bold?
		
	shape: INTEGER
			-- Shape of `Current'.

	char_set: INTEGER
			-- Char set used by `Current'.
		
	is_underlined: BOOLEAN
			-- Is `Current' underlined?
		
	is_striked_out: BOOLEAN
			-- Is `Current' striken out?
		
	vertical_offset: INTEGER
			-- Vertical offset of `Current'.

	fcolor: INTEGER
			-- foreground color RGB packed into 24 bit.
		
	bcolor: INTEGER
			-- background color RGB packed into 24 bit.

	destroy is
			-- 
		do
			
		end

end -- class EV_CHARACTER_FORMAT_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

