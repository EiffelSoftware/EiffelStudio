indexing
	description: "[
		Objects that represent effects applicable to EiffelVision2 character formats.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHARACTER_FORMAT_EFFECTS

inherit
	ANY
		redefine
			is_equal
		end

feature -- Status report

	is_striked_out: BOOLEAN
			-- Is the character striken out?
		
	is_underlined: BOOLEAN
			-- Is the character underlined?
			
feature -- Status setting

	enable_striked_out is
			-- Ensure characters are displayed as striken out, and set `is_striked_out' to True.
		do
			is_striked_out := True
		ensure
			is_striked_out: is_striked_out
		end
		
	disable_striked_out is
			-- Ensure characters are not displayed as striken out, and set `is_striked_out' to False.
		do
			is_striked_out := False
		ensure
			not_striked_out: not is_striked_out
		end
		
	enable_underlined is
			-- Ensure characters are displayed as underlined, and set `is_underlined' to True.
		do
			is_underlined := True
		ensure
			is_underlined: is_underlined
		end
		
	disable_underlined is
			-- Ensure characters are not displayed as underlined, and set `is_underlined' to False.
		do
			is_underlined := False
		ensure
			not_underlined: not is_underlined
		end
		
	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := (is_striked_out = other.is_striked_out) and then
				(is_underlined = other.is_underlined)
		end

end -- class EV_CHARACTER_FORMAT_EFFECTS

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

