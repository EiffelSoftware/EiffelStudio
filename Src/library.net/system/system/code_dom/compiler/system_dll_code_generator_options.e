indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.Compiler.CodeGeneratorOptions"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_GENERATOR_OPTIONS

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.CodeDom.Compiler.CodeGeneratorOptions"
		end

feature -- Access

	frozen get_indent_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.Compiler.CodeGeneratorOptions"
		alias
			"get_IndentString"
		end

	frozen get_else_on_closing: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.CodeDom.Compiler.CodeGeneratorOptions"
		alias
			"get_ElseOnClosing"
		end

	frozen get_item (index: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String): System.Object use System.CodeDom.Compiler.CodeGeneratorOptions"
		alias
			"get_Item"
		end

	frozen get_bracing_style: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.Compiler.CodeGeneratorOptions"
		alias
			"get_BracingStyle"
		end

	frozen get_blank_lines_between_members: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.CodeDom.Compiler.CodeGeneratorOptions"
		alias
			"get_BlankLinesBetweenMembers"
		end

feature -- Element Change

	frozen set_blank_lines_between_members (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.CodeDom.Compiler.CodeGeneratorOptions"
		alias
			"set_BlankLinesBetweenMembers"
		end

	frozen set_bracing_style (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.Compiler.CodeGeneratorOptions"
		alias
			"set_BracingStyle"
		end

	frozen set_else_on_closing (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.CodeDom.Compiler.CodeGeneratorOptions"
		alias
			"set_ElseOnClosing"
		end

	frozen set_indent_string (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.Compiler.CodeGeneratorOptions"
		alias
			"set_IndentString"
		end

	frozen set_item (index: SYSTEM_STRING; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object): System.Void use System.CodeDom.Compiler.CodeGeneratorOptions"
		alias
			"set_Item"
		end

end -- class SYSTEM_DLL_CODE_GENERATOR_OPTIONS
