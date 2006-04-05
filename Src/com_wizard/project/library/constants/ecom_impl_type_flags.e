indexing
	description: "IMPLTYPEFLAGS flags"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ECOM_IMPL_TYPE_FLAGS
	
inherit
	ECOM_FLAGS

feature -- Access

	Impltypeflag_fdefault: INTEGER is
			-- Interface or dispinterface represents default for
			-- source or sink
		external
			"C [macro <oaidl.h>]"
		alias
			"IMPLTYPEFLAG_FDEFAULT"
		end
		
	Impltypeflag_fsource: INTEGER is
			-- Member of coclass called rather than implemented
		external
			"C [macro <oaidl.h>]"
		alias
			"IMPLTYPEFLAG_FSOURCE"
		end
		
	Impltypeflag_frestricted: INTEGER is
			-- Member should not be displayed or programmable by users
		external
			"C [macro <oaidl.h>]"
		alias
			"IMPLTYPEFLAG_FRESTRICTED"
		end

	Impltypeflag_fdefaultvtable: INTEGER is
			-- Sink receive events through the VTABLE.
		external
			"C [macro <oaidl.h>]"
		alias
			"IMPLTYPEFLAG_FDEFAULTVTABLE"
		end
		
feature -- Status Report

	is_fdefault (a_flag: INTEGER):BOOLEAN is
			-- Is flag `Impltypeflag_fdefault'?
		do
			Result := binary_and (a_flag, Impltypeflag_fdefault) = Impltypeflag_fdefault
		end

	is_fsource (a_flag: INTEGER):BOOLEAN is
			-- Is flag `Impltypeflag_fsource'?
		do
			Result := binary_and (a_flag, Impltypeflag_fsource) = Impltypeflag_fsource
		end

	is_frestricted (a_flag: INTEGER):BOOLEAN is
			-- Is flag `Impltypeflag_frestricted?
		do
			Result := binary_and (a_flag, Impltypeflag_frestricted) = Impltypeflag_frestricted
		end

	is_fdefaultvtable (a_flag: INTEGER):BOOLEAN is
			-- Is flag `Impltypeflag_fdefaultvtable?
		do
			Result := binary_and (a_flag, Impltypeflag_fdefaultvtable) = Impltypeflag_fdefaultvtable
		end

	is_valid_impltypeflag (a_flag: INTEGER): BOOLEAN is
			-- Is `flag' a valid combination of impltypeflags?
		do
			Result := is_fdefault (a_flag) or
					is_fsource (a_flag) or 
					is_frestricted (a_flag) or
					is_fdefaultvtable (a_flag) or
					(a_flag = 0)
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
end -- class ECOM_IMPLTYPEFLAGS

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

