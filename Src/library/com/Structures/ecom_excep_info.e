indexing
	description: "Encapsulation of EXEPTINFO structure"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_EXCEP_INFO

inherit
	ECOM_STRUCTURE

creation
	make,
	make_from_pointer

feature {NONE} -- Initialization

	make_from_pointer (a_pointer: POINTER) is
			-- Make from pointer.
		do
			make_by_pointer (a_pointer)
		end

feature -- Access

	w_code: INTEGER is
			-- No description available.
		do
			Result := ccom_excepinfo_w_code (item)
		end

	w_reserved: INTEGER is
			-- No description available.
		do
			Result := ccom_excepinfo_w_reserved (item)
		end

	bstr_source: STRING is
			-- No description available.
		do
			Result := ccom_excepinfo_bstr_source (item)
		ensure
			non_void_bstr_source: Result /= Void
		end

	bstr_description: STRING is
			-- No description available.
		do
			Result := ccom_excepinfo_bstr_description (item)
		ensure
			non_void_bstr_description: Result /= Void
		end

	bstr_help_file: STRING is
			-- No description available.
		do
			Result := ccom_excepinfo_bstr_help_file (item)
		ensure
			non_void_bstr_help_file: Result /= Void
		end

	dw_help_context: INTEGER is
			-- No description available.
		do
			Result := ccom_excepinfo_dw_help_context (item)
		end

	pv_reserved: POINTER is
			-- No description available.
		do
			Result := ccom_excepinfo_pv_reserved (item)
		end

	scode: ECOM_HRESULT is
			-- No description available.
		do
			Result := ccom_excepinfo_scode (item)
		ensure
			non_void_scode: Result /= Void
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of EXCEPINFO structure
		do
			Result := c_size_of_excep_info
		end

feature -- Basic Operations

	set_w_code (a_w_code: INTEGER) is
			-- Set `w_code' with `a_w_code'.
		do
			ccom_excepinfo_set_w_code (item, a_w_code)
		end

	set_w_reserved (a_w_reserved: INTEGER) is
			-- Set `w_reserved' with `a_w_reserved'.
		do
			ccom_excepinfo_set_w_reserved (item, a_w_reserved)
		end

	set_bstr_source (a_bstr_source: STRING) is
			-- Set `bstr_source' with `a_bstr_source'.
		do
			ccom_excepinfo_set_bstr_source (item, a_bstr_source)
		end

	set_bstr_description (a_bstr_description: STRING) is
			-- Set `bstr_description' with `a_bstr_description'.
		do
			ccom_excepinfo_set_bstr_description (item, a_bstr_description)
		end

	set_bstr_help_file (a_bstr_help_file: STRING) is
			-- Set `bstr_help_file' with `a_bstr_help_file'.
		do
			ccom_excepinfo_set_bstr_help_file (item, a_bstr_help_file)
		end

	set_dw_help_context (a_dw_help_context: INTEGER) is
			-- Set `dw_help_context' with `a_dw_help_context'.
		do
			ccom_excepinfo_set_dw_help_context (item, a_dw_help_context)
		end

	set_pv_reserved (a_pv_reserved: POINTER) is
			-- Set `pv_reserved' with `a_pv_reserved'.
		do
			ccom_excepinfo_set_pv_reserved (item, a_pv_reserved)
		end

	set_scode (a_scode: ECOM_HRESULT) is
			-- Set `scode' with `a_scode'.
		require
			non_void_a_scode: a_scode /= Void
		do
			ccom_excepinfo_set_scode (item, a_scode)
		end

feature {NONE} -- Externals

	c_size_of_excep_info: INTEGER is
			-- Size of structure
		external
			"C [macro %"ecom_EXCEPINFO.h%"]"
		alias
			"sizeof(EXCEPINFO)"
		end

	ccom_excepinfo_w_code (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_EXCEPINFO.h%"](EXCEPINFO *):EIF_INTEGER"
		end

	ccom_excepinfo_set_w_code (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_EXCEPINFO.h%"](EXCEPINFO *, USHORT)"
		end

	ccom_excepinfo_w_reserved (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_EXCEPINFO.h%"](EXCEPINFO *):EIF_INTEGER"
		end

	ccom_excepinfo_set_w_reserved (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_EXCEPINFO.h%"](EXCEPINFO *, USHORT)"
		end

	ccom_excepinfo_bstr_source (a_pointer: POINTER): STRING is
			-- No description available.
		external
			"C++ [macro %"ecom_EXCEPINFO.h%"](EXCEPINFO *):EIF_REFERENCE"
		end

	ccom_excepinfo_set_bstr_source (a_pointer: POINTER; arg2: STRING) is
			-- No description available.
		external
			"C++ [macro %"ecom_EXCEPINFO.h%"](EXCEPINFO *, EIF_OBJECT)"
		end

	ccom_excepinfo_bstr_description (a_pointer: POINTER): STRING is
			-- No description available.
		external
			"C++ [macro %"ecom_EXCEPINFO.h%"](EXCEPINFO *):EIF_REFERENCE"
		end

	ccom_excepinfo_set_bstr_description (a_pointer: POINTER; arg2: STRING) is
			-- No description available.
		external
			"C++ [macro %"ecom_EXCEPINFO.h%"](EXCEPINFO *, EIF_OBJECT)"
		end

	ccom_excepinfo_bstr_help_file (a_pointer: POINTER): STRING is
			-- No description available.
		external
			"C++ [macro %"ecom_EXCEPINFO.h%"](EXCEPINFO *):EIF_REFERENCE"
		end

	ccom_excepinfo_set_bstr_help_file (a_pointer: POINTER; arg2: STRING) is
			-- No description available.
		external
			"C++ [macro %"ecom_EXCEPINFO.h%"](EXCEPINFO *, EIF_OBJECT)"
		end

	ccom_excepinfo_dw_help_context (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_EXCEPINFO.h%"](EXCEPINFO *):EIF_INTEGER"
		end

	ccom_excepinfo_set_dw_help_context (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_EXCEPINFO.h%"](EXCEPINFO *, ULONG)"
		end

	ccom_excepinfo_pv_reserved (a_pointer: POINTER): POINTER is
			-- No description available.
		external
			"C++ [macro %"ecom_EXCEPINFO.h%"](EXCEPINFO *):EIF_POINTER"
		end

	ccom_excepinfo_set_pv_reserved (a_pointer: POINTER; arg2: POINTER) is
			-- No description available.
		external
			"C++ [macro %"ecom_EXCEPINFO.h%"](EXCEPINFO *, void *)"
		end

	ccom_excepinfo_scode (a_pointer: POINTER): ECOM_HRESULT is
			-- No description available.
		external
			"C++ [macro %"ecom_EXCEPINFO.h%"](EXCEPINFO *):EIF_REFERENCE"
		end

	ccom_excepinfo_set_scode (a_pointer: POINTER; arg2: ECOM_HRESULT) is
			-- No description available.
		external
			"C++ [macro %"ecom_EXCEPINFO.h%"](EXCEPINFO *, EIF_OBJECT)"
		end
		
end -- class ECOM_EXCEP_INFO

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

