indexing

	description: "Stat flags, used in feature `stat' of EOLE_STREAM"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	ECOM_STAT_FLAGS

feature -- Access

	Statflag_default: INTEGER is
			-- Indicate that this is not used for property
		external
			"C [macro <wtypes.h>]"
		alias
			"STATFLAG_DEFAULT"
		end

	Statflag_noname: INTEGER is
			-- Indicate that this is not used for property
		external
			"C [macro <wtypes.h>]"
		alias
			"STATFLAG_NONAME"
		end
		
	is_valid_stat_flag (flag: INTEGER): BOOLEAN is
			-- Is `flag' a valid stat flag?
		do
			Result := flag = Statflag_default or
						flag = Statflag_noname
		end
		
end -- class EOLE_STAT_FLAGS

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
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

