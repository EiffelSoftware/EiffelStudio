indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.Compiler.ICodeCompiler"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_ICODE_COMPILER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	compile_assembly_from_source (options: SYSTEM_DLL_COMPILER_PARAMETERS; source: SYSTEM_STRING): SYSTEM_DLL_COMPILER_RESULTS is
		external
			"IL deferred signature (System.CodeDom.Compiler.CompilerParameters, System.String): System.CodeDom.Compiler.CompilerResults use System.CodeDom.Compiler.ICodeCompiler"
		alias
			"CompileAssemblyFromSource"
		end

	compile_assembly_from_file (options: SYSTEM_DLL_COMPILER_PARAMETERS; file_name: SYSTEM_STRING): SYSTEM_DLL_COMPILER_RESULTS is
		external
			"IL deferred signature (System.CodeDom.Compiler.CompilerParameters, System.String): System.CodeDom.Compiler.CompilerResults use System.CodeDom.Compiler.ICodeCompiler"
		alias
			"CompileAssemblyFromFile"
		end

	compile_assembly_from_file_batch (options: SYSTEM_DLL_COMPILER_PARAMETERS; file_names: NATIVE_ARRAY [SYSTEM_STRING]): SYSTEM_DLL_COMPILER_RESULTS is
		external
			"IL deferred signature (System.CodeDom.Compiler.CompilerParameters, System.String[]): System.CodeDom.Compiler.CompilerResults use System.CodeDom.Compiler.ICodeCompiler"
		alias
			"CompileAssemblyFromFileBatch"
		end

	compile_assembly_from_dom (options: SYSTEM_DLL_COMPILER_PARAMETERS; compilation_unit: SYSTEM_DLL_CODE_COMPILE_UNIT): SYSTEM_DLL_COMPILER_RESULTS is
		external
			"IL deferred signature (System.CodeDom.Compiler.CompilerParameters, System.CodeDom.CodeCompileUnit): System.CodeDom.Compiler.CompilerResults use System.CodeDom.Compiler.ICodeCompiler"
		alias
			"CompileAssemblyFromDom"
		end

	compile_assembly_from_source_batch (options: SYSTEM_DLL_COMPILER_PARAMETERS; sources: NATIVE_ARRAY [SYSTEM_STRING]): SYSTEM_DLL_COMPILER_RESULTS is
		external
			"IL deferred signature (System.CodeDom.Compiler.CompilerParameters, System.String[]): System.CodeDom.Compiler.CompilerResults use System.CodeDom.Compiler.ICodeCompiler"
		alias
			"CompileAssemblyFromSourceBatch"
		end

	compile_assembly_from_dom_batch (options: SYSTEM_DLL_COMPILER_PARAMETERS; compilation_units: NATIVE_ARRAY [SYSTEM_DLL_CODE_COMPILE_UNIT]): SYSTEM_DLL_COMPILER_RESULTS is
		external
			"IL deferred signature (System.CodeDom.Compiler.CompilerParameters, System.CodeDom.CodeCompileUnit[]): System.CodeDom.Compiler.CompilerResults use System.CodeDom.Compiler.ICodeCompiler"
		alias
			"CompileAssemblyFromDomBatch"
		end

end -- class SYSTEM_DLL_ICODE_COMPILER
