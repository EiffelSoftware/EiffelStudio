indexing

	description: 
		"Environment for bitmaps, help, binaries, scripts...."
	date: "$Date$"
	revision: "$Revision$"

class EIFFEL_ENV

inherit
	SYSTEM_CONSTANTS

	ENV_INTERP

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

feature -- Access: file name

	Eiffel_recent_projects: STRING is
			-- Recent projects location
		local
			fname: FILE_NAME
		once
			if Platform_constants.is_windows then
				Result := "HKEY_CURRENT_USER\Software\ISE\Eiffel51\recent projects"
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
				Result := "HKEY_CURRENT_USER\Software\ISE\Eiffel51"
			else
				create fname.make_from_string (Execution_environment.home_directory_name)
				fname.set_file_name (".ecrc")
				Result := fname
			end
		end

	Default_class_file: FILE_NAME is
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<"studio", "help", "defaults">>)
			Result.set_file_name (Default_class_filename)
		end

	Default_ace_name: FILE_NAME is
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<"studio", "help", "defaults">>)
			Result.set_file_name (Default_ace_file)
		end

	Bitmaps_path: DIRECTORY_NAME is
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<"studio", "bitmaps">>)
		end

	Cursor_path: DIRECTORY_NAME is
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<"studio", "bitmaps", "cursor">>)
		end

	Help_path: DIRECTORY_NAME is
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<"studio", "help", "errors">>)
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
			Result.extend_from_array (<<"studio", "filters">>)
		end

	profile_path: DIRECTORY_NAME is
			-- Location of the profiler configuration files
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array(<<"studio", "profiler">>)
		end

	New_project_wizards_path: DIRECTORY_NAME is
			-- Location of new project wizards.
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<"studio", "wizards", "new_projects">>)
		end

	last_opened_projects_resource_name: STRING is "studio_recent_files"

	default_file_name: FILE_NAME is
			-- Default recent project file name
		do
			create Result.make_from_string (Eiffel_installation_dir_name)
			if Platform_constants.is_windows then
				Result.extend_from_array (<<"eifinit", "studio", "spec", "windows">>)
			else
				Result.extend_from_array (<<"eifinit", "studio", "spec", "gtk">>)
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
				Result.extend_from_array (<<"eifinit", "studio", "spec", "windows">>)
			else
				Result.extend_from_array (<<"eifinit", "studio", "spec", "gtk">>)
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
			Result.extend_from_array (<<"eifinit", "studio", "spec", "windows">>)
			Result.set_file_name ("culture")
		end

	tmp_directory: DIRECTORY_NAME is
			-- Locate of the temporary directory
		once
			create Result.make
			Result.set_directory ("tmp")
		end

feature -- Access: command name

	Freeze_command_name: FILE_NAME is
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<"studio", "spec", Eiffel_platform, "bin">>)
			Result.set_file_name (Platform_constants.Finish_freezing_script)
		end

	Prelink_command_name: FILE_NAME is
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<"studio", "spec", Eiffel_platform, "bin">>)
			Result.set_file_name (Prelink_script)
		end

	Estudio_command_name: FILE_NAME is
			-- Complete path to `estudio'.
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<"studio", "spec", Eiffel_platform, "bin">>)
			Result.set_file_name ("estudio")
		end

feature -- Status

	has_borland: BOOLEAN is
			-- Is Borland C++ back-end C compiler?
		once
			Result := Platform_constants.is_windows and then Eiffel_c_compiler.is_equal ("bcb")
		end
		
end -- class EIFFEL_ENV
