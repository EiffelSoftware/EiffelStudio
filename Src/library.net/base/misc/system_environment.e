indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Environment"

frozen external class
	SYSTEM_ENVIRONMENT

create {NONE}

feature -- Access

	frozen get_system_directory: STRING is
		external
			"IL static signature (): System.String use System.Environment"
		alias
			"get_SystemDirectory"
		end

	frozen get_stack_trace: STRING is
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

	frozen get_osversion: SYSTEM_OPERATINGSYSTEM is
		external
			"IL static signature (): System.OperatingSystem use System.Environment"
		alias
			"get_OSVersion"
		end

	frozen get_command_line: STRING is
		external
			"IL static signature (): System.String use System.Environment"
		alias
			"get_CommandLine"
		end

	frozen get_new_line: STRING is
		external
			"IL static signature (): System.String use System.Environment"
		alias
			"get_NewLine"
		end

	frozen get_user_name: STRING is
		external
			"IL static signature (): System.String use System.Environment"
		alias
			"get_UserName"
		end

	frozen get_user_domain_name: STRING is
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

	frozen get_machine_name: STRING is
		external
			"IL static signature (): System.String use System.Environment"
		alias
			"get_MachineName"
		end

	frozen get_version: SYSTEM_VERSION is
		external
			"IL static signature (): System.Version use System.Environment"
		alias
			"get_Version"
		end

	frozen get_current_directory: STRING is
		external
			"IL static signature (): System.String use System.Environment"
		alias
			"get_CurrentDirectory"
		end

feature -- Element Change

	frozen set_current_directory (value: STRING) is
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

	frozen get_logical_drives: ARRAY [STRING] is
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

	frozen get_environment_variable (variable: STRING): STRING is
		external
			"IL static signature (System.String): System.String use System.Environment"
		alias
			"GetEnvironmentVariable"
		end

	frozen get_environment_variables: SYSTEM_COLLECTIONS_IDICTIONARY is
		external
			"IL static signature (): System.Collections.IDictionary use System.Environment"
		alias
			"GetEnvironmentVariables"
		end

	frozen get_folder_path (folder: INTEGER): STRING is
			-- Valid values for `folder' are:
			-- ApplicationData = 26
			-- CommonApplicationData = 35
			-- LocalApplicationData = 28
			-- Cookies = 33
			-- Favorites = 6
			-- History = 34
			-- InternetCache = 32
			-- Programs = 2
			-- Recent = 8
			-- SendTo = 9
			-- StartMenu = 11
			-- Startup = 7
			-- System = 37
			-- Templates = 21
			-- DesktopDirectory = 16
			-- Personal = 5
			-- ProgramFiles = 38
			-- CommonProgramFiles = 43
		require
			valid_special_folder_in_system_environment: folder = 26 or folder = 35 or folder = 28 or folder = 33 or folder = 6 or folder = 34 or folder = 32 or folder = 2 or folder = 8 or folder = 9 or folder = 11 or folder = 7 or folder = 37 or folder = 21 or folder = 16 or folder = 5 or folder = 38 or folder = 43
		external
			"IL static signature (enum System.Environment+SpecialFolder): System.String use System.Environment"
		alias
			"GetFolderPath"
		end

	frozen get_command_line_args: ARRAY [STRING] is
		external
			"IL static signature (): System.String[] use System.Environment"
		alias
			"GetCommandLineArgs"
		end

	frozen expand_environment_variables (name: STRING): STRING is
		external
			"IL static signature (System.String): System.String use System.Environment"
		alias
			"ExpandEnvironmentVariables"
		end

end -- class SYSTEM_ENVIRONMENT
