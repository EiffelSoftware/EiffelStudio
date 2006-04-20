indexing
	description: "COM PARAMFLAGS flags"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ECOM_PARAM_FLAGS

inherit
	ECOM_FLAGS
	
feature -- Access

	Paramflag_none: INTEGER is
			-- Whether the parameter passes or receives information is unspecified
		external
			"C [macro <oaidl.h>]"
		alias
			"PARAMFLAG_NONE"
		end

	Paramflag_fin: INTEGER is
			-- Parameter passes information from the caller to the callee
		external
			"C [macro <oaidl.h>]"
		alias
			"PARAMFLAG_FIN"
		end

	Paramflag_fout: INTEGER is
			--  Parameter returns information from the callee to the caller
		external
			"C [macro <oaidl.h>]"
		alias
			"PARAMFLAG_FOUT"
		end
			
	Paramflag_flcid: INTEGER is
			-- Parameter is the LCID of a client application
		external
			"C [macro <oaidl.h>]"
		alias
			"PARAMFLAG_FLCID"
		end

	Paramflag_fretval: INTEGER is
			-- Parameter is the return value of the member
		external
			"C [macro <oaidl.h>]"
		alias
			"PARAMFLAG_FRETVAL"
		end
		
	Paramflag_fopt: INTEGER is
			-- Parameter is optional
		external
			"C [macro <oaidl.h>]"
		alias
			"PARAMFLAG_FOPT"
		end
			
	Paramflag_fhasdefault: INTEGER is
			-- Parameter has default behaviors defined
		external
			"C [macro <oaidl.h>]"
		alias
			"PARAMFLAG_FHASDEFAULT"
		end

feature -- Status report

	has_fopt_and_fhasdefault (flag: INTEGER): BOOLEAN is
			-- Does `flag' include `Paramflag_fopt' and
			-- `Paramflag_fhasdefault'?
		do
			Result := is_paramflag_fopt (flag) and is_paramflag_fhasdefault (flag)
		end

	is_paramflag_none (flag: INTEGER): BOOLEAN is
			-- Is flag PARAMFLAG_NONE?
		do
			Result := flag = Paramflag_none
		end

	is_paramflag_fin (flag: INTEGER): BOOLEAN is
			-- Is `in' parameter?
		do
			Result := binary_and (flag, Paramflag_fin) = Paramflag_fin
		end

	is_paramflag_fout (flag: INTEGER): BOOLEAN is
			-- Is `out' parameter?
		do
			Result := binary_and (flag, Paramflag_fout) = Paramflag_fout
		end

	is_paramflag_flcid (flag: INTEGER): BOOLEAN is
			-- Is `lcid' parameter?
		do
			Result := binary_and (flag, Paramflag_flcid) = Paramflag_flcid
		end

	is_paramflag_fretval (flag: INTEGER): BOOLEAN is
			-- Is `retval' parameter?
		do
			Result := binary_and (flag, Paramflag_fretval) = Paramflag_fretval
		end

	is_paramflag_fopt (flag: INTEGER): BOOLEAN is
			-- Is `opt' parameter?
		do
			Result := binary_and (flag, Paramflag_fopt) = Paramflag_fopt
		end

	is_paramflag_fhasdefault (flag: INTEGER): BOOLEAN is
			-- Is `hasdefault' parameter?
		do
			Result := binary_and (flag, Paramflag_fhasdefault) = Paramflag_fhasdefault
		end

	is_valid_paramflag (flag: INTEGER): BOOLEAN is
			-- Is `flag' a valid combination of paramflags?
		do
			Result := is_paramflag_none (flag) or
						is_paramflag_fin (flag) or
						is_paramflag_fout (flag) or
						is_paramflag_flcid (flag) or
						is_paramflag_fretval (flag) or
						is_paramflag_fopt (flag) or
						is_paramflag_fhasdefault (flag) 
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class ECOM_PARAM_FLAGS

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

