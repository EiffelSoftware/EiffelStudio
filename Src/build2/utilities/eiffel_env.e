indexing

	description: 
		"Environment for bitmaps, help, binaries, scripts...."
	date: "$Date$"
	revision: "$Revision$"

class EIFFEL_ENV

feature -- Status

	execution_environment: EXECUTION_ENVIRONMENT is
			-- Result is instance of EXECUTION_ENVIRONMENT
		once
			create Result
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

	short_studio_name: STRING is "studio"
			-- Short version of EiffelStudio name.
	
	short_build_name: STRING is "build"
			-- Short version of Build name.

feature -- Access: file name


	Templates_path: FILE_NAME is
			-- Location of templates.
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "help", "defaults", Eiffel_platform>>)
		end

	Bitmaps_path: DIRECTORY_NAME is
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<short_build_name, "bitmaps">>)
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


	tmp_directory: DIRECTORY_NAME is
			-- Locate of the temporary directory
		once
			create Result.make
			Result.set_directory ("tmp")
		end

feature -- Access: command name

	Estudio_command_name: FILE_NAME is
			-- Complete path to `estudio'.
		once
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "spec", Eiffel_platform, "bin">>)
			Result.set_file_name ("estudio")
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

end -- class EIFFEL_ENV
