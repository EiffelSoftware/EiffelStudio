indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeMemberField"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_MEMBER_FIELD

inherit
	SYSTEM_DLL_CODE_TYPE_MEMBER

create
	make_system_dll_code_member_field_2,
	make_system_dll_code_member_field_3,
	make_system_dll_code_member_field_1,
	make_system_dll_code_member_field

feature {NONE} -- Initialization

	frozen make_system_dll_code_member_field_2 (type: SYSTEM_STRING; name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.CodeDom.CodeMemberField"
		end

	frozen make_system_dll_code_member_field_3 (type: TYPE; name: SYSTEM_STRING) is
		external
			"IL creator signature (System.Type, System.String) use System.CodeDom.CodeMemberField"
		end

	frozen make_system_dll_code_member_field_1 (type: SYSTEM_DLL_CODE_TYPE_REFERENCE; name: SYSTEM_STRING) is
		external
			"IL creator signature (System.CodeDom.CodeTypeReference, System.String) use System.CodeDom.CodeMemberField"
		end

	frozen make_system_dll_code_member_field is
		external
			"IL creator use System.CodeDom.CodeMemberField"
		end

feature -- Access

	frozen get_type_code_type_reference: SYSTEM_DLL_CODE_TYPE_REFERENCE is
		external
			"IL signature (): System.CodeDom.CodeTypeReference use System.CodeDom.CodeMemberField"
		alias
			"get_Type"
		end

	frozen get_init_expression: SYSTEM_DLL_CODE_EXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeMemberField"
		alias
			"get_InitExpression"
		end

feature -- Element Change

	frozen set_type (value: SYSTEM_DLL_CODE_TYPE_REFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeMemberField"
		alias
			"set_Type"
		end

	frozen set_init_expression (value: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeMemberField"
		alias
			"set_InitExpression"
		end

end -- class SYSTEM_DLL_CODE_MEMBER_FIELD
