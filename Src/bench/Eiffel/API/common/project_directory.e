indexing
	description: "Directory for an eiffelbench project.";
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
			mode as file_mode,
			exists as base_exists,
			is_readable as is_base_readable,
			is_writable as is_base_writable,
			is_executable as is_base_executable
		end

	SHARED_WORKBENCH

creation

	make
	
feature -- Access

	is_new: BOOLEAN is
			-- Is this a new eiffel project directory?
			-- (Checks to see if there is eiffelgen directory
			-- and project.eif file).
		require
			exists: exists
		local
			dir_name: DIRECTORY_NAME
			eif_gen_d: DIRECTORY;
		do
			!! dir_name.make_from_string (name);
			dir_name.extend (Eiffelgen);
			!! eif_gen_d.make (dir_name);
			Result := not eif_gen_d.exists or else
				not project_eif_file.exists
		ensure
			not_new_implies_eif_exists:
				not is_new implies project_eif_file.exists
		end;

	project_eif_file: PROJECT_EIFFEL_FILE is
			-- Project.eif file in project directory
		local
			fn, ptxt_fn: FILE_NAME
		do
			if private_project_eif_file = Void then
				!! fn.make_from_string (name);
				fn.extend (Eiffelgen);
				fn.set_file_name (Dot_workbench);
				!! ptxt_fn.make_from_string (name);
				ptxt_fn.extend (Eiffelgen);
				ptxt_fn.set_file_name (Project_txt);
				!! private_project_eif_file.make (fn, ptxt_fn)
			end;
			Result := private_project_eif_file
		ensure
			not_void_result: Result /= Void
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
		local
			w_code_dir, f_code_dir, comp_dir: DIRECTORY;
			project_file: RAW_FILE
		do
			!! w_code_dir.make (Workbench_generation_path);
			!! f_code_dir.make (Final_generation_path);
			!! comp_dir.make (Compilation_path);
			!! project_file.make (Project_file_name);
			Result := is_base_readable and then w_code_dir.is_readable
					and then f_code_dir.is_readable and then comp_dir.is_readable
					and then project_file.is_readable
			if initialized then
				Result := Result and then System.server_controler.is_readable
			end
		end;

	is_writable: BOOLEAN is
			-- May the project be both compiled and used for browsing?
		local
			w_code_dir, f_code_dir, comp_dir: DIRECTORY;
			project_file: RAW_FILE
		do
			!! w_code_dir.make (Workbench_generation_path);
			!! f_code_dir.make (Final_generation_path);
			!! comp_dir.make (Compilation_path);
			!! project_file.make (Project_file_name);
			Result := is_base_writable and then w_code_dir.is_writable
					and then f_code_dir.is_writable and then comp_dir.is_writable
					and then project_file.is_writable
			if initialized then
				Result := Result and then System.server_controler.is_writable
				if System.is_dynamic then
					Result := Result and then 
						(not Update_dle_file.exists or else 
						Update_dle_file.is_writable)
				else
					Result := Result and then 
						(not Update_file.exists or else Update_file.is_writable)
				end
			end
		end;

	exists: BOOLEAN is
			-- Does the project exist?
			--| Ie, Comp, F_code, W_code exist?
		local
			w_code_dir, f_code_dir, comp_dir: DIRECTORY;
			project_file: RAW_FILE
		do
			!! w_code_dir.make (Workbench_generation_path);
			!! f_code_dir.make (Final_generation_path);
			!! comp_dir.make (Compilation_path);
			!! project_file.make (Project_file_name);
			Result := base_exists and then w_code_dir.exists
				and then f_code_dir.exists and then comp_dir.exists
				and then project_file.exists
			if initialized then
				Result := Result and then System.server_controler.exists
			end
		end
               
	has_base_full_access: BOOLEAN is
		do
			Result := is_base_readable and then is_base_writable and then
					is_base_executable                      
		end                                                              

feature -- Update

	set_initialized is
			-- Set a flag to know wether or not the project has been initialized
			-- correctly, ie `system' has been correctly created.
		do
			initialized := True
		end

	initialized: BOOLEAN
			-- Has the project correctly initialized?

feature {NONE} -- Implementation

	private_project_eif_file: PROJECT_EIFFEL_FILE
			-- Project.eif file

end -- class PROJECT_DIRECTORY
