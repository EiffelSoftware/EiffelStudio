indexing

	description: 
		"Representation of a command line project class. Used to initialize,%
		%retrieve and create eiffel projects."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class COMMAND_LINE_PROJECT 

inherit
	SHARED_EIFFEL_PROJECT

	SHARED_ERROR_BEHAVIOR

	PROJECT_CONTEXT

	EB_SHARED_OUTPUT_TOOLS

	SHARED_EXEC_ENVIRONMENT
	
	SHARED_WORKBENCH
		export
			{NONE} all
		end

	EXCEPTIONS
		rename
			class_name as except_class_name,
			raise as raise_exception,
			die as lic_die
		export
			{NONE} all
		end

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
			create e_displayer.make (Error_window);
			Eiffel_project.set_error_displayer (e_displayer)

				-- If `file_name' is Void it means the user did not specify
				-- his project file, so he wants to create a new project.
				--| Even if it was not the case, before overwritting, we will
				--| make sure that there is no EIFGEN directory in the specified
				--| directory.
			if file_name /= Void then
				open_project_file (file_name)
			else
				create_project
			end
		end

feature -- Project Initialization

	create_project is
			-- Create an Eiffel Project.
			--| By default in current directory, otherwise in directory
			--| pointed by `project_path_name'.
		local
			d: DIRECTORY
			d_name: DIRECTORY_NAME
			answer: STRING
		do
				-- Initialize the attribute to its default value.
			project_is_new := False

				-- Check the value of `-project_path' if specified in the
				-- command line.
			if project_path_name /= Void then
					-- Check the validity of the path given in argument
				create d.make (project_path_name)
				if d.exists then
					Project_directory_name.wipe_out
					Project_directory_name.set_directory (project_path_name)
				else
					error_occurred := True
					io.error.put_string ("Cannot create project in:%N")
					io.error.put_string (project_path_name)
					io.error.put_new_line
				end
			end

			if not error_occurred then
					-- We create a project without an existing Eiffel Project file.
				create project_dir.make (Project_directory_name, Void);

					-- Check the existence of an already existing Eiffel project.
				create d_name.make_from_string (project_dir.name)
				d_name.extend (Eiffelgen)
				create d.make (d_name)
				if d.exists then
						-- A Project exist
					if stop_on_error then
						error_occurred := stop_on_error
						io.error.put_string ("In `")
						io.error.put_string (project_dir.name)
						io.error.put_string ("' an Eiffel project already exists%N")
						io.error.put_string ("Compilation aborted due to `-batch' or `-stop' option.%N")
					else
						io.error.put_string ("In `")
						io.error.put_string (project_dir.name)
						io.error.put_string ("' an Eiffel project already exists.%N")
						io.error.put_string ("Do you wish to overwrite it (Y-yes or N-no)? %N")
						io.read_line
						answer := io.last_string
						answer.to_lower
						error_occurred := not (answer.is_equal ("y") or answer.is_equal ("yes"))
						io.error.put_new_line
					end
				end
				project_is_new := True
			end
		end

	open_project_file (file_name: STRING) is
			-- Initialize project as a new one or retrieving
			-- existing data in the valid directory `project_dir'.
		require
--| FIXME Failed for command line: -short -filter html-css -all -project d:\46dev\eiffel\ace\test_project\test.epr
--|			project_directory_exist: project_dir /= Void
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
				if file_name.index_of (Operating_environment.Directory_separator, 1) /= 0 then
					error_occurred := True
					msg := "You cannot specify a project name which contains a directory separator%N"
					msg.append ("when you are specifying a project path.")
				else
					dir_name := project_path_name.twin
					Project_directory_name.set_directory (dir_name)
					new_file_name := project_path_name.twin
					if new_file_name.item (new_file_name.count) /= Operating_environment.Directory_separator then
						new_file_name.append_character (Operating_environment.Directory_separator)
					end
					new_file_name.append (file_name)
				end
			else
					-- No project path has been specified, so `file_name' can either contain
					-- a file name or a path name.
					--| If it is a relative path name, we prepend `Current_working_directory' to it.
					--| Otherwise, we extract the `Project_directory_name' from the path.
				if file_name.index_of (Operating_environment.Directory_separator, 1) /= 0 then
					dir_name := file_name.substring (1, file_name.last_index_of
								(Operating_environment.Directory_separator, file_name.count) - 1)
					Project_directory_name.set_directory (dir_name)
					new_file_name := file_name
				else
					dir_name := Execution_environment.current_working_directory
					Project_directory_name.set_directory (dir_name)
					new_file_name := dir_name.twin
					if new_file_name.item (new_file_name.count) /= Operating_environment.Directory_separator then
						new_file_name.append_character (Operating_environment.Directory_separator)
					end
					new_file_name.append (file_name)
				end
			end

			if not error_occurred then
					--| Retrieve existing project
				create project_file.make (new_file_name)
				create project_dir.make (dir_name, project_file)
			else
				if msg /= Void then
					io.error.put_string (msg)
					io.error.put_new_line
					error_occurred := True
				end
			end
		end

feature -- Project retrieval

	retrieve_project is
			-- Retrieve a project from the disk.
		require
			project_directory_exists: project_dir /= Void
		local
			msg: STRING
		do	
			io.error.put_string ("Retrieving project...%N")
				-- Retrieve the project
			if not project_dir.exists or else project_dir.is_new then
				msg := Warning_messages.w_Project_directory_not_exist (project_file.name, project_dir.name)
			elseif 
				not project_dir.is_base_readable or else 
				not project_dir.is_base_writable or else
				not project_dir.is_base_executable
			then
				msg := Warning_messages.w_Cannot_open_project
			else
				Eiffel_project.make (project_dir)
	
				if Eiffel_project.retrieval_error then
					if Eiffel_project.is_incompatible then
						msg := Warning_messages.w_Project_incompatible (project_dir.name, 
							version_number, Eiffel_project.incompatible_version_number)
					else
						if Eiffel_project.is_corrupted then
							msg := Warning_messages.w_Project_corrupted (project_dir.name)
						elseif Eiffel_project.retrieval_interrupted then
							msg := Warning_messages.w_Project_interrupted (project_dir.name)
						end
					end
				elseif Eiffel_project.incomplete_project then
					msg := Warning_messages.w_Project_directory_not_exist (project_file.name, project_dir.name)
				elseif Eiffel_project.read_write_error then
					msg := Warning_messages.w_Cannot_open_project
				end
			end

			if msg /= Void then
				io.error.put_string (msg)
				io.error.put_new_line
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
			l_retried: BOOLEAN
		do
			if not l_retried then
				if not is_loop and then Ace_name = Void then
					create path.make_from_string (Execution_environment.current_working_directory)
					path.set_file_name ("Ace.ace")	
					create file.make (path)
					if file.exists then
						Ace_name := path
					else
						create path.make_from_string (Execution_environment.current_working_directory)
						path.set_file_name ("Ace")	
						Ace_name := path
					end
				end
				if Ace_name /= Void then
					check_ace_file (Ace_name)
				end
				Eiffel_project.make_new (project_dir, True, Void, Void)
				check
					Project_initialized: Eiffel_project.initialized
				end
				Eiffel_ace.set_file_name (Ace_name)
			end
		rescue
			l_retried := True
			io.error.put_string ("An error occurred during removal of previous project.%N")
			io.error.put_string ("Please make sure to have full permission to your existing project.%N")
			error_occurred := True
			retry
		end

feature -- Input/output

	termination_requested: BOOLEAN is
		local
			str: STRING
		do
			io.error.put_string ("%N%
				%Press <Return> to retry saving or <Q> to quit%N");
			wait_for_return;
			str := io.last_string.as_lower
			Result := ((str.count >= 1) and then (str.item (1) = 'q'))
		end;

	wait_for_return is
		do
			io.read_line;
		rescue
			retry
		end;

feature -- Check Ace file

	check_ace_file (fn: STRING) is
			-- Check that the Ace file exists and is readable and plain
		local
			f: PLAIN_TEXT_FILE
		do
			create f.make (fn);
			if
				not (f.exists and then f.is_readable and then f.is_plain)
			then
				io.error.put_string ("Ace file `");
				io.error.put_string (fn);
				if f.exists then
					io.error.put_string ("' cannot be read%N");
				else
					io.error.put_string ("' does not exist%N");
				end;
				lic_die (-1)
			end
		end;

feature {NONE} -- Error messages

	Warning_messages: WARNING_MESSAGES is
			-- Placeholder to access all warning messages.
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

end -- class COMMAND_LINE_PROJECT
