indexing

	description: "VARTYPE constants"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EOLE_VARTYPE

feature -- Access

	Vt_empty: INTEGER is
			-- Not specified
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_EMPTY"
		end
		
	Vt_null: INTEGER is
			-- Null
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_NULL"
		end
		
	Vt_i1: INTEGER is
			-- 1-byte signed integer
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_I1"
		end
		
	Vt_i2: INTEGER is
			-- 2-byte signed integer
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_I2"
		end
		
	Vt_i4: INTEGER is
			-- 4-byte signed integer
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_I4"
		end
		
	Vt_i8: INTEGER is
			-- 8-byte sgned integer
			-- may appear in TYPEDESC only
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_I8"
		end
		
	Vt_ui1: INTEGER is
			-- Unsigned character
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_UI1"
		end
		
	Vt_ui2: INTEGER is
			-- 2-bytes unsigned integer
			-- may appear in TYPEDESC only
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_UI2"
		end
		
	Vt_ui4: INTEGER is
			-- 4-bytes unsigned integer
			-- may appear in TYPEDESC only
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_UI4"
		end
		
	Vt_ui8: INTEGER is
			-- 8-bytes unsigned integer
			-- may appear in TYPEDESC only
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_UI8"
		end
		
	Vt_r4: INTEGER is
			-- 4-byte real
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_R4"
		end
		
	Vt_r8: INTEGER is
			-- 8-byte real
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_R8"
		end
		
	Vt_cy: INTEGER is
			-- Currency
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_CY"
		end
		
	Vt_date: INTEGER is
			-- Date
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_DATE"
		end
		
	Vt_bstr: INTEGER is
			-- Binary string
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_BSTR"
		end
		
	Vt_dispatch: INTEGER is
			-- IDispatch*
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_DISPATCH"
		end
		
	Vt_error: INTEGER is
			-- SCODE
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_ERROR"
		end
		
	Vt_bool: INTEGER is
			-- Boolean: True = -1 False = 0
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_BOOL"
		end
		
	Vt_variant: INTEGER is
			-- VARIANT*
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_VARIANT"
		end
		
	Vt_unknown: INTEGER is
			-- IUnknown*
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_UNKNOWN"
		end
		
	Vt_reserved: INTEGER is
			-- Reserverd for Microsoft use
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_RESERVED"
		end

	Vt_byref: INTEGER is
			-- Pointer to data is passed
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_BYREF"
		end
		
	Vt_array: INTEGER is
			-- A Safe array of data is passed
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_ARRAY"
		end
		
	Vt_int: INTEGER is
			-- integer
			-- may appear in TYPEDESC only
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_INT"
		end
		
	Vt_uint: INTEGER is
			-- unsigned integer
			-- may appear in TYPEDESC only
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_UINT"
		end
		
	Vt_void: INTEGER is
			-- NULL
			-- may appear in TYPEDESC only
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_VOID"
		end
		
	Vt_hresult: INTEGER is
			-- HRESULT
			-- may appear in TYPEDESC only
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_HRESULT"
		end
		
	Vt_ptr: INTEGER is
			-- pointer
			-- may appear in TYPEDESC only
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_PTR"
		end
		
	Vt_safearray: INTEGER is
			-- Safearray
			-- may appear in TYPEDESC only
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_SAFEARRAY"
		end
		
	Vt_carray: INTEGER is
			-- array
			-- may appear in TYPEDESC only
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_CARRAY"
		end
		
	Vt_userdefined: INTEGER is
			-- User defined
			-- may appear in TYPEDESC only
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_USERDEFINED"
		end
		
	Vt_lpstr: INTEGER is
			-- LPSTR
			-- may appear in TYPEDESC only
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_LPSTR"
		end
		
	Vt_lpwstr: INTEGER is
			-- LPWSTR
			-- may appear in TYPEDESC only
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_LPWSTR"
		end
		
end -- class EOLE_VARTYPE

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

