note
	description: "Encapsulation of EXEPTINFO structure"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_EXCEP_INFO

inherit
	ECOM_STRUCTURE

create
	make,
	make_from_pointer

feature {NONE} -- Initialization

	make_from_pointer (a_pointer: POINTER)
			-- Make from pointer.
		do
			make_by_pointer (a_pointer)
		end

feature -- Access

	w_code: INTEGER
			-- No description available.
		do
			Result := ccom_excepinfo_w_code (item)
		end

	w_reserved: INTEGER
			-- No description available.
		do
			Result := ccom_excepinfo_w_reserved (item)
		end

	bstr_source: STRING
			-- No description available.
		do
			Result := ccom_excepinfo_bstr_source (item)
		ensure
			non_void_bstr_source: Result /= Void
		end

	bstr_description: STRING
			-- No description available.
		do
			Result := ccom_excepinfo_bstr_description (item)
		ensure
			non_void_bstr_description: Result /= Void
		end

	bstr_help_file: STRING
			-- No description available.
		do
			Result := ccom_excepinfo_bstr_help_file (item)
		ensure
			non_void_bstr_help_file: Result /= Void
		end

	dw_help_context: INTEGER
			-- No description available.
		do
			Result := ccom_excepinfo_dw_help_context (item)
		end

	pv_reserved: POINTER
			-- No description available.
		do
			Result := ccom_excepinfo_pv_reserved (item)
		end

	scode: ECOM_HRESULT
			-- No description available.
		do
			Result := ccom_excepinfo_scode (item)
		ensure
			non_void_scode: Result /= Void
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size of EXCEPINFO structure
		do
			Result := c_size_of_excep_info
		end

feature -- Basic Operations

	set_w_code (a_w_code: INTEGER)
			-- Set `w_code' with `a_w_code'.
		do
			ccom_excepinfo_set_w_code (item, a_w_code)
		end

	set_w_reserved (a_w_reserved: INTEGER)
			-- Set `w_reserved' with `a_w_reserved'.
		do
			ccom_excepinfo_set_w_reserved (item, a_w_reserved)
		end

	set_bstr_source (a_bstr_source: STRING)
			-- Set `bstr_source' with `a_bstr_source'.
		do
			ccom_excepinfo_set_bstr_source (item, a_bstr_source)
		end

	set_bstr_description (a_bstr_description: STRING)
			-- Set `bstr_description' with `a_bstr_description'.
		do
			ccom_excepinfo_set_bstr_description (item, a_bstr_description)
		end

	set_bstr_help_file (a_bstr_help_file: STRING)
			-- Set `bstr_help_file' with `a_bstr_help_file'.
		do
			ccom_excepinfo_set_bstr_help_file (item, a_bstr_help_file)
		end

	set_dw_help_context (a_dw_help_context: INTEGER)
			-- Set `dw_help_context' with `a_dw_help_context'.
		do
			ccom_excepinfo_set_dw_help_context (item, a_dw_help_context)
		end

	set_pv_reserved (a_pv_reserved: POINTER)
			-- Set `pv_reserved' with `a_pv_reserved'.
		do
			ccom_excepinfo_set_pv_reserved (item, a_pv_reserved)
		end

	set_scode (a_scode: ECOM_HRESULT)
			-- Set `scode' with `a_scode'.
		require
			non_void_a_scode: a_scode /= Void
		do
			ccom_excepinfo_set_scode (item, a_scode)
		end

feature {NONE} -- Externals

	c_size_of_excep_info: INTEGER
			-- Size of structure
		external
			"C [macro %"ecom_EXCEPINFO.h%"]"
		alias
			"sizeof(EXCEPINFO)"
		end

	ccom_excepinfo_w_code (a_pointer: POINTER): INTEGER
			-- No description available.
		external
			"C++ [macro %"ecom_EXCEPINFO.h%"](EXCEPINFO *):EIF_INTEGER"
		end

	ccom_excepinfo_set_w_code (a_pointer: POINTER; arg2: INTEGER)
			-- No description available.
		external
			"C++ [macro %"ecom_EXCEPINFO.h%"](EXCEPINFO *, USHORT)"
		end

	ccom_excepinfo_w_reserved (a_pointer: POINTER): INTEGER
			-- No description available.
		external
			"C++ [macro %"ecom_EXCEPINFO.h%"](EXCEPINFO *):EIF_INTEGER"
		end

	ccom_excepinfo_set_w_reserved (a_pointer: POINTER; arg2: INTEGER)
			-- No description available.
		external
			"C++ [macro %"ecom_EXCEPINFO.h%"](EXCEPINFO *, USHORT)"
		end

	ccom_excepinfo_bstr_source (a_pointer: POINTER): STRING
			-- No description available.
		external
			"C++ [macro %"ecom_EXCEPINFO.h%"](EXCEPINFO *):EIF_REFERENCE"
		end

	ccom_excepinfo_set_bstr_source (a_pointer: POINTER; arg2: STRING)
			-- No description available.
		external
			"C++ [macro %"ecom_EXCEPINFO.h%"](EXCEPINFO *, EIF_OBJECT)"
		end

	ccom_excepinfo_bstr_description (a_pointer: POINTER): STRING
			-- No description available.
		external
			"C++ [macro %"ecom_EXCEPINFO.h%"](EXCEPINFO *):EIF_REFERENCE"
		end

	ccom_excepinfo_set_bstr_description (a_pointer: POINTER; arg2: STRING)
			-- No description available.
		external
			"C++ [macro %"ecom_EXCEPINFO.h%"](EXCEPINFO *, EIF_OBJECT)"
		end

	ccom_excepinfo_bstr_help_file (a_pointer: POINTER): STRING
			-- No description available.
		external
			"C++ [macro %"ecom_EXCEPINFO.h%"](EXCEPINFO *):EIF_REFERENCE"
		end

	ccom_excepinfo_set_bstr_help_file (a_pointer: POINTER; arg2: STRING)
			-- No description available.
		external
			"C++ [macro %"ecom_EXCEPINFO.h%"](EXCEPINFO *, EIF_OBJECT)"
		end

	ccom_excepinfo_dw_help_context (a_pointer: POINTER): INTEGER
			-- No description available.
		external
			"C++ [macro %"ecom_EXCEPINFO.h%"](EXCEPINFO *):EIF_INTEGER"
		end

	ccom_excepinfo_set_dw_help_context (a_pointer: POINTER; arg2: INTEGER)
			-- No description available.
		external
			"C++ [macro %"ecom_EXCEPINFO.h%"](EXCEPINFO *, ULONG)"
		end

	ccom_excepinfo_pv_reserved (a_pointer: POINTER): POINTER
			-- No description available.
		external
			"C++ [macro %"ecom_EXCEPINFO.h%"](EXCEPINFO *):EIF_POINTER"
		end

	ccom_excepinfo_set_pv_reserved (a_pointer: POINTER; arg2: POINTER)
			-- No description available.
		external
			"C++ [macro %"ecom_EXCEPINFO.h%"](EXCEPINFO *, void *)"
		end

	ccom_excepinfo_scode (a_pointer: POINTER): ECOM_HRESULT
			-- No description available.
		external
			"C++ [macro %"ecom_EXCEPINFO.h%"](EXCEPINFO *):EIF_REFERENCE"
		end

	ccom_excepinfo_set_scode (a_pointer: POINTER; arg2: ECOM_HRESULT)
			-- No description available.
		external
			"C++ [macro %"ecom_EXCEPINFO.h%"](EXCEPINFO *, EIF_OBJECT)"
		end
		
note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class ECOM_EXCEP_INFO

