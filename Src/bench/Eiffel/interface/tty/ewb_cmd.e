-- General notion of command line command 
-- corresponding to an option of `ewb'

deferred class EWB_CMD 

inherit

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
	COMPARABLE
		undefine
			is_equal
		end;
	SHARED_LICENSE
		rename
			class_name as except_class_name
		end;
	SHARED_EXEC_ENVIRONMENT;
	SHARED_RESOURCES


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
			-- ("Ace.ace" or "Ace" by default)

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
			workbench_file: RAW_FILE;
			temp: STRING;
			fn: FILE_NAME
		do

	-- Do not do anything if already initialized.
	-- (Introduced for the command loop)
if not initialized.item then

			if not retried then
				error_occurred := False;

					-- Project directory
				!! project_dir.make (project_name); 
	
					-- Workbench file
				!! fn.make_from_string (project_dir.name);
				fn.extend (Eiffelgen);
				fn.set_file_name (Dot_workbench);
				!!workbench_file.make (fn.path);

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
			workbench_file: RAW_FILE;
			precomp_r: PRECOMP_R;
			temp: STRING
		do

	-- Do not do anything if already initialized.
	-- (Introduced for the command loop)
if not initialized.item then

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
					precomp_r.set_precomp_dir;
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

	check_permissions is
			-- Check to see if the project writable/readable
			-- Most of the commands need only read permissions
			-- It is the default behavior
		do
			if is_project_writable then
				Project_read_only.set_item (false)
			elseif is_project_readable then
				Project_read_only.set_item (true);
			else
				io.error.put_string (
					"Project is not readable; check permissions.%N");
				error_occurred := true
			end
		end

	make_new_project is
			-- Initialize project as a new one.
		require
			New_project: project_is_new
		local
			workb: WORKBENCH_I;
			init_work: INIT_WORKBENCH;
			file: PLAIN_TEXT_FILE
		do

	-- Do not do anything if already initialized.
	-- (Introduced for the command loop)
if not initialized.item then

			!!workb;
			!!init_work.make (workb);
			workb.make;
			if Ace_name = Void then
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
			end;
			check_ace_file (Ace_name);
			Workbench.lace.set_file_name (Ace_name);

	-- The project is now initialized
	-- (Introduced for the command loop)
initialized.put (True);
end
		end;

feature {NONE} -- I/O

	termination_requested: BOOLEAN is
		local
			str: STRING
		do
			io.error.putstring ("%N%
				%Press <Return> to resume compilation or <Q> to quit%N");
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

	last_input: STRING;

	get_last_input is
		do
			last_input := cmd_arguments.current_item;
		end;

	no_more_arguments: BOOLEAN is
		do
			Result := cmd_arguments.no_more_arguments
		end;

	check_arguments_and_execute is
		local
			not_first: BOOLEAN
		do
			if not no_more_arguments then
				io.error.putstring ("%
					%Too many arguments. The following arguments will be ignored:%N");
				from
				until
					cmd_arguments.no_more_arguments
				loop
					if not_first then
						io.error.putchar (' ');
					end;
					not_first := True;
					io.error.putstring (cmd_arguments.current_item);
				end;
				io.error.new_line;
				io.error.new_line;
			end;
			if not abort then
				execute
			else
				abort := False;
			end;
		end;

	get_name is
		local
			i, j: INTEGER;
			done: BOOLEAN;
			item: CHARACTER;
			arg: STRING;
			count: INTEGER
		do
			wait_for_return;
			count := io.laststring.count;
			!! arg.make (count);
			cmd_arguments.wipe_out;
			from
				i := 1;
				j := 1;
			until
				(i > count)
			loop
				item := io.laststring.item (i);
				if
					(item = ' ') or else
					(item = '%T')
				then
					if arg.count /= 0 then
						cmd_arguments.force (arg, j);
						j := j + 1;
						!!arg.make (count -i);
					end;
				else
					arg.extend (item)
				end;
				i := i + 1
			end;
			if j = 1 or else arg.count /= 0 then
					-- If we are processing more than one word, we don't
					-- want to keep the trailing white spaces
				cmd_arguments.force (arg, j);
			end;
		end;

	get_class_name is
		do
			if no_more_arguments then
				io.putstring ("--> Class name: ");
				get_name;
			end;
			get_last_input;
			last_input.to_lower;
			if last_input.empty then
				abort := True
			end;
		end;

	get_feature_name is
		do
			if no_more_arguments then
				io.putstring ("--> Feature name: ");
				get_name;
			end;
			get_last_input;
			last_input.to_lower;
			if last_input.empty then
				abort := True
			end;
		end;

	output_window: CLICK_WINDOW;

	yank_window: YANK_WINDOW is
		once
			!!Result.make;
		end;

	cmd_arguments: EWB_ARGUMENTS is
		once
			!!Result.make (1, 2);
		end;

	abort: BOOLEAN;
			-- Does the user want to abort the command?

	arguments: STRING is
			-- Arguments passed to the application
		once
			!!Result.make (0)
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

	confirmed (message: STRING): BOOLEAN is
		local
			c: CHARACTER
		do
			io.putstring (message);
			io.putstring (" [y/n]? ");
			io.readchar;
			c := io.lastchar;
			if c /= '%N' then
				io.next_line;
			end;
			Result := ((c = 'Y') or (c = 'y'))
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

feature {NONE} -- Check Ace file

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

feature -- Execution

	work (pn, an: STRING) is
		do
			project_name := pn;
			Ace_name := an;
			execute;
		end;

	execute is
		deferred
		end;

	loop_execute is
		do
			check_arguments_and_execute
		end;

feature

	edit (a_file: STRING) is
		require
			file_not_void: a_file /= Void
		local
			editor: STRING;
			cmd: STRING;
		do
			editor := resources.get_string (r_Editor, Void);
			if editor /= Void then
				!!cmd.make (0);
				cmd.append (editor);
				cmd.extend (' ');
				cmd.append (a_file);
				Execution_environment.system (cmd);
			else
				io.error.putstring ("The resource EDITOR is not set%N");
			end;
		end;

end
