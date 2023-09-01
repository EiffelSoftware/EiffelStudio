note
	description: "Facilities to locate and create project directories/files."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PROJECT_DIRECTORY

inherit
	ANY

	SYSTEM_CONSTANTS
		rename
			project_file_name as project_file_name_constant
		export
			{NONE} all
		end

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_location: like location; a_target: READABLE_STRING_GENERAL)
			-- Initialize Current project location at `a_location' for a target `a_target'.
		require
			a_location_not_void: a_location /= Void
			a_location_not_empty: not a_location.is_empty
			a_target_not_void: a_target /= Void
			a_target_not_empty: not a_target.is_empty
		do
			location := a_location
			target := a_target.as_string_32
		ensure
			location_set: location = a_location
			target_set: target.same_string_general (a_target)
		end

feature -- Access

	location: PATH
			-- Location of project

	target: STRING_32
			-- Name of project's target

feature -- Directory creation

	create_project_directories
			-- Create basic structure for project.
		local
			l_dirs: ARRAY [like path]
		do
			l_dirs := <<eifgens_path, target_path, compilation_path, final_path, workbench_path, partial_generation_path, data_path>>
			l_dirs.do_all (agent safe_create_directory)
		end

	create_profiler_directory
			-- Directory where the profiler files are generated
		do
			create_project_directories
			safe_create_directory (profiler_path)
		end

	create_local_assemblies_directory (is_final: BOOLEAN)
			-- Directory where local assemblies will be generated.
		do
			create_project_directories
			if is_final then
				safe_create_directory (final_assemblies_path)
			else
				safe_create_directory (workbench_assemblies_path)
			end
		end

feature -- Directories

	path: PATH
			-- Path for current location.
		do
			Result := location
		ensure
			path_not_void: Result /= Void
		end

	backup_path: like path
			-- Path where backups will be saved during a compilation.
		do
			Result := internal_backup_path
			if Result = Void then
				Result := target_path.extended (backup)
				internal_backup_path := Result
			end
		ensure
			backup_path_not_void: Result /= Void
		end

	compilation_path: like path
			-- Path to `COMP' where compiler data will be stored.
		do
			Result := internal_compilation_path
			if Result = Void then
				Result := target_path.extended (comp)
				internal_compilation_path := Result
			end
		ensure
			compilation_path_not_void: Result /= Void
		end

	documentation_path: like path
			-- Path where documentation will be generated if not location is given.
		do
			Result := internal_documentation_path
			if Result = Void then
				Result := path.extended (documentation)
				internal_documentation_path := Result
			end
		ensure
			documentation_path_not_void: Result /= Void
		end

	eifgens_path: like path
			-- Path to `EIFGENs' directory.
		do
			Result := internal_eifgens_path
			if Result = Void then
				Result := path.extended (eiffelgens)
				internal_eifgens_path := Result
			end
		ensure
			eifgens_path_not_void: Result /= Void
		end

	final_assemblies_path: like path
			-- Path to `F_code/Assemblies' directory with project directory.
		do
			Result := internal_final_assemblies_path
			if Result = Void then
				Result := final_path.extended (local_assemblies)
				internal_final_assemblies_path := Result
			end
		ensure
			final_assemblies_path_not_void: Result /= Void
		end

	final_path: like path
			-- Path to `F_code' directory with project directory.
		do
			Result := internal_final_path
			if Result = Void then
				Result := target_path.extended (f_code)
				internal_final_path := Result
			end
		ensure
			final_path_not_void: Result /= Void
		end

	partial_generation_path: like path
			-- Path to where partial classes will be merged.
		do
			Result := internal_partial_generation_path
			if Result = Void then
				Result := target_path.extended (partials)
				internal_partial_generation_path := Result
			end
		ensure
			partial_generation_path_not_void: Result /= Void
		end

	profiler_path: like path
			-- Path to `Profiler' directory within project directory.
		do
			Result := internal_profiler_path
			if Result = Void then
				Result := target_path.extended (profiler)
				internal_profiler_path := Result
			end
		ensure
			profiler_path_not_void: Result /= Void
		end

	target_path: like path
			-- Path to `target' directory within project directory.
		do
			Result := internal_target_path
			if Result = Void then
				Result := eifgens_path.extended (target)
				internal_target_path := Result
			end
		ensure
			target_path_not_void: Result /= Void
		end

	workbench_assemblies_path: like path
			-- Path to `W_code/Assemblies' directory with project directory.
		do
			Result := internal_workbench_assemblies_path
			if Result = Void then
				Result := workbench_path.extended (local_assemblies)
				internal_workbench_assemblies_path := Result
			end
		ensure
			workbench_assemblies_path_not_void: Result /= Void
		end

	workbench_path: like path
			-- Path to `W_code' directory with project directory.
		do
			Result := internal_workbench_path
			if Result = Void then
				Result := target_path.extended (w_code)
				internal_workbench_path := Result
			end
		ensure
			workbench_path_not_void: Result /= Void
		end

	data_path: like path
			-- Path to `Data" directory which is used to store customized formatter, metrics, docking layout files.
		do
			Result := internal_data_path
			if Result = Void then
				Result := target_path.extended (data_directory)
				internal_data_path := Result
			end
		ensure
			data_path_not_void: Result /= Void
		end

	testing_results_path: like path
			-- Path to testing result directory in EIFGENs directory
		do
			Result := internal_testing_results_path
			if Result = Void then
				Result := target_path.extended (testing_results_directory)
				internal_testing_results_path := Result
			end
		end

feature -- Files

	project_file_name: PATH
			-- Path to `project.epr'.
		do
			Result := internal_project_file_name
			if Result = Void then
				Result := target_path.extended (project_file_name_constant)
				internal_project_file_name := Result
			end
		ensure
			project_file_name_not_void: Result /= Void
		end

	project_file: PROJECT_EIFFEL_FILE
			-- Access to project file data.
		do
				-- It is not stored within Current because Current is saved to disk
				-- and when retrieved it would cause to have a valid file handle
				-- to be restored in `project_file'.
			create Result.make (project_file_name)
		ensure
			project_file_not_void: Result /= Void
		end

	precompilation_file_name: PATH
			-- Path to `precomp.eif'.
		do
			Result := internal_precompilation_file_name
			if Result = Void then
				Result := target_path.extended (precomp_eif)
				internal_precompilation_file_name := Result
			end
		ensure
			precompilation_file_name_not_void: Result /= Void
		end

	lock_file_name: PATH
			-- Path to `ec.lock'.
		do
			Result := internal_lock_file_name
			if Result = Void then
				Result := target_path.extended (ec_lock_file_name)
				internal_lock_file_name := Result
			end
		ensure
			lock_file_name_not_void: Result /= Void
		end

	workbench_executable_file_name: PATH
			-- Path to executable of workbench mode.
		do
			Result := workbench_path.extended_path (executable_file_name)
		ensure
			workbench_executable_file_name_not_void: Result /= Void
		end

	final_executable_file_name: PATH
			-- Path to executable of finalized mode.
		do
			Result := final_path.extended_path (executable_file_name)
		ensure
			final_executable_file_name_not_void: Result /= Void
		end

	single_file_compilation_executable_file_name: like executable_file_name
			-- Path to executable location after single file compilation mode.
		do
				-- The executable will be copied into the current working directory.
			Result := executable_file_name
		ensure
			single_file_compilation_executable_file_name_not_void: Result /= Void
		end

	executable_file_name: PATH
			-- File name of executable.
		do
			fixme ("'target' is not always the executable filename, check output or system name.")
			if {PLATFORM}.is_windows then
				create Result.make_from_string (target + ".exe")
			else
				create Result.make_from_string (target)
			end
		ensure
			executable_file_name_not_void: Result /= Void
		end

feature -- Status report

	is_compiled: BOOLEAN
			-- Is project compiled?
		do
			Result := project_file.exists
		end

feature -- Access

	is_project_file_valid: BOOLEAN
			-- Is the `project_epr' file valid?
		do
			Result := project_file.is_valid
		end

	is_path_readable: BOOLEAN
			-- Is `path' readable?
		local
			l_dir: DIRECTORY
		do
			create l_dir.make_with_path (path)
			Result := l_dir.exists and then l_dir.is_readable
		end

	is_path_writable: BOOLEAN
			-- Is `path' writable?
		local
			l_dir: DIRECTORY
		do
			create l_dir.make_with_path (path)
			Result := l_dir.exists and then l_dir.is_writable
		end

	path_exists: BOOLEAN
			-- Does `path' exist?
		local
			l_dir: DIRECTORY
		do
			create l_dir.make_with_path (path)
			Result := l_dir.exists
		end

	is_project_readable: BOOLEAN
			-- May the project be used for browsing and debugging?
		local
			w_code_dir, f_code_dir, comp_dir: DIRECTORY
		do
			create w_code_dir.make_with_path (workbench_path)
			create f_code_dir.make_with_path (final_path)
			create comp_dir.make_with_path (compilation_path)
			Result := is_path_readable and then w_code_dir.is_readable
					and then f_code_dir.is_readable and then comp_dir.is_readable
					and then project_file.is_readable
		end

	is_project_writable: BOOLEAN
			-- May the project be both compiled and used for browsing?
		local
			w_code_dir, f_code_dir, comp_dir: DIRECTORY
		do
			create w_code_dir.make_with_path (workbench_path)
			create f_code_dir.make_with_path (final_path)
			create comp_dir.make_with_path (compilation_path)
			Result := is_path_writable and then w_code_dir.is_writable
					and then f_code_dir.is_writable and then comp_dir.is_writable
					and then project_file.is_writable
		end

	is_lock_file_present: BOOLEAN
			-- Is `lock_file_name' present?
		local
			l_file: PLAIN_TEXT_FILE
		do
			create l_file.make_with_path (lock_file_name)
			Result := l_file.exists
		end

	exists: BOOLEAN
			-- Does the project exist?
			--| Ie, Comp, F_code, W_code and project file exist?
		local
			w_code_dir, f_code_dir, comp_dir: DIRECTORY
		do
			create w_code_dir.make_with_path (workbench_path)
			create f_code_dir.make_with_path (final_path)
			create comp_dir.make_with_path (compilation_path)
			Result := path_exists and then w_code_dir.exists
				and then f_code_dir.exists and then comp_dir.exists
				and then project_file.exists
		end

feature -- Locking

	create_lock_file
			-- Create `lock_file_name'.
		local
			l_file: PLAIN_TEXT_FILE
			retried: BOOLEAN
			utf: UTF_CONVERTER
		do
			if not retried then
				create l_file.make_with_path (lock_file_name)
				l_file.open_write
				l_file.put_string (utf.utf_8_bom_to_string_8)
				l_file.put_string ({EIFFEL_CONSTANTS}.ise_eiffel_env)
				l_file.put_character ('=')
				l_file.put_string (utf.string_32_to_utf_8_string_8 (eiffel_layout.ec_command_name.name))
				l_file.put_new_line
				l_file.put_string ("version=")
				l_file.put_string (utf.string_32_to_utf_8_string_8 (compiler_version_number.version))
				l_file.put_new_line
				l_file.put_string ("date=")
				l_file.put_string ((create {DATE_TIME}.make_now).out)
				l_file.put_new_line
					-- The following cannot be filled yet, but some people might put some information in here.
				l_file.put_string ("host=%Npid=%Nuser=%N")
				l_file.close
			end
		rescue
			retried := True
			retry
		end

	delete_lock_file
			-- Delete `lock_file_name'.
		local
			l_file: PLAIN_TEXT_FILE
			retried: BOOLEAN
		do
			if not retried and then is_lock_file_present then
				create l_file.make_with_path (lock_file_name)
				l_file.delete
			end
		rescue
			retried := True
			retry
		end

feature -- Settings

	set_location (a_location: like location)
			-- Set `location' with `a_location'.
		require
			a_location_not_void: a_location /= Void
			a_location_not_empty: not a_location.is_empty
		do
			location := a_location
			reset_content
		ensure
			locationt_set: location = a_location
		end

	set_target (a_target: like target)
			-- Set `target' with `a_target'.
		require
			a_target_not_void: a_target /= Void
			a_target_not_empty: not a_target.is_empty
		do
			target := a_target
			reset_content
		ensure
			target_set: target = a_target
		end

feature -- Directory creation

	safe_create_directory (a_dir: PATH)
			-- Create `a_dir' if it doesn't exist.
		require
			a_dir_attached: a_dir /= Void
		local
			d: DIRECTORY
		do
			create d.make_with_path (a_dir)
			if not d.exists then
				d.create_dir
			end
		end

feature {NONE} -- Implementation

	reset_content
			-- Reset all paths to Void.
		do
			internal_backup_path := Void
			internal_compilation_path := Void
			internal_documentation_path := Void
			internal_eifgens_path := Void
			internal_final_assemblies_path := Void
			internal_final_path := Void
			internal_partial_generation_path := Void
			internal_profiler_path := Void
			internal_target_path := Void
			internal_workbench_assemblies_path := Void
			internal_workbench_path := Void
			internal_data_path := Void
			internal_testing_results_path := Void
			internal_precompilation_file_name := Void
			internal_lock_file_name := Void
			internal_project_file_name := Void
		end

feature {NONE} -- Implementation: Access

	internal_backup_path: like backup_path
	internal_compilation_path: like compilation_path
	internal_documentation_path: like documentation_path
	internal_eifgens_path: like eifgens_path
	internal_final_assemblies_path: like final_assemblies_path
	internal_final_path: like final_path
	internal_partial_generation_path: like partial_generation_path
	internal_profiler_path: like profiler_path
	internal_target_path: like target_path
	internal_workbench_assemblies_path: like workbench_assemblies_path
	internal_workbench_path: like workbench_path
	internal_data_path: like data_path
	internal_testing_results_path: like testing_results_path
			-- Placeholders for storing path.

	internal_precompilation_file_name: like precompilation_file_name
	internal_lock_file_name: like lock_file_name
	internal_project_file_name: like project_file_name
			-- Placeholders for storing filename.

invariant
	location_not_void: location /= Void
	location_not_empty: not location.is_empty
	target_not_void: target /= Void
	target_not_empty: not target.is_empty

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
