indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.Compiler.CodeDomProvider"

deferred external class
	SYSTEM_CODEDOM_COMPILER_CODEDOMPROVIDER

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_COMPONENT
	SYSTEM_IDISPOSABLE

feature -- Access

	get_file_extension: STRING is
		external
			"IL signature (): System.String use System.CodeDom.Compiler.CodeDomProvider"
		alias
			"get_FileExtension"
		end

	get_language_options: SYSTEM_CODEDOM_COMPILER_LANGUAGEOPTIONS is
		external
			"IL signature (): System.CodeDom.Compiler.LanguageOptions use System.CodeDom.Compiler.CodeDomProvider"
		alias
			"get_LanguageOptions"
		end

feature -- Basic Operations

	create_generator: SYSTEM_CODEDOM_COMPILER_ICODEGENERATOR is
		external
			"IL deferred signature (): System.CodeDom.Compiler.ICodeGenerator use System.CodeDom.Compiler.CodeDomProvider"
		alias
			"CreateGenerator"
		end

	create_generator_text_writer (output: SYSTEM_IO_TEXTWRITER): SYSTEM_CODEDOM_COMPILER_ICODEGENERATOR is
		external
			"IL signature (System.IO.TextWriter): System.CodeDom.Compiler.ICodeGenerator use System.CodeDom.Compiler.CodeDomProvider"
		alias
			"CreateGenerator"
		end

	create_compiler: SYSTEM_CODEDOM_COMPILER_ICODECOMPILER is
		external
			"IL deferred signature (): System.CodeDom.Compiler.ICodeCompiler use System.CodeDom.Compiler.CodeDomProvider"
		alias
			"CreateCompiler"
		end

	create_generator_string (file_name: STRING): SYSTEM_CODEDOM_COMPILER_ICODEGENERATOR is
		external
			"IL signature (System.String): System.CodeDom.Compiler.ICodeGenerator use System.CodeDom.Compiler.CodeDomProvider"
		alias
			"CreateGenerator"
		end

	create_parser: SYSTEM_CODEDOM_COMPILER_ICODEPARSER is
		external
			"IL signature (): System.CodeDom.Compiler.ICodeParser use System.CodeDom.Compiler.CodeDomProvider"
		alias
			"CreateParser"
		end

end -- class SYSTEM_CODEDOM_COMPILER_CODEDOMPROVIDER
