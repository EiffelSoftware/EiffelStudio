indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.Compiler.Executor"

frozen external class
	SYSTEM_CODEDOM_COMPILER_EXECUTOR

create {NONE}

feature -- Basic Operations

	frozen exec_wait (cmd: STRING; temp_files: SYSTEM_CODEDOM_COMPILER_TEMPFILECOLLECTION) is
		external
			"IL static signature (System.String, System.CodeDom.Compiler.TempFileCollection): System.Void use System.CodeDom.Compiler.Executor"
		alias
			"ExecWait"
		end

	frozen exec_wait_with_capture_int_ptr_string_string (user_token: POINTER; cmd: STRING; current_dir: STRING; temp_files: SYSTEM_CODEDOM_COMPILER_TEMPFILECOLLECTION; output_name: STRING; error_name: STRING): INTEGER is
		external
			"IL static signature (System.IntPtr, System.String, System.String, System.CodeDom.Compiler.TempFileCollection, System.String&, System.String&): System.Int32 use System.CodeDom.Compiler.Executor"
		alias
			"ExecWaitWithCapture"
		end

	frozen exec_wait_with_capture_string_string_temp_file_collection_string_string (cmd: STRING; current_dir: STRING; temp_files: SYSTEM_CODEDOM_COMPILER_TEMPFILECOLLECTION; output_name: STRING; error_name: STRING): INTEGER is
		external
			"IL static signature (System.String, System.String, System.CodeDom.Compiler.TempFileCollection, System.String&, System.String&): System.Int32 use System.CodeDom.Compiler.Executor"
		alias
			"ExecWaitWithCapture"
		end

	frozen exec_wait_with_capture (cmd: STRING; temp_files: SYSTEM_CODEDOM_COMPILER_TEMPFILECOLLECTION; output_name: STRING; error_name: STRING): INTEGER is
		external
			"IL static signature (System.String, System.CodeDom.Compiler.TempFileCollection, System.String&, System.String&): System.Int32 use System.CodeDom.Compiler.Executor"
		alias
			"ExecWaitWithCapture"
		end

	frozen exec_wait_with_capture_int_ptr_string_temp_file_collection_string_string (user_token: POINTER; cmd: STRING; temp_files: SYSTEM_CODEDOM_COMPILER_TEMPFILECOLLECTION; output_name: STRING; error_name: STRING): INTEGER is
		external
			"IL static signature (System.IntPtr, System.String, System.CodeDom.Compiler.TempFileCollection, System.String&, System.String&): System.Int32 use System.CodeDom.Compiler.Executor"
		alias
			"ExecWaitWithCapture"
		end

end -- class SYSTEM_CODEDOM_COMPILER_EXECUTOR
