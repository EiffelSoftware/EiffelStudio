indexing

	description: "IDLFLAGS flags"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_IDL_FLAGS
	
inherit
	EOLE_FLAGS

feature -- Access

	idlflag_none: INTEGER is
			-- Whether parameter passes or receives information is unspecified
			-- IDispatch interfaces can use this flag.
		external
			"C [macro <oaidl.h>]"
		alias
			"IDLFLAG_NONE"
		end

	idlflag_fin: INTEGER is
			-- Parameter passes information from caller to callee
		external
			"C [macro <oaidl.h>]"
		alias
			"IDLFLAG_FIN"
		end

	idlflag_fout: INTEGER is
			-- Parameter returns information from callee to caller
		external
			"C [macro <oaidl.h>]"
		alias
			"IDLFLAG_FOUT"
		end

	dilflag_flcid: INTEGER is
			-- Parameter is LCID (local identifier) of client application
		external
			"C [macro <oaidl.h>]"
		alias
			"IDLFLAG_FLCID"
		end

	idlflag_fretval: INTEGER is
			-- Parameter is return value of member
		external
			"C [macro <oaidl.h>]"
		alias
			"IDLFLAG_FRETVAL"
		end

	is_valid_idlflag (flag: INTEGER): BOOLEAN is
			-- Is `flag' a valid combination of idlflags?
		do
			Result := c_and (idlflag_none + idlflag_fin
						+ idlflag_fout + dilflag_flcid
						+ idlflag_fretval, flag)
						= idlflag_none + idlflag_fin
						+ idlflag_fout + dilflag_flcid
						+ idlflag_fretval
		end
	
end -- class EOLE_IDLFLAGS

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

