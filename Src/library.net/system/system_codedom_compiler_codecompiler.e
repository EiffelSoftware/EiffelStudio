indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.Compiler.CodeCompiler"

deferred external class
	SYSTEM_CODEDOM_COMPILER_CODECOMPILER

inherit
	SYSTEM_CODEDOM_COMPILER_ICODECOMPILER
		rename
			compile_assembly_from_dom_batch as system_code_dom_compiler_icode_compiler_compile_assembly_from_dom_batch,
			compile_assembly_from_file_batch as system_code_dom_compiler_icode_compiler_compile_assembly_from_file_batch,
			compile_assembly_from_source_batch as system_code_dom_compiler_icode_compiler_compile_assembly_from_source_batch,
			compile_assembly_from_source as system_code_dom_compiler_icode_compiler_compile_assembly_from_source,
			compile_assembly_from_file as system_code_dom_compiler_icode_compiler_compile_assembly_from_file,
			compile_assembly_from_dom as system_code_dom_compiler_icode_compiler_compile_assembly_from_dom
		end
	SYSTEM_CODEDOM_COMPILER_ICODEGENERATOR
		rename
			get_type_output as system_code_dom_compiler_icode_generator_get_type_output,
			create_valid_identifier as system_code_dom_compiler_icode_generator_create_valid_identifier,
			create_escaped_identifier as system_code_dom_compiler_icode_generator_create_escaped_identifier,
			validate_identifier as system_code_dom_compiler_icode_generator_validate_identifier,
			is_valid_identifier as system_code_dom_compiler_icode_generator_is_valid_identifier,
			generate_code_from_statement as system_code_dom_compiler_icode_generator_generate_code_from_statement,
			generate_code_from_namespace as system_code_dom_compiler_icode_generator_generate_code_from_namespace,
			generate_code_from_compile_unit as system_code_dom_compiler_icode_generator_generate_code_from_compile_unit,
			generate_code_from_expression as system_code_dom_compiler_icode_generator_generate_code_from_expression,
			generate_code_from_type as system_code_dom_compiler_icode_generator_generate_code_from_type,
			supports as system_code_dom_compiler_icode_generator_supports
		end
	SYSTEM_CODEDOM_COMPILER_CODEGENERATOR

feature {NONE} -- Implementation

	frozen system_code_dom_compiler_icode_compiler_compile_assembly_from_dom_batch (options: SYSTEM_CODEDOM_COMPILER_COMPILERPARAMETERS; ea: ARRAY [SYSTEM_CODEDOM_CODECOMPILEUNIT]): SYSTEM_CODEDOM_COMPILER_COMPILERRESULTS is
		external
			"IL signature (System.CodeDom.Compiler.CompilerParameters, System.CodeDom.CodeCompileUnit[]): System.CodeDom.Compiler.CompilerResults use System.CodeDom.Compiler.CodeCompiler"
		alias
			"System.CodeDom.Compiler.ICodeCompiler.CompileAssemblyFromDomBatch"
		end

	process_compiler_output_line (results: SYSTEM_CODEDOM_COMPILER_COMPILERRESULTS; line: STRING) is
		external
			"IL deferred signature (System.CodeDom.Compiler.CompilerResults, System.String): System.Void use System.CodeDom.Compiler.CodeCompiler"
		alias
			"ProcessCompilerOutputLine"
		end

	from_file (options: SYSTEM_CODEDOM_COMPILER_COMPILERPARAMETERS; file_name: STRING): SYSTEM_CODEDOM_COMPILER_COMPILERRESULTS is
		external
			"IL signature (System.CodeDom.Compiler.CompilerParameters, System.String): System.CodeDom.Compiler.CompilerResults use System.CodeDom.Compiler.CodeCompiler"
		alias
			"FromFile"
		end

	cmd_args_from_parameters (options: SYSTEM_CODEDOM_COMPILER_COMPILERPARAMETERS): STRING is
		external
			"IL deferred signature (System.CodeDom.Compiler.CompilerParameters): System.String use System.CodeDom.Compiler.CodeCompiler"
		alias
			"CmdArgsFromParameters"
		end

	frozen system_code_dom_compiler_icode_compiler_compile_assembly_from_file (options: SYSTEM_CODEDOM_COMPILER_COMPILERPARAMETERS; file_name: STRING): SYSTEM_CODEDOM_COMPILER_COMPILERRESULTS is
		external
			"IL signature (System.CodeDom.Compiler.CompilerParameters, System.String): System.CodeDom.Compiler.CompilerResults use System.CodeDom.Compiler.CodeCompiler"
		alias
			"System.CodeDom.Compiler.ICodeCompiler.CompileAssemblyFromFile"
		end

	get_response_file_cmd_args (options: SYSTEM_CODEDOM_COMPILER_COMPILERPARAMETERS; cmd_args: STRING): STRING is
		external
			"IL signature (System.CodeDom.Compiler.CompilerParameters, System.String): System.String use System.CodeDom.Compiler.CodeCompiler"
		alias
			"GetResponseFileCmdArgs"
		end

	get_compiler_name: STRING is
		external
			"IL deferred signature (): System.String use System.CodeDom.Compiler.CodeCompiler"
		alias
			"get_CompilerName"
		end

	frozen join_string_array (sa: ARRAY [STRING]; separator: STRING): STRING is
		external
			"IL static signature (System.String[], System.String): System.String use System.CodeDom.Compiler.CodeCompiler"
		alias
			"JoinStringArray"
		end

	frozen system_code_dom_compiler_icode_compiler_compile_assembly_from_dom (options: SYSTEM_CODEDOM_COMPILER_COMPILERPARAMETERS; e: SYSTEM_CODEDOM_CODECOMPILEUNIT): SYSTEM_CODEDOM_COMPILER_COMPILERRESULTS is
		external
			"IL signature (System.CodeDom.Compiler.CompilerParameters, System.CodeDom.CodeCompileUnit): System.CodeDom.Compiler.CompilerResults use System.CodeDom.Compiler.CodeCompiler"
		alias
			"System.CodeDom.Compiler.ICodeCompiler.CompileAssemblyFromDom"
		end

	from_file_batch (options: SYSTEM_CODEDOM_COMPILER_COMPILERPARAMETERS; file_names: ARRAY [STRING]): SYSTEM_CODEDOM_COMPILER_COMPILERRESULTS is
		external
			"IL signature (System.CodeDom.Compiler.CompilerParameters, System.String[]): System.CodeDom.Compiler.CompilerResults use System.CodeDom.Compiler.CodeCompiler"
		alias
			"FromFileBatch"
		end

	from_dom_batch (options: SYSTEM_CODEDOM_COMPILER_COMPILERPARAMETERS; ea: ARRAY [SYSTEM_CODEDOM_CODECOMPILEUNIT]): SYSTEM_CODEDOM_COMPILER_COMPILERRESULTS is
		external
			"IL signature (System.CodeDom.Compiler.CompilerParameters, System.CodeDom.CodeCompileUnit[]): System.CodeDom.Compiler.CompilerResults use System.CodeDom.Compiler.CodeCompiler"
		alias
			"FromDomBatch"
		end

	from_source_batch (options: SYSTEM_CODEDOM_COMPILER_COMPILERPARAMETERS; sources: ARRAY [STRING]): SYSTEM_CODEDOM_COMPILER_COMPILERRESULTS is
		external
			"IL signature (System.CodeDom.Compiler.CompilerParameters, System.String[]): System.CodeDom.Compiler.CompilerResults use System.CodeDom.Compiler.CodeCompiler"
		alias
			"FromSourceBatch"
		end

	frozen system_code_dom_compiler_icode_compiler_compile_assembly_from_source (options: SYSTEM_CODEDOM_COMPILER_COMPILERPARAMETERS; source: STRING): SYSTEM_CODEDOM_COMPILER_COMPILERRESULTS is
		external
			"IL signature (System.CodeDom.Compiler.CompilerParameters, System.String): System.CodeDom.Compiler.CompilerResults use System.CodeDom.Compiler.CodeCompiler"
		alias
			"System.CodeDom.Compiler.ICodeCompiler.CompileAssemblyFromSource"
		end

	frozen system_code_dom_compiler_icode_compiler_compile_assembly_from_file_batch (options: SYSTEM_CODEDOM_COMPILER_COMPILERPARAMETERS; file_names: ARRAY [STRING]): SYSTEM_CODEDOM_COMPILER_COMPILERRESULTS is
		external
			"IL signature (System.CodeDom.Compiler.CompilerParameters, System.String[]): System.CodeDom.Compiler.CompilerResults use System.CodeDom.Compiler.CodeCompiler"
		alias
			"System.CodeDom.Compiler.ICodeCompiler.CompileAssemblyFromFileBatch"
		end

	frozen system_code_dom_compiler_icode_compiler_compile_assembly_from_source_batch (options: SYSTEM_CODEDOM_COMPILER_COMPILERPARAMETERS; sources: ARRAY [STRING]): SYSTEM_CODEDOM_COMPILER_COMPILERRESULTS is
		external
			"IL signature (System.CodeDom.Compiler.CompilerParameters, System.String[]): System.CodeDom.Compiler.CompilerResults use System.CodeDom.Compiler.CodeCompiler"
		alias
			"System.CodeDom.Compiler.ICodeCompiler.CompileAssemblyFromSourceBatch"
		end

	get_file_extension: STRING is
		external
			"IL deferred signature (): System.String use System.CodeDom.Compiler.CodeCompiler"
		alias
			"get_FileExtension"
		end

	from_dom (options: SYSTEM_CODEDOM_COMPILER_COMPILERPARAMETERS; e: SYSTEM_CODEDOM_CODECOMPILEUNIT): SYSTEM_CODEDOM_COMPILER_COMPILERRESULTS is
		external
			"IL signature (System.CodeDom.Compiler.CompilerParameters, System.CodeDom.CodeCompileUnit): System.CodeDom.Compiler.CompilerResults use System.CodeDom.Compiler.CodeCompiler"
		alias
			"FromDom"
		end

	from_source (options: SYSTEM_CODEDOM_COMPILER_COMPILERPARAMETERS; source: STRING): SYSTEM_CODEDOM_COMPILER_COMPILERRESULTS is
		external
			"IL signature (System.CodeDom.Compiler.CompilerParameters, System.String): System.CodeDom.Compiler.CompilerResults use System.CodeDom.Compiler.CodeCompiler"
		alias
			"FromSource"
		end

end -- class SYSTEM_CODEDOM_COMPILER_CODECOMPILER
