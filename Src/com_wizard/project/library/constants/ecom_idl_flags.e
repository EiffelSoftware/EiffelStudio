indexing
	description: "COM IDLFLAGS flags"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	ECOM_IDL_FLAGS

inherit
	ECOM_FLAGS
	
feature -- Access

	Idlflag_none: INTEGER is
			-- Whether the parameter passes or receives information is unspecified
		external
			"C [macro <oaidl.h>]"
		alias
			"IDLFLAG_NONE"
		end

	Idlflag_fin: INTEGER is
			-- Parameter passes information from the caller to the callee
		external
			"C [macro <oaidl.h>]"
		alias
			"IDLFLAG_FIN"
		end

	Idlflag_fout: INTEGER is
			--  Parameter returns information from the callee to the caller
		external
			"C [macro <oaidl.h>]"
		alias
			"IDLFLAG_FOUT"
		end
			
	Idlflag_flcid: INTEGER is
			-- Parameter is the LCID of a client application
		external
			"C [macro <oaidl.h>]"
		alias
			"IDLFLAG_FLCID"
		end

	Idlflag_fretval: INTEGER is
			-- Parameter is the return value of the member
		external
			"C [macro <oaidl.h>]"
		alias
			"IDLFLAG_FRETVAL"
		end

feature -- Status report

	is_idlflag_none (flag: INTEGER): BOOLEAN is
			-- Is flag IDLFLAG_NONE?
		do
			Result := flag = Idlflag_none
		end

	is_idlflag_fin (flag: INTEGER): BOOLEAN is
			-- Is `in' parameter?
		do
			Result := binary_and (flag, Idlflag_fin) = Idlflag_fin
		end

	is_idlflag_fout (flag: INTEGER): BOOLEAN is
			-- Is `out' parameter?
		do
			Result := binary_and (flag, Idlflag_fout) = Idlflag_fout
		end

	is_idlflag_flcid (flag: INTEGER): BOOLEAN is
			-- Is `lcid' parameter?
		do
			Result := binary_and (flag, Idlflag_flcid) = Idlflag_flcid
		end

	is_idlflag_fretval (flag: INTEGER): BOOLEAN is
			-- Is `retval' parameter?
		do
			Result := binary_and (flag, Idlflag_fretval) = Idlflag_fretval
		end

	is_valid_idlflag (flag: INTEGER): BOOLEAN is
			-- Is `flag' a valid combination of idlflags?
		do
			Result := is_idlflag_none (flag) or
						is_idlflag_fin (flag) or
						is_idlflag_fout (flag) or
						is_idlflag_flcid (flag) or
						is_idlflag_fretval (flag)
		end

end -- class ECOM_IDL_FLAGS

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

