indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.Compiler.ICodeCompiler"

deferred external class
	SYSTEM_CODEDOM_COMPILER_ICODECOMPILER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	compile_assembly_from_source (options: SYSTEM_CODEDOM_COMPILER_COMPILERPARAMETERS; source: STRING): SYSTEM_CODEDOM_COMPILER_COMPILERRESULTS is
		external
			"IL deferred signature (System.CodeDom.Compiler.CompilerParameters, System.String): System.CodeDom.Compiler.CompilerResults use System.CodeDom.Compiler.ICodeCompiler"
		alias
			"CompileAssemblyFromSource"
		end

	compile_assembly_from_file (options: SYSTEM_CODEDOM_COMPILER_COMPILERPARAMETERS; file_name: STRING): SYSTEM_CODEDOM_COMPILER_COMPILERRESULTS is
		external
			"IL deferred signature (System.CodeDom.Compiler.CompilerParameters, System.String): System.CodeDom.Compiler.CompilerResults use System.CodeDom.Compiler.ICodeCompiler"
		alias
			"CompileAssemblyFromFile"
		end

	compile_assembly_from_file_batch (options: SYSTEM_CODEDOM_COMPILER_COMPILERPARAMETERS; file_names: ARRAY [STRING]): SYSTEM_CODEDOM_COMPILER_COMPILERRESULTS is
		external
			"IL deferred signature (System.CodeDom.Compiler.CompilerParameters, System.String[]): System.CodeDom.Compiler.CompilerResults use System.CodeDom.Compiler.ICodeCompiler"
		alias
			"CompileAssemblyFromFileBatch"
		end

	compile_assembly_from_dom (options: SYSTEM_CODEDOM_COMPILER_COMPILERPARAMETERS; compilation_unit: SYSTEM_CODEDOM_CODECOMPILEUNIT): SYSTEM_CODEDOM_COMPILER_COMPILERRESULTS is
		external
			"IL deferred signature (System.CodeDom.Compiler.CompilerParameters, System.CodeDom.CodeCompileUnit): System.CodeDom.Compiler.CompilerResults use System.CodeDom.Compiler.ICodeCompiler"
		alias
			"CompileAssemblyFromDom"
		end

	compile_assembly_from_source_batch (options: SYSTEM_CODEDOM_COMPILER_COMPILERPARAMETERS; sources: ARRAY [STRING]): SYSTEM_CODEDOM_COMPILER_COMPILERRESULTS is
		external
			"IL deferred signature (System.CodeDom.Compiler.CompilerParameters, System.String[]): System.CodeDom.Compiler.CompilerResults use System.CodeDom.Compiler.ICodeCompiler"
		alias
			"CompileAssemblyFromSourceBatch"
		end

	compile_assembly_from_dom_batch (options: SYSTEM_CODEDOM_COMPILER_COMPILERPARAMETERS; compilation_units: ARRAY [SYSTEM_CODEDOM_CODECOMPILEUNIT]): SYSTEM_CODEDOM_COMPILER_COMPILERRESULTS is
		external
			"IL deferred signature (System.CodeDom.Compiler.CompilerParameters, System.CodeDom.CodeCompileUnit[]): System.CodeDom.Compiler.CompilerResults use System.CodeDom.Compiler.ICodeCompiler"
		alias
			"CompileAssemblyFromDomBatch"
		end

end -- class SYSTEM_CODEDOM_COMPILER_ICODECOMPILER
