indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "System.Diagnostics.ProcessStartInfo"
	assembly: "System", "1.0.3200.0", "neutral", "b77a5c561934e089"

external class
	PROCESSSTARTINFO

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (file_name: SYSTEM_STRING; arguments: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Diagnostics.ProcessStartInfo"
		end

	frozen make is
		external
			"IL creator use System.Diagnostics.ProcessStartInfo"
		end

	frozen make_1 (file_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Diagnostics.ProcessStartInfo"
		end

feature -- Access

	frozen get_working_directory: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.ProcessStartInfo"
		alias
			"get_WorkingDirectory"
		end

	frozen get_redirect_standard_error: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.ProcessStartInfo"
		alias
			"get_RedirectStandardError"
		end

	frozen get_error_dialog: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.ProcessStartInfo"
		alias
			"get_ErrorDialog"
		end

	frozen get_use_shell_execute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.ProcessStartInfo"
		alias
			"get_UseShellExecute"
		end

	frozen get_environment_variables: STRINGDICTIONARY is
		external
			"IL signature (): System.Collections.Specialized.StringDictionary use System.Diagnostics.ProcessStartInfo"
		alias
			"get_EnvironmentVariables"
		end

	frozen get_file_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.ProcessStartInfo"
		alias
			"get_FileName"
		end

	frozen get_verbs: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (): System.String[] use System.Diagnostics.ProcessStartInfo"
		alias
			"get_Verbs"
		end

	frozen get_redirect_standard_input: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.ProcessStartInfo"
		alias
			"get_RedirectStandardInput"
		end

	frozen get_create_no_window: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.ProcessStartInfo"
		alias
			"get_CreateNoWindow"
		end

	frozen get_error_dialog_parent_handle: POINTER is
		external
			"IL signature (): System.IntPtr use System.Diagnostics.ProcessStartInfo"
		alias
			"get_ErrorDialogParentHandle"
		end

	frozen get_arguments: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.ProcessStartInfo"
		alias
			"get_Arguments"
		end

	frozen get_window_style: PROCESSWINDOWSTYLE is
		external
			"IL signature (): System.Diagnostics.ProcessWindowStyle use System.Diagnostics.ProcessStartInfo"
		alias
			"get_WindowStyle"
		end

	frozen get_verb: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.ProcessStartInfo"
		alias
			"get_Verb"
		end

	frozen get_redirect_standard_output: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.ProcessStartInfo"
		alias
			"get_RedirectStandardOutput"
		end

feature -- Element Change

	frozen set_redirect_standard_input (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Diagnostics.ProcessStartInfo"
		alias
			"set_RedirectStandardInput"
		end

	frozen set_error_dialog (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Diagnostics.ProcessStartInfo"
		alias
			"set_ErrorDialog"
		end

	frozen set_error_dialog_parent_handle (value: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use System.Diagnostics.ProcessStartInfo"
		alias
			"set_ErrorDialogParentHandle"
		end

	frozen set_verb (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.ProcessStartInfo"
		alias
			"set_Verb"
		end

	frozen set_working_directory (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.ProcessStartInfo"
		alias
			"set_WorkingDirectory"
		end

	frozen set_window_style (value: PROCESSWINDOWSTYLE) is
		external
			"IL signature (System.Diagnostics.ProcessWindowStyle): System.Void use System.Diagnostics.ProcessStartInfo"
		alias
			"set_WindowStyle"
		end

	frozen set_create_no_window (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Diagnostics.ProcessStartInfo"
		alias
			"set_CreateNoWindow"
		end

	frozen set_redirect_standard_error (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Diagnostics.ProcessStartInfo"
		alias
			"set_RedirectStandardError"
		end

	frozen set_file_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.ProcessStartInfo"
		alias
			"set_FileName"
		end

	frozen set_use_shell_execute (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Diagnostics.ProcessStartInfo"
		alias
			"set_UseShellExecute"
		end

	frozen set_redirect_standard_output (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Diagnostics.ProcessStartInfo"
		alias
			"set_RedirectStandardOutput"
		end

	frozen set_arguments (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.ProcessStartInfo"
		alias
			"set_Arguments"
		end

end -- class PROCESSSTARTINFO
