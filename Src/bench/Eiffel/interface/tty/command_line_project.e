indexing

	description: 
		"Representation of a command line project class. Used to initialize,%
		%retrieve and create eiffel projects.";
	date: "$Date$";
	revision: "$Revision $"

class COMMAND_LINE_PROJECT 

inherit
	SHARED_EIFFEL_PROJECT

	PROJECT_CONTEXT

	WINDOWS

	SHARED_BENCH_LICENSES
		rename
			class_name as except_class_name
		end;

	SHARED_EXEC_ENVIRONMENT

	WARNING_MESSAGES

feature -- Properties

	project_file_name: STRING;
			-- Name of the project file. 
			-- Not required when creating a project.

	project_path_name: STRING;
			-- Path where to look for the EIFGEN directory and the
			-- project file.

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

	project_dir: PROJECT_DIRECTORY
		-- Location of the project directory.	

	project_file: PROJECT_EIFFEL_FILE
			-- Location of the file where all the information 
			-- about the current project are saved.

feature -- Update

	init_project (file_name: STRING) is
			-- Initialize the project, with the `file_name' project file
			--| At this stage, `Project_directory_name' and `file_name' have
			--| been set.
		local
			e_displayer: DEFAULT_ERROR_DISPLAYER
		do
				--| Initialization of the display
			!! e_displayer.make (Error_window);
			Eiffel_project.set_error_displayer (e_displayer)

				-- If `file_name' is Void it means the user did not specify
				-- his project file, so he wants to create a new project.
				--| Even if it was not the case, before overwritting, we will
				--| make sure that there is no EIFGEN directory in the specified
				--| directory.
			if file_name /= Void then
				open_project_file (file_name)
			else
				create_project (Project_directory_name)
			end
		end

feature -- Project Initialization

	create_project (dir: STRING) is
			-- Create an Eiffel Project.
		local
			p: PROJECT_EIFFEL_FILE
		do
			!! project_dir.make (dir, p);
			if project_path_name /= Void then
				Project_directory_name.wipe_out
				Project_directory_name.set_directory (project_path_name)
			end
			project_is_new := True
		end

	open_project_file (file_name: STRING) is
			-- Initialize project as a new one or retrieving
			-- existing data in the valid directory `project_dir'.
		require
			project_directory_exist: project_dir /= Void
		local
			dir_name: STRING
			new_file_name: STRING
			msg: STRING
		do
			Project_directory_name.wipe_out
			if project_path_name /= Void then
					-- `project_path_name' has been specified, so `file_name'
					-- should not contain any absolute path.
					--| We raise an error if it is the case.
					--| If not, we append the `file_name' to `project_path_name', we
					--| add a `Directory_separator' if it is needed.
				if file_name.index_of (Directory_separator, 1) /= 0 then
					error_occurred := True
					msg := "You cannot specifiy a project name which contains a directory separator%N"
					msg.append ("when you are specifying a project path.")
				else
					Project_directory_name.set_directory (project_path_name)
					new_file_name := clone (project_path_name)
					if new_file_name.item (new_file_name.count) /= Directory_separator then
						new_file_name.append_character (Directory_separator)
					end
					new_file_name.append (file_name)
				end
			else
					-- No project path has been specified, so `file_name' can either contain
					-- a file name or a path name.
					--| If it is a relative path name, we prepend `Current_working_directory' to it.
					--| Otherwise, we extract the `Project_directory_name' from the path.
				if file_name.index_of (Directory_separator, 1) /= 0 then
					dir_name := file_name.substring (1, file_name.last_index_of
								(directory_separator, file_name.count) - 1)
					Project_directory_name.set_directory (dir_name)
					new_file_name := file_name
				else
					dir_name := Execution_environment.current_working_directory
					Project_directory_name.set_directory (dir_name)
					new_file_name := clone (dir_name)
					if new_file_name.item (new_file_name.count) /= Directory_separator then
						new_file_name.append_character (Directory_separator)
					end
					new_file_name.append (file_name)
				end
			end

			if not error_occurred then
					--| Retrieve existing project
				!! project_file.make (new_file_name)
				!! project_dir.make (dir_name, project_file)
			end
		end

feature -- Project retrieval

	retrieve_project is
			-- Retrieve a project from the disk.
		require
			project_directory_exists: project_dir /= Void
		local
			msg: STRING
			title: STRING
			old_title: STRING
		do	
			io.error.putstring ("Retrieving project...%N")
			Eiffel_project.make (project_dir)

				-- Retrieve the project
			Eiffel_project.retrieve

			if Eiffel_project.retrieval_error then
				if Eiffel_project.is_incompatible then
					msg := w_Project_incompatible (project_dir.name, 
						version_number, Eiffel_project.incompatible_version_number)
				else
					if Eiffel_project.is_corrupted then
						msg := w_Project_corrupted (project_dir.name)
					elseif Eiffel_project.retrieval_interrupted then
						msg := w_Project_interrupted (project_dir.name)
					end
				end
			elseif Eiffel_project.incomplete_project then
				msg := w_Project_directory_not_exist (project_file.name, project_dir.name)
			elseif Eiffel_project.read_write_error then
				msg := w_Cannot_open_project
			end

			if msg /= Void then
				io.error.putstring (msg)
				io.error.new_line
				error_occurred := True
			end
		end

	make_new_project (is_loop: BOOLEAN) is
			-- Initialize project as a new one.
		require
			New_project: project_is_new
		local
			file: PLAIN_TEXT_FILE
			path: FILE_NAME
		do
			if is_loop then
				if Ace_name /= Void then
					check_ace_file (Ace_name);
				end; 
			elseif Ace_name = Void then
				!! path.make_from_string (Execution_environment.current_working_directory)
				path.set_file_name ("Ace.ace")	
				!!file.make (path)
				if file.exists then
					Ace_name := path
				else
					!! path.make_from_string (Execution_environment.current_working_directory)
					path.set_file_name ("Ace")	
					Ace_name := path
				end
				check_ace_file (Ace_name);
			end;
			Eiffel_project.make_new (project_dir)
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
