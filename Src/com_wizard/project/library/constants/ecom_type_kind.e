indexing
	description: "COM TYPEKIND constants"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	ECOM_TYPE_KIND

feature 

	Tkind_enum: INTEGER is
			-- Set of enumerators
		external
			"C [macro <oaidl.h>]"
		alias
			"TKIND_ENUM"
		end
		
	Tkind_record: INTEGER is
			-- Struct with no methods.
		external
			"C [macro <oaidl.h>]"
		alias
			"TKIND_RECORD"
		end

	Tkind_module: INTEGER is
			-- Module which can only have static functions and data
		external
			"C [macro <oaidl.h>]"
		alias
			"TKIND_MODULE"
		end

	Tkind_interface: INTEGER is
			-- Type that has virtual functions, all of which are pure.
		external
			"C [macro <oaidl.h>]"
		alias
			"TKIND_INTERFACE"
		end

	Tkind_dispatch: INTEGER is
			-- Set of methods and properties that are accessible
			-- via IDispatch::Invoke.
		external
			"C [macro <oaidl.h>]"
		alias
			"TKIND_DISPATCH"
		end

	Tkind_coclass: INTEGER is
			-- Set of implemented component object interfaces.
		external
			"C [macro <oaidl.h>]"
		alias
			"TKIND_COCLASS"
		end

	Tkind_alias: INTEGER is
			-- Type that is an alias for another type.
		external
			"C [macro <oaidl.h>]"
		alias
			"TKIND_ALIAS"
		end

	Tkind_union: INTEGER is
			-- Union, all of whose members have offset zero.
		external
			"C [macro <oaidl.h>]"
		alias
			"TKIND_UNION"
		end

	Tkind_max: INTEGER is
			-- End marker
		external
			"C [macro <oaidl.h>]"
		alias
			"TKIND_MAX"
		end

	is_valid_type_kind (kind: INTEGER): BOOLEAN is
			-- Is `kind' a valid type kind?
		do
			Result := kind = Tkind_enum or
			kind = Tkind_record or
			kind = Tkind_module or
			kind = Tkind_interface or
			kind = Tkind_dispatch or
			kind = Tkind_coclass or
			kind = Tkind_alias or
			kind = Tkind_union or
			kind = Tkind_max
		end
		
end -- class ECOM_TYPE_KIND

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

