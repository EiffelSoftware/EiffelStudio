indexing

	description:
		"Environment for bitmaps, help, binaries, scripts...."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class GB_EIFFEL_ENV

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

	Eiffel_preferences: STRING is
			-- Preferences location
		local
			fname: FILE_NAME
		once
			if platform_constants.is_windows then
				Result := "HKEY_CURRENT_USER\Software\ISE\Eiffel56\build\Preferences"
			else
				create fname.make_from_string (Execution_environment.home_directory_name)
				fname.set_file_name (".buildrc")
				Result := fname
			end
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

feature {NONE} -- Implementation

	platform_constants: PLATFORM is
			-- To get on what kind of computer we are running.
		once
			create Result
		ensure
			platform_constants_not_void: Result /= Void
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class GB_EIFFEL_ENV
