-- General notion of command line command 
-- corresponding to an option of `ewb'

deferred class EWB_CMD 

inherit

	SHARED_WORKBENCH;
	PROJECT_CONTEXT
		redefine
			init_project_directory,
			init_precompilation_directory
		end

feature -- Initialization

	init_project_directory: PROJECT_DIR;
			-- Dummy attribute used for once initialization

	init_precompilation_directory: PROJECT_DIR;
			-- Dummy attribute used for once initialization

	project_name: STRING;
			-- Name of the project directory. 
			-- ("Project" by default)

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

	init_project is
			-- Initialize the project, i.e.
		local
			project_dir: PROJECT_DIR
		do
			!! project_dir.make (project_name); 
			if project_dir.valid then
				init_project_directory := project_dir;
				if not project_dir.exists then
					project_dir.create;
					project_is_new := True
				else
					project_is_new := False
				end;
				if project_dir /= Project_directory then end;
				Create_compilation_directory;
				Create_generation_directory;
			else
				error_occurred := True;
				io.error.putstring (project_name);
				io.error.putstring (" is not a valid project name%N");
			end;
		end;

	retrieve_precompiled_project is
			-- Initialize the system with precompiled
			-- information contained in `project_dir'.
		require
			New_project: project_is_new
		local
			project_dir: PROJECT_DIR;
			workb: WORKBENCH_I;
			init_work: INIT_WORKBENCH;
			workbench_file: UNIX_FILE;
		do
			!! project_dir.make (precompiled_project_name); 
			if project_dir.valid and project_dir.exists then
				init_precompilation_directory := project_dir;
				if Precompilation_directory /= Precompilation_directory then end;
			else
				io.error.putstring (precompiled_project_name);
				io.error.putstring (" is not a valid project name%N");
				error_occurred := True;
			end;
			if not error_occurred then	
				!!workb;
				!!workbench_file.make_open_read (Precompilation_file_name);
				workb ?= workb.retrieved (workbench_file);
				
				-- Check that it is a precompiled cluster

				if (workb /= Void) and then workb.system.precompilation then
					!!init_work.make (workb);
					Workbench.init;
					if Workbench /= Void then
						Workbench.lace.set_file_name (Ace_name);
						System.server_controler.init;
						System.set_precompilation (False);
					else
						error_occurred := True;
						io.error.putstring ("Cannot retrieve precompiled project%N");
					end;
				else
					io.error.putstring (precompiled_project_name);
					io.error.putstring (" is not a precompiled system%N");
					error_occurred := True
				end;
			end;
		end;

	retrieve_project is
			-- Retrieve existing project.
		local
			project_dir: PROJECT_DIR;
			workb: WORKBENCH_I;
			init_work: INIT_WORKBENCH;
			workbench_file: UNIX_FILE;
		do
			!!workb;
			!!workbench_file.make_open_read (Project_file_name);
			workb ?= workb.retrieved (workbench_file);
			!!init_work.make (workb);
			Workbench.init;
			if Workbench /= Void then
				Workbench.lace.set_file_name (Ace_name);
				if System.uses_precompiled then
					get_precompilation_directory;
					if precompiled_project_name /= Void then
						!! project_dir.make (precompiled_project_name); 
						if project_dir.valid and project_dir.exists then
							init_precompilation_directory := project_dir;
							if Precompilation_directory /= 
									Precompilation_directory then end;
						else
							io.error.putstring (precompiled_project_name);
							io.error.putstring (" is not a valid project name%N");
							error_occurred := True;
						end;
					end;
				end;
				System.server_controler.init;
			else
				error_occurred := True;
				io.error.putstring ("Cannot retrieve project%N");
			end;
		end;

	make_new_project is
			-- Initialize project as a new one.
		require
			New_project: project_is_new
		local
			workb: WORKBENCH_I;
			init_work: INIT_WORKBENCH;
		do
			!!workb;
			!!init_work.make (workb);
			workb.make;
			Workbench.lace.set_file_name (Ace_name);
		end;

feature -- Compilation

	compile is
			-- Regular compilation
		local
			exit: BOOLEAN
		do
			from
			until
				exit
			loop
				Workbench.recompile;
				if not Workbench.successfull then
					io.error.putstring ("%NPress <return> to resume compilation%N");
					wait_for_return;
				else
					exit := True
				end
			end;
		end;

feature {NONE}

	wait_for_return is
		do
			io.readline;
--		rescue
--				-- FIXME: Should abort for CTRL C
--			retry
		end;

feature -- Precompilation

	get_precompilation_directory is
		local
			f: UNIX_FILE;
			fn: STRING;
			i, j: INTEGER;
		do
			fn := Project_name.duplicate;
			from
				i := 1
			until
				i > fn.count
			loop
				if (fn.item (i) = '/') then
					j := i
				end;
				i := i + 1
			end;
			fn.replace_substring (".precomp", j+1,fn.count);
			!!f.make (fn);
			if f.exists and then f.is_readable then
				f.open_read;
				if not f.empty then
					f.readline;
					precompiled_project_name := f.laststring.duplicate;
				end;
				f.close
			else
				suggest_precompilation_retrieval
			end;
		end;

	suggest_precompilation_retrieval is
		do
			io.putstring ("Do you wish to include precompiled information?[y/n] ") ;
			io.readline;
			if (io.laststring.item (1) = 'y') then
				io.putstring ("Name of precompiled project (full path): ");
				io.readline;
				precompiled_project_name := io.laststring.duplicate;
				io.putstring ("Importing precompiled information from: ");
				io.putstring (precompiled_project_name);
				io.new_line;
			end;
		end;

feature -- Termination

	terminate_project is
			-- Clear the servers and save the system structures
			-- to disk.
		local
			file: UNIX_FILE
		do
			System.server_controler.wipe_out;
			!!file.make (Project_file_name);
			file.open_write;
			Workbench.basic_store (file);
			file.close;
		end;

feature -- Input/Output

	name: STRING is
		deferred
		end;

	confirmed: BOOLEAN is
		do
			io.error.putstring ("Do you wish to ");
			io.error.putstring (name);
			io.error.putstring (" the system [y/n]? ");
			io.readchar;
			io.next_line;	
			Result := ((io.lastchar = 'Y') or (io.lastchar = 'y'))
		end;

	print_header is
		do
			io.error.putstring ("%
			   	%Eiffel compilation manager%N%
			  	%  (version 3.0 level 0)%N");
		end;

	print_tail is
		do
			io.error.putstring ("System recompiled.%N")
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

end
