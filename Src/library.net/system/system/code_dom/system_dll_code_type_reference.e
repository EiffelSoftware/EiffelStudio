indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeTypeReference"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_TYPE_REFERENCE

inherit
	SYSTEM_DLL_CODE_OBJECT

create
	make_system_dll_code_type_reference_3,
	make_system_dll_code_type_reference,
	make_system_dll_code_type_reference_2,
	make_system_dll_code_type_reference_1

feature {NONE} -- Initialization

	frozen make_system_dll_code_type_reference_3 (array_type: SYSTEM_DLL_CODE_TYPE_REFERENCE; rank: INTEGER) is
		external
			"IL creator signature (System.CodeDom.CodeTypeReference, System.Int32) use System.CodeDom.CodeTypeReference"
		end

	frozen make_system_dll_code_type_reference (type: TYPE) is
		external
			"IL creator signature (System.Type) use System.CodeDom.CodeTypeReference"
		end

	frozen make_system_dll_code_type_reference_2 (base_type: SYSTEM_STRING; rank: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32) use System.CodeDom.CodeTypeReference"
		end

	frozen make_system_dll_code_type_reference_1 (type_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeTypeReference"
		end

feature -- Access

	frozen get_base_type: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeTypeReference"
		alias
			"get_BaseType"
		end

	frozen get_array_element_type: SYSTEM_DLL_CODE_TYPE_REFERENCE is
		external
			"IL signature (): System.CodeDom.CodeTypeReference use System.CodeDom.CodeTypeReference"
		alias
			"get_ArrayElementType"
		end

	frozen get_array_rank: INTEGER is
		external
			"IL signature (): System.Int32 use System.CodeDom.CodeTypeReference"
		alias
			"get_ArrayRank"
		end

feature -- Element Change

	frozen set_array_rank (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.CodeDom.CodeTypeReference"
		alias
			"set_ArrayRank"
		end

	frozen set_base_type (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeTypeReference"
		alias
			"set_BaseType"
		end

	frozen set_array_element_type (value: SYSTEM_DLL_CODE_TYPE_REFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeTypeReference"
		alias
			"set_ArrayElementType"
		end

end -- class SYSTEM_DLL_CODE_TYPE_REFERENCE
