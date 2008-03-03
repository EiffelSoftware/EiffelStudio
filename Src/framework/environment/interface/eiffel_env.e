indexing

	description:
		"Environment for bitmaps, help, binaries, scripts...."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class EIFFEL_ENV

feature -- Status update

	check_environment_variable is
			-- Check if needed environment variables are set up.
		local
			temp: STRING
			p: PRODUCT_NAMES
			l_file: RAW_FILE
			l_dir: DIRECTORY
		do
			temp := get_environment (ise_eiffel_env)

			create p
			if (temp = Void) or else temp.is_empty then
				if platform.is_unix then
						-- on unix we asume that the unix layout is used
					is_unix_layout := True
				else
					io.error.put_string (p.Workbench_name)
					io.error.put_string (": the environment variable $"+ise_eiffel_env+" is not set.%N")
					(create {EXCEPTIONS}).die (-1)
				end
			else
				create l_file.make (temp)
				if not l_file.exists or not l_file.is_directory then
					io.error.put_string ("WARNING: the environment variable $"+ise_eiffel_env+" points to a non-existing directory.%N")
				else
						-- put it into the environment for backward compatibility
					environment.put (eiffel_installation_dir_name, ise_eiffel_env)
				end
			end

			if Platform.is_windows then
				temp := get_environment (ise_c_compiler_env)
				if (temp = Void) or else temp.is_empty then
					io.error.put_string (p.Workbench_name)
					io.error.put_string (": the environment variable $"+ise_c_compiler_env+" is not set%N")
					(create {EXCEPTIONS}).die (-1)
				else
						-- put it into the environment for backward compatibility
					environment.put (temp, ise_c_compiler_env)
				end
			end

			temp := get_environment (ise_platform_env)
			if (temp = Void) or else temp.is_empty then
				if is_unix_layout then
					is_valid_environment := True
					environment.put (unix_layout_platform, ise_platform_env)
				else
					io.error.put_string (p.Workbench_name)
					io.error.put_string (": the environment variable $"+ise_platform_env+" is not set%N")
					(create {EXCEPTIONS}).die (-1)
				end
			else
					-- we have now a valid environment, although we may have some warnings
				is_valid_environment := True
				if not is_unix_layout then
				create l_file.make (bin_path)
					if not l_file.exists or not l_file.is_directory then
						io.error.put_string ("WARNING: the path $"+ise_eiffel_env+"/studio/spec/$"+ise_platform_env+"/bin points to a non-existing directory.%N")
					end
				end
					-- put it into the environment for backward compatibility
				environment.put (temp, ise_platform_env)
			end

				-- we are finished with the checks, the rest is some default setup

				-- Check that `eiffel_home' exists.
			create l_file.make (eiffel_home)
			if not l_file.exists or else not l_file.is_directory then
				safe_create_dir (eiffel_home)
				create l_dir.make (eiffel_home)
				is_valid_home := l_dir.exists
			else
				is_valid_home := True
			end

				-- Make sure to define ISE_LIBRARY if not defined.
			temp := get_environment (ise_library_env)
			if temp = Void then
				environment.put (lib_path, ise_library_env)
			else
				environment.put (temp, ise_library_env)
			end
		ensure
			is_valid_environment: is_valid_environment
		end

	set_precompile (a_is_dotnet: BOOLEAN) is
			-- Set up the ISE_PRECOMP environment variable, depending on `a_is_dotnet'.
		require
			is_valid_environment: is_valid_environment
		do
			environment.put (Eiffel_precomp_mode (a_is_dotnet), ise_precomp_env)
			is_valid_precompile_environment := True
		ensure
			is_valid_precompile_environment: is_valid_precompile_environment
		end

feature -- Status report

	is_valid_environment: BOOLEAN
			-- Have the needed environment variables been set?

	is_valid_precompile_environment: BOOLEAN
			-- Has the precompile environment been set correctly?

	is_valid_home: BOOLEAN
			-- Is there a valid home directory?

	frozen is_workbench: BOOLEAN is
			-- Are we running the workbench version of the compiler?
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"EIF_IS_WORKBENCH"
		end

	is_unix_layout: BOOLEAN
			-- Is eiffelstudio installed in the unix layout?

feature -- Version

	Major_version: NATURAL_16 is 6
	Minor_version: NATURAL_16 is 2

feature -- Access

	application_name: STRING is
			-- Name of the application.
		deferred
		ensure
			result_ok: Result /= Void and then not Result.is_empty
		end

	product_name: STRING is "Eiffel"
			-- Name of the product.

	product_version_name: STRING is
			-- Versioned name of the product.
		once
			if is_unix_layout then
				Result := product_name + major_version.out + "." + minor_version.out
				Result.to_lower
			else
				Result := product_name + major_version.out + minor_version.out
			end
		end

	environment_info: STRING is
			-- Information about the environment.
		do
			create Result.make (100)
			if is_unix_layout then
				Result.append ("Base Path = " + unix_layout_base_path)
			else
				Result.append ("$ISE_EIFFEL = " + eiffel_installation_dir_name + "%N")
				Result.append ("$ISE_LIBRARY = " + eiffel_library + "%N")
				Result.append ("$ISE_PLATFORM = " + eiffel_platform)
				if platform.is_windows then
					Result.append ("%N$ISE_C_COMPILER = " + eiffel_c_compiler)
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

feature -- Preferences

	Eiffel_preferences: STRING is
			-- Preferences location
		local
			fname: FILE_NAME
		once
			if platform.is_windows then
				Result := "HKEY_CURRENT_USER\Software\ISE\" + product_version_name + "\"+application_name+"\Preferences"
				if is_workbench then
					Result.append ("_wkbench")
				end
			else
				create fname.make_from_string (eiffel_home)
				fname.set_file_name (application_name + "rc" + major_version.out + minor_version.out)
				Result := fname
			end
		end

	general_preferences: FILE_NAME is
			-- Platform independent preferences.
		require
			is_valid_environment: is_valid_environment
		do
			create Result.make_from_string (shared_application_path)
			Result.extend ("eifinit")
			Result.set_file_name ("default")
			Result.add_extension ("xml")
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

	platform_preferences: FILE_NAME is
			-- Platform specific preferences.
		do
			create Result.make_from_string (shared_application_path)
			Result.extend_from_array (<<"eifinit", "spec", Platform_abstraction>>)
			Result.set_file_name ("default")
			Result.add_extension ("xml")
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

feature -- Access: Environment variables

	Eiffel_c_compiler: STRING is
			-- ISE_C_COMPILER name.
		require
			is_valid_environment: is_valid_environment
			windows: platform.is_windows
		once
			Result := get_environment (ise_c_compiler_env)
		ensure
			result_not_void: Result /= Void
		end

	Eiffel_platform: STRING is
			-- ISE_PLATFORM name.
		require
			is_valid_environment: is_valid_environment
		once
			Result := get_environment (ise_platform_env)
		ensure
			result_not_void: Result /= Void
		end

	Platform_abstraction: STRING is
			-- Abstraction between Windows and Unix.
		once
			if Platform.is_windows then
				Result := "windows"
			else
				Result := "unix"
			end
		ensure
			result_not_void: Result /= Void
		end

	Eiffel_projects_directory: DIRECTORY_NAME is
			-- ISE_PROJECTS name.
		local
			l_tmp: STRING
		once
			l_tmp := get_environment (ise_projects_env)
			if
				l_tmp = Void or else l_tmp.is_empty
			then
				if Platform.is_windows then
					create Result.make_from_string (Default_project_location_for_windows)
				else
					Result := Home
				end
			else
				create Result.make_from_string (l_tmp)
			end
		end

	Eiffel_home: DIRECTORY_NAME is
			-- Name of directory containing Eiffel specific data.
		local
			l_dir_name: STRING
		once
			create Result.make_from_string (Home)
			if platform.is_windows then
				l_dir_name := "EiffelSoftware"
			else
				l_dir_name := ".es"
			end
			if is_workbench then
				l_dir_name.append ("_wkbench")
			end
			Result.extend (l_dir_name)
		ensure
			result_not_void: Result /= Void
		end

	Home: DIRECTORY_NAME is
			-- HOME name.
		local
			l_tmp: STRING
		once
			l_tmp := environment.home_directory_name
			if l_tmp = Void then
				create Result.make
			else
				create Result.make_from_string (l_tmp)
			end
		ensure
			result_not_void: Result /= Void
		end

feature -- Access: file name

	Eiffel_installation_dir_name: DIRECTORY_NAME is
			-- Installation of ISE Eiffel name.
		require
			not_unix_layout: not is_unix_layout
		local
			l_name: STRING
		once
			l_name := get_environment (ise_eiffel_env)
			if is_workbench and then (create {DIRECTORY}.make (l_name + "_wkbench")).exists then
				l_name.append ("_wkbench")
			end
			create Result.make_from_string (l_name)
		ensure
			result_not_void_or_empty: is_valid_environment implies
				(Result /= Void and then not Result.is_empty)
		end

	Bin_path: DIRECTORY_NAME is
		require
			not_unix_layout: not is_unix_layout
			is_valid_environment: is_valid_environment
		do
			Result := Studio_path.twin
			Result.extend_from_array (<<"spec", Eiffel_platform, "bin">>)
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

	Eiffel_library: DIRECTORY_NAME is
			-- ISE_LIBRARY name.
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (get_environment (ise_library_env))
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

	Eiffel_precomp: DIRECTORY_NAME is
			-- ISE_PRECOMP name.
		require
			is_valid_precompile_environment: is_valid_precompile_environment
		do
			create Result.make_from_string (get_environment (ise_precomp_env))
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

	Eiffel_precomp_mode (a_is_dotnet: BOOLEAN): DIRECTORY_NAME
			-- Retrieve precomp location.
		require
			is_valid_environment: is_valid_environment
		local
			l_dn_name: STRING
		do
			Result := lib_path.twin
			Result.extend_from_array (<<"precomp", "spec">>)
			if a_is_dotnet then
					-- Append '-dotnet' to platform name
				create l_dn_name.make (eiffel_platform.count + 7)
				l_dn_name.append (eiffel_platform)
				l_dn_name.append ("-dotnet")
				Result.extend (l_dn_name)
			else
				Result.extend (eiffel_platform)
			end
		ensure
			result_ok: Result /= Void and then not Result.is_empty
		end

	Runtime_include_path: DIRECTORY_NAME is
			-- Include path for the runtime.
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				Result := unix_layout_base_path.twin
				Result.extend_from_array (<<"include", product_version_name>>)
			else
				Result := studio_path.twin
				Result.extend_from_array (<<"spec", eiffel_platform, "include">>)
			end
		ensure
			Result_ok: Result /= Void and then not Result.is_empty
		end

	docking_data_name: STRING is
			-- Docking config data folder name
		once
			if not is_workbench then
				Result := "docking_"
			else
				Result := "docking_wb_"
			end
			Result.append_integer (major_version)
			Result.append_integer (minor_version)
		end

	Standard_tools_layout_name: STRING is
			-- Standard tools layout name
		once
			if not is_workbench then
				Result := "standard_layout.wb"
			else
				Result := "standard_layout_wb.wb"
			end
		end

	Standard_tools_debug_layout_name: STRING is
			-- Standard tools debug layout name
		once
			if not is_workbench then
				Result := "standard_debug_layout.wb"
			else
				Result := "standard_debug_layout_wb.wb"
			end
		end

	Runtime_lib_path: DIRECTORY_NAME is
			-- Library path for the runtime.
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				Result := unix_layout_base_path.twin
				Result.extend (unix_layout_lib_dir)
			else
				Result := studio_path.twin
				Result.extend_from_array (<<"spec", eiffel_platform, "lib">>)
			end
		ensure
			Result_ok: Result /= Void and then not Result.is_empty
		end

	Shared_path: DIRECTORY_NAME is
			-- Location of shared files (platform independent).
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				Result := unix_layout_base_path.twin
				Result.extend_from_array (<<"share", product_version_name>>)
			else
				create Result.make_from_string (eiffel_installation_dir_name)
			end
		ensure
			Result_not_void: Result /= Void
		end

	Lib_path: DIRECTORY_NAME is
			-- Location of libs files (platform dependent).
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				Result := unix_layout_base_path.twin
				Result.extend_from_array (<<unix_layout_lib_dir, product_version_name>>)
			else
				create Result.make_from_string (eiffel_installation_dir_name)
			end
		ensure
			Result_not_void: Result /= Void
		end

	Shared_application_path: DIRECTORY_NAME is
			-- Location of shared files specific for the current application (platform independent).
		require
			is_valid_environment: is_valid_environment
		once
			Result := shared_path.twin
				-- Patrickr, 11/01/06 hack for backwards compatibility, the application is ec but
				-- the directory is studio
			if not is_unix_layout and application_name.is_equal ("ec") then
				Result.extend (short_studio_name)
			else
				Result.extend (application_name)
			end
		ensure
			shared_application_path_not_void: Result /= Void
		end

	Lib_application_path: DIRECTORY_NAME is
			-- Location of lib files specific for the current application (platform dependent).
		require
			is_valid_environment: is_valid_environment
		once
			Result := lib_path.twin
				-- Patrickr, 11/01/06 hack for backwards compatibility, the application is ec but
				-- the directory is studio
			if not is_unix_layout and application_name.is_equal ("ec") then
				Result.extend (short_studio_name)
			else
				Result.extend (application_name)
			end
		ensure
			lib_application_path_not_void: Result /= Void
		end

	Help_path: DIRECTORY_NAME is
			-- Location of help
		require
			is_valid_environment: is_valid_environment
		once
			Result := shared_application_path.twin
			Result.extend ("help")
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

	Templates_path: DIRECTORY_NAME is
			-- Location of templates.
		require
			is_valid_environment: is_valid_environment
		once
			Result := Help_path.twin
			Result.extend ("defaults")
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

	Config_path: DIRECTORY_NAME is
		require
			is_valid_environment: is_valid_environment
		once
			Result := shared_application_path.twin
			Result.extend ("config")
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

	Generation_templates_path: DIRECTORY_NAME is
			-- Location of templates used in code generation.
		require
			is_valid_environment: is_valid_environment
		once
			Result := Config_path.twin
			Result.extend_from_array (<<Eiffel_platform, "templates">>)
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

	Bitmaps_path: DIRECTORY_NAME is
		require
			is_valid_environment: is_valid_environment
		once
			Result := shared_application_path.twin
			Result.extend ("bitmaps")
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

	Cursor_path: DIRECTORY_NAME is
		require
			is_valid_environment: is_valid_environment
		once
			Result := Bitmaps_path.twin
			Result.extend ("cursor")
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

	Assemblies_path: DIRECTORY_NAME is
			-- Location of Eiffel Assembly Cache.
		require
			is_valid_environment: is_valid_environment
		once
			Result := lib_path.twin
			Result.extend_from_array (<<"dotnet", "assemblies">>)
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

	Default_config_name: FILE_NAME is
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (Templates_path)
			Result.set_file_name (Default_config_file)
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

	Library_path: DIRECTORY_NAME is
		require
			is_valid_environment: is_valid_environment
		once
			Result := Eiffel_library.twin
			Result.extend (library_directory_name)
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

	Error_path: DIRECTORY_NAME is
		require
			is_valid_environment: is_valid_environment
		once
			Result := help_path.twin
			Result.extend ("errors")
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

	built_ins_path (a_is_platform_neutral, a_is_dotnet: BOOLEAN): DIRECTORY_NAME is
			-- Directory where implementation for `built_ins' are found.
		require
			is_valid_environment: is_valid_environment
		do
			Result := studio_path.twin
			Result.extend ("built_ins")
			if a_is_platform_neutral then
				Result.extend ("neutral")
			else
				if a_is_dotnet then
					Result.extend ("dotnet")
				else
					Result.extend ("classic")
				end
			end
		ensure
			built_ins_path_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

	Docs_path: DIRECTORY_NAME is
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				Result := unix_layout_base_path.twin
				Result.extend_from_array (<<"share", "doc", product_version_name>>)
			else
				Result := eiffel_installation_dir_name.twin
			end
			Result.extend ("docs")
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

	filter_path: DIRECTORY_NAME is
		require
			is_valid_environment: is_valid_environment
		once
			Result := shared_application_path.twin
			Result.extend ("filters")
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

	profile_path: DIRECTORY_NAME is
			-- Location of the profiler configuration files
		require
			is_valid_environment: is_valid_environment
		once
			Result := shared_application_path.twin
			Result.extend ("profiler")
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

	language_path: DIRECTORY_NAME is
			-- Location of the .mo files
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				Result := unix_layout_share_path.twin
				Result.extend_from_array (<< unix_layout_locale_dir, product_version_name >>)
			else
				Result := shared_path.twin
				Result.extend (short_studio_name)
				Result.extend_from_array (<<"lang", "mo_files">>)
			end
		end

	predefined_metrics_file: FILE_NAME is
			-- File to store predefined metrics
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (shared_application_path)
			Result.extend ("metrics")
			Result.set_file_name ("predefined_metrics.xml")
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

	New_project_wizards_path: DIRECTORY_NAME is
			-- Location of new project wizards.
		require
			is_valid_environment: is_valid_environment
		once
			Result := lib_application_path.twin
			Result.extend_from_array (<<"wizards", "new_projects">>)
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

	precompilation_wizard_resources_directory: DIRECTORY_NAME is
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "wizards", "others", "precompile">>)
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

	compiler_configuration: FILE_NAME is
			-- Platform specific system level resource specification file
			-- ($ISE_EIFFEL/eifinit/application_name/spec/$ISE_PLATFORM)
		require
			is_valid_environment: is_valid_environment
		do
			create Result.make_from_string (shared_application_path)
			Result.extend ("eifinit")
			Result.set_file_name ("general")
			Result.add_extension ("cfg")
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

	msil_culture_name: FILE_NAME is
			-- Culture specification file
		require
			is_windows: Platform.is_windows
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (shared_application_path)
			Result.extend_from_array (<<"eifinit", "spec", Platform_abstraction>>)
			Result.set_file_name ("culture")
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

	tmp_directory: DIRECTORY_NAME is
			-- Locate of the temporary directory
		once
			create Result.make
			Result.set_directory ("tmp")
		ensure
			Result_ok: Result /= Void and then not Result.is_empty
		end

	borland_directory: DIRECTORY_NAME is
			-- Location of the borland directory
		require
			has_borland: has_borland
			not_unix_layout: not is_unix_layout
		once
			create Result.make_from_string (eiffel_installation_dir_name)
			Result.extend ("BCC55")
		ensure
			Result_ok: Result /= Void and then not Result.is_empty
		end

feature -- Access: user files

	session_data_path: !DIRECTORY_NAME
			-- Location of stored session data.
		require
			is_valid_environment: is_valid_environment
		once
			Result ?= eiffel_home.twin
			Result.extend_from_array (<<"session">>)
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- Access: command name

	precompilation_wizard_command_name: FILE_NAME is
			-- Command to be executed to launch the precompilation wizard.
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (precompilation_wizard_resources_directory)
			Result.extend_from_array (<<"spec", Eiffel_platform>>)
			Result.set_file_name ("wizard")
			if not platform.is_unix then
				Result.add_extension (executable_suffix)
			end
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

	Freeze_command_name: FILE_NAME is
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				create Result.make_from_string (unix_layout_base_path)
				Result.extend ("bin")
			else
				create Result.make_from_string (bin_path)
			end
			Result.set_file_name (Finish_freezing_script)
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

	docking_standard_layout_path: FILE_NAME is
			-- Path of standard docking layout.
		local
			l_dir: DIRECTORY
		do
			create Result.make_from_string (eiffel_home)
			Result.extend_from_array (<<docking_data_name>>)
			create l_dir.make (Result)
			if not l_dir.exists then
				l_dir.create_dir
				if not l_dir.is_closed then
					l_dir.close
				end
			end
		ensure
			folder_exist: (create {DIRECTORY}.make (Result)).exists
		end

	Prelink_command_name: FILE_NAME is
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				create Result.make_from_string (lib_application_path)
			else
				create Result.make_from_string (bin_path)
			end
			Result.set_file_name ("prelink")
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

	ec_command_name: FILE_NAME is
			-- Complete path to `ec'.
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				create Result.make_from_string (unix_layout_base_path)
				Result.extend ("bin")
			else
				create Result.make_from_string (bin_path)
			end
			Result.set_file_name (ec_name)
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

	Estudio_command_name: FILE_NAME is
			-- Complete path to `estudio'.
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				create Result.make_from_string (unix_layout_base_path)
				Result.extend ("bin")
				Result.set_file_name ("estudio" + major_version.out + "." + minor_version.out)
			else
				create Result.make_from_string (bin_path)
				Result.set_file_name ("estudio")
			end

			if not platform.is_unix then
				Result.add_extension (executable_suffix)
			end
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

	Ecdbgd_command_name: FILE_NAME is
			-- Complete path to `ecdbgd'.
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				create Result.make_from_string (lib_application_path)
			else
				create Result.make_from_string (bin_path)
			end
			Result.set_file_name ("ecdbgd")
			if not platform.is_unix then
				Result.add_extension (executable_suffix)
			end
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

	Emake_command_name: FILE_NAME is
			-- Complete path to `emake'.
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				create Result.make_from_string (lib_application_path)
			else
				create Result.make_from_string (bin_path)
			end
			Result.set_file_name ("emake")
			if not platform.is_unix then
				Result.add_extension (executable_suffix)
			end
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

	Quick_finalize_command_name: FILE_NAME is
			-- Complete path to `quick_finalize'.
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				create Result.make_from_string (lib_application_path)
			else
				create Result.make_from_string (bin_path)
			end
			Result.set_file_name ("quick_finalize")
			if not platform.is_unix then
				Result.add_extension (executable_suffix)
			end
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

	compile_library_command_name: FILE_NAME is
			-- Complete path to `compile_library.bat'.
		require
			is_valid_environment: is_valid_environment
			is_windows: platform.is_windows
		once
			create Result.make_from_string (bin_path)
			Result.set_file_name ("compile_library")
			Result.add_extension ("bat")
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

	x2c_command_name: FILE_NAME is
			-- Complete path to `x2c'.
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				create Result.make_from_string (lib_application_path)
			else
				create Result.make_from_string (bin_path)
			end
			Result.set_file_name ("x2c")
			if not platform.is_unix then
				Result.add_extension (executable_suffix)
			end
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

feature -- Access: names

	ec_name: STRING is
		once
			Result := get_environment (ec_name_env)
			if Result = Void then
				create Result.make (6)
				Result.append ("ec")
				if is_unix_layout then
					Result.append (major_version.out.as_lower + "." + minor_version.out.as_lower)
				end
				if Platform.is_windows then
					Result.append (".exe")
				end
			end
		end

	Finish_freezing_script: STRING is
			-- Name of post-eiffel compilation processing to launch
			-- C code.
		once
			create Result.make_from_string ("finish_freezing")
			if is_unix_layout then
				Result.append (major_version.out.as_lower + "." + minor_version.out.as_lower)
			end
			if Platform.is_windows then
				Result.append (".exe")
			end
		end

feature -- Status

	has_borland: BOOLEAN is
			-- Is Borland C++ back-end C compiler?
		once
			Result := Platform.is_windows and then Eiffel_c_compiler.is_equal ("bcb")
		end

feature -- Environment access

	get_environment (a_var: STRING): STRING is
			-- Get `a_var' from the environment, taking into account the `application_name' to lookup the defaults.
		do
			Result := environment.get_from_application (a_var, application_name)
		end

feature -- Environment update

	set_environment (a_value, a_var: STRING) is
			-- Update environment variable `a_key' to be `a_value'.
		require
			a_var_ok: a_var /= Void and then not a_var.is_empty and then not a_var.has ('%U')
			a_value_ok: a_value /= Void and then not a_value.has ('%U')
		do
			environment.put (a_value, a_var)
		ensure
			value_updated: get_environment (a_var) /= Void implies get_environment (a_var).is_equal (a_value)
		end

feature -- IL environment

	default_il_environment: IL_ENVIRONMENT is
			-- Default il environment, using the newest available runtime.
		once
			create Result
		ensure
			Result_not_void: Result /= Void
		end

feature -- Version limitation

	has_diagram: BOOLEAN is True
			-- Does this version have the diagram tool?

	has_metrics: BOOLEAN is True
			-- Does this version have the metrics?

	has_profiler: BOOLEAN is True
			-- Does this version have the profiler?

	has_documentation_generation: BOOLEAN is True
			-- Does this version have the documentation generation?

	has_xmi_generation: BOOLEAN is True
			-- Does this version have the XMI generation?

	has_dll_generation: BOOLEAN is True
			-- Does this version have the DLL generation?

	has_signable_generation: BOOLEAN is True;
			-- Does this version allow the signing of .NET assemblies

feature -- File constants

	Default_config_file: STRING is "default.ecf"

	library_directory_name: STRING is "library"
			-- Name of the library directory.

	short_studio_name: STRING is "studio";
			-- Short version of EiffelStudio name.

	Default_project_location_for_windows: STRING is "C:\projects"
			-- Default project location on windows.

feature -- Environment constants

	ise_eiffel_env: STRING is "ISE_EIFFEL"
		-- Installation location.

	ise_library_env: STRING is "ISE_LIBRARY"
		-- Location of the library folder.

	ise_precomp_env: STRING is "ISE_PRECOMP"
		-- Precompile location.

	ise_platform_env: STRING is "ISE_PLATFORM"
		-- Platform.

	ise_c_compiler_env: STRING is "ISE_C_COMPILER"
		-- C compiler (windows only)

	ise_projects_env: STRING is "ISE_PROJECTS"

	ec_name_env: STRING is "EC_NAME"
		-- ec executable name.

feature -- Constants

	Executable_suffix: STRING is
			-- Platform specific executable extension.
		once
			if not Platform.is_unix then
				Result := "exe"
			else
				Result := ""
			end
		end

	platform: PLATFORM_CONSTANTS
		once
			create Result
		end

feature {NONE} -- Implementation

	Studio_path: DIRECTORY_NAME is
			-- Location of studio
		require
			not_unix_layout: not is_unix_layout
			is_valid_environment: is_valid_environment
		once
			Result := eiffel_installation_dir_name.twin
			Result.extend (short_studio_name)
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

feature {NONE} -- Environment access

	environment: ENVIRONMENT_ACCESS
		once
			create Result
		end

	safe_create_dir (a_dir: STRING) is
			-- Try to create a directory `a_dir'.
		require
			a_dir_not_void: a_dir /= Void
		local
			l_dir: DIRECTORY
			retried: BOOLEAN
		do
			if not retried then
				create l_dir.make (a_dir)
				l_dir.create_dir
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Configuration of layout

	unix_layout_base_path: DIRECTORY_NAME
			-- Base for the unix layout. e.g. "/usr" or "/usr/local"
		once
			create Result.make
			Result.set_directory ("usr")
			Result.extend ("local")
		ensure
			Result_not_void: Result /= Void
		end

	unix_layout_share_path: DIRECTORY_NAME
			-- share for the unix layout. e.g. "/usr/share"
		once
			create Result.make_from_string ("/usr/share") -- Comment to finde line for replacement UNIX_BASE_PATH
		ensure
			Result_not_void: Result /= Void
		end

	unix_layout_lib_dir: STRING is
			-- Directory name for lib. e.g. "lib" or "lib64"
		once
			create Result.make_from_string ("lib") -- Comment to finde line for replacement UNIX_LIB_NAME
		ensure
			Result_not_void: Result /= Void
		end

	unix_layout_locale_dir: STRING is
			-- Directory name for lib. e.g. "locale"
		once
			create Result.make_from_string ("locale") -- Comment to finde line for replacement UNIX_LIB_NAME
		ensure
			Result_not_void: Result /= Void
		end

	unix_layout_platform: STRING is "unix";
			-- Platform to use for the unix layout.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
