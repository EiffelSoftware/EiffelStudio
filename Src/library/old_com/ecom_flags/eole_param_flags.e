indexing

	description: "PARAMFLAGS flags"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_PARAM_FLAGS

inherit
	EOLE_FLAGS
	
feature -- Access

	Paramflag_none: INTEGER is
			-- Whether the parameter passes or receives information is unspecified
		external
			"C [macro %"oleflags.h%"]"
		alias
			"PARAMFLAG_NONE"
		end

	Paramflag_fin: INTEGER is
			-- Parameter passes information from the caller to the callee
		external
			"C [macro %"oleflags.h%"]"
		alias
			"PARAMFLAG_FIN"
		end

	Paramflag_fout: INTEGER is
			--  Parameter returns information from the callee to the caller
		external
			"C [macro %"oleflags.h%"]"
		alias
			"PARAMFLAG_FOUT"
		end
			
	Paramflag_flcid: INTEGER is
			-- Parameter is the LCID of a client application
		external
			"C [macro %"oleflags.h%"]"
		alias
			"PARAMFLAG_FLCID"
		end

	Paramflag_fretval: INTEGER is
			-- Parameter is the return value of the member
		external
			"C [macro %"oleflags.h%"]"
		alias
			"PARAMFLAG_FRETVAL"
		end
		
	Paramflag_fopt: INTEGER is
			-- Parameter is optional
		external
			"C [macro %"oleflags.h%"]"
		alias
			"PARAMFLAG_FOPT"
		end
			
	Paramflag_fhasdefault: INTEGER is
			-- Parameter has default behaviors defined
		external
			"C [macro %"oleflags.h%"]"
		alias
			"PARAMFLAG_FHASDEFAULT"
		end

	has_fopt_and_fhasdefault (flag: INTEGER): BOOLEAN is
			-- Does `flag' include `Paramflag_fopt' and
			-- `Paramflag_fhasdefault'?
		do
			Result := c_and (Paramflag_fopt + Paramflag_fhasdefault,
								flag) = flag
		end

	is_valid_typeflag (flag: INTEGER): BOOLEAN is
			-- Is `flag' a valid combination of typeflags?
		do
			Result := c_and (Paramflag_none + Paramflag_fin
						+ Paramflag_fout + Paramflag_flcid
						+ Paramflag_fretval + Paramflag_fopt
						+ Paramflag_fhasdefault, flag)
						= Paramflag_none + Paramflag_fin
						+ Paramflag_fout + Paramflag_flcid
						+ Paramflag_fretval + Paramflag_fopt
						+ Paramflag_fhasdefault
		end

end -- class EOLE_PARAM_FLAGS

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

