indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.Compiler.CodeDomProvider"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_CODE_DOM_PROVIDER

inherit
	SYSTEM_DLL_COMPONENT
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE

feature -- Access

	get_file_extension: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.Compiler.CodeDomProvider"
		alias
			"get_FileExtension"
		end

	get_language_options: SYSTEM_DLL_LANGUAGE_OPTIONS is
		external
			"IL signature (): System.CodeDom.Compiler.LanguageOptions use System.CodeDom.Compiler.CodeDomProvider"
		alias
			"get_LanguageOptions"
		end

feature -- Basic Operations

	create_generator: SYSTEM_DLL_ICODE_GENERATOR is
		external
			"IL deferred signature (): System.CodeDom.Compiler.ICodeGenerator use System.CodeDom.Compiler.CodeDomProvider"
		alias
			"CreateGenerator"
		end

	create_generator_text_writer (output: TEXT_WRITER): SYSTEM_DLL_ICODE_GENERATOR is
		external
			"IL signature (System.IO.TextWriter): System.CodeDom.Compiler.ICodeGenerator use System.CodeDom.Compiler.CodeDomProvider"
		alias
			"CreateGenerator"
		end

	create_compiler: SYSTEM_DLL_ICODE_COMPILER is
		external
			"IL deferred signature (): System.CodeDom.Compiler.ICodeCompiler use System.CodeDom.Compiler.CodeDomProvider"
		alias
			"CreateCompiler"
		end

	create_generator_string (file_name: SYSTEM_STRING): SYSTEM_DLL_ICODE_GENERATOR is
		external
			"IL signature (System.String): System.CodeDom.Compiler.ICodeGenerator use System.CodeDom.Compiler.CodeDomProvider"
		alias
			"CreateGenerator"
		end

	create_parser: SYSTEM_DLL_ICODE_PARSER is
		external
			"IL signature (): System.CodeDom.Compiler.ICodeParser use System.CodeDom.Compiler.CodeDomProvider"
		alias
			"CreateParser"
		end

	get_converter (type: TYPE): SYSTEM_DLL_TYPE_CONVERTER is
		external
			"IL signature (System.Type): System.ComponentModel.TypeConverter use System.CodeDom.Compiler.CodeDomProvider"
		alias
			"GetConverter"
		end

end -- class SYSTEM_DLL_CODE_DOM_PROVIDER
