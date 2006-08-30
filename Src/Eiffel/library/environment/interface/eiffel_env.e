indexing

	description:
		"Environment for bitmaps, help, binaries, scripts...."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class EIFFEL_ENV

feature -- Status

	check_environment_variable is
			-- Check if $ISE_EIFFEL and $ISE_PLATFORM are correctly set?
		local
			temp: STRING
			p: PRODUCT_NAMES
			l_file: RAW_FILE
			l_dir: DIRECTORY
		do
			temp := Eiffel_installation_dir_name
			create p
			if (temp = Void) or else temp.is_empty then
				io.error.put_string (p.Workbench_name)
				io.error.put_string (": the environment variable $ISE_EIFFEL is not set.%N")
				(create {EXCEPTIONS}).die (-1)
			else
				create l_file.make (temp)
				if not l_file.exists or not l_file.is_directory then
					io.error.put_string ("WARNING: the environment variable $ISE_EIFFEL points to a non-existing directory.%N")
				end
			end

			temp := Eiffel_platform
			if (temp = Void) or else temp.is_empty then
				io.error.put_string (p.Workbench_name)
				io.error.put_string (": the environment variable $ISE_PLATFORM is not set%N")
				(create {EXCEPTIONS}).die (-1)
			else
				create l_file.make (bin_path)
				if not l_file.exists or not l_file.is_directory then
					io.error.put_string ("WARNING: the path $ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin points to a non-existing directory.%N")
				end
			end

			if Platform.is_windows then
				temp := Eiffel_c_compiler
				if (temp = Void) or else temp.is_empty then
					io.error.put_string (p.Workbench_name)
					io.error.put_string (": the environment variable $ISE_C_COMPILER is not set%N")
					(create {EXCEPTIONS}).die (-1)
				end
			end

				-- Make sure to define ISE_LIBRARY if not defined.
			if environment.get (ise_library_env) = Void then
				environment.put (eiffel_installation_dir_name, ise_library_env)
			end

				-- Check that `eiffel_home' exists.
			create l_file.make (eiffel_home)
			if not l_file.exists or else not l_file.is_directory then
				create l_dir.make (eiffel_home)
				l_dir.create_dir
			end
		end

	set_precompile (a_is_dotnet: BOOLEAN) is
			-- Set up the ISE_PRECOMP environment variable, depending on `a_is_dotnet'.
		local
			l_path: DIRECTORY_NAME
		do
			create l_path.make_from_string (eiffel_installation_dir_name)
			l_path.extend_from_array (<<"precomp", "spec">>)
			if a_is_dotnet then
				l_path.extend ("dotnet")
			else
				l_path.extend (eiffel_platform)
			end
			environment.put (l_path, ise_precomp_env)
		end

feature -- Status report

	frozen is_workbench: BOOLEAN is
			-- Are we running the workbench version of the compiler?
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"EIF_IS_WORKBENCH"
		end

feature -- Version

	major_version: NATURAL_16 is 5
	minor_version: NATURAL_16 is 7

feature -- Preferences

	Eiffel_preferences: STRING is
			-- Preferences location
		local
			fname: FILE_NAME
		once
			if platform.is_windows then
				Result := "HKEY_CURRENT_USER\Software\ISE\Eiffel" +
					major_version.out + minor_version.out + "\ec\Preferences"
			else
				create fname.make_from_string (eiffel_home)
				fname.set_file_name (".ecrc" + major_version.out + minor_version.out)
				Result := fname
			end
			if is_workbench then
				Result.append ("_wkbench")
			end
		end

feature -- Access: environment variable

	Eiffel_installation_dir_name: STRING is
			-- Installation of ISE Eiffel name.
		once
			Result := environment.get ("ISE_EIFFEL")
		ensure
			eiffel_installation_dir_name_not_void: Result /= Void
		end

	Eiffel_library: STRING is
			-- ISE_LIBRARY name.
		once
			Result := environment.get ("ISE_LIBRARY")
		ensure
			eiffel_library_not_void: Result /= Void
		end

	Eiffel_precomp: STRING is
			-- ISE_PRECOMP name.
		do
			Result := environment.get ("ISE_PRECOMP")
		ensure
			result_not_void: Result /= Void
		end

	Eiffel_c_compiler: STRING is
			-- ISE_C_COMPILER name.
		once
			Result := environment.get ("ISE_C_COMPILER")
		ensure
			eiffel_c_compiler_not_void: platform.is_windows implies Result /= Void
		end

	Eiffel_platform: STRING is
			-- ISE_PLATFORM name.
		once
			Result := environment.get ("ISE_PLATFORM")
		ensure
			eiffel_platform_not_void: Result /= Void
		end

	Eiffel_defaults: STRING is
			-- ISE_DEFAULTS name.
		once
			Result := environment.get ("ISE_DEFAULTS")
		end

	Eiffel_projects_directory: STRING is
			-- ISE_PROJECRS name.
		once
			Result := environment.get ("ISE_PROJECTS")
		end

	eiffel_home: DIRECTORY_NAME is
			-- Name of directory containing Eiffel specific data.
		once
			create Result.make_from_string (Home)
			if platform.is_windows then
				Result.extend ("EiffelStudio")
			else
				Result.extend (".ec")
			end
		ensure
			Eiffel_home_not_empty: Result /= Void
		end

	Home: STRING is
			-- HOME name.
		once
			Result := environment.home_directory_name
			if Result = Void then
				Result := ""
			end
		ensure
			home_not_void: Result /= Void
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
			platform_abstraction_not_void: Result /= Void
		end

feature -- Access: file name

	Templates_path: FILE_NAME is
			-- Location of templates.
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "help", "defaults">>)
		ensure
			result_not_void: Result /= Void
		end

	Generation_templates_path: FILE_NAME is
			-- Location of templates used in code generation.
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "config", Eiffel_platform, "templates">>)
		ensure
			generation_templates_path_not_void: Result /= Void and not Result.is_empty
		end

	Assemblies_path: FILE_NAME is
			-- Location of Eiffel Assembly Cache.
		once
			create Result.make_from_string ("$ISE_EIFFEL")
			Result.extend_from_array (<<"dotnet", "assemblies">>)
		ensure
			result_not_void: Result /= Void
		end

	Default_class_file: FILE_NAME is
		once
			Result := Templates_path.twin
			Result.set_file_name (Default_class_filename)
		end

	Default_config_name: FILE_NAME is
		once
			create Result.make_from_string (Templates_path)
			Result.set_file_name (Default_config_file)
		end

	Bitmaps_path: DIRECTORY_NAME is
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "bitmaps">>)
		ensure
			Result_not_void: Result /= Void
		end

	Cursor_path: DIRECTORY_NAME is
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "bitmaps", "cursor">>)
		ensure
			Result_not_void: Result /= Void
		end

	Library_path: DIRECTORY_NAME is
		once
			create Result.make_from_string (Eiffel_library)
			Result.extend (library_directory_name)
		ensure
			Result_not_void: Result /= Void
		end

	Syntax_path: DIRECTORY_NAME is
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "syntax">>)
		ensure
			Result_not_void: Result /= Void
		end

	Help_path: DIRECTORY_NAME is
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "help", "errors">>)
		ensure
			Result_not_void: Result /= Void
		end

	Docs_path: DIRECTORY_NAME is
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend ("docs")
		ensure
			Result_not_void: Result /= Void
		end

	Bin_path: FILE_NAME is
			-- Partial file name that points to bin directory of Eiffel installation.
			-- Therefore it is not a once function since we need to create
			-- a new instance each time it is called so that caller can then
			-- calls `set_file_name' on returned object.
		do
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "spec", Eiffel_platform, "bin">>)
		end

	filter_path: DIRECTORY_NAME is
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "filters">>)
		end

	profile_path: DIRECTORY_NAME is
			-- Location of the profiler configuration files
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array(<<short_studio_name, "profiler">>)
		end

	predefined_metrics_file: FILE_NAME is
			-- File to store predefined metrics
		once
			create Result.make_from_string (eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "metrics">>)
			Result.set_file_name ("predefined_metrics.xml")
		ensure
			predefined_metrics_file_not_void: Result /= Void
			predefined_metrics_file_not_empty: not Result.is_empty
		end

	New_project_wizards_path: DIRECTORY_NAME is
			-- Location of new project wizards.
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "wizards", "new_projects">>)
		end

	precompilation_wizard_command_name: FILE_NAME is
			-- Command to be executed to launch the precompilation wizard.
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "wizards", "others", "precompile", "spec", Eiffel_platform>>)
			Result.set_file_name ("wizard")
		end

	precompilation_wizard_resources_directory: DIRECTORY_NAME is
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "wizards", "others", "precompile">>)
		end

	last_opened_projects_resource_name: STRING is "studio_recent_files"

	general_preferences: FILE_NAME is
			-- Platform independent preferences.
		do
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<"eifinit", short_studio_name>>)
			Result.set_file_name ("default")
			Result.add_extension ("xml")
		ensure
			general_preferences_not_void: Result /= Void
			general_preferences_not_empty: not Result.is_empty
		end

	platform_preferences: FILE_NAME is
			-- Platform specific preferences.
		do
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<"eifinit", short_studio_name, "spec", Platform_abstraction>>)
			Result.set_file_name ("default")
			Result.add_extension ("xml")
		ensure
			platform_preferences_not_void: Result /= Void
			platform_preferences_not_empty: not Result.is_empty
		end

	compiler_configuration: FILE_NAME is
			-- Platform specific system level resource specification file
			-- ($ISE_EIFFEL/eifinit/application_name/spec/$ISE_PLATFORM)
		require
			Eiffel_installation_dir_name_not_void: Eiffel_installation_dir_name /= Void
			Eiffel_platform: Eiffel_platform /= Void
		do
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<"eifinit", short_studio_name>>)
			Result.set_file_name ("general")
			Result.add_extension ("cfg")
		ensure
			compiler_configuration_not_void: Result /= Void
			compiler_configuration_not_empty: not Result.is_empty
		end

	msil_culture_name: FILE_NAME is
			-- Culture specification file
		require
			is_windows: Platform.is_windows
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<"eifinit", short_studio_name, "spec", Platform_abstraction>>)
			Result.set_file_name ("culture")
		end

	tmp_directory: DIRECTORY_NAME is
			-- Locate of the temporary directory
		once
			create Result.make
			Result.set_directory ("tmp")
		end

	Ise_eac_browser_name: FILE_NAME is
			-- Filename of EAC Browser application
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "spec", Eiffel_platform, "bin">>)
			Result.set_file_name (Eac_browser_file)
		end

	eiffelsoftware_runtime_path: STRING is
			-- Path to EiffelSoftware.Runtime.dll
		local
			l_separator: CHARACTER
		once
			l_separator := (create {OPERATING_ENVIRONMENT}).directory_separator
			create Result.make (short_studio_name.count + 63)
			Result.append ("$ISE_EIFFEL")
			Result.append_character (l_separator)
			Result.append (short_studio_name)
			Result.append_character (l_separator)
			Result.append ("spec")
			Result.append_character (l_separator)
			Result.append ("$ISE_PLATFORM")
			Result.append_character (l_separator)
			Result.append ("lib")
			Result.append_character (l_separator)
			Result.append ("EiffelSoftware.Runtime.dll")
		end

feature -- Access: command name

	Freeze_command_name: FILE_NAME is
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "spec", Eiffel_platform, "bin">>)
			Result.set_file_name (Finish_freezing_script)
		end

	Prelink_command_name: FILE_NAME is
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "spec", Eiffel_platform, "bin">>)
			Result.set_file_name (Prelink_script)
		end

	ec_name: STRING is
		once
			Result := environment.get (ec_name_env)
			if Result = Void then
				create Result.make (6)
				Result.append ("ec")
				if Platform.is_windows then
					Result.append (".exe")
				end
			end
		end

	ec_command_name: FILE_NAME is
			-- Complete path to `ec'.
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "spec", Eiffel_platform, "bin">>)
			Result.set_file_name (ec_name)
		end

	Estudio_command_name: FILE_NAME is
			-- Complete path to `estudio'.
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "spec", Eiffel_platform, "bin">>)
			Result.set_file_name ("estudio")
		end

	Ecdbgd_command_name: FILE_NAME is
			-- Complete path to `ecdbgd'.
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "spec", Eiffel_platform, "bin">>)
			Result.set_file_name ("ecdbgd")
			if Platform.is_windows then
				Result.add_extension ("exe")
			end
		ensure
			result_not_void: Result /= Void
		end

	ec_folder: DIRECTORY_NAME is
			-- Path to the binaries.
		local
			l_p: STRING
		once
			l_p := environment.get (ec_folder_env)
			if l_p /= Void then
				create Result.make_from_string (l_p)
			else
				create Result.make_from_string (Eiffel_installation_dir_name)
				Result.extend_from_array (<<short_studio_name, "spec", Eiffel_platform, "bin">>)
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

feature -- Constants

	Default_class_filename: STRING is "default.cls"

	Default_config_file: STRING is "default.ecf"

	ise_library_env: STRING is "ISE_LIBRARY"
			-- Name of the ISE_LIBRARY environment variable.

	ise_precomp_env: STRING is "ISE_PRECOMP"
			-- Name of the ISE_PRECOMP environment variable.

	ec_name_env: STRING is "EC_NAME"
			-- Name of the EC_NAME environment variable.

	ec_folder_env: STRING is "EC_FOLDER"
			-- Name of the EC_FOLDER environment variable.

	library_directory_name: STRING is "library"
			-- Name of the library directory.

	short_studio_name: STRING is "studio";
			-- Short version of EiffelStudio name.

	Prelink_script: STRING is "prelink"

	Eac_browser_file: STRING is "eac_browser.exe"

	Executable_suffix: STRING is
			-- Platform specific executable extension.
		once
			if not Platform.is_unix then
				Result := "exe"
			else
				Result := ""
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

feature

	platform: PLATFORM_CONSTANTS
		once
			create Result
		end

feature {NONE}

	environment: EXECUTION_ENVIRONMENT
		once
			create Result
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

end -- class EIFFEL_ENV
