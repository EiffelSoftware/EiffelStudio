indexing
	description: "Eiffel Vision WEL key conversion. Provides a function%N%
		%for WEL to vision2 conversion and for vision2 to WEL conversion."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WEL_KEY_CONVERSION

inherit
	WEL_VK_CONSTANTS

	EV_KEY_CONSTANTS

feature -- Conversion

	key_code_to_wel (a_key_code: INTEGER): INTEGER is
		require
			a_key_code_valid: valid_key_code (a_key_code)
		do
			check
				to_be_implemented: False
			end
		end

	key_code_from_wel (a_wel_code: INTEGER): INTEGER is
		do
			check
				to_be_implemented: False
			end
		ensure
			valid_key_code: valid_key_code (Result)
		end

end -- class EV_WEL_KEY_CONVERSION

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
--| Revision 1.1  2000/03/15 23:33:29  brendel
--| Initial.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------


