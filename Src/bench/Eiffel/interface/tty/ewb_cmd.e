-- General notion of command line command 
-- corresponding to an option of `ewb'

deferred class EWB_CMD 

inherit

	SHARED_WORKBENCH;
	SHARED_ERROR_BEHAVIOR;
	PROJECT_CONTEXT
		redefine
			init_project_directory
		end;
	WINDOWS;
	SHARED_RESCUE_STATUS;
	SHARED_EWB_HELP;
	SHARED_EWB_CMD_NAMES;
	SHARED_EWB_ABBREV;
	COMPARABLE;
	LIC_EXITER

feature -- Creation

	null is do end;

feature -- Initialization

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
			-- ("Ace" by default)

	project_is_new: BOOLEAN;
			-- Is it a new project?

	error_occurred: BOOLEAN;
			-- Did an error occur during the initialization
			-- process?

	retried: BOOLEAN;

	initialized: CELL [BOOLEAN] is
		once
			!! Result.put (False);
		end

	init_project is
			-- Initialize the project, i.e.
		local
			project_dir: PROJECT_DIR;
			workbench_file: UNIX_FILE;
			temp: STRING
		do

	-- Do not do anything if already initialized.
	-- (Introduced for the command loop)
if not initialized.item then

			if not retried then
				error_occurred := False;

					-- Project directory
				!! project_dir.make (project_name); 
	
					-- Workbench file
				!! temp.make (0);
				temp.append (project_dir.name);
				temp.append (workb_rel_path);
				!!workbench_file.make (temp);

					-- Is the project new?
				project_is_new := project_dir.is_new or else
								(not workbench_file.exists)

				if project_is_new then
					if not project_dir.exists then
						!! temp.make (0);
						temp.append ("Directory: ");
						temp.append (project_dir.name);
						temp.append (" does not exist");
						error_occurred := True;
					elseif not project_dir.is_directory then
						!! temp.make (0);
						temp.append (project_dir.name);
						temp.append (" is not a directory");
						error_occurred := True;
					elseif
						not (project_dir.is_readable and then
							project_dir.is_writable and then
							project_dir.is_executable)
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
end;
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
			workbench_file: UNIX_FILE;
			precomp_r: PRECOMP_R;
			temp: STRING
		do

	-- Do not do anything if already initialized.
	-- (Introduced for the command loop)
if not initialized.item then

			if not retried then
				!!workb;
				!!workbench_file.make_open_binary_read (Project_file_name);
				workb ?= workb.retrieved (workbench_file);
				if not workbench_file.is_closed then
					workbench_file.close
				end
				!!init_work.make (workb);
				Workbench.init;
				Workbench.lace.set_file_name (Ace_name);
				if System.uses_precompiled then
					!!precomp_r;
					precomp_r.set_precomp_dir;
				end;
				System.server_controler.init;
				Universe.update_cluster_paths	
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

	-- The project is now initialized
	-- (Introduced for the command loop)
initialized.put (True);
end

		rescue
			if Rescue_status.is_unexpected_exception then
				retried := True;
				retry
			end
		end;

	make_new_project is
			-- Initialize project as a new one.
		require
			New_project: project_is_new
		local
			workb: WORKBENCH_I;
			init_work: INIT_WORKBENCH;
		do

	-- Do not do anything if already initialized.
	-- (Introduced for the command loop)
if not initialized.item then

			!!workb;
			!!init_work.make (workb);
			workb.make;
			Workbench.lace.set_file_name (Ace_name);

	-- The project is now initialized
	-- (Introduced for the command loop)
initialized.put (True);
end
		end;

feature -- Compilation

	compile is
			-- Regular compilation
		local
			exit: BOOLEAN;
			str: STRING
		do
			from
			until
				exit
			loop
				Workbench.recompile;
				if not Workbench.successfull then
					if stop_on_error then
						lic_die (-1);
					end;
					if termination_requested then
						--lic_die (0);
							-- es3 -loop does NOT like lic_die(0)
						discard_license;
						exit := True
					end
				else
					exit := True
				end
			end;
		end;

feature {NONE} -- I/O

	termination_requested: BOOLEAN is
		local
			str: STRING
		do
			io.error.putstring ("%N%
				%Press <Return> to resume compilation or <Q> to quit%N");
			wait_for_return;
			str := io.laststring.duplicate;
			str.to_lower;
			Result := ((str.count >= 1) and then (str.item (1) = 'q'))
		end;

	wait_for_return is
		do
			io.readline;
		rescue
			retry
		end;

	last_input: STRING;

	get_name is
		local
			i: INTEGER;
			done: BOOLEAN
		do
			wait_for_return;
			!! last_input.make (io.laststring.count);
			from
				i := 1
			until
				(i > io.laststring.count) or else
				done
			loop
				if
					(io.laststring.item (i) = ' ') or else
					(io.laststring.item (i) = '%T')
				then
					done := True
				else
					last_input.append_character (io.laststring.item (i))
				end;
				i := i + 1
			end;
		end;

	get_class_name is
		do
			io.putstring ("--> Class name: ");
			get_name;
			last_input.to_lower;
			if last_input.empty then
				get_class_name
			end;
		end;

	get_feature_name is
		do
			io.putstring ("--> Feature name: ");
			get_name;
			last_input.to_lower;
			if last_input.empty then
				get_feature_name
			end;
		end;

	output_window: CLICK_WINDOW;

	yank_window: YANK_WINDOW is
		once
			!!Result.make;
		end;

	prompt_finish_freezing (finalized_dir: BOOLEAN) is
		do
			io.error.putstring ("You must now run %"");
			io.error.putstring (Finish_freezing_script);
			io.error.putstring ("%" in:%N%T");
			if finalized_dir then
				io.error.putstring (Final_generation_path)	
			else
				io.error.putstring (Workbench_generation_path)	
			end;
			io.error.new_line;
		end;

feature -- I/O

	set_output_window (display: CLICK_WINDOW) is
		do
			output_window := display
		end;

feature -- Termination

	terminate_project is
			-- Clear the servers and save the system structures
			-- to disk.
		local
			file: UNIX_FILE;
			temp: STRING
		do
			if not retried then
				System.server_controler.wipe_out;
				!!file.make (Project_file_name);
				file.open_binary_write;
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
					terminate_project
				end
			end
		rescue
			if Rescue_status.is_unexpected_exception then
				retried := True;
				retry
			end
		end;

feature -- Input/Output

	name: STRING is
		deferred
		end;

	infix "<" (other: EWB_CMD): BOOLEAN is
			-- The sort criteria is the command name
		do
			Result := name < other.name
		end;

	help_message: STRING is
		deferred
		end;

	abbreviation: CHARACTER is
		deferred
		end;

	confirmed: BOOLEAN is
		do
--			io.putstring ("Do you wish to ");
--			io.putstring (name);
--			io.putstring (" the system [y/n]? ");
--			io.readchar;
--			io.next_line;	
--			Result := ((io.lastchar = 'Y') or (io.lastchar = 'y'))
			Result := True
		end;

	print_header is
		do
			io.putstring ("%
			   	%Eiffel compilation manager%N%
			  	%  (version ");
			io.putstring (Version_number);
			io.putstring (")%N");
		end;

	print_tail is
		do
			io.error.putstring ("System recompiled.%N")
		end;

feature -- Execution

	work (pn, an: STRING) is
		local
			f: UNIX_FILE
		do
			!! f.make (an);
			if
				f.exists and then f.is_readable and then f.is_plain
			then
				project_name := pn;
				Ace_name := an;
				execute;
			else
				io.error.putstring ("File: ");
				io.error.putstring (an);
				io.error.putstring (" cannot be read%N");
				lic_die (-1)
			end
		end;

	execute is
		deferred
		end;

	loop_execute is
		deferred
		end;

end
