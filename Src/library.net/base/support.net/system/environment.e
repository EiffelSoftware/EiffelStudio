indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Environment"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ENVIRONMENT

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_has_shutdown_started: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Environment"
		alias
			"get_HasShutdownStarted"
		end

	frozen get_system_directory: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Environment"
		alias
			"get_SystemDirectory"
		end

	frozen get_stack_trace: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Environment"
		alias
			"get_StackTrace"
		end

	frozen get_working_set: INTEGER_64 is
		external
			"IL static signature (): System.Int64 use System.Environment"
		alias
			"get_WorkingSet"
		end

	frozen get_exit_code: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Environment"
		alias
			"get_ExitCode"
		end

	frozen get_osversion: OPERATING_SYSTEM is
		external
			"IL static signature (): System.OperatingSystem use System.Environment"
		alias
			"get_OSVersion"
		end

	frozen get_command_line: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Environment"
		alias
			"get_CommandLine"
		end

	frozen get_new_line: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Environment"
		alias
			"get_NewLine"
		end

	frozen get_user_name: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Environment"
		alias
			"get_UserName"
		end

	frozen get_user_domain_name: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Environment"
		alias
			"get_UserDomainName"
		end

	frozen get_tick_count: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Environment"
		alias
			"get_TickCount"
		end

	frozen get_user_interactive: BOOLEAN is
		external
			"IL static signature (): System.Boolean use System.Environment"
		alias
			"get_UserInteractive"
		end

	frozen get_machine_name: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Environment"
		alias
			"get_MachineName"
		end

	frozen get_version: VERSION is
		external
			"IL static signature (): System.Version use System.Environment"
		alias
			"get_Version"
		end

	frozen get_current_directory: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Environment"
		alias
			"get_CurrentDirectory"
		end

feature -- Element Change

	frozen set_current_directory (value: SYSTEM_STRING) is
		external
			"IL static signature (System.String): System.Void use System.Environment"
		alias
			"set_CurrentDirectory"
		end

	frozen set_exit_code (value: INTEGER) is
		external
			"IL static signature (System.Int32): System.Void use System.Environment"
		alias
			"set_ExitCode"
		end

feature -- Basic Operations

	frozen get_logical_drives: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL static signature (): System.String[] use System.Environment"
		alias
			"GetLogicalDrives"
		end

	frozen exit (exit_code: INTEGER) is
		external
			"IL static signature (System.Int32): System.Void use System.Environment"
		alias
			"Exit"
		end

	frozen get_environment_variable (variable: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.Environment"
		alias
			"GetEnvironmentVariable"
		end

	frozen get_environment_variables: IDICTIONARY is
		external
			"IL static signature (): System.Collections.IDictionary use System.Environment"
		alias
			"GetEnvironmentVariables"
		end

	frozen get_folder_path (folder: SPECIAL_FOLDER_IN_ENVIRONMENT): SYSTEM_STRING is
		external
			"IL static signature (System.Environment+SpecialFolder): System.String use System.Environment"
		alias
			"GetFolderPath"
		end

	frozen get_command_line_args: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL static signature (): System.String[] use System.Environment"
		alias
			"GetCommandLineArgs"
		end

	frozen expand_environment_variables (name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.Environment"
		alias
			"ExpandEnvironmentVariables"
		end

end -- class ENVIRONMENT
