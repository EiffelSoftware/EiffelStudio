indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.Compiler.Executor"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_EXECUTOR

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Basic Operations

	frozen exec_wait (cmd: SYSTEM_STRING; temp_files: SYSTEM_DLL_TEMP_FILE_COLLECTION) is
		external
			"IL static signature (System.String, System.CodeDom.Compiler.TempFileCollection): System.Void use System.CodeDom.Compiler.Executor"
		alias
			"ExecWait"
		end

	frozen exec_wait_with_capture_int_ptr_string_string (user_token: POINTER; cmd: SYSTEM_STRING; current_dir: SYSTEM_STRING; temp_files: SYSTEM_DLL_TEMP_FILE_COLLECTION; output_name: SYSTEM_STRING; error_name: SYSTEM_STRING): INTEGER is
		external
			"IL static signature (System.IntPtr, System.String, System.String, System.CodeDom.Compiler.TempFileCollection, System.String&, System.String&): System.Int32 use System.CodeDom.Compiler.Executor"
		alias
			"ExecWaitWithCapture"
		end

	frozen exec_wait_with_capture_string_string_temp_file_collection_string_string (cmd: SYSTEM_STRING; current_dir: SYSTEM_STRING; temp_files: SYSTEM_DLL_TEMP_FILE_COLLECTION; output_name: SYSTEM_STRING; error_name: SYSTEM_STRING): INTEGER is
		external
			"IL static signature (System.String, System.String, System.CodeDom.Compiler.TempFileCollection, System.String&, System.String&): System.Int32 use System.CodeDom.Compiler.Executor"
		alias
			"ExecWaitWithCapture"
		end

	frozen exec_wait_with_capture (cmd: SYSTEM_STRING; temp_files: SYSTEM_DLL_TEMP_FILE_COLLECTION; output_name: SYSTEM_STRING; error_name: SYSTEM_STRING): INTEGER is
		external
			"IL static signature (System.String, System.CodeDom.Compiler.TempFileCollection, System.String&, System.String&): System.Int32 use System.CodeDom.Compiler.Executor"
		alias
			"ExecWaitWithCapture"
		end

	frozen exec_wait_with_capture_int_ptr_string_temp_file_collection_string_string (user_token: POINTER; cmd: SYSTEM_STRING; temp_files: SYSTEM_DLL_TEMP_FILE_COLLECTION; output_name: SYSTEM_STRING; error_name: SYSTEM_STRING): INTEGER is
		external
			"IL static signature (System.IntPtr, System.String, System.CodeDom.Compiler.TempFileCollection, System.String&, System.String&): System.Int32 use System.CodeDom.Compiler.Executor"
		alias
			"ExecWaitWithCapture"
		end

end -- class SYSTEM_DLL_EXECUTOR
