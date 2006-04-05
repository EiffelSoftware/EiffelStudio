indexing

	description:
		"Directory for an EiffelStudio project.%
		%This represents the directory in which the%
		%EIFGEN directory resides."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class REMOTE_PROJECT_DIRECTORY

inherit

	EIFFEL_ENV
		rename
			precomp_eif as shared_precomp_eif
		end;
	PROJECT_CONTEXT
		rename
			compilation_path as shared_compilation_path,
			precomp_eif as shared_precomp_eif
		export
			{NONE} all
		end;
	DIRECTORY
		rename
			make as directory_make,
			mode as file_mode
		end;
	SHARED_ERROR_HANDLER;
	SHARED_ENV;
	COMPILER_EXPORTER

create

	make

feature {NONE} -- Initialization

	make (dn: STRING) is
			-- Create a remote project directory object.
		do
			name := dn
			has_precompiled_preobj := True;
			directory_make (Environ.interpreted_string (dn))
		end

feature -- Status report

	is_valid: BOOLEAN;
		-- Is Current a valid project directory
		-- Set by the check routines `check_precompiled'
		-- and `check_project'

	has_precompiled_preobj: BOOLEAN
			-- Does a `preobj' file exist for the current precompiled project?
			-- This file might not exist as a result of merging precompilations

feature -- Status setting

	set_has_precompiled_preobj (b: BOOLEAN) is
			-- Set `has_precompiled_preobj' to `b'.
		do
			has_precompiled_preobj := b
		end

	set_licensed (b: BOOLEAN) is
			-- Set `licensed' to `b'.
		do
			licensed := b
		end

	set_system_name (n: STRING) is
			-- Set `system_name' to `n'
		do
			system_name := n
		end

	set_il_generation (v: BOOLEAN) is
			-- Set `il_generation' to `v'.
		do
			il_generation := v
		ensure
			il_generation_set: il_generation = v
		end

	set_msil_generation_type (s: STRING) is
			-- Set `msil_generation_type' to `s'
		require
			non_void_s: s /= Void
			valid_s: s.is_equal ("dll") or s.is_equal ("exe")
		do
			msil_generation_type := s
		ensure
			msil_generation_type_set: s.is_equal (msil_generation_type)
		end

	set_is_precompile_finalized (v: BOOLEAN) is
			-- Set `is_precompile_finalize' to `v'
		do
			is_precompile_finalized := v
		ensure
			is_precompile_finalized_set: is_precompile_finalized = v
		end

	set_line_generation (b: BOOLEAN) is
			-- Sets `line_generation' to `b'
		do
			line_generation := b
		ensure
			line_generation_set: line_generation = b
		end

feature -- Access

	compilation_path: DIRECTORY_NAME is
			-- Path of the COMP directory
		do
			create Result.make_from_string (name);
			Result.extend (Comp)
		end;

	licensed: BOOLEAN
			-- Is this precompilation protected by a license?

	project_epr_location: FILE_NAME is
			-- Full name of the file where the
			-- workbench is stored
		do
			create Result.make_from_string (name);
			Result.set_file_name (project_file_name);
		end

	project_epr_file: PROJECT_EIFFEL_FILE is
			-- File where the workbench is stored
		do
			create Result.make (project_epr_location)
		end

	precomp_eif_location: FILE_NAME is
			-- Full name of the file where the
			-- precompilation information is stored
		do
			create Result.make_from_string (name);
			Result.set_file_name (Shared_precomp_eif)
		end

	precomp_eif_file: PROJECT_EIFFEL_FILE is
			-- File where the precompilation information is stored
		do
			create Result.make (precomp_eif_location)
		end

	precomp_il_info_file (a_use_optimized_precompile: BOOLEAN): FILE_NAME is
			-- File where the il debug info for the precompiled is stored
		do
			create Result.make_from_string (name);
			if a_use_optimized_precompile then
				Result.extend (F_code)
			else
				Result.extend (W_code)
			end
			Result.set_file_name (Il_info_name)
			Result.add_extension (Il_info_extension)
		end

	precompiled_preobj: FILE_NAME is
			-- Full name of `preobj' object file
		local
			makefile_name: STRING
		do
			makefile_name := name
			create Result.make_from_string (makefile_name);
			Result.extend (W_code)
			Result.set_file_name (Platform_constants.Preobj)
		end

	precompiled_driver: FILE_NAME is
			-- Full name of the precompilation driver
		do
			create Result.make_from_string (name);
			Result.extend (W_code)
			Result.set_file_name (Platform_constants.Driver)
		end

	assembly_driver (a_use_optimized_precompile: BOOLEAN): FILE_NAME is
			-- Full name of assembly driver.
		do
			create Result.make_from_string (name)
			if a_use_optimized_precompile then
				Result.extend (F_code)
			else
				Result.extend (W_code)
			end
			Result.set_file_name (system_name)
			Result.add_extension (msil_generation_type)
		ensure
			assembly_driver_not_void: Result /= Void
		end

	assembly_helper_driver (a_use_optimized_precompile: BOOLEAN): FILE_NAME is
			-- Full name of assembly driver.
		do
			create Result.make_from_string (name)
			if a_use_optimized_precompile then
				Result.extend (F_code)
			else
				Result.extend (W_code)
			end
			Result.set_file_name ("lib" + system_name)
			Result.add_extension ("dll")
		ensure
			assembly_herlp_driver_not_void: Result /= Void
		end

	assembly_debug_info (a_use_optimized_precompile: BOOLEAN): FILE_NAME is
			-- Full name of assembly pdb.
		do
			create Result.make_from_string (name)
			if a_use_optimized_precompile then
				Result.extend (F_code)
			else
				Result.extend (W_code)
			end
			Result.set_file_name (system_name)
			Result.add_extension ("pdb")
		ensure
			assembly_debug_info_not_void: Result /= Void
		end

	system_name: STRING
			-- Name of the precompiled library

	il_generation: BOOLEAN
			-- Is current project made for IL code generation?

	msil_generation_type: STRING
			-- Type of assembly to generate

	is_precompile_finalized: BOOLEAN
			-- Is precompile finalized?

	line_generation: BOOLEAN
			-- Does precompile have debug information generated for it?

feature -- Check

	check_version_number (precomp_id: INTEGER)is
			-- Check the version number of current directory.
		require
			for_precompilation: precomp_id > 0
		local
			vd52: VD52;
			vd53: VD53;
			file: PROJECT_EIFFEL_FILE
		do
			file := project_epr_file;
			file.open_read
			file.check_version_number (precomp_id);
			file.close
			if file.is_incompatible then
				create vd52;
				vd52.set_path (compilation_path);
				vd52.set_precompiled_version (file.project_version_number);
				vd52.set_compiler_version (version_number);
				Error_handler.insert_error (vd52);
				Error_handler.raise_error
			elseif file.is_invalid_precompilation then
				create vd53;
				vd53.set_path (compilation_path);
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

	check_precompiled is
			-- Check that `Current' is a valid precompiled
			-- project.
		do
			is_precompile := True;
			check_project_directory
				-- precomp.eif file must be readable.
			check_file (<<>>, Shared_precomp_eif);
		end

	check_optional (a_use_optimized_precompile: BOOLEAN) is
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

	check_project_directory is
			-- Check that `Current' is a valid remote
			-- project directory.
		do
			is_valid := True;
				-- Current directory must be
				-- readable.
			check_directory (<<>>);

				-- COMP directory must be
				-- readable.
			check_directory (<<Comp>>);

				-- project.eif file must be
				-- readable.
			check_file (<<>>, project_file_name);

				-- W_code file must be
				-- readable.
			check_directory (<<W_code>>);

		end

	check_directory (directories: ARRAY [STRING]) is
			-- Check readability of directory of name
			-- `rn' relative to Current.
		local
			d: DIRECTORY;
			dn: DIRECTORY_NAME;
			vd42: VD42;
			i: INTEGER
		do
			if is_valid then
				create dn.make_from_string (name);
				from
					i := directories.lower
				until
					i > directories.upper
				loop
					dn.extend (directories.item (i))
					i := i + 1
				end
				create d.make (dn);
				is_valid :=
					d.exists and then
					d.is_readable and then
					d.is_executable
				if not is_valid and then is_precompile then
					create vd42;
					vd42.set_path (dn);
					vd42.set_is_directory;
					Error_handler.insert_error (vd42);
				end
			end
		end;

	check_file (directories: ARRAY [STRING]; rn: STRING) is
			-- Check readability of file of name
			-- `rn' relative to Current.
		local
			f: RAW_FILE;
			fn: FILE_NAME;
			vd42: VD42;
			i: INTEGER
		do
			if is_valid then
				create fn.make_from_string (name);
				from
					i := directories.lower
				until
					i > directories.upper
				loop
					fn.extend (directories.item (i))
					i := i + 1
				end
				fn.set_file_name (rn);
				create f.make (fn);
				is_valid :=
					f.exists and then
					f.is_plain and then
					f.is_readable
				if not is_valid and then is_precompile then
					create vd42;
					vd42.set_path (fn);
					Error_handler.insert_error (vd42);
				end
			end
		end;

	check_precompiled_optional (rn: STRING) is
			-- Check that `rn' is a valid path.
		require
			rn_not_void: rn /= Void
		local
			f: RAW_FILE;
			fn: FILE_NAME;
			vd43: VD43;
			ok: BOOLEAN
		do
			if is_valid then
				create fn.make_from_string (rn)
				create f.make (fn)
				ok :=
					f.exists and then
					f.is_plain and then
					f.is_readable
				if not ok then
					create vd43
					vd43.set_path (fn)
					Error_handler.insert_warning (vd43)
				end
			end
		end

feature {NONE} -- Externals

	date_string (a_date: INTEGER): STRING is
			-- String representation of `a_date'
		external
			"C"
		alias
			"eif_date_string"
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

end -- class REMOTE_PROJECT_DIRECTORY
