indexing

	description: 
		"Directory for an eiffelbench project.%
		%This represents the directory in which the%
		%EIFGEN directory resides.";
	date: "$Date$";
	revision: "$Revision $"

class REMOTE_PROJECT_DIRECTORY

inherit

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

creation

	make
	
feature {NONE} -- Initialization

	make (dn: STRING) is
			-- Create a remote project directory object.
		do
			dollar_name := dn;
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

feature -- Access

	dollar_name: STRING
			-- Directory name (with environment variables)

	compilation_path: DIRECTORY_NAME is
			-- Path of the COMP directory
		do
			!! Result.make_from_string (name);
			Result.extend_from_array (<<Eiffelgen, Comp>>)
		end

	project_eif: FILE_NAME is
			-- Full name of the file where the
			-- workbench is stored
		do
			!! Result.make_from_string (name);
			Result.extend (Eiffelgen);
			Result.set_file_name (Dot_workbench)
		end

	precomp_eif: FILE_NAME is
			-- Full name of the file where the
			-- precompilation information is stored
		do
			!! Result.make_from_string (name);
			Result.extend (Eiffelgen);
			Result.set_file_name (Shared_precomp_eif)
		end

	precompiled_preobj: FILE_NAME is
			-- Full name of `preobj' object file
		local
			makefile_name: STRING
		do
			makefile_name := Environ.translated_string (dollar_name);
			!! Result.make_from_string (makefile_name);
			Result.extend_from_array (<<Eiffelgen, W_code>>);
			Result.set_file_name (Preobj)
		end

	precompiled_driver: FILE_NAME is
			-- Full name of the precompilation driver
		do
			!! Result.make_from_string (name);
			Result.extend_from_array (<<Eiffelgen, W_code>>);
			Result.set_file_name (Driver)
		end

feature -- Check

	check_precompiled is
			-- Check that `Current' is a valid precompiled
			-- project.
		do
			is_precompile := True;
			check_project_directory
				-- EIFGEN/precomp.eif file must be readable.
			check_file (<<Eiffelgen>>, Shared_precomp_eif);
				-- EIFGEN/W_code/driver and EIFGEN/W_code/preobj.o
				-- should be present. If they are not, issue a warning.
			check_precompiled_optional (<<Eiffelgen, W_code>>, Driver);
			if has_precompiled_preobj then
				check_precompiled_optional (<<Eiffelgen, W_code>>, Preobj)
			end;
		end

	check_extendible is
			-- Check that `Current' is a valid dynamically extendible
			-- project.
		do
			is_precompile := False;
			check_project_directory
		end;

feature {COMPILER_EXPORTER} -- Update

	update_path is
			-- Interpret environment variables in directory name.
		do
			name := Environ.interpreted_string (dollar_name)
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

				-- EIFGEN directory must be 
				-- be readable.
			check_directory (<<Eiffelgen>>);

				-- EIFGEN/COMP directory must be
				-- readable.
			check_directory (<<Eiffelgen, Comp>>);

				-- EIFGEN/project.eif file must be
				-- readable.
			check_file (<<Eiffelgen>>, Dot_workbench);

				-- EIFGEN/W_code file must be
				-- readable.
			check_directory (<<Eiffelgen, W_code>>);

		end

	check_directory (directories: ARRAY [STRING]) is
			-- Check readability of directory of name
			-- `rn' relative to Current.
		local
			d: DIRECTORY;
			dn: DIRECTORY_NAME;
			vd42: VD42;
			v9rd: V9RD;
			i: INTEGER
		do
			if is_valid then
				!!dn.make_from_string (name);
				from
					i := directories.lower
				until
					i > directories.upper
				loop
					dn.extend (directories.item (i))
					i := i + 1
				end
				!! d.make (dn);
				is_valid :=
					d.exists and then
					d.is_readable and then
					d.is_executable
				if not is_valid then
					if is_precompile then
						!! vd42;
						vd42.set_path (dn);
						vd42.set_is_directory;
						Error_handler.insert_error (vd42);
					else
						!! v9rd;
						v9rd.set_path (dn);
						v9rd.set_is_directory;
						Error_handler.insert_error (v9rd);
					end;
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
			v9rd: V9RD;
			i: INTEGER
		do
			if is_valid then
				!!fn.make_from_string (name);
				from
					i := directories.lower
				until
					i > directories.upper
				loop
					fn.extend (directories.item (i))
					i := i + 1
				end
				fn.set_file_name (rn);
				!! f.make (fn);
				is_valid :=
					f.exists and then
					f.is_plain and then
					f.is_readable
				if not is_valid then
					if is_precompile then
						!! vd42;
						vd42.set_path (fn);
						Error_handler.insert_error (vd42);
					else
						!! v9rd;
						v9rd.set_path (fn);
						Error_handler.insert_error (v9rd);
					end	
				end
			end
		end;

	check_precompiled_optional (directories: ARRAY [STRING]; rn: STRING) is
		local
			f: RAW_FILE;
			fn: FILE_NAME;
			vd43: VD43;
			ok: BOOLEAN
			i: INTEGER;
		do
			if is_valid then
				!!fn.make_from_string (name);
				from
					i := directories.lower
				until
					i > directories.upper
				loop
					fn.extend (directories.item (i))
					i := i + 1
				end
				fn.set_file_name (rn);
				!! f.make (fn);
				ok :=
					f.exists and then
					f.is_plain and then
					f.is_readable
				if not ok then
					!! vd43;
					vd43.set_path (fn);
					Error_handler.insert_warning (vd43);
				end
			end
		end

end -- class REMOTE_PROJECT_DIRECTORY
