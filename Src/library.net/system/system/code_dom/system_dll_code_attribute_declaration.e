indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeAttributeDeclaration"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION

inherit
	SYSTEM_OBJECT

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (name: SYSTEM_STRING; arguments: NATIVE_ARRAY [SYSTEM_DLL_CODE_ATTRIBUTE_ARGUMENT]) is
		external
			"IL creator signature (System.String, System.CodeDom.CodeAttributeArgument[]) use System.CodeDom.CodeAttributeDeclaration"
		end

	frozen make is
		external
			"IL creator use System.CodeDom.CodeAttributeDeclaration"
		end

	frozen make_1 (name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeAttributeDeclaration"
		end

feature -- Access

	frozen get_arguments: SYSTEM_DLL_CODE_ATTRIBUTE_ARGUMENT_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeAttributeArgumentCollection use System.CodeDom.CodeAttributeDeclaration"
		alias
			"get_Arguments"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeAttributeDeclaration"
		alias
			"get_Name"
		end

feature -- Element Change

	frozen set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeAttributeDeclaration"
		alias
			"set_Name"
		end

end -- class SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION
