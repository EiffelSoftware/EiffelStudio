indexing

	description: "TYPEFLAGS flags"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_TYPE_FLAGS

inherit
	EOLE_FLAGS
	
feature -- Access

	Typeflag_fappobject: INTEGER is
			-- Type description that describes Application object
		external
			"C [macro %"oleflags.h%"]"
		alias
			"TYPEFLAG_FAPPOBJECT"
		end

	Typeflag_fcancreate: INTEGER is
			-- Instances of type can be created by ITypeInfo::CreateInstance
		external
			"C [macro %"oleflags.h%"]"
		alias
			"TYPEFLAG_FCANCREATE"
		end

	Typeflag_flicensed: INTEGER is
			-- Type is licensed
		external
			"C [macro %"oleflags.h%"]"
		alias
			"TYPEFLAG_FLICENSED"
		end
			
	Typeflag_fpredeclid: INTEGER is
			-- Type is predefined
		external
			"C [macro %"oleflags.h%"]"
		alias
			"TYPEFLAG_FPREDECLID"
		end

	Typeflag_fhidden: INTEGER is
			-- Type should not be displayed to browsers
		external
			"C [macro %"oleflags.h%"]"
		alias
			"TYPEFLAG_FHIDDEN"
		end
		
	Typeflag_fcontrol: INTEGER is
			-- Type is a control from which other types will be derived, 
			-- and should not be displayed to users
		external
			"C [macro %"oleflags.h%"]"
		alias
			"TYPEFLAG_FCONTROL"
		end
			
	Typeflag_fdual: INTEGER is
			-- Types in interface derive from IDispatch and are 
			-- fully compatible with Automation
		external
			"C [macro %"oleflags.h%"]"
		alias
			"TYPEFLAG_FDUAL"
		end
	
	Typeflag_fnonextensible: INTEGER is
			-- Interface cannot add members at run time
		external
			"C [macro %"oleflags.h%"]"
		alias
			"TYPEFLAG_FNONEXTENSIBLE"
		end
			
	Typeflag_foleautomation: INTEGER is
			-- Types used in interface are fully compatible with Automation,
			-- mand may be displayed in an object browser
		external
			"C [macro %"oleflags.h%"]"
		alias
			"TYPEFLAG_FOLEAUTOMATION"
		end
			
	Typeflag_frestricted: INTEGER is
			-- Should not be accessible from macro languages
		external
			"C [macro %"oleflags.h%"]"
		alias
			"TYPEFLAG_FRESTRICTED"
		end
	
	Typeflag_faggregatable: INTEGER is
			-- Class supports aggregation
		external
			"C [macro %"oleflags.h%"]"
		alias
			"TYPEFLAG_FAGGREGATABLE"
		end
			
	Typeflag_freplaceable: INTEGER is
			-- Object supports IConnectionPointWithDefault,
			-- and has default behaviors
		external
			"C [macro %"oleflags.h%"]"
		alias
			"TYPEFLAG_FREPLACEABLE"
		end
	
	Typeflag_fdispatchable: INTEGER is
			-- Interface derives from IDispatch
		external
			"C [macro %"oleflags.h%"]"
		alias
			"TYPEFLAG_FDISPATCHABLE"
		end

	is_valid_typeflag (flag: INTEGER): BOOLEAN is
			-- Is `flag' a valid combination of typeflags?
		do
			Result := c_and (Typeflag_fappobject + Typeflag_fcancreate
						+ Typeflag_flicensed + Typeflag_fpredeclid
						+ Typeflag_fhidden + Typeflag_fcontrol
						+ Typeflag_fdual + Typeflag_fnonextensible
						+ Typeflag_foleautomation + Typeflag_frestricted
						+ Typeflag_faggregatable + Typeflag_freplaceable
						+ Typeflag_fdispatchable, flag)
						= Typeflag_fappobject + Typeflag_fcancreate
						+ Typeflag_flicensed + Typeflag_fpredeclid
						+ Typeflag_fhidden + Typeflag_fcontrol
						+ Typeflag_fdual + Typeflag_fnonextensible
						+ Typeflag_foleautomation + Typeflag_frestricted
						+ Typeflag_faggregatable + Typeflag_freplaceable
						+ Typeflag_fdispatchable
		end

end -- class EOLE_TYPEFLAGS

--|-------------------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license.
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1997.
--| Modifications and extensions: copyright (C) ISE, 1997. 
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
