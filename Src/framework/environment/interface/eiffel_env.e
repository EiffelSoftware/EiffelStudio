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
				io.error.put_string (p.Workbench_name)
				io.error.put_string (": the environment variable $"+ise_eiffel_env+" is not set.%N")
				(create {EXCEPTIONS}).die (-1)
			else
				create l_file.make (temp)
				if not l_file.exists or not l_file.is_directory then
					io.error.put_string ("WARNING: the environment variable $"+ise_eiffel_env+" points to a non-existing directory.%N")
				else
						-- put it into the environment for backward compatibility
					environment.put (temp, ise_eiffel_env)
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
				io.error.put_string (p.Workbench_name)
				io.error.put_string (": the environment variable $"+ise_platform_env+" is not set%N")
				(create {EXCEPTIONS}).die (-1)
			else
					-- we have now a valid environment, although we may have some warnings
				is_valid_environment := True
				create l_file.make (bin_path)
				if not l_file.exists or not l_file.is_directory then
					io.error.put_string ("WARNING: the path $"+ise_eiffel_env+"/studio/spec/$"+ise_platform_env+"/bin points to a non-existing directory.%N")
				else
						-- put it into the environment for backward compatibility
					environment.put (temp, ise_platform_env)
				end
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
			if get_environment (ise_library_env) = Void then
				environment.put (eiffel_installation_dir_name, ise_library_env)
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

feature -- Version

	Major_version: NATURAL_16 is 5
	Minor_version: NATURAL_16 is 7

feature -- Access

	application_name: STRING is
			-- Name of the application.
		deferred
		ensure
			result_ok: Result /= Void and then not Result.is_empty
		end

feature -- Preferences

	Eiffel_preferences: STRING is
			-- Preferences location
		local
			fname: FILE_NAME
		once
			if platform.is_windows then
				Result := "HKEY_CURRENT_USER\Software\ISE\Eiffel" +
					major_version.out + minor_version.out + "\"+application_name+"\Preferences"
			else
				create fname.make_from_string (eiffel_home)
				fname.set_file_name ("."+application_name+"rc" + major_version.out + minor_version.out)
				Result := fname
			end
			if is_workbench then
				Result.append ("_wkbench")
			end
		end

	general_preferences: FILE_NAME is
			-- Platform independent preferences.
		require
			is_valid_environment: is_valid_environment
		do
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<"eifinit", short_studio_name>>)
			Result.set_file_name ("default")
			Result.add_extension ("xml")
		ensure
			result_not_void_or_empty: Result /= Void and then not Result.is_empty
		end

	platform_preferences: FILE_NAME is
			-- Platform specific preferences.
		do
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<"eifinit", short_studio_name, "spec", Platform_abstraction>>)
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

	Eiffel_projects_directory: STRING is
			-- ISE_PROJECTS name.
		once
			Result := get_environment (ise_projects_env)
		end

	Eiffel_home: DIRECTORY_NAME is
			-- Name of directory containing Eiffel specific data.
		once
			create Result.make_from_string (Home)
			if platform.is_windows then
				Result.extend ("EiffelSoftware")
			else
				Result.extend (".es")
			end
		ensure
			result_not_void: Result /= Void
		end

	Home: STRING is
			-- HOME name.
		once
			Result := environment.home_directory_name
			if Result = Void then
				Result := ""
			end
		ensure
			result_not_void: Result /= Void
		end

feature -- Access: file name

	Eiffel_installation_dir_name: DIRECTORY_NAME is
			-- Installation of ISE Eiffel name.
		once
			create Result.make_from_string (get_environment (ise_eiffel_env))
		ensure
			result_not_void_or_empty: is_valid_environment implies Result /= Void and not Result.is_empty
		end

	Eiffel_library: DIRECTORY_NAME is
			-- ISE_LIBRARY name.
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (get_environment (ise_library_env))
		ensure
			result_not_void_or_empty: Result /= Void and not Result.is_empty
		end

	Eiffel_precomp: DIRECTORY_NAME is
			-- ISE_PRECOMP name.
		require
			is_valid_precompile_environment: is_valid_precompile_environment
		do
			create Result.make_from_string (get_environment (ise_precomp_env))
		ensure
			result_not_void_or_empty: Result /= Void and not Result.is_empty
		end

	Eiffel_precomp_mode (a_is_dotnet: BOOLEAN): DIRECTORY_NAME
			-- Retrieve precomp location.
		require
			is_valid_environment: is_valid_environment
		do
			Result := eiffel_installation_dir_name.twin
			Result.extend_from_array (<<"precomp", "spec">>)
			if a_is_dotnet then
				Result.extend ("dotnet")
			else
				Result.extend (eiffel_platform)
			end
		ensure
			result_ok: Result /= Void and then not Result.is_empty
		end

	Studio_path: DIRECTORY_NAME is
			-- Location of studio
		require
			is_valid_environment: is_valid_environment
		once
			Result := eiffel_installation_dir_name.twin
			Result.extend (short_studio_name)
		ensure
			result_not_void_or_empty: Result /= Void and not Result.is_empty
		end

	Help_path: DIRECTORY_NAME is
			-- Location of help
		require
			is_valid_environment: is_valid_environment
		once
			Result := Studio_path.twin
			Result.extend ("help")
		ensure
			result_not_void_or_empty: Result /= Void and not Result.is_empty
		end

	Templates_path: DIRECTORY_NAME is
			-- Location of templates.
		require
			is_valid_environment: is_valid_environment
		once
			Result := Help_path.twin
			Result.extend ("defaults")
		ensure
			result_not_void_or_empty: Result /= Void and not Result.is_empty
		end

	Config_path: DIRECTORY_NAME is
		require
			is_valid_environment: is_valid_environment
		once
			Result := Studio_path.twin
			Result.extend ("config")
		ensure
			result_not_void_or_empty: Result /= Void and not Result.is_empty
		end

	Config_eif: FILE_NAME is
		require
			windows: platform.is_windows
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (Config_path)
			Result.extend_from_array (<<eiffel_platform, eiffel_c_compiler>>)
			Result.set_file_name ("config")
			Result.add_extension ("eif")
		ensure
			result_not_void_or_empty: Result /= Void and not Result.is_empty
		end

	Generation_templates_path: DIRECTORY_NAME is
			-- Location of templates used in code generation.
		require
			is_valid_environment: is_valid_environment
		once
			Result := Config_path.twin
			Result.extend_from_array (<<Eiffel_platform, "templates">>)
		ensure
			result_not_void_or_empty: Result /= Void and not Result.is_empty
		end

	Bitmaps_path: DIRECTORY_NAME is
		require
			is_valid_environment: is_valid_environment
		once
			Result := Studio_path.twin
			Result.extend ("bitmaps")
		ensure
			result_not_void_or_empty: Result /= Void and not Result.is_empty
		end

	Cursor_path: DIRECTORY_NAME is
		require
			is_valid_environment: is_valid_environment
		once
			Result := Bitmaps_path.twin
			Result.extend ("cursor")
		ensure
			result_not_void_or_empty: Result /= Void and not Result.is_empty
		end

	Assemblies_path: DIRECTORY_NAME is
			-- Location of Eiffel Assembly Cache.
		require
			is_valid_environment: is_valid_environment
		once
			Result := eiffel_installation_dir_name.twin
			Result.extend_from_array (<<"dotnet", "assemblies">>)
		ensure
			result_not_void_or_empty: Result /= Void and not Result.is_empty
		end

	Default_class_file: FILE_NAME is
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (Templates_path)
			Result.set_file_name (Default_class_filename)
		ensure
			result_not_void_or_empty: Result /= Void and not Result.is_empty
		end

	Default_config_name: FILE_NAME is
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (Templates_path)
			Result.set_file_name (Default_config_file)
		ensure
			result_not_void_or_empty: Result /= Void and not Result.is_empty
		end

	Library_path: DIRECTORY_NAME is
		require
			is_valid_environment: is_valid_environment
		once
			Result := Eiffel_library.twin
			Result.extend (library_directory_name)
		ensure
			result_not_void_or_empty: Result /= Void and not Result.is_empty
		end

	Error_path: DIRECTORY_NAME is
		require
			is_valid_environment: is_valid_environment
		once
			Result := help_path.twin
			Result.extend ("errors")
		ensure
			result_not_void_or_empty: Result /= Void and not Result.is_empty
		end

	Docs_path: DIRECTORY_NAME is
		require
			is_valid_environment: is_valid_environment
		once
			Result := Eiffel_installation_dir_name.twin
			Result.extend ("docs")
		ensure
			result_not_void_or_empty: Result /= Void and not Result.is_empty
		end

	Bin_path: DIRECTORY_NAME is
		require
			is_valid_environment: is_valid_environment
		local
			l_p: STRING
		do
			l_p := get_environment (ec_folder_env)
			if l_p /= Void then
				create Result.make_from_string (l_p)
			else
				Result := Studio_path.twin
				Result.extend_from_array (<<"spec", Eiffel_platform, "bin">>)
			end
		ensure
			result_not_void_or_empty: Result /= Void and not Result.is_empty
		end

	filter_path: DIRECTORY_NAME is
		require
			is_valid_environment: is_valid_environment
		once
			Result := studio_path.twin
			Result.extend ("filters")
		ensure
			result_not_void_or_empty: Result /= Void and not Result.is_empty
		end

	profile_path: DIRECTORY_NAME is
			-- Location of the profiler configuration files
		require
			is_valid_environment: is_valid_environment
		once
			Result := studio_path.twin
			Result.extend ("profiler")
		ensure
			result_not_void_or_empty: Result /= Void and not Result.is_empty
		end

	predefined_metrics_file: FILE_NAME is
			-- File to store predefined metrics
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (studio_path)
			Result.extend ("metrics")
			Result.set_file_name ("predefined_metrics.xml")
		ensure
			result_not_void_or_empty: Result /= Void and not Result.is_empty
		end

	New_project_wizards_path: DIRECTORY_NAME is
			-- Location of new project wizards.
		require
			is_valid_environment: is_valid_environment
		once
			Result := studio_path.twin
			Result.extend_from_array (<<"wizards", "new_projects">>)
		ensure
			result_not_void_or_empty: Result /= Void and not Result.is_empty
		end

	precompilation_wizard_resources_directory: DIRECTORY_NAME is
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "wizards", "others", "precompile">>)
		ensure
			result_not_void_or_empty: Result /= Void and not Result.is_empty
		end

	compiler_configuration: FILE_NAME is
			-- Platform specific system level resource specification file
			-- ($ISE_EIFFEL/eifinit/application_name/spec/$ISE_PLATFORM)
		require
			is_valid_environment: is_valid_environment
		do
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<"eifinit", short_studio_name>>)
			Result.set_file_name ("general")
			Result.add_extension ("cfg")
		ensure
			result_not_void_or_empty: Result /= Void and not Result.is_empty
		end

	msil_culture_name: FILE_NAME is
			-- Culture specification file
		require
			is_windows: Platform.is_windows
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<"eifinit", short_studio_name, "spec", Platform_abstraction>>)
			Result.set_file_name ("culture")
		ensure
			result_not_void_or_empty: Result /= Void and not Result.is_empty
		end

	tmp_directory: DIRECTORY_NAME is
			-- Locate of the temporary directory
		once
			create Result.make
			Result.set_directory ("tmp")
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
			result_not_void_or_empty: Result /= Void and not Result.is_empty
		end

--	Ise_eac_browser_name: FILE_NAME is
--			-- Filename of EAC Browser application
--		once
--			create Result.make_from_string (bin_path)
--			Result.set_file_name ("eac_browser.exe")
--		end

	Freeze_command_name: FILE_NAME is
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (bin_path)
			Result.set_file_name (Finish_freezing_script)
		ensure
			result_not_void_or_empty: Result /= Void and not Result.is_empty
		end

	Prelink_command_name: FILE_NAME is
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (bin_path)
			Result.set_file_name ("prelink")
		ensure
			result_not_void_or_empty: Result /= Void and not Result.is_empty
		end

	ec_command_name: FILE_NAME is
			-- Complete path to `ec'.
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (bin_path)
			Result.set_file_name (ec_name)
		ensure
			result_not_void_or_empty: Result /= Void and not Result.is_empty
		end

	Estudio_command_name: FILE_NAME is
			-- Complete path to `estudio'.
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (bin_path)
			Result.set_file_name ("estudio")
			if not platform.is_unix then
				Result.add_extension (executable_suffix)
			end
		ensure
			result_not_void_or_empty: Result /= Void and not Result.is_empty
		end

	Ecdbgd_command_name: FILE_NAME is
			-- Complete path to `ecdbgd'.
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (bin_path)
			Result.set_file_name ("ecdbgd")
			if not platform.is_unix then
				Result.add_extension (executable_suffix)
			end
		ensure
			result_not_void_or_empty: Result /= Void and not Result.is_empty
		end

	Emake_command_name: FILE_NAME is
			-- Complete path to `emake'.
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (bin_path)
			Result.set_file_name ("emake")
			if not platform.is_unix then
				Result.add_extension (executable_suffix)
			end
		ensure
			result_not_void_or_empty: Result /= Void and not Result.is_empty
		end

	Quick_finalize_command_name: FILE_NAME is
			-- Complete path to `quick_finalize'.
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (bin_path)
			Result.set_file_name ("quick_finalize")
			if not platform.is_unix then
				Result.add_extension (executable_suffix)
			end
		ensure
			result_not_void_or_empty: Result /= Void and not Result.is_empty
		end

feature -- Access: names

	ec_name: STRING is
		once
			Result := get_environment (ec_name_env)
			if Result = Void then
				create Result.make (6)
				Result.append ("ec")
				if Platform.is_windows then
					Result.append (".exe")
				end
			end
		end

	Finish_freezing_script: STRING is
			-- Name of post-eiffel compilation processing to launch
			-- C code.
		once
			if Platform.is_windows then
				Result := "finish_freezing.exe"
			else
				Result := "finish_freezing"
			end
		end

feature -- Status

	has_borland: BOOLEAN is
			-- Is Borland C++ back-end C compiler?
		once
			Result := Platform.is_windows and then Eiffel_c_compiler.is_equal ("bcb")
		end

	is_unix_layout: BOOLEAN
			-- Is eiffelstudio installed in the unix layout?

feature -- Environment access

	get_environment (a_var: STRING): STRING is
			-- Get `a_var' from the environment, taking into account the `application_name' to lookup the defaults.
		do
			Result := environment.get_from_application (a_var, application_name)
		end

feature -- Version limitation

	has_case: BOOLEAN is True
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

	Default_class_filename: STRING is "default.cls"

	Default_config_file: STRING is "default.ecf"

	library_directory_name: STRING is "library"
			-- Name of the library directory.

	short_studio_name: STRING is "studio";
			-- Short version of EiffelStudio name.

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

	ec_folder_env: STRING is "EC_FOLDER"
		-- Location of the binaries.

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
