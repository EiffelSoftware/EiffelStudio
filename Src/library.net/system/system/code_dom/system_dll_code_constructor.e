indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeConstructor"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_CONSTRUCTOR

inherit
	SYSTEM_DLL_CODE_MEMBER_METHOD

create
	make_system_dll_code_constructor

feature {NONE} -- Initialization

	frozen make_system_dll_code_constructor is
		external
			"IL creator use System.CodeDom.CodeConstructor"
		end

feature -- Access

	frozen get_base_constructor_args: SYSTEM_DLL_CODE_EXPRESSION_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeExpressionCollection use System.CodeDom.CodeConstructor"
		alias
			"get_BaseConstructorArgs"
		end

	frozen get_chained_constructor_args: SYSTEM_DLL_CODE_EXPRESSION_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeExpressionCollection use System.CodeDom.CodeConstructor"
		alias
			"get_ChainedConstructorArgs"
		end

end -- class SYSTEM_DLL_CODE_CONSTRUCTOR
