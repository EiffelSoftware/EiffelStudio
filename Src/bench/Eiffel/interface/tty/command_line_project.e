indexing

	description: 
		"Representation of a command line project class. Used to initialize,%
		%retrieve and create eiffel projects.";
	date: "$Date$";
	revision: "$Revision $"

class COMMAND_LINE_PROJECT 

inherit

	SHARED_ERROR_BEHAVIOR;
	SHARED_EIFFEL_PROJECT;
	PROJECT_CONTEXT;
	WINDOWS;
	SHARED_BENCH_LICENSES
		rename
			class_name as except_class_name
		end;

feature -- Properties

	project_name: STRING;
			-- Name of the project directory. 
			-- ("" by default)

	precompiled_project_name: STRING;
			-- Name of precompiled project directory
			-- if any.

	Ace_name: STRING;
			-- Name of the Ace file.
			-- ("Ace.ace" or "Ace" by default)

	project_is_new: BOOLEAN;
			-- Is it a new project?

	error_occurred: BOOLEAN;
			-- Did an error occur during the initialization
			-- process?

	retried: BOOLEAN;
			-- For rescues

feature -- Update

	init_project is
			-- Initialize the project, i.e.
		local
			project_dir: PROJECT_DIRECTORY;
			project_eif_file: RAW_FILE;
			temp: STRING;
			fn: FILE_NAME;
			e_displayer: DEFAULT_ERROR_DISPLAYER
		do
			error_occurred := False;

				-- Project directory
			!! project_dir.make (project_name); 

			if not project_dir.exists then
				!! temp.make (0);
				temp.append ("Directory: ");
				temp.append (project_dir.name);
				temp.append (" does not exist");
				error_occurred := True;
			else
					-- Is the project new?
				project_is_new := project_dir.is_new;
				if project_is_new then
					if
						not project_dir.is_readable or else
						not project_dir.is_writable or else
						not project_dir.is_executable
					then
						!! temp.make (0);
						temp.append ("Directory: ");
						temp.append (project_dir.name);
						temp.append (" does not have appropriate permissions.")

						error_occurred := True;
					else
							-- Create a new project.
						Eiffel_project.make (project_dir);
					end
				else
					project_eif_file := project_dir.project_eif_file;
					if not project_eif_file.is_readable then
						!! temp.make (0);
						temp.append (project_eif_file.name);
						temp.append (" is not readable");
						error_occurred := True
					elseif not project_eif_file.is_plain then
						!! temp.make (0);
						temp.append (project_eif_file.name);
						temp.append (" is not a file");
						error_occurred := True
					end;
				end;
			end;
			if error_occurred then
				io.error.putstring (temp);
				io.error.new_line;
			end;
			!! e_displayer.make (Error_window);
			Eiffel_project.set_error_displayer (e_displayer)
		end;

	retrieve_project is
			-- Retrieve existing project.
		require
			valid_project_name: project_name /= Void and then 
							not project_name.empty
		local
			workb: WORKBENCH_I;
			init_work: INIT_WORKBENCH;
			project_eif_file: RAW_FILE;
			precomp_r: PRECOMP_R;
			extendible_r: EXTENDIBLE_R;
			temp: STRING;
			project_dir: PROJECT_DIRECTORY;
		do
			!! project_dir.make (project_name);
			Eiffel_project.retrieve (project_dir);
			if Eiffel_project.retrieval_error then
				!! temp.make (0);
				if Eiffel_project.is_corrupted then
					temp.append ("Project in: ");
					temp.append (Project_directory);
					temp.append ("%Nis corrupted. ");
				elseif Eiffel_project.retrieval_interrupted then
					temp.append ("Retrieving project in: ");
					temp.append (Project_directory);
					temp.append ("%Nwas interrupted. ");
				else 
					if Eiffel_project.incompatible_version_number.empty then
						temp.append
							("File `project.txt' does not exist in project directory:%N"
)
						temp.append (Project_directory);
						temp.append ("%NThis file must exist. ");
					else
						temp.append ("Incompatible_version for project: ")
						temp.append (Project_directory);
						temp.append ("%NEiffelBench version is: ");
						temp.append (version_number);
						temp.append ("%NProject was compiled with version: ");
						temp.append (Eiffel_project.incompatible_version_number)
						temp.append ("%N")
					end
				end
				temp.append ("Cannot continue");
				io.error.putstring (temp);
				io.error.new_line;
				error_occurred := True
			elseif Eiffel_project.read_write_error then
				io.error.put_string (
					"Project is not readable; check permissions.%N");
				error_occurred := true
			elseif Eiffel_project.is_read_only then
				io.error.put_string (
					"No write permissions on project.%N%
					%Project opened in read-only mode.%N")
			end
			if Ace_name /= Void then
				if Eiffel_project.ace.valid_file_name (Ace_name) then
					Eiffel_project.ace.set_file_name (Ace_name)
				else
					io.error.putstring ("Ace file `");
					io.error.putstring (Ace_name);
					io.error.putstring ("' does not exist.%N")
					error_occurred := True
				end
			end
		end;

	make_new_project (is_loop: BOOLEAN) is
			-- Initialize project as a new one.
		require
			New_project: project_is_new
		local
			workb: WORKBENCH_I;
			init_work: INIT_WORKBENCH;
			file: PLAIN_TEXT_FILE
		do
			if is_loop then
				if Ace_name /= Void then
					check_ace_file (Ace_name);
				end; 
			elseif Ace_name = Void then
				!!file.make ("Ace.ace")
				if file.exists then
					Ace_name := "Ace.ace"
				else
					!!file.make ("Ace");
					if file.exists then
						Ace_name := "Ace"
					else
						Ace_name := "Ace.ace"
					end
				end
				check_ace_file (Ace_name);
			end;
			Eiffel_ace.set_file_name (Ace_name);
		end

feature -- Input/output

	termination_requested: BOOLEAN is
		local
			str: STRING
		do
			io.error.putstring ("%N%
				%Press <Return> to retry saving or <Q> to quit%N");
			wait_for_return;
			str := clone (io.laststring)
			str.to_lower;
			Result := ((str.count >= 1) and then (str.item (1) = 'q'))
		end;

	wait_for_return is
		do
			io.readline;
		rescue
			retry
		end;

feature -- Check Ace file

	check_ace_file (fn: STRING) is
			-- Check that the Ace file exists and is readable and plain
		local
			f: PLAIN_TEXT_FILE
		do
			!! f.make (fn);
			if
				not (f.exists and then f.is_readable and then f.is_plain)
			then
				io.error.putstring ("Ace file `");
				io.error.putstring (fn);
				if f.exists then
					io.error.putstring ("' cannot be read%N");
				else
					io.error.putstring ("' does not exist%N");
				end;
				lic_die (-1)
			end
		end;

end -- class COMMAND_LINE_PROJECT
