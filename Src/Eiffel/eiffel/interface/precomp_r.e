indexing

	description:
		"Retrieve the `project.eif' of the precompiled project."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class PRECOMP_R

inherit

	SHARED_ERROR_HANDLER
	SHARED_RESCUE_STATUS
	PROJECT_CONTEXT
	COMPILER_EXPORTER
	SHARED_EIFFEL_PROJECT
	SHARED_WORKBENCH
	SHARED_CONFIGURE_RESOURCES

feature

	retrieve_precompiled (a_project_path: STRING) is
			-- Initialize the system with precompiled information
			-- contained in precompile project in `a_project_path'.
		require
			a_project_path_not_void: a_project_path /= Void
		local
			project_dir: REMOTE_PROJECT_DIRECTORY;
			project: E_PROJECT;
			project_eif: PROJECT_EIFFEL_FILE;
			vd41: VD41;
			vd52: VD52;
			sys: SYSTEM_I;
			workb: WORKBENCH_I
		do
			project_dir := precompiled_project_directory (a_project_path)
			if project_dir /= Void then
				project_eif := project_dir.project_epr_file
				project := project_eif.retrieved_project
				if project_eif.error then
					if project_eif.is_interrupted then
						Error_handler.insert_interrupt_error (True)
					elseif project_eif.is_corrupted then
						create vd41;
						vd41.set_path (project_dir.name)
						Error_handler.insert_error (vd41)
						Error_handler.raise_error
					else
							-- Must be incompatible version
						create vd52
						vd52.set_path (project_dir.name)
						vd52.set_precompiled_version
								(project_eif.project_version_number)
						vd52.set_compiler_version (version_number)
						Error_handler.insert_error (vd52)
						Error_handler.raise_error
					end
				else
						-- Check that it is a precompiled cluster
					sys := project.saved_workbench.system
					if sys /= Void and then sys.is_precompiled then
						workb := project.saved_workbench
						Workbench.set_precompiled_directories (workb.precompiled_directories)
						Universe.copy (workb.universe)
						Workbench.set_system (sys)

						Eiffel_project.set_system (project.system)
						project_dir.set_has_precompiled_preobj (sys.has_precompiled_preobj)
						project_dir.set_il_generation (sys.il_generation)
						project_dir.set_line_generation (sys.line_generation)
						Workbench.precompiled_directories.force (project_dir, sys.compilation_id)
						Workbench.set_precompiled_driver (project_dir.precompiled_driver)
						Workbench.set_melted_file_name (project_dir.system_name)
						project_dir.set_msil_generation_type (sys.msil_generation_type)
						project_dir.set_is_precompile_finalized (sys.is_precompile_finalized)
						project_dir.check_optional (False)
						if project_dir.is_precompile_finalized then
							project_dir.check_optional (True)
						end
						sys.reset_loaded_precompiled_properties
						set_precomp_dir
						sys.init_counters
						sys.server_controler.init
					else
						create vd41;
						vd41.set_path (project_dir.name)
						Error_handler.insert_error (vd41)
						Error_handler.raise_error
					end
				end
			end
		end

	set_precomp_dir is
			-- Update precompilation related once functions.
		require
			driver_not_void: Workbench.precompiled_driver /= Void
		local
			precomp_dirs: HASH_TABLE [REMOTE_PROJECT_DIRECTORY, INTEGER]
		do
			Precompilation_driver.make_from_string
					(Workbench.precompiled_driver)
			precomp_dirs := Workbench.precompiled_directories
			Precompilation_directories.copy (precomp_dirs)
		end;

	check_version_number is
			-- Check the version number for all precompilation.
			-- Raise an error if there an incompatible version.
		require
			driver_not_void: Workbench.precompiled_driver /= Void
		local
			precomp_dirs: HASH_TABLE [REMOTE_PROJECT_DIRECTORY, INTEGER]
		do
			Precompilation_driver.make_from_string (Workbench.precompiled_driver)
			precomp_dirs := Workbench.precompiled_directories;
			from
				precomp_dirs.start
			until
				precomp_dirs.after
			loop
				precomp_dirs.item_for_iteration.check_version_number
					(precomp_dirs.key_for_iteration);
				precomp_dirs.forth
			end;
		end;

feature {NONE} -- Implementation

	precompiled_project_directory (a_path: STRING): REMOTE_PROJECT_DIRECTORY is
			-- Precompiled project directory containing all other
			-- precompiled libraries listed in `precompiled_project'
		require
			a_path_ok: a_path /= Void and then not a_path.is_empty
		local
			project_dir: REMOTE_PROJECT_DIRECTORY;
			info: PRECOMP_INFO;
			project_eif: PROJECT_EIFFEL_FILE;
			vd41: VD41;
			vd45: VD45;
			vd52: VD52;
			precomp_ids: HASH_TABLE [INTEGER, STRING];
			dir_name: STRING;
			id: INTEGER
		do
			create precomp_ids.make (15)
			create project_dir.make (a_path)

			project_dir.check_precompiled
			Error_handler.checksum

			if project_dir.is_valid then
				project_eif := project_dir.precomp_eif_file
				info := project_eif.retrieved_precompile
				if project_eif.error then
					if project_eif.is_interrupted then
						Error_handler.insert_interrupt_error (True)
					elseif project_eif.is_corrupted then
						create vd41;
						vd41.set_path (project_dir.name)
						Error_handler.insert_error (vd41)
						Error_handler.raise_error
					else
						-- Must be incompatible version
						create vd52;
						vd52.set_path (project_dir.name)
						vd52.set_precompiled_version
							(project_eif.project_version_number)
						vd52.set_compiler_version (version_number)
						Error_handler.insert_error (vd52)
						Error_handler.raise_error
					end
				else
					project_dir.set_licensed (info.licensed)
					project_dir.set_system_name (info.name)
					from info.start until info.after loop
						dir_name := info.key_for_iteration
						id := info.item_for_iteration
						if precomp_ids.has (dir_name) then
								-- Check compatibility between
								-- precompiled libraries.
							if id /= precomp_ids.found_item then
								create vd45
								vd45.set_path (dir_name)
								Error_handler.insert_error (vd45)
								Error_handler.raise_error
							end
						else
							precomp_ids.put (id, dir_name)
						end;
						info.forth
					end;
					id := info.compilation_id
					if precomp_ids.has (a_path) then
							-- Check compatibility between
							-- precompiled libraries.
						if id /= precomp_ids.found_item then
							create vd45
							vd45.set_path (a_path)
							Error_handler.insert_error (vd45)
							Error_handler.raise_error
						end
					else
						precomp_ids.put (id, a_path)
					end;
					Result := project_dir
				end
			end;
		ensure
			valid_project: Result /= Void implies Result.is_valid
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

end -- class PRECOMP_R
