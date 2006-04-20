indexing
	description: "TYPEFLAGS flags"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ECOM_TYPE_FLAGS

inherit
	ECOM_FLAGS
	
feature -- Access

	Typeflag_fappobject: INTEGER is
			-- Type description that describes Application object
		external
			"C [macro <oaidl.h>]"
		alias
			"TYPEFLAG_FAPPOBJECT"
		end

	Typeflag_fcancreate: INTEGER is
			-- Instances of type can be created by ITypeInfo::CreateInstance
		external
			"C [macro <oaidl.h>]"
		alias
			"TYPEFLAG_FCANCREATE"
		end

	Typeflag_flicensed: INTEGER is
			-- Type is licensed
		external
			"C [macro <oaidl.h>]"
		alias
			"TYPEFLAG_FLICENSED"
		end
			
	Typeflag_fpredeclid: INTEGER is
			-- Type is predefined
		external
			"C [macro <oaidl.h>]"
		alias
			"TYPEFLAG_FPREDECLID"
		end

	Typeflag_fhidden: INTEGER is
			-- Type should not be displayed to browsers
		external
			"C [macro <oaidl.h>]"
		alias
			"TYPEFLAG_FHIDDEN"
		end
		
	Typeflag_fcontrol: INTEGER is
			-- Type is a control from which other types will be derived, 
			-- and should not be displayed to users
		external
			"C [macro <oaidl.h>]"
		alias
			"TYPEFLAG_FCONTROL"
		end
			
	Typeflag_fdual: INTEGER is
			-- Types in interface derive from IDispatch and are 
			-- fully compatible with Automation
		external
			"C [macro <oaidl.h>]"
		alias
			"TYPEFLAG_FDUAL"
		end
	
	Typeflag_fnonextensible: INTEGER is
			-- Interface cannot add members at run time
		external
			"C [macro <oaidl.h>]"
		alias
			"TYPEFLAG_FNONEXTENSIBLE"
		end
			
	Typeflag_foleautomation: INTEGER is
			-- Types used in interface are fully compatible with Automation,
			-- mand may be displayed in an object browser
		external
			"C [macro <oaidl.h>]"
		alias
			"TYPEFLAG_FOLEAUTOMATION"
		end
			
	Typeflag_frestricted: INTEGER is
			-- Should not be accessible from macro languages
		external
			"C [macro <oaidl.h>]"
		alias
			"TYPEFLAG_FRESTRICTED"
		end
	
	Typeflag_faggregatable: INTEGER is
			-- Class supports aggregation
		external
			"C [macro <oaidl.h>]"
		alias
			"TYPEFLAG_FAGGREGATABLE"
		end
			
	Typeflag_freplaceable: INTEGER is
			-- Object supports IConnectionPointWithDefault,
			-- and has default behaviors
		external
			"C [macro <oaidl.h>]"
		alias
			"TYPEFLAG_FREPLACEABLE"
		end
	
	Typeflag_fdispatchable: INTEGER is
			-- Interface derives from IDispatch
		external
			"C [macro <oaidl.h>]"
		alias
			"TYPEFLAG_FDISPATCHABLE"
		end

	Typeflag_freversebind: INTEGER is
			-- Reversebind
		external
			"C [macro <oaidl.h>]"
		alias
			"TYPEFLAG_FREVERSEBIND"
		end

feature -- Status report

	is_typeflag_fappobject (flag: INTEGER): BOOLEAN is
			-- Is Application object?
		do
			Result := binary_and (flag, Typeflag_fappobject) = Typeflag_fappobject
		end

	is_typeflag_fcancreate (flag: INTEGER): BOOLEAN is
			--Can instances of type be created by ITypeInfo::CreateInstance?
		do
			Result := binary_and (flag, Typeflag_fcancreate) = Typeflag_fcancreate
		end

	is_typeflag_flicensed (flag: INTEGER): BOOLEAN is
			-- Is type licensed?
		do
			Result := binary_and (flag, Typeflag_flicensed) = Typeflag_flicensed
		end

	is_typeflag_fpredeclid (flag: INTEGER): BOOLEAN is
			-- Is type predefined?
		do
			Result := binary_and (flag, Typeflag_fpredeclid) = Typeflag_fpredeclid
		end

	is_typeflag_fhidden (flag: INTEGER): BOOLEAN is
			-- Is type hidden?
		do
			Result := binary_and (flag, Typeflag_fhidden) = Typeflag_fhidden
		end

	is_typeflag_fcontrol (flag: INTEGER): BOOLEAN is
			-- Is type control?
		do
			Result := binary_and (flag, Typeflag_fcontrol) = Typeflag_fcontrol
		end

	is_typeflag_fdual (flag: INTEGER): BOOLEAN is
			-- Is interface dual?
		do
			Result := binary_and (flag, Typeflag_fdual) = Typeflag_fdual
		end

	is_typeflag_fnonextensible (flag: INTEGER): BOOLEAN is
			-- Is interface nonextensible?
		do
			Result := binary_and (flag, Typeflag_fnonextensible) = Typeflag_fnonextensible
		end

	is_typeflag_foleautomation (flag: INTEGER): BOOLEAN is
			-- Is type automation type?
		do
			Result := binary_and (flag, Typeflag_foleautomation) = Typeflag_foleautomation
		end

	is_typeflag_frestricted (flag: INTEGER): BOOLEAN is
			-- Is type restricted?
		do
			Result := binary_and (flag, Typeflag_frestricted) = Typeflag_frestricted
		end

	is_typeflag_faggregatable (flag: INTEGER): BOOLEAN is
			-- Does class support aggregation?
		do
			Result := binary_and (flag, Typeflag_faggregatable) = Typeflag_faggregatable
		end

	is_typeflag_freplaceable (flag: INTEGER): BOOLEAN is
			-- Does object support IConnectionPointWithDefault?
		do
			Result := binary_and (flag, Typeflag_freplaceable) = Typeflag_freplaceable
		end

	is_typeflag_fdispatchable (flag: INTEGER): BOOLEAN is
			-- Does interface derive from IDispatch?
		do
			Result := binary_and (flag, Typeflag_fdispatchable) = Typeflag_fdispatchable
		end

	is_typeflag_freversebind (flag: INTEGER): BOOLEAN is
			-- Is reversebind?
		do
			Result := binary_and (flag, Typeflag_freversebind) = Typeflag_freversebind
		end

	is_valid_typeflag (flag: INTEGER): BOOLEAN is
			-- Is `flag' a valid combination of typeflags?
		do
			Result := is_typeflag_fappobject (flag) or
					is_typeflag_fcancreate (flag) or
					is_typeflag_flicensed (flag) or
					is_typeflag_fpredeclid (flag) or
					is_typeflag_fhidden (flag) or
					is_typeflag_fcontrol (flag) or
					is_typeflag_fdual (flag) or
					is_typeflag_fnonextensible (flag) or
					is_typeflag_foleautomation (flag) or
					is_typeflag_frestricted (flag) or
					is_typeflag_faggregatable (flag) or
					is_typeflag_freplaceable (flag) or
					is_typeflag_fdispatchable (flag) or
					is_typeflag_freversebind (flag) or
					flag = 0
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
end -- class ECOM_TYPE_FLAGS

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

