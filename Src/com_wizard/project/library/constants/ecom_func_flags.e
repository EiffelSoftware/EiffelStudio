indexing
	description: "FUNCFLAGS flags"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ECOM_FUNC_FLAGS

inherit
	ECOM_FLAGS
	
feature -- Access

	Funcflag_frestricted: INTEGER is
			-- Function should not be accessible from
			-- This flag is intended for system-level functions or functions
			-- that you do not want type browsers to display.
		external
			"C [macro <oaidl.h>]"
		alias
			"FUNCFLAG_FRESTRICTED"
		end

	Funcflag_fsource: INTEGER is
			-- Function returns object that is source of events
		external
			"C [macro <oaidl.h>]"
		alias
			"FUNCFLAG_FSOURCE"
		end

	Funcflag_fbindable: INTEGER is
			-- Function that supports data binding
		external
			"C [macro <oaidl.h>]"
		alias
			"FUNCFLAG_FBINDABLE"
		end

	Funcflag_frequestedit: INTEGER is
		external
			"C [macro <oaidl.h>]"
		alias
			"FUNCFLAG_FREQUESTEDIT"
		end

	Funcflag_fdisplaybind: INTEGER is
			-- Function that is displayed to user as bindable;
			-- that is, FUNC_FBINDABLE must also be set.
		external
			"C [macro <oaidl.h>]"
		alias
			"FUNCFLAG_FDISPLAYBIND"
		end

	Funcflag_fdefaultbind: INTEGER is
			-- Function that best represents object
			-- Only one function in dispinterface may have this attribute.
		external
			"C [macro <oaidl.h>]"
		alias
			"FUNCFLAG_FDEFAULTBIND"
		end

	Funcflag_fhidden: INTEGER is
			-- Function should not be displayed to user, 
			-- although it exists and is bindable.
		external
			"C [macro <oaidl.h>]"
		alias
			"FUNCFLAG_FHIDDEN"
		end

	Funcflag_fdefaultcollelem: INTEGER is
			-- Permits optimization.
		external
			"C [macro <oaidl.h>]"
		alias
			"FUNCFLAG_FDEFAULTCOLLELEM"
		end

	Funcflag_fuidefault: INTEGER is
			-- Type information member is default 
			-- member for display in user interface. 
		external
			"C [macro <oaidl.h>]"
		alias
			"FUNCFLAG_FUIDEFAULT"
		end

	Funcflag_fnonbrowsable: INTEGER is
			-- Property appears in object browser, 
			-- but not in properties browser
		external
			"C [macro <oaidl.h>]"
		alias
			"FUNCFLAG_FNONBROWSABLE"
		end

	Funcflag_freplaceable: INTEGER is
			-- Tags interface as having default behaviors. 
		external
			"C [macro <oaidl.h>]"
		alias
			"FUNCFLAG_FREPLACEABLE"
		end

	Funcflag_fimmediatebind: INTEGER is
			-- Mapped as individual bindable properties.
		external
			"C [macro <oaidl.h>]"
		alias
			"FUNCFLAG_FIMMEDIATEBIND"
		end

feature -- Status report

	is_funcflag_frestricted (flag: INTEGER): BOOLEAN is
			-- Is flag FRESTRICTED?
		do
			Result := binary_and (flag, Funcflag_frestricted) = Funcflag_frestricted
		end

	is_funcflag_fsource (flag: INTEGER): BOOLEAN is
			-- Is flag fsource?
		do
			Result := binary_and (flag, Funcflag_fsource) = Funcflag_fsource
		end

	is_funcflag_fbindable (flag: INTEGER): BOOLEAN is
			-- Is flag fbindable?
		do
			Result := binary_and (flag, Funcflag_fbindable) = Funcflag_fbindable
		end

	is_funcflag_frequestedit (flag: INTEGER): BOOLEAN is
			-- Is flag frequestedit?
		do
			Result := binary_and (flag, Funcflag_frequestedit) = Funcflag_frequestedit
		end

	is_funcflag_fdisplaybind (flag: INTEGER): BOOLEAN is
			-- Is flag fdisplaybind?
		do
			Result := binary_and (flag, Funcflag_fdisplaybind) = Funcflag_fdisplaybind
		end

	is_funcflag_fdefaultbind (flag: INTEGER): BOOLEAN is
			-- Is flag fdefaultbind?
		do
			Result := binary_and (flag, Funcflag_fdefaultbind) = Funcflag_fdefaultbind
		end

	is_funcflag_fhidden (flag: INTEGER): BOOLEAN is
			-- Is flag fhidden?
		do
			Result := binary_and (flag, Funcflag_fhidden) = Funcflag_fhidden
		end

	is_funcflag_fdefaultcollelem (flag: INTEGER): BOOLEAN is
			-- Is flag fdefaultcollelem?
		do
			Result := binary_and (flag, Funcflag_fdefaultcollelem) = Funcflag_fdefaultcollelem
		end

	is_funcflag_fuidefault (flag: INTEGER): BOOLEAN is
			-- Is flag fuidefault?
		do
			Result := binary_and (flag, Funcflag_fuidefault) = Funcflag_fuidefault
		end

	is_funcflag_fnonbrowsable (flag: INTEGER): BOOLEAN is
			-- Is flag fnonbrowsable?
		do
			Result := binary_and (flag, Funcflag_fnonbrowsable) = Funcflag_fnonbrowsable
		end

	is_funcflag_freplaceable (flag: INTEGER): BOOLEAN is
			-- Is flag freplaceable?
		do
			Result := binary_and (flag, Funcflag_freplaceable) = Funcflag_freplaceable
		end

	is_funcflag_fimmediatebind (flag: INTEGER): BOOLEAN is
			-- Is flag fimmediatebind?
		do
			Result := binary_and (flag, Funcflag_fimmediatebind) = Funcflag_fimmediatebind
		end


	is_valid_funcflag (flag: INTEGER): BOOLEAN is
			-- Is `flag' a valid combination of funcflags?
		do
			Result := is_funcflag_frestricted (flag) or
					is_funcflag_fsource (flag) or
					is_funcflag_fbindable (flag) or
					is_funcflag_frequestedit (flag) or
					is_funcflag_fdisplaybind (flag) or
					is_funcflag_fdefaultbind (flag) or
					is_funcflag_fhidden (flag) or
					is_funcflag_fdefaultcollelem (flag) or
					is_funcflag_fuidefault (flag) or
					is_funcflag_fnonbrowsable (flag) or
					is_funcflag_freplaceable (flag) or
					is_funcflag_fimmediatebind (flag)
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
end -- class ECOM_FUNC_FLAGS

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

