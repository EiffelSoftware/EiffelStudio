indexing

	description: 
		"Representation of a command line project class. Used to initialize,%
		%retrieve and create eiffel projects.";
	date: "$Date$";
	revision: "$Revision $"

class COMMAND_LINE_PROJECT 

inherit

	SHARED_ERROR_BEHAVIOR;
	PROJECT_CONTEXT
		redefine
			init_project_directory
		end;
	WINDOWS;
	SHARED_RESCUE_STATUS;
	SHARED_LICENSE
		rename
			class_name as except_class_name
		end

feature -- Properties

	init_project_directory: PROJECT_DIR;
			-- Dummy attribute used for once initialization

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
			project_dir: PROJECT_DIR;
			workbench_file: RAW_FILE;
			temp: STRING;
			fn: FILE_NAME
		do
			if not retried then
				error_occurred := False;

					-- Project directory
				!! project_dir.make (project_name); 
	
					-- Workbench file
				!! fn.make_from_string (project_dir.name);
				fn.extend (Eiffelgen);
				fn.set_file_name (Dot_workbench);
				!!workbench_file.make (fn);

				if not project_dir.exists then
					!! temp.make (0);
					temp.append ("Directory: ");
					temp.append (project_dir.name);
					temp.append (" does not exist");
					error_occurred := True;
				else

						-- Is the project new?
					project_is_new := project_dir.is_new or else
								(not workbench_file.exists)

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
							init_project_directory := project_dir;
							if project_dir /= Project_directory then end;
							Create_compilation_directory;
							Create_generation_directory;
						end
					else
						if not workbench_file.is_readable then
							!! temp.make (0);
							temp.append (workbench_file.name);
							temp.append (" is not readable");
							error_occurred := True
						elseif not workbench_file.is_plain then
							!! temp.make (0);
							temp.append (workbench_file.name);
							temp.append (" is not a file");
							error_occurred := True
						else
							init_project_directory := project_dir;
							if project_dir /= Project_directory then end
						end;
					end;
				end;
				if error_occurred then
					io.error.putstring (temp);
					io.error.new_line;
				end
			else
				error_occurred := True;
				retried := False;
				!! temp.make (0);
				temp.append ("Project in: ");
				temp.append (project_dir.name);
				temp.append ("%NCannot be retrieved. Check permissions");
				temp.append (" and please try again");
				io.error.putstring (temp);
				io.error.new_line;
			end
		rescue
			if Rescue_status.is_unexpected_exception then
				retried := True;
				retry
			end
		end;

	retrieve_project is
			-- Retrieve existing project.
		local
			workb: WORKBENCH_I;
			init_work: INIT_WORKBENCH;
			workbench_file: RAW_FILE;
			precomp_r: PRECOMP_R;
			extendible_r: EXTENDIBLE_R;
			temp: STRING
		do
			if not retried then
				!!workb;
				!!workbench_file.make_open_read (Project_file_name);
				workb ?= workb.retrieved (workbench_file);
				if workb = Void then
					retried := True;
				end;
			end;
			if not retried then
				if not workbench_file.is_closed then
					workbench_file.close
				end
				!!init_work.make (workb);
				Workbench.init;

					-- Set the ace file ONLY if -ace is used
				if Ace_name /= Void then
					check_ace_file (Ace_name);
					Workbench.lace.set_file_name (Ace_name);
				end;

				if System.uses_precompiled then
					!!precomp_r;
					precomp_r.set_precomp_dir
				end;
				if System.is_dynamic then
					!!extendible_r;
					extendible_r.set_extendible_dir
				end;
				System.server_controler.init;
				Universe.update_cluster_paths;

				check_permissions
			else
				retried := False;
				if not workbench_file.is_closed then
					workbench_file.close
				end;
				!! temp.make (0);
				temp.append ("Project in: ");
				temp.append (Project_directory.name);
				temp.append (" is corrupted. Cannot continue");
				io.error.putstring (temp);
				io.error.new_line;
				error_occurred := True
			end
		rescue
			if Rescue_status.is_unexpected_exception then
				retried := True;
				retry
			end
		end;

	check_permissions is
			-- Check to see if the project writable/readable
			-- Most of the commands need only read permissions
			-- It is the default behavior
		do
			if is_project_writable then
				Project_read_only.set_item (false)
			elseif is_project_readable then
				Project_read_only.set_item (true);
				io.error.put_string (
					"No write permissions on project.%N%
					%Project opened in read-only mode.%N")
			else
				io.error.put_string (
					"Project is not readable; check permissions.%N");
				error_occurred := true
			end
		end

	make_new_project (is_loop: BOOLEAN) is
			-- Initialize project as a new one.
		require
			New_project: project_is_new
		local
			workb: WORKBENCH_I;
			init_work: INIT_WORKBENCH;
			file: PLAIN_TEXT_FILE
		do
			!!workb;
			!!init_work.make (workb);
			workb.make;
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
			Workbench.lace.set_file_name (Ace_name);
		end

feature -- Output

	save_project is
			-- Clear the servers and save the system structures
			-- to disk.
		local
			file: RAW_FILE;
			temp: STRING
		do
			if not retried then
				System.server_controler.wipe_out;
				!!file.make (Project_file_name);
				file.open_write;
				Workbench.basic_store (file);
				file.close;
			else
				retried := False;
				if not file.is_closed then
					file.close
				end;
					!! temp.make (0);
					temp.append ("Error: could not write to ");
					temp.append (Project_file_name);
					temp.append ("%NPlease check permissions and disk space");
				io.error.putstring (temp);
				io.error.new_line;
				if stop_on_error or else termination_requested then
					lic_die (-1)
				else
					save_project
				end
			end
		rescue
			if Rescue_status.is_unexpected_exception then
				retried := True;
				retry
			end
		end;

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
				f.exists and then f.is_readable and then f.is_plain
			then
			else
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
