indexing
	description: "Directory for an eiffel project.";
	date: "$Date$";
	revision: "$Revision $"

class PROJECT_DIRECTORY

inherit
	PROJECT_CONTEXT
		export
			{NONE} all
		end

	DIRECTORY
		rename
			make as directory_make,
			mode as file_mode,
			exists as base_exists,
			is_readable as is_base_readable,
			is_writable as is_base_writable,
			is_executable as is_base_executable
		end

	SHARED_WORKBENCH

creation
	make
	
feature -- Initialization

	make (dn: STRING; project_eiffel_file: PROJECT_EIFFEL_FILE) is
		do
			directory_make (dn)
			if project_eiffel_file /= Void then
				set_project_file (project_eiffel_file)
			end
		end

feature -- Access

	is_new: BOOLEAN is
			-- Is this a new eiffel project directory?
			-- (Checks to see if there is an EIFGEN directory
			-- and project.eif file).
		require
			exists: exists
		local
			dir_name: DIRECTORY_NAME
			eif_gen_d: DIRECTORY
		do
			create dir_name.make_from_string (name)
			dir_name.extend (Eiffelgen)
			create eif_gen_d.make (dir_name)
			Result := not eif_gen_d.exists
			if not Result then
					-- A `EIFGEN' directory exists, we need to check
					-- if there is an Eiffel Project Repository file.
				if project_eif_file /= Void then
					Result := not project_eif_file.exists
				end
			end
		ensure
			not_new_implies_eif_exists:
				not is_new implies (project_eif_file /= Void
							and then project_eif_file.exists)
		end;

	valid_project_eif: BOOLEAN is
			-- Is the `project_eif' file valid?
		local
			file: like project_eif_file
		do
			file := project_eif_file;
			Result := file.is_readable and then
				file.is_plain
		ensure
			valid_implies_good_file:
				project_eif_file.is_readable and then
					project_eif_file.is_plain
		end;

	is_readable: BOOLEAN is
			-- May the project be used for browsing and debugging?
		require
			project_eif_file_set: project_eif_file /= Void
		local
			w_code_dir, f_code_dir, comp_dir: DIRECTORY;
			project_file: RAW_FILE
		do
			create w_code_dir.make (temp_workbench_generation_path);
			create f_code_dir.make (temp_final_generation_path);
			create comp_dir.make (temp_compilation_path);
			create project_file.make (project_eif_file.name);
			Result := is_base_readable and then w_code_dir.is_readable
					and then f_code_dir.is_readable and then comp_dir.is_readable
					and then project_file.is_readable
			if initialized then
				Result := Result and then System.server_controler.is_readable
			end
		end;

	is_writable: BOOLEAN is
			-- May the project be both compiled and used for browsing?
		require
			project_eif_file_set: project_eif_file /= Void
		local
			w_code_dir, f_code_dir, comp_dir: DIRECTORY
			project_file: RAW_FILE
		do
			create w_code_dir.make (temp_workbench_generation_path)
			create f_code_dir.make (temp_final_generation_path)
			create comp_dir.make (temp_compilation_path)
			create project_file.make (project_eif_file.name)
			Result := is_base_writable and then w_code_dir.is_writable
					and then f_code_dir.is_writable and then comp_dir.is_writable
					and then project_file.is_writable
			if initialized then
				Result := Result and then System.server_controler.is_writable
			end
		end;

	exists: BOOLEAN is
			-- Does the project exist?
			--| Ie, Comp, F_code, W_code and project file exist?
		require
			project_eif_file_set: project_eif_file /= Void
		local
			w_code_dir, f_code_dir, comp_dir: DIRECTORY
			project_file: RAW_FILE
		do
			create w_code_dir.make (temp_workbench_generation_path)
			create f_code_dir.make (temp_final_generation_path)
			create comp_dir.make (temp_compilation_path)
			create project_file.make (project_eif_file.name)
			Result := base_exists and then w_code_dir.exists
				and then f_code_dir.exists and then comp_dir.exists
				and then project_file.exists
			if initialized then
				Result := Result and then System.server_controler.exists
			end
		end

	eifgen_exists: BOOLEAN is
			-- Does the `EIFGEN' directory exist?
		local
			base: DIRECTORY
			base_name: DIRECTORY_NAME
		do
			create base_name.make_from_string (Project_directory_name)
			base_name.extend (Eiffelgen)
			create base.make (base_name)

			Result := base_exists and then base.exists
		end
               
	has_base_full_access: BOOLEAN is
		do
			Result := is_base_readable and then is_base_writable and then
					is_base_executable                      
		end

	forget_old_project is
			-- Rename `EIFGEN' to `EIFGEN-old'.
			-- Will raise an exception if it is not possible.
			-- This exception will be catch at a higher level
			--| This is for safety reason and to avoid the user
			--| to do it by hands.
		require
			project_exists: exists
			is_readable: is_readable
			is_writable: is_writable
		local
			old_name: DIRECTORY_NAME
			new_name: STRING
			eifgen_dir: DIRECTORY
		do
			create old_name.make_from_string (name)
			old_name.set_subdirectory (Eiffelgen)

			new_name ?= clone (old_name)
			new_name.append ("-old")

				--| Change the name of the directory
				--| If the directory exists, it will raise an exception
			create eifgen_dir.make (old_name)
			eifgen_dir.change_name (new_name)
		end

feature -- Update

	set_initialized is
			-- Set a flag to know wether or not the project has been initialized
			-- correctly, ie `system' has been correctly created.
		do
			initialized := True
		ensure
			initialized_set: initialized
		end

	set_project_file (project_file: PROJECT_EIFFEL_FILE) is
		require
			project_file_not_void: project_file /= Void
		do
			project_eif_file := project_file
		ensure
			project_eif_file_set: project_eif_file = project_file
		end

feature -- Access
	
	initialized: BOOLEAN
			-- Has the project correctly initialized?

	project_eif_file: PROJECT_EIFFEL_FILE
			-- Project.eif file in project directory

end -- class PROJECT_DIRECTORY
