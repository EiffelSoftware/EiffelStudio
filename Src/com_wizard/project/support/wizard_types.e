indexing
	description: "Type names"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_TYPES
	
feature -- Eiffel types

	Arguments_type: STRING is "ARGUMENTS"

	Integer_type: STRING is "INTEGER"

	Internal_type: STRING is "INTERNAL"

	Void_type: STRING is "Void"

	Character_type: STRING is "CHARACTER"

	Real_type: STRING is "REAL"

	Double_type: STRING is "DOUBLE"

	Boolean_type: STRING is "BOOLEAN"

	Date_time: STRING is "DATE_TIME"

	Ecom_hresult: STRING is "ECOM_HRESULT"

	Ecom_variant: STRING is "ECOM_VARIANT"

	Ecom_currency: STRING is "ECOM_CURRENCY"

	Ecom_decimal: STRING is "ECOM_DECIMAL"

	Ecom_interface: STRING  is "ECOM_INTERFACE"

	Ecom_unknown_interface: STRING  is "ECOM_UNKNOWN_INTERFACE"

	Ecom_automation_interface: STRING is "ECOM_AUTOMATION_INTERFACE"

	String_type: STRING is "STRING"

	Ecom_large_integer: STRING is "ECOM_LARGE_INTEGER"

	Ecom_ularge_integer: STRING is "ECOM_ULARGE_INTEGER"

	Any_type: STRING is "ANY"

	Pointer_type: STRING is "POINTER"

	Exceptions_type: STRING is "EXCEPTIONS"

	Wrapper_type: STRING is "ECOM_WRAPPER"

	Queriable_type: STRING is "ECOM_QUERIABLE"

	Wel_string_type: STRING is "WEL_STRING"

	Ecom_wide_string_type: STRING is "ECOM_WIDE_STRING"

	Error_handler_type: STRING is "ECOM_ERROR_HANDLER"

	ecom_excep_info_type: STRING is "ECOM_EXCEP_INFO"

	Character_ref_type: STRING is "CHARACTER_REF"

	Integer_ref_type: STRING is "INTEGER_REF"

	Real_ref_type: STRING is "REAL_REF"

	Double_ref_type: STRING is "DOUBLE_REF"

	Boolean_ref_type: STRING is "BOOLEAN_REF"

	Array_type: STRING is "ARRAY"

	Ecom_array_type: STRING is "ECOM_ARRAY"

	Cell_type: STRING is "CELL"

	Alias_type: STRING is "ALIAS"

	Ecom_structure: STRING is "ECOM_STRUCTURE"

	Cell_pointer: STRING is "CELL [POINTER]"

feature -- COM/C types

	Ulong_type: STRING is "ULONG"

	Bool: STRING is "BOOL"

	Excepinfo: STRING is "EXCEPINFO"

	Lpwstr: STRING is "LPWSTR"

	Lpstr: STRING is "LPSTR"

	Iunknown_type: STRING is "IUnknown"

	Idispatch_type: STRING is "IDispatch"

	Variant_bool: STRING is "VARIANT_BOOL"

	Variant_bool_pointer: STRING is "VARIANT_BOOL *"

	Date_c_keyword, Com_date_type: STRING is "DATE"

	Hresult: STRING is "HRESULT"

	Type_info: STRING is "ITypeInfo *"

	Variant_c_keyword: STRING is "VARIANT"

	Currency, Com_currency_type: STRING is "CURRENCY"

	Decimal, Com_decimal_type: STRING is "DECIMAL"

	Idispatch: STRING is "IDispatch *"

	Iunknown: STRING is "IUnknown *"

	Bstr: STRING is "BSTR"

	Com_char_type: STRING is "CHAR"

	Uchar_type: STRING is "UCHAR"

	Com_character_pointer: STRING is "CHAR *"

	Olechar: STRING is "OLECHAR"

	Large_integer: STRING is "LARGE_INTEGER"

	Ularge_integer: STRING is "ULARGE_INTEGER"

	Safearray: STRING is "SAFEARRAY"

	Com_safearray_type: STRING is "SAFEARRAY *"

	Variantarg: STRING is "VARIANTARG"

	Clsid_type: STRING is "CLSID"

	Libid_type: STRING is "LIBID"

	Iid_type: STRING is "IID"

	Dword: STRING is "DWORD"

	Long_macro: STRING is "LONG"

	C_void_pointer: STRING is "void *"

	Void_c_keyword: STRING is "void"

	Char: STRING is "char"

	Short: STRING is "short"

	Com_short_type: STRING is "SHORT"

	Ushort_type: STRING is "USHORT"

	Long: STRING is "long"

	Unsigned_char: STRING is "unsigned char"

	Unsigned_short: STRING is "unsigned short"

	Unsigned_long: STRING is "unsigned long"

	Float: STRING is "float"

	Com_float_type: STRING is "FLOAT"

	Com_float_pointer: STRING is "FLOAT *"

	Double_c_keyword: STRING is "double"

	Unsigned_int: STRING is "unsigned int"

	Uint_type: STRING is "UINT"

	Com_integer_type: STRING is "INT"

	Com_integer_pointer: STRING is "INT *"

	Carray: STRING is "CARRAY"

	Com_double_pointer: STRING is "DOUBLE *"

feature -- Cecil types

	Eif_integer: STRING is "EIF_INTEGER"

	Eif_character: STRING is "EIF_CHARACTER"

	Eif_boolean: STRING is "EIF_BOOLEAN"

	Eif_pointer: STRING is "EIF_POINTER"

	Eif_real: STRING is "EIF_REAL"

	Eif_double: STRING is "EIF_DOUBLE"

	Eif_reference: STRING is "EIF_REFERENCE"

	Eif_object: STRING is "EIF_OBJECT"

	Eif_procedure: STRING is "EIF_PROCEDURE"

	Eif_character_function: STRING is "EIF_CHARACTER_FUNCTION"

	Eif_reference_function: STRING is "EIF_REFERENCE_FUNCTION"

	Eif_pointer_function: STRING is "EIF_POINTER_FUNCTION"

	Eif_integer_function: STRING is "EIF_INTEGER_FUNCTION"

	Eif_real_function: STRING is "EIF_REAL_FUNCTION"

	Eif_double_function: STRING is "EIF_DOUBLE_FUNCTION"

	Eif_boolean_function: STRING is "EIF_BOOLEAN_FUNCTION"

	Eif_type_id: STRING is "EIF_TYPE_ID"

end -- class WIZARD_TYPES
