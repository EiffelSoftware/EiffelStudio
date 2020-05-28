note

	description: "[
			Directory for an EiffelStudio project.
			This represents the directory in which the EIFGEN directory resides.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class REMOTE_PROJECT_DIRECTORY

inherit
	SYSTEM_CONSTANTS
	SHARED_ERROR_HANDLER;
	COMPILER_EXPORTER

create

	make

feature {NONE} -- Initialization

	make (a_project_location: like project_location)
			-- Create a remote project directory object.
		require
			a_project_location_not_void: a_project_location /= Void
		do
			has_precompiled_preobj := True;
			project_location := a_project_location
		ensure
			project_location_set: project_location = a_project_location
		end

feature -- Status report

	name: READABLE_STRING_32
			-- Name for remote project.
		do
			Result := project_location.location.name
		ensure
			name_not_void: Result /= Void
		end

	is_valid: BOOLEAN;
		-- Is Current a valid project directory
		-- Set by the check routines `check_precompiled'
		-- and `check_project'

	has_precompiled_preobj: BOOLEAN
			-- Does a `preobj' file exist for the current precompiled project?
			-- This file might not exist as a result of merging precompilations

feature -- Status setting

	set_has_precompiled_preobj (b: BOOLEAN)
			-- Set `has_precompiled_preobj' to `b'.
		do
			has_precompiled_preobj := b
		end

	set_system_name (n: like system_name)
			-- Set `system_name' to `n'
		do
			system_name := n
		end

	set_il_generation (v: BOOLEAN)
			-- Set `il_generation' to `v'.
		do
			il_generation := v
		ensure
			il_generation_set: il_generation = v
		end

	set_msil_generation_type (s: like msil_generation_type)
			-- Set `msil_generation_type' to `s'
		require
			non_void_s: s /= Void
			valid_s: s.same_string_general ("dll") or s.same_string_general ("exe")
		do
			msil_generation_type := s
		ensure
			msil_generation_type_set: s = msil_generation_type
		end

	set_is_precompile_finalized (v: BOOLEAN)
			-- Set `is_precompile_finalize' to `v'
		do
			is_precompile_finalized := v
		ensure
			is_precompile_finalized_set: is_precompile_finalized = v
		end

	set_line_generation (b: BOOLEAN)
			-- Sets `line_generation' to `b'
		do
			line_generation := b
		ensure
			line_generation_set: line_generation = b
		end

feature -- Access

	project_location: PROJECT_DIRECTORY
			-- Info about remote project location

	compilation_path: like {PROJECT_DIRECTORY}.path
			-- Path of the COMP directory
		do
			Result := project_location.compilation_path
		ensure
			compilation_path_not_void: Result /= Void
		end

	project_epr_file: PROJECT_EIFFEL_FILE
			-- File where the workbench is stored
		do
			Result := project_location.project_file
		ensure
			project_epr_file_not_void: Result /= Void
		end

	precomp_eif_file: PROJECT_EIFFEL_FILE
			-- File where the precompilation information is stored
		do
			create Result.make (project_location.precompilation_file_name)
		ensure
			precomp_eif_file_not_void: Result /= Void
		end

	precomp_il_info_file (a_use_optimized_precompile: BOOLEAN): PATH
			-- File where the il debug info for the precompiled is stored
		do
			if a_use_optimized_precompile then
				Result := project_location.final_path
			else
				Result := project_location.workbench_path
			end
			Result := Result.extended (Il_info_name + "." + il_info_extension)
		ensure
			precomp_il_info_file_not_void: Result /= Void
		end

	precompiled_preobj: PATH
			-- Full name of `preobj' object file
		do
			Result := project_location.workbench_path.extended (preobj)
		ensure
			precompiled_preobj_not_void: Result /= Void
		end

	precompiled_driver: PATH
			-- Full name of the precompilation driver
		do
			Result := project_location.workbench_path.extended (Driver)
		ensure
			precompiled_driver_not_void: Result /= Void
		end

	assembly_driver (a_use_optimized_precompile: BOOLEAN): PATH
			-- Full name of assembly driver.
		do
			if a_use_optimized_precompile then
				Result := project_location.final_path
			else
				Result := project_location.workbench_path
			end
			Result := Result.extended (system_name).appended_with_extension (msil_generation_type)
		ensure
			assembly_driver_not_void: Result /= Void
		end

	assembly_helper_driver (a_use_optimized_precompile: BOOLEAN): PATH
			-- Full name of assembly driver.
		do
			if a_use_optimized_precompile then
				Result := project_location.final_path
			else
				Result := project_location.workbench_path
			end
			Result := Result.extended ("lib" + system_name + ".dll")
		ensure
			assembly_herlp_driver_not_void: Result /= Void
		end

	assembly_debug_info (a_use_optimized_precompile: BOOLEAN): PATH
			-- Full name of assembly pdb.
		do
			if a_use_optimized_precompile then
				Result := project_location.final_path
			else
				Result := project_location.workbench_path
			end
			Result := Result.extended (system_name + ".pdb")
		ensure
			assembly_debug_info_not_void: Result /= Void
		end

	system_name: STRING
			-- Name of the precompiled library

	il_generation: BOOLEAN
			-- Is current project made for IL code generation?

	msil_generation_type: READABLE_STRING_32
			-- Type of assembly to generate

	is_precompile_finalized: BOOLEAN
			-- Is precompile finalized?

	line_generation: BOOLEAN
			-- Does precompile have debug information generated for it?

feature -- Check

	check_version_number (precomp_id: INTEGER)
			-- Check the version number of current directory.
		require
			for_precompilation: precomp_id > 0
		local
			vd52: VD52;
			vd53: VD53;
			file: PROJECT_EIFFEL_FILE
		do
			file := project_epr_file;
			file.check_version_number (precomp_id);
			if file.is_incompatible then
				create vd52;
				vd52.set_path (compilation_path.name);
				vd52.set_precompiled_version (file.project_version_number);
				vd52.set_compiler_version (version_number);
				Error_handler.insert_error (vd52);
				Error_handler.raise_error
			elseif file.is_invalid_precompilation then
				create vd53;
				vd53.set_path (compilation_path.name);
				if file.precompilation_id = 0 then
					vd53.set_precompiled_date ("unknown")
				else
					vd53.set_precompiled_date (date_string (file.precompilation_id));
				end
				vd53.set_expected_date (date_string (precomp_id));
				Error_handler.insert_error (vd53);
				Error_handler.raise_error
			end
		end;

	check_precompiled
			-- Check that `Current' is a valid precompiled
			-- project.
		do
			is_precompile := True;
			check_project_directory
				-- precomp.eif file must be readable.
			check_file (project_location.precompilation_file_name);
		end

	check_optional (a_use_optimized_precompile: BOOLEAN)
			-- Check that `Current' is ready to be used for execution.
		do
				-- EIFGEN/W_code/driver and EIFGEN/W_code/preobj.o
				-- should be present. If they are not, issue a warning.
			if il_generation then
				check_precompiled_optional (assembly_driver (a_use_optimized_precompile));
			else
				check_precompiled_optional (precompiled_driver);
					-- FIXME: Manu 09/18/2002: we cannot use `precompiled_preobj'
					-- as it is using the Makefile convention and not the actual
					-- path to the precompiled preobj.
--				if has_precompiled_preobj then
--					check_precompiled_optional (precompiled_preobj)
--				end
			end
		end

feature {NONE} -- Implementation

	is_precompile: BOOLEAN;
			-- Are we checking a precompile?
			-- If not, we must be checking dle stuff

	check_project_directory
			-- Check that `Current' is a valid remote
			-- project directory.
		do
			is_valid := True;
				-- Current directory must be
				-- readable.
			check_directory (project_location.eifgens_path)

				-- COMP directory must be
				-- readable.
			check_directory (project_location.compilation_path)

				-- project.eif file must be
				-- readable.
			check_file (project_location.project_file_name);

				-- W_code file must be
				-- readable.
			check_directory (project_location.workbench_path);

		end

	check_directory (a_directory: PATH)
			-- Check readability of directory of name
			-- `rn' relative to Current.
		require
			a_directory_not_void: a_directory /= Void
		local
			d: DIRECTORY
			vd42: VD42
		do
			if is_valid then
				create d.make_with_path (a_directory)
				is_valid :=
					d.exists and then
					d.is_readable and then
					d.is_executable
				if not is_valid and then is_precompile then
					create vd42
					vd42.set_path (a_directory.name)
					vd42.set_is_directory
					Error_handler.insert_error (vd42)
				end
			end
		end

	check_file (n: PATH)
			-- Check readability of file of name
			-- `rn' relative to Current.
		require
			n_not_void: n /= Void
		local
			f: RAW_FILE
			vd42: VD42
		do
			if is_valid then
				create f.make_with_path (n)
				is_valid :=
					f.exists and then
					f.is_plain and then
					f.is_readable
				if not is_valid and then is_precompile then
					create vd42
					vd42.set_path (n.name)
					Error_handler.insert_error (vd42)
				end
			end
		end

	check_precompiled_optional (rn: PATH)
			-- Check that `rn' is a valid path.
		require
			rn_not_void: rn /= Void
		local
			f: RAW_FILE
			vd43: VD43
			ok: BOOLEAN
		do
			if is_valid then
				create f.make_with_path (rn)
				ok :=
					f.exists and then
					f.is_plain and then
					f.is_readable
				if not ok then
					create vd43
					vd43.set_path (rn.name)
					Error_handler.insert_warning (vd43, False)
				end
			end
		end

feature {NONE} -- Externals

	date_string (a_date: INTEGER): STRING
			-- String representation of `a_date'
		external
			"C"
		alias
			"eif_date_string"
		end

invariant
	project_location_not_void: project_location /= Void

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
