indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "Microsoft.VisualBasic.VBCodeProvider"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_VBCODE_PROVIDER

inherit
	SYSTEM_DLL_CODE_DOM_PROVIDER
		redefine
			get_converter,
			get_language_options,
			get_file_extension
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE

create
	make_system_dll_vbcode_provider

feature {NONE} -- Initialization

	frozen make_system_dll_vbcode_provider is
		external
			"IL creator use Microsoft.VisualBasic.VBCodeProvider"
		end

feature -- Access

	get_file_extension: SYSTEM_STRING is
		external
			"IL signature (): System.String use Microsoft.VisualBasic.VBCodeProvider"
		alias
			"get_FileExtension"
		end

	get_language_options: SYSTEM_DLL_LANGUAGE_OPTIONS is
		external
			"IL signature (): System.CodeDom.Compiler.LanguageOptions use Microsoft.VisualBasic.VBCodeProvider"
		alias
			"get_LanguageOptions"
		end

feature -- Basic Operations

	create_compiler: SYSTEM_DLL_ICODE_COMPILER is
		external
			"IL signature (): System.CodeDom.Compiler.ICodeCompiler use Microsoft.VisualBasic.VBCodeProvider"
		alias
			"CreateCompiler"
		end

	create_generator: SYSTEM_DLL_ICODE_GENERATOR is
		external
			"IL signature (): System.CodeDom.Compiler.ICodeGenerator use Microsoft.VisualBasic.VBCodeProvider"
		alias
			"CreateGenerator"
		end

	get_converter (type: TYPE): SYSTEM_DLL_TYPE_CONVERTER is
		external
			"IL signature (System.Type): System.ComponentModel.TypeConverter use Microsoft.VisualBasic.VBCodeProvider"
		alias
			"GetConverter"
		end

end -- class SYSTEM_DLL_VBCODE_PROVIDER
