indexing

	description: "Running Object Table Registration flags"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_ROT_REGISTER_FLAGS

inherit
	EOLE_FLAGS
	
feature -- Access

	Rotflags_registrationkeepsalive: INTEGER is
			-- Strong reference
		external
			"C [macro <wtypes.h>]"
		alias
			"ROTFLAGS_REGISTRATIONKEEPSALIVE"
		end

	Rotflags_weakreference: INTEGER is 0
			-- Weak reference

	Rotflags_allowanyclient: INTEGER
		external
			"C [macro <wtypes.h>]"
		alias
			"ROTFLAGS_ALLOWANYCLIENT"
		end
		
	is_valid_ROT_REGISTER_flags (flags: INTEGER): BOOLEAN is
			-- Is `flags' a valid combination of ROT_REGISTERainer flags?
		do
			Result := c_and (Rotflags_registrationkeepsalive + Rotflags_weakreference
						+ Rotflags_allowanyclient, flags)
						= Rotflags_registrationkeepsalive + Rotflags_weakreference
						+ Rotflags_allowanyclient
		end
		
end -- class EOLE_ROT_REGISTER_FLAGS

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| ROT_REGISTERact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1998.
--| Modifications and extensions: copyright (C) ISE, 1998.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

