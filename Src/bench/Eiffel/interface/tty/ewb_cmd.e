-- General notion of command line command 
-- corresponding to an option of `ewb'

deferred class EWB_CMD 

inherit

	SHARED_WORKBENCH;
	PROJECT_CONTEXT
		redefine
			init_project_directory
		end;
	SHARED_DIALOG;
	BUILD_LIC;
	WINDOWS

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

	init_project is
			-- Initialize the project, i.e.
		local
			project_dir: PROJECT_DIR
		do
			!! project_dir.make (project_name); 
			project_dir.check_directory (error_popup_window);
			if project_dir.is_valid then
				init_project_directory := project_dir;
				project_is_new := project_dir.is_new;
				if project_dir /= Project_directory then end;
				Create_compilation_directory;
				Create_generation_directory;
			else
				error_occurred := True;
			end;
		end;
				

	retrieve_project is
			-- Retrieve existing project.
		local
			project_dir: PROJECT_DIR;
			workb: WORKBENCH_I;
			init_work: INIT_WORKBENCH;
			workbench_file: UNIX_FILE;
			precomp_r: PRECOMP_R;
		do
			!!workb;
			!!workbench_file.make_open_read (Project_file_name);
			workb ?= workb.retrieved (workbench_file);
			!!init_work.make (workb);
			Workbench.init;
			if Workbench /= Void then
				Workbench.lace.set_file_name (Ace_name);
				if System.uses_precompiled then
					!!precomp_r;
					precomp_r.set_precomp_dir;
				end;
				System.server_controler.init;
				Universe.update_cluster_paths	
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
			exit: BOOLEAN;
			str: STRING
		do
			from
			until
				exit
			loop
				Workbench.recompile;
				if not Workbench.successfull then
					io.error.putstring ("%N%
						%Press <Return> to resume compilation or <Q> to quit%N");
					wait_for_return;
					str := io.laststring.duplicate;
					str.to_lower;
					if 
						((str.count >= 1) and then (str.item (1) = 'q')) 
					then
						if licence.registered then
							licence.unregister
						end;
						die(0)
					end;
				else
					exit := True
				end
			end;
		end;

feature {NONE}

	wait_for_return is
		do
			io.readline;
		rescue
				-- FIXME: Should abort for CTRL C
			retry
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
		rescue
			if not file.is_closed then
				file.close;
			end;
			Dialog_window.display ("Error in reading/writing .workbench file");
			retry
		end;

feature -- Input/Output

	name: STRING is
		deferred
		end;

	confirmed: BOOLEAN is
			--|Note: Currently no command necessitates confirmation
		do
--			io.error.putstring ("Do you wish to ");
--			io.error.putstring (name);
--			io.error.putstring (" the system [y/n]? ");
--			io.readchar;
--			io.next_line;	
--			Result := ((io.lastchar = 'Y') or (io.lastchar = 'y'))
			Result := True
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
