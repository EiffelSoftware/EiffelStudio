indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "Microsoft.CSharp.CSharpCodeProvider"

external class
	MICROSOFT_CSHARP_CSHARPCODEPROVIDER

inherit
	SYSTEM_CODEDOM_COMPILER_CODEDOMPROVIDER
		redefine
			get_file_extension
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_COMPONENTMODEL_ICOMPONENT

create
	make_csharpcodeprovider

feature {NONE} -- Initialization

	frozen make_csharpcodeprovider is
		external
			"IL creator use Microsoft.CSharp.CSharpCodeProvider"
		end

feature -- Access

	get_file_extension: STRING is
		external
			"IL signature (): System.String use Microsoft.CSharp.CSharpCodeProvider"
		alias
			"get_FileExtension"
		end

feature -- Basic Operations

	create_compiler: SYSTEM_CODEDOM_COMPILER_ICODECOMPILER is
		external
			"IL signature (): System.CodeDom.Compiler.ICodeCompiler use Microsoft.CSharp.CSharpCodeProvider"
		alias
			"CreateCompiler"
		end

	create_generator: SYSTEM_CODEDOM_COMPILER_ICODEGENERATOR is
		external
			"IL signature (): System.CodeDom.Compiler.ICodeGenerator use Microsoft.CSharp.CSharpCodeProvider"
		alias
			"CreateGenerator"
		end

end -- class MICROSOFT_CSHARP_CSHARPCODEPROVIDER
