indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.Compiler.CompilerResults"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_COMPILER_RESULTS

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make (temp_files: SYSTEM_DLL_TEMP_FILE_COLLECTION) is
		external
			"IL creator signature (System.CodeDom.Compiler.TempFileCollection) use System.CodeDom.Compiler.CompilerResults"
		end

feature -- Access

	frozen get_errors: SYSTEM_DLL_COMPILER_ERROR_COLLECTION is
		external
			"IL signature (): System.CodeDom.Compiler.CompilerErrorCollection use System.CodeDom.Compiler.CompilerResults"
		alias
			"get_Errors"
		end

	frozen get_path_to_assembly: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.Compiler.CompilerResults"
		alias
			"get_PathToAssembly"
		end

	frozen get_native_compiler_return_value: INTEGER is
		external
			"IL signature (): System.Int32 use System.CodeDom.Compiler.CompilerResults"
		alias
			"get_NativeCompilerReturnValue"
		end

	frozen get_output: SYSTEM_DLL_STRING_COLLECTION is
		external
			"IL signature (): System.Collections.Specialized.StringCollection use System.CodeDom.Compiler.CompilerResults"
		alias
			"get_Output"
		end

	frozen get_compiled_assembly: ASSEMBLY is
		external
			"IL signature (): System.Reflection.Assembly use System.CodeDom.Compiler.CompilerResults"
		alias
			"get_CompiledAssembly"
		end

	frozen get_temp_files: SYSTEM_DLL_TEMP_FILE_COLLECTION is
		external
			"IL signature (): System.CodeDom.Compiler.TempFileCollection use System.CodeDom.Compiler.CompilerResults"
		alias
			"get_TempFiles"
		end

feature -- Element Change

	frozen set_native_compiler_return_value (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.CodeDom.Compiler.CompilerResults"
		alias
			"set_NativeCompilerReturnValue"
		end

	frozen set_temp_files (value: SYSTEM_DLL_TEMP_FILE_COLLECTION) is
		external
			"IL signature (System.CodeDom.Compiler.TempFileCollection): System.Void use System.CodeDom.Compiler.CompilerResults"
		alias
			"set_TempFiles"
		end

	frozen set_compiled_assembly (value: ASSEMBLY) is
		external
			"IL signature (System.Reflection.Assembly): System.Void use System.CodeDom.Compiler.CompilerResults"
		alias
			"set_CompiledAssembly"
		end

	frozen set_path_to_assembly (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.Compiler.CompilerResults"
		alias
			"set_PathToAssembly"
		end

end -- class SYSTEM_DLL_COMPILER_RESULTS
