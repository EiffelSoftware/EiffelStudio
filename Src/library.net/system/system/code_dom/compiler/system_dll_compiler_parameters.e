indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.Compiler.CompilerParameters"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_COMPILER_PARAMETERS

inherit
	SYSTEM_OBJECT

create
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_3 (assembly_names: NATIVE_ARRAY [SYSTEM_STRING]; output_name: SYSTEM_STRING; include_debug_information: BOOLEAN) is
		external
			"IL creator signature (System.String[], System.String, System.Boolean) use System.CodeDom.Compiler.CompilerParameters"
		end

	frozen make_2 (assembly_names: NATIVE_ARRAY [SYSTEM_STRING]; output_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String[], System.String) use System.CodeDom.Compiler.CompilerParameters"
		end

	frozen make is
		external
			"IL creator use System.CodeDom.Compiler.CompilerParameters"
		end

	frozen make_1 (assembly_names: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL creator signature (System.String[]) use System.CodeDom.Compiler.CompilerParameters"
		end

feature -- Access

	frozen get_compiler_options: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.Compiler.CompilerParameters"
		alias
			"get_CompilerOptions"
		end

	frozen get_output_assembly: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.Compiler.CompilerParameters"
		alias
			"get_OutputAssembly"
		end

	frozen get_win32_resource: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.Compiler.CompilerParameters"
		alias
			"get_Win32Resource"
		end

	frozen get_main_class: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.Compiler.CompilerParameters"
		alias
			"get_MainClass"
		end

	frozen get_user_token: POINTER is
		external
			"IL signature (): System.IntPtr use System.CodeDom.Compiler.CompilerParameters"
		alias
			"get_UserToken"
		end

	frozen get_temp_files: SYSTEM_DLL_TEMP_FILE_COLLECTION is
		external
			"IL signature (): System.CodeDom.Compiler.TempFileCollection use System.CodeDom.Compiler.CompilerParameters"
		alias
			"get_TempFiles"
		end

	frozen get_generate_in_memory: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.CodeDom.Compiler.CompilerParameters"
		alias
			"get_GenerateInMemory"
		end

	frozen get_referenced_assemblies: SYSTEM_DLL_STRING_COLLECTION is
		external
			"IL signature (): System.Collections.Specialized.StringCollection use System.CodeDom.Compiler.CompilerParameters"
		alias
			"get_ReferencedAssemblies"
		end

	frozen get_generate_executable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.CodeDom.Compiler.CompilerParameters"
		alias
			"get_GenerateExecutable"
		end

	frozen get_include_debug_information: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.CodeDom.Compiler.CompilerParameters"
		alias
			"get_IncludeDebugInformation"
		end

	frozen get_warning_level: INTEGER is
		external
			"IL signature (): System.Int32 use System.CodeDom.Compiler.CompilerParameters"
		alias
			"get_WarningLevel"
		end

	frozen get_treat_warnings_as_errors: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.CodeDom.Compiler.CompilerParameters"
		alias
			"get_TreatWarningsAsErrors"
		end

feature -- Element Change

	frozen set_temp_files (value: SYSTEM_DLL_TEMP_FILE_COLLECTION) is
		external
			"IL signature (System.CodeDom.Compiler.TempFileCollection): System.Void use System.CodeDom.Compiler.CompilerParameters"
		alias
			"set_TempFiles"
		end

	frozen set_main_class (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.Compiler.CompilerParameters"
		alias
			"set_MainClass"
		end

	frozen set_compiler_options (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.Compiler.CompilerParameters"
		alias
			"set_CompilerOptions"
		end

	frozen set_treat_warnings_as_errors (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.CodeDom.Compiler.CompilerParameters"
		alias
			"set_TreatWarningsAsErrors"
		end

	frozen set_user_token (value: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use System.CodeDom.Compiler.CompilerParameters"
		alias
			"set_UserToken"
		end

	frozen set_warning_level (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.CodeDom.Compiler.CompilerParameters"
		alias
			"set_WarningLevel"
		end

	frozen set_include_debug_information (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.CodeDom.Compiler.CompilerParameters"
		alias
			"set_IncludeDebugInformation"
		end

	frozen set_win32_resource (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.Compiler.CompilerParameters"
		alias
			"set_Win32Resource"
		end

	frozen set_generate_in_memory (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.CodeDom.Compiler.CompilerParameters"
		alias
			"set_GenerateInMemory"
		end

	frozen set_output_assembly (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.Compiler.CompilerParameters"
		alias
			"set_OutputAssembly"
		end

	frozen set_generate_executable (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.CodeDom.Compiler.CompilerParameters"
		alias
			"set_GenerateExecutable"
		end

end -- class SYSTEM_DLL_COMPILER_PARAMETERS
