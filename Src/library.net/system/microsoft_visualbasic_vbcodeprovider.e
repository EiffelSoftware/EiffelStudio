indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "Microsoft.VisualBasic.VBCodeProvider"

external class
	MICROSOFT_VISUALBASIC_VBCODEPROVIDER

inherit
	SYSTEM_CODEDOM_COMPILER_CODEDOMPROVIDER
		redefine
			get_language_options,
			get_file_extension
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_COMPONENTMODEL_ICOMPONENT

create
	make_vbcodeprovider

feature {NONE} -- Initialization

	frozen make_vbcodeprovider is
		external
			"IL creator use Microsoft.VisualBasic.VBCodeProvider"
		end

feature -- Access

	get_file_extension: STRING is
		external
			"IL signature (): System.String use Microsoft.VisualBasic.VBCodeProvider"
		alias
			"get_FileExtension"
		end

	get_language_options: SYSTEM_CODEDOM_COMPILER_LANGUAGEOPTIONS is
		external
			"IL signature (): System.CodeDom.Compiler.LanguageOptions use Microsoft.VisualBasic.VBCodeProvider"
		alias
			"get_LanguageOptions"
		end

feature -- Basic Operations

	create_compiler: SYSTEM_CODEDOM_COMPILER_ICODECOMPILER is
		external
			"IL signature (): System.CodeDom.Compiler.ICodeCompiler use Microsoft.VisualBasic.VBCodeProvider"
		alias
			"CreateCompiler"
		end

	create_generator: SYSTEM_CODEDOM_COMPILER_ICODEGENERATOR is
		external
			"IL signature (): System.CodeDom.Compiler.ICodeGenerator use Microsoft.VisualBasic.VBCodeProvider"
		alias
			"CreateGenerator"
		end

end -- class MICROSOFT_VISUALBASIC_VBCODEPROVIDER
