indexing

	description: 
		"Environment for bitmaps, help, binaries, scripts...."
	date: "$Date$"
	revision: "$Revision$"

class EIFFEL_ENV

inherit
	SYSTEM_CONSTANTS

	SHARED_EXEC_ENVIRONMENT

feature -- Status

	check_environment_variable is
			-- Check if $ISE_EIFFEL and $ISE_PLATFORM are correctly set?
		local
			temp: STRING
			p: PRODUCT_NAMES
		do
			temp := Eiffel_installation_dir_name
			create p
			if (temp = Void) or else temp.is_empty then
				io.error.putstring (p.Workbench_name)
				io.error.putstring (": the environment variable $ISE_EIFFEL is not set%N")
				(create {EXCEPTIONS}).die (-1)
			end

			temp := Eiffel_platform
			if (temp = Void) or else temp.is_empty then
				io.error.putstring (p.Workbench_name)
				io.error.putstring (": the environment variable $ISE_PLATFORM is not set%N")
				(create {EXCEPTIONS}).die (-1)
			end
			
			if Platform_constants.is_windows then
				temp := Eiffel_c_compiler
				if (temp = Void) or else temp.is_empty then
					io.error.putstring (p.Workbench_name)
					io.error.putstring (": the environment variable $ISE_C_COMPILER is not set%N")
					(create {EXCEPTIONS}).die (-1)
				end
			end
		end

feature -- Access: environment variable

	Eiffel_installation_dir_name: STRING is
			-- Installation of ISE Eiffel name.
		once
			Result := Execution_environment.get ("ISE_EIFFEL")
		end

	Eiffel_license: STRING is
			-- ISE_LICENSE name.
		once
			Result := Execution_environment.get ("ISE_LICENSE")
		end

	Eiffel_c_compiler: STRING is
			-- ISE_C_COMPILER name.
		once
			Result := Execution_environment.get ("ISE_C_COMPILER")
		end
		
	Eiffel_platform: STRING is
			-- ISE_PLATFORM name.
		once
			Result := Execution_environment.get ("ISE_PLATFORM")
		end

	Eiffel_defaults: STRING is
			-- ISE_DEFAULTS name.
		once
			Result := Execution_environment.get ("ISE_DEFAULTS")
		end

	Eiffel_projects_directory: STRING is
			-- ISE_PROJECRS name.
		once
			Result := Execution_environment.get ("ISE_PROJECTS")
		end

	Home: STRING is
			-- HOME name.
		once
			Result := Execution_environment.get ("HOME")
		end

	Platform_abstraction: STRING is
			-- Abstraction between Windows and Unix.
		once
			if Platform_constants.is_windows then
				Result := "windows"
			else
				Result := "unix"
			end
		end

	short_studio_name: STRING is "studio"
			-- Short version of EiffelStudio name.

feature -- Access: file name

	Eiffel_recent_projects: STRING is
			-- Recent projects location
		local
			fname: FILE_NAME
		once
			if Platform_constants.is_windows then
				Result := "HKEY_CURRENT_USER\Software\ISE\Eiffel54\recent projects"
			else
				create fname.make_from_string (Execution_environment.home_directory_name)
				fname.set_file_name (".ec_recent_projects")
				Result := fname
			end
		end
	
	Eiffel_preferences: STRING is
			-- Preferences location
		local
			fname: FILE_NAME
		once
			if Platform_constants.is_windows then
				Result := "HKEY_CURRENT_USER\Software\ISE\Eiffel54"
			else
				create fname.make_from_string (Execution_environment.home_directory_name)
				fname.set_file_name (".ecrc")
				Result := fname
			end
		end

	Templates_path: FILE_NAME is
			-- Location of templates.
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "help", "defaults", Eiffel_platform>>)
		end

	Generation_templates_path: FILE_NAME is
			-- Location of templates used in code generation.
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "config", Eiffel_platform, "templates">>)
		ensure
			generation_templates_path_not_void: Result /= Void and not Result.is_empty
		end
		
	Assemblies_path (clr_version: STRING): FILE_NAME is
			-- Location of Eiffel Assembly Cache.
		require
			clr_version_not_void: clr_version /= Void
		once
			create Result.make_from_string ("$ISE_EIFFEL")
			Result.extend_from_array (<<"dotnet", "assemblies">>)
		end
		
	Default_class_file: FILE_NAME is
		once
			Result := clone (Templates_path)
			Result.set_file_name (Default_class_filename)
		end

	Default_ace_name: FILE_NAME is
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "help", "defaults", Eiffel_platform>>)
			Result.set_file_name (Default_ace_file)
		end

	Bitmaps_path: DIRECTORY_NAME is
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "bitmaps">>)
		end

	Cursor_path: DIRECTORY_NAME is
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "bitmaps", "cursor">>)
		end

	Help_path: DIRECTORY_NAME is
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "help", "errors">>)
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

	Default_precompiled_location: DIRECTORY_NAME is
			-- Default location for the precompiled base
			-- $ISE_EIFFEL/precomp/spec/$ISE_PLATFORM
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<"precomp", "spec", Eiffel_platform>>)
		end

	Default_precompiled_base_location: DIRECTORY_NAME is
			-- Default location for the precompiled base
			-- $ISE_EIFFEL/precomp/spec/$ISE_PLATFORM/base
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<"precomp", "spec", Eiffel_platform, "base">>)
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
			Result.extend_from_array (<<short_studio_name, "wizards", "precompile", "spec", Eiffel_platform>>)
			Result.set_file_name ("wizard")
		end

	precompilation_wizard_resources_directory: DIRECTORY_NAME is
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "wizards", "precompile">>)
		end

	last_opened_projects_resource_name: STRING is "studio_recent_files"

	default_file_name: FILE_NAME is
			-- Default recent project file name
		do
			create Result.make_from_string (Eiffel_installation_dir_name)
			if Platform_constants.is_windows then
				Result.extend_from_array (<<"eifinit", short_studio_name, "spec", "windows">>)
			else
				Result.extend_from_array (<<"eifinit", short_studio_name, "spec", "gtk">>)
			end
			Result.set_file_name ("default_recent_projects")
			Result.add_extension ("xml")
		ensure
			Result_not_empty: Result /= Void
		end

	system_general: FILE_NAME is
			-- General system level resource specification file
			-- ($ISE_EIFFEL/eifinit/application_name/general)
		do
			create Result.make_from_string (Eiffel_installation_dir_name)
			if Platform_constants.is_windows then
				Result.extend_from_array (<<"eifinit", short_studio_name, "spec", "windows">>)
			else
				Result.extend_from_array (<<"eifinit", short_studio_name, "spec", "gtk">>)
			end
			Result.set_file_name ("default")
			Result.add_extension ("xml")
		ensure
			Result_not_empty: Result /= Void
		end

	msil_culture_name: FILE_NAME is
			-- Culture specification file
		require
			is_windows: Platform_constants.is_windows
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<"eifinit", short_studio_name, "spec", "windows">>)
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

feature -- Access: command name

	Freeze_command_name: FILE_NAME is
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "spec", Eiffel_platform, "bin">>)
			Result.set_file_name (Platform_constants.Finish_freezing_script)
		end

	Prelink_command_name: FILE_NAME is
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "spec", Eiffel_platform, "bin">>)
			Result.set_file_name (Prelink_script)
		end

	Estudio_command_name: FILE_NAME is
			-- Complete path to `estudio'.
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "spec", Eiffel_platform, "bin">>)
			Result.set_file_name ("estudio")
		end

feature -- Status

	has_borland: BOOLEAN is
			-- Is Borland C++ back-end C compiler?
		once
			Result := Platform_constants.is_windows and then Eiffel_c_compiler.is_equal ("bcb")
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
			
	has_signable_generation: BOOLEAN is True
			-- Does this version allow the signing of .NET assemblies

end -- class EIFFEL_ENV
