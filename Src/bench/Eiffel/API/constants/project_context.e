indexing

	description:
		"Directories management for an Eiffel project."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class PROJECT_CONTEXT

inherit
	SYSTEM_CONSTANTS

feature -- Eiffel Project Directories

	target_path_name: STRING is
			-- Target name, used to build paths.
		do
			Result := internal_target_name.name
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
			create Result.make_from_string (eiffel_gen_path);
			Result.extend (Backup);
		end

	Case_storage_path: DIRECTORY_NAME is
		once
			create Result.make_from_string (eiffel_gen_path);
			Result.extend_from_array (<<Casegen , Case_storage>>);
		end

	Case_gen_path: DIRECTORY_NAME is
		once
			create Result.make_from_string (eiffel_gen_path);
			Result.extend (Casegen);
		end

	Documentation_path: DIRECTORY_NAME is
		once
			create Result.make_from_string (eiffel_gen_path);
			Result.extend (Documentation);
		end

	Profiler_path: DIRECTORY_NAME is
			-- Directory of the profiler's output files
		once
			create Result.make_from_string (Eiffel_gen_path);
			Result.extend (Profiler)
		end

	Eiffel_gen_path: DIRECTORY_NAME is
		once
			create Result.make_from_string (Project_directory_name);
			Result.extend (target_path_name);
		end

	Partial_generation_path: DIRECTORY_NAME is
			-- Valid path for partial generation
		once
			create Result.make_from_string (Eiffel_gen_path)
			Result.extend (Partials)
		end


	Workbench_generation_path: DIRECTORY_NAME is
			-- Valid path for compilation
		once
			Result := temp_workbench_generation_path
		end

	Workbench_bin_generation_path: DIRECTORY_NAME is
			-- Path to `assemblies' directory in EIFGEN/W_code.
		once
			create Result.make_from_string (Workbench_generation_path)
			Result.extend (Local_assemblies)
		end

	Final_generation_path: DIRECTORY_NAME is
		once
			Result := temp_final_generation_path
		end

	Final_bin_generation_path: DIRECTORY_NAME is
			-- Path to `assemblies' directory in EIFGEN/F_code.
		once
			create Result.make_from_string (Final_generation_path)
			Result.extend (Local_assemblies)
		end

	Compilation_path: DIRECTORY_NAME is
			-- Path to the compilation directory
		once
			Result := temp_compilation_path
		end

	Precompilation_file_name: FILE_NAME is
			-- Full name of file where current precompilation
			-- information is stored
		do
			create Result.make_from_string (Project_directory_name);
			Result.extend (target_path_name);
			Result.set_file_name (Precomp_eif);
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
			create Result.make_from_string (eiffel_gen_path);
			Result.set_file_name (Additional_args);
		end

feature -- Temporary access prior to the creation or the opening of a file.

	temp_workbench_generation_path: DIRECTORY_NAME is
			-- Generate a temporary generation path
		do
			create Result.make_from_string (Project_directory_name);
			Result.extend_from_array (<<target_path_name, W_code>>);
		end

	temp_final_generation_path: DIRECTORY_NAME is
		do
			create Result.make_from_string (Project_directory_name);
			Result.extend_from_array (<<target_path_name, F_code>>);
		end

	temp_compilation_path: DIRECTORY_NAME is
		do
			create Result.make_from_string (Project_directory_name);
			Result.extend_from_array (<<target_path_name, Comp>>);
		end

feature {NONE} -- Directory creation

	Create_generation_directory is
		local
			d: DIRECTORY
		once
			create_eiffel_gen_directory
			create d.make (Final_generation_path)
			if not d.exists then
				d.create_dir
			end;
			create d.make (Workbench_generation_path)
			if not d.exists then
				d.create_dir
			end
			create d.make (partial_generation_path)
			if not d.exists then
				d.create_dir
			end
		end

	Create_case_storage_directory is
		local
			d: DIRECTORY
		do
			create d.make (Case_gen_path);
			if not d.exists then
				d.create_dir
			end;
			create d.make (Case_storage_path);
			if not d.exists then
				d.create_dir
			end;
		end

	Create_eiffel_gen_directory is
		local
			d: DIRECTORY
		once
			create d.make (Eiffel_gen_path);
			if not d.exists then
				d.create_dir
			end;
		end;

	Create_compilation_directory is
			-- Directory where the compilation files are generated
		local
			d: DIRECTORY
		once
			Create_eiffel_gen_directory;
			create d.make (compilation_path);
			if not d.exists then
				d.create_dir
			end
		end;

	Create_profiler_directory is
			-- Directory where the profiler files are generated
		local
			d: DIRECTORY
		once
			create d.make (Profiler_path);
			if not d.exists then
				d.create_dir
			end
		end

	Create_local_assemblies_directory is
			-- Directory where local assemblies will be generated.
		local
			d: DIRECTORY
		do
			create_generation_directory
			create d.make (Final_bin_generation_path)
			if not d.exists then
				d.create_dir
			end;
			create d.make (Workbench_bin_generation_path)
			if not d.exists then
				d.create_dir
			end
		end

feature {NONE} -- Implementation

	internal_target_name: TARGET_NAME is
			-- Target name.
		once
			create Result
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

end -- class PROJECT_CONTEXT
