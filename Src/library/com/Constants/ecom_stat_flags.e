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

