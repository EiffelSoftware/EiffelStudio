indexing

	description:
		"Directories management for an Eiffel project."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class PROJECT_CONTEXT

inherit
	SYSTEM_CONSTANTS

feature -- Eiffel Project Directories

	project_target_name: STRING is
			-- Target name, used to build paths.
		do
			Result := internal_project_target_name.name
		end

	Project_directory_name: DIRECTORY_NAME is
			-- Shared project directory
		once
			create Result.make
		end

	Precompilation_directories: HASH_TABLE [REMOTE_PROJECT_DIRECTORY,INTEGER] is
			-- Shared precompilation directories, indexed by precompilation ids
		once
			create Result.make (5)
		end

	Backup_path: DIRECTORY_NAME is
			-- Path to the backup directory
		once
			create Result.make_from_string (target_path)
			Result.extend (Backup)
		end

	Documentation_path: DIRECTORY_NAME is
		once
			create Result.make_from_string (Project_directory_name)
			Result.extend (Documentation)
		end

	Profiler_path: DIRECTORY_NAME is
			-- Directory of the profiler's output files
		once
			create Result.make_from_string (target_path)
			Result.extend (Profiler)
		end

	Eiffel_gen_path: DIRECTORY_NAME is
		once
			create Result.make_from_string (Project_directory_name)
			Result.extend (eiffelgens)
		end

	target_path: DIRECTORY_NAME is
		once
			create Result.make_from_string (eiffel_gen_path)
			Result.extend (project_target_name)
		end

	Partial_generation_path: DIRECTORY_NAME is
			-- Valid path for partial generation
		once
			create Result.make_from_string (target_path)
			Result.extend (Partials)
		end

	Workbench_generation_path: DIRECTORY_NAME is
			-- Valid path for compilation
		once
			Result := temp_workbench_generation_path
		end

	Final_generation_path: DIRECTORY_NAME is
		once
			Result := temp_final_generation_path
		end

	Compilation_path: DIRECTORY_NAME is
			-- Path to the compilation directory
		once
			Result := temp_compilation_path
		end

	Precompilation_driver: FILE_NAME is
			-- Full name of the precompilation driver used
		once
			create Result.make
		end

	Arguments_file_name: FILE_NAME is
			-- Full name of file where additional arguments
			-- information for system is stored
		once
			create Result.make_from_string (target_path)
			Result.set_file_name (Additional_args)
		end

	Precompilation_file_name: FILE_NAME is
			-- Full name of file where current precompilation
			-- information is stored
		do
			create Result.make_from_string (target_path)
			Result.set_file_name (Precomp_eif)
		end

	Workbench_bin_generation_path: DIRECTORY_NAME is
			-- Path to `assemblies' directory in EIFGEN/W_code.
		do
			create Result.make_from_string (temp_workbench_generation_path)
			Result.extend (Local_assemblies)
		end

	Final_bin_generation_path: DIRECTORY_NAME is
			-- Path to `assemblies' directory in EIFGEN/F_code.
		do
			create Result.make_from_string (temp_final_generation_path)
			Result.extend (Local_assemblies)
		end

feature -- Temporary access prior to the creation or the opening of a file.

	temp_eiffel_gen_path: DIRECTORY_NAME is
			-- Temporary location of project.
		do
			create Result.make_from_string (Project_directory_name)
			Result.extend (eiffelgens)
		end

	temp_workbench_generation_path: DIRECTORY_NAME is
			-- Generate a temporary generation path
		do
			create Result.make_from_string (temp_target_path)
			Result.extend (W_code)
		end

	temp_final_generation_path: DIRECTORY_NAME is
		do
			create Result.make_from_string (temp_target_path)
			Result.extend (F_code)
		end

	temp_target_path: DIRECTORY_NAME is
		do
			create Result.make_from_string (temp_eiffel_gen_path)
			Result.extend (project_target_name)
		end

	temp_compilation_path: DIRECTORY_NAME is
		do
			create Result.make_from_string (temp_target_path)
			Result.extend (Comp)
		end

	temp_partial_generation_path: DIRECTORY_NAME is
			-- Valid path for partial generation
		do
			create Result.make_from_string (temp_target_path)
			Result.extend (Partials)
		end

	temp_profiler_path: DIRECTORY_NAME is
			-- Directory of the profiler's output files
		do
			create Result.make_from_string (temp_target_path)
			Result.extend (Profiler)
		end

feature {NONE} -- Directory creation

	create_generation_directory is
		local
			d: DIRECTORY
		do
			create_eiffel_gen_directory
			create d.make (temp_final_generation_path)
			if not d.exists then
				d.create_dir
			end
			create d.make (temp_workbench_generation_path)
			if not d.exists then
				d.create_dir
			end
			create d.make (temp_partial_generation_path)
			if not d.exists then
				d.create_dir
			end
		end

	create_eiffel_gen_directory is
		local
			d: DIRECTORY
		do
			create d.make (Temp_eiffel_gen_path)
			if not d.exists then
				d.create_dir
			end
			create d.make (temp_target_path)
			if not d.exists then
				d.create_dir
			end
		end

	create_compilation_directory is
			-- Directory where the compilation files are generated
		local
			d: DIRECTORY
		do
			create_eiffel_gen_directory
			create d.make (temp_compilation_path)
			if not d.exists then
				d.create_dir
			end
		end

	create_profiler_directory is
			-- Directory where the profiler files are generated
		local
			d: DIRECTORY
		do
			create d.make (temp_profiler_path)
			if not d.exists then
				d.create_dir
			end
		end

	create_local_assemblies_directory is
			-- Directory where local assemblies will be generated.
		local
			d: DIRECTORY
		do
			create_generation_directory
			create d.make (final_bin_generation_path)
			if not d.exists then
				d.create_dir
			end
			create d.make (workbench_bin_generation_path)
			if not d.exists then
				d.create_dir
			end
		end

feature {NONE} -- Implementation

	internal_project_target_name: TARGET_NAME is
			-- Target name.
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

end -- class PROJECT_CONTEXT
