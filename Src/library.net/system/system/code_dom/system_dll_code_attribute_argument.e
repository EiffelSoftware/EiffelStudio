indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeAttributeArgument"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_ATTRIBUTE_ARGUMENT

inherit
	SYSTEM_OBJECT

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (name: SYSTEM_STRING; value: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL creator signature (System.String, System.CodeDom.CodeExpression) use System.CodeDom.CodeAttributeArgument"
		end

	frozen make is
		external
			"IL creator use System.CodeDom.CodeAttributeArgument"
		end

	frozen make_1 (value: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL creator signature (System.CodeDom.CodeExpression) use System.CodeDom.CodeAttributeArgument"
		end

feature -- Access

	frozen get_value: SYSTEM_DLL_CODE_EXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeAttributeArgument"
		alias
			"get_Value"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeAttributeArgument"
		alias
			"get_Name"
		end

feature -- Element Change

	frozen set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeAttributeArgument"
		alias
			"set_Name"
		end

	frozen set_value (value: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeAttributeArgument"
		alias
			"set_Value"
		end

end -- class SYSTEM_DLL_CODE_ATTRIBUTE_ARGUMENT
