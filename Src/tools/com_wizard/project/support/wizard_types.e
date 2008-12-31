note
	description: "Type names"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_TYPES
	
feature -- Eiffel types

	Arguments_type: STRING = "ARGUMENTS"

	Integer_type: STRING = "INTEGER"

	Internal_type: STRING = "INTERNAL"

	Void_type: STRING = "Void"

	Character_type: STRING = "CHARACTER"

	Real_type: STRING = "REAL"

	Double_type: STRING = "DOUBLE"

	Boolean_type: STRING = "BOOLEAN"

	Date_time: STRING = "DATE_TIME"

	Ecom_hresult: STRING = "ECOM_HRESULT"

	Ecom_variant: STRING = "ECOM_VARIANT"

	Ecom_currency: STRING = "ECOM_CURRENCY"

	Ecom_decimal: STRING = "ECOM_DECIMAL"

	Ecom_interface: STRING  = "ECOM_INTERFACE"

	Ecom_unknown_interface: STRING  = "ECOM_UNKNOWN_INTERFACE"

	Ecom_automation_interface: STRING = "ECOM_AUTOMATION_INTERFACE"

	String_type: STRING = "STRING"

	Ecom_large_integer: STRING = "ECOM_LARGE_INTEGER"

	Ecom_ularge_integer: STRING = "ECOM_ULARGE_INTEGER"

	Any_type: STRING = "ANY"

	Pointer_type: STRING = "POINTER"

	Exceptions_type: STRING = "EXCEPTIONS"

	Queriable_type: STRING = "ECOM_QUERIABLE"

	Error_handler_type: STRING = "ECOM_ERROR_HANDLER"

	ecom_excep_info_type: STRING = "ECOM_EXCEP_INFO"

	Character_ref_type: STRING = "CHARACTER_REF"

	Integer_ref_type: STRING = "INTEGER_REF"

	Integer64_ref_type: STRING = "INTEGER_64_REF"

	Real_ref_type: STRING = "REAL_REF"

	Double_ref_type: STRING = "DOUBLE_REF"

	Boolean_ref_type: STRING = "BOOLEAN_REF"

	Array_type: STRING = "ARRAY"

	Ecom_array_type: STRING = "ECOM_ARRAY"

	Cell_type: STRING = "CELL"

	Alias_type: STRING = "ALIAS"

	Ecom_structure: STRING = "ECOM_STRUCTURE"

	Cell_pointer: STRING = "CELL [POINTER]"

feature -- COM/C types

	Ulong_type: STRING = "ULONG"

	Bool: STRING = "BOOL"

	Excepinfo: STRING = "EXCEPINFO"

	Lpwstr: STRING = "LPWSTR"

	Lpstr: STRING = "LPSTR"

	Iunknown_type: STRING = "IUnknown"

	Idispatch_type: STRING = "IDispatch"

	Variant_bool: STRING = "VARIANT_BOOL"

	Variant_bool_pointer: STRING = "VARIANT_BOOL *"

	Date_c_keyword, Com_date_type: STRING = "DATE"

	Hresult: STRING = "HRESULT"

	Type_info: STRING = "ITypeInfo *"

	Variant_c_keyword: STRING = "VARIANT"

	Currency, Com_currency_type: STRING = "CURRENCY"

	Decimal, Com_decimal_type: STRING = "DECIMAL"

	Idispatch: STRING = "IDispatch *"

	Iunknown: STRING = "IUnknown *"

	Bstr: STRING = "BSTR"

	Com_char_type: STRING = "CHAR"

	Uchar_type: STRING = "UCHAR"

	Com_character_pointer: STRING = "CHAR *"

	Olechar: STRING = "OLECHAR"

	Large_integer: STRING = "LONGLONG"

	Ularge_integer: STRING = "ULONGLONG"

	Safearray: STRING = "SAFEARRAY"

	Com_safearray_type: STRING = "SAFEARRAY *"

	Variantarg: STRING = "VARIANTARG"

	Clsid_type: STRING = "CLSID"

	Libid_type: STRING = "LIBID"

	Iid_type: STRING = "IID"

	Dword: STRING = "DWORD"

	Long_macro: STRING = "LONG"

	C_void_pointer: STRING = "void *"

	Void_c_keyword: STRING = "void"

	Char: STRING = "char"

	Short: STRING = "short"

	Com_short_type: STRING = "SHORT"

	Ushort_type: STRING = "USHORT"

	Long: STRING = "long"

	Unsigned_char: STRING = "unsigned char"

	Unsigned_short: STRING = "unsigned short"

	Unsigned_long: STRING = "unsigned long"

	Float: STRING = "float"

	Com_float_type: STRING = "FLOAT"

	Com_float_pointer: STRING = "FLOAT *"

	Double_c_keyword: STRING = "double"

	Unsigned_int: STRING = "unsigned int"

	Uint_type: STRING = "UINT"

	Com_integer_type: STRING = "INT"

	Com_integer_pointer: STRING = "INT *"

	Carray: STRING = "CARRAY"

	Com_double_pointer: STRING = "DOUBLE *"

feature -- Cecil types

	Eif_integer: STRING = "EIF_INTEGER"

	Eif_character: STRING = "EIF_CHARACTER"

	Eif_boolean: STRING = "EIF_BOOLEAN"

	Eif_pointer: STRING = "EIF_POINTER"

	Eif_real: STRING = "EIF_REAL"

	Eif_double: STRING = "EIF_DOUBLE"

	Eif_reference: STRING = "EIF_REFERENCE"

	Eif_object: STRING = "EIF_OBJECT"

	Eif_procedure: STRING = "EIF_PROCEDURE"

	Eif_character_function: STRING = "EIF_CHARACTER_FUNCTION"

	Eif_reference_function: STRING = "EIF_REFERENCE_FUNCTION"

	Eif_pointer_function: STRING = "EIF_POINTER_FUNCTION"

	Eif_integer_function: STRING = "EIF_INTEGER_FUNCTION"

	Eif_real_function: STRING = "EIF_REAL_FUNCTION"

	Eif_double_function: STRING = "EIF_DOUBLE_FUNCTION"

	Eif_boolean_function: STRING = "EIF_BOOLEAN_FUNCTION"

	Eif_type_id: STRING = "EIF_TYPE_ID";

note
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
end -- class WIZARD_TYPES

