note
	description: "[

	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_WEBAPP

inherit
	XU_SHARED_OUTPUTTER

create
	make_empty

feature {NONE} -- Initialization

	make_empty
			-- Initialization for `Current'.
		do
			make ("", 0, "")
		end


	make (a_name: STRING; a_port: INTEGER; a_root: STRING)
			-- Initialization for `Current'.
		require
			a_port_pos: a_port >= 0
		do
			name := a_name
			port := a_port
			root := a_root

			is_compiled := False

			is_process_exited := False
			is_compile_process_exited := False
			is_compiling := False
			is_running := False

		ensure
			name_set: name = a_name
			port_set: port = a_port
			root_set: root = a_root
		end

feature -- Access Attributes

	name: STRING assign set_name
		-- The name of the webapp

	port: INTEGER assign set_port
		-- The port of the webapp where the server can connect to

	root: STRING assign set_root
		-- The root directory of the webapp

feature -- Access Utilities

	compiler: STRING = "/usr/local/home/fabioz/Eiffel64/studio/spec/linux-x86-64/bin/ecb"
			-- The filename of the compiler used to compile webapplications

	compiler_args: STRING
			-- The arguments that are passed to the compiler
		require
			not_empty_initialized: not is_empty
		do
			Result  := "-config " + name + "-voidunsafe.ecf -target " + name + " -c_compile -clean"
		end

	run_workdir: STRING
			-- The working directory to execute the application
		require
			not_empty_initialized: not is_empty
		do
			Result := compile_workdir + "/EIFGENs/" + name + "/W_code"
		end

	compile_workdir: STRING
			-- The working directory to compile the application
		require
			not_empty_initialized: not is_empty
		do
			Result := root + "/" + name
		end


feature -- Access Compiling

	is_compiled: BOOLEAN
--	is_compiling_failed: BOOLEAN assign set_is_compiling_failed
--	is_compile_process_launched: BOOLEAN assign set_is_compile_process_launched
--	is_compile_process_failed: BOOLEAN assign set_is_compile_process_failed
	compile_process: detachable PROCESS assign set_compile_process
	is_compile_process_exited: BOOLEAN
	is_compiling: BOOLEAN

feature -- Access Process

--	is_launched: BOOLEAN assign set_is_launched
--	is_launch_failed: BOOLEAN assign set_is_launch_failed
	process: detachable PROCESS assign set_process
	is_process_exited: BOOLEAN
	is_running: BOOLEAN

feature -- Status setting

	stop
			-- Stops the process
		do
			if attached {PROCESS} process as p then
				o.dprint ("Terminating " + name  + "", 4)
				p.terminate
			end

			if attached {PROCESS} compile_process as p then
				o.dprint ("Terminating compile process of " + name  + "", 4)
				p.terminate
			end
		end

feature -- Operations

	run: BOOLEAN
			-- Returns true if the webapp is running
			-- Initiates launching the webapp if its not running
		require
			not_empty_initialized: not is_empty
		local
			l_process_factory: PROCESS_FACTORY
			l_args: LINKED_LIST [STRING]
		do
			Result := False
			create l_args.make
			l_args.force (port.out)
			if is_running and then not is_process_exited then
				Result := True
			else
					-- Launch process
				create l_process_factory
				process := l_process_factory.process_launcher (name, l_args , run_workdir )
				process.set_on_exit_handler (agent set_is_process_exited)
				o.dprint("Launching new process '" + run_workdir + "/" + name + " " + port.out + "'",1)
				process.launch
				is_running := True
			end
		end

	compile: BOOLEAN
			-- Returns true if the webapp is compiled
			-- Initiates compiling if its not compiled
		require
			not_empty_initialized: not is_empty
			can_compile: can_compile
		local
			l_process_factory: PROCESS_FACTORY
			l_cmd: STRING
		do
			Result := False
			if is_compile_process_exited then
				Result := True
			else
				if not is_compiling then
						-- Launch compiling
					l_cmd :=  compiler + " " + compiler_args
					create l_process_factory
					compile_process := l_process_factory.process_launcher_with_command_line (compiler + " " + compiler_args, compile_workdir)
					compile_process.set_on_exit_handler (agent set_is_compile_process_exited)
					o.dprint("Launching new process '" + compiler + " " + compiler_args + "'",3)
					compile_process.launch
					is_compiling := True
				end
			end
		end

feature -- Stauts

	is_empty: BOOLEAN
			-- Is any important attributes not set?
		do
			Result := (name.is_empty or (port = 0) or root.is_empty)
		end

	file_exists (a_filename: STRING): BOOLEAN
			-- Checks if a file exists
		local
			l_file: RAW_FILE
		do
			Result := False
			create l_file.make (a_filename)
		Result :=		l_file.exists
--			if l_file.is_open_read then
--				Result := True
--				l_file.close
--			end
			if not Result then
				o.eprint ("File '" + a_filename  + "' does not exist!", generating_type)
			end
		end

	can_compile: BOOLEAN
			-- Checks if there is a valid compiler available
		do
			Result := file_exists (compiler)
		end

	can_run: BOOLEAN
			-- Checks if the webapp executable has been generated
		do
			Result := file_exists (run_workdir + "/" + name)
		end

feature -- Used as agents

	set_is_compile_process_exited
			-- Sets
		do
			is_compile_process_exited := True
		end

	set_is_process_exited
			-- Sets
		do
			is_process_exited := True
		end

--	compile_process_out (a_out: STRING)
--			-- Redirects output from compile_process
--		do
--			o.iprint (a_out)
--		end

--	set_launch_failed
--			-- Setter
--		do		o.eprint ("Failed to launch process for '" + name + "'", generating_type)
--				is_launch_failed := True
--				is_launched := False
--		end

--	set_launched
--			-- Setter
--		do
--				o.dprint ("Successfully launched '" + name + "'",2)
--				is_launched := True
--				is_launch_failed := False

--		end

--	set_compile_process_failed
--			-- Setter
--		do
--				o.eprint ("Failed to launch compile process for '" + name + "'", generating_type)
--				is_compile_process_failed := True
--				is_compile_process_launched := False
--		end


--	set_compile_launched
--			-- Setter
--		do
--				o.dprint ("Successfully launched compile process for '" + name + "'",1)
--				is_compile_process_failed := False
--				is_compile_process_launched := True
--		end

feature -- Status setting Compiling

--	set_is_compiled (a_is_compiled: BOOLEAN)
--			-- Setter
--		do
--			is_compiled := a_is_compiled
--		ensure
--			is_compiled_set: is_compiled = a_is_compiled
--		end

--	set_is_compiling_failed (a_is_compiling_failed: BOOLEAN)
--			-- Setter
--		do
--			is_compiling_failed := a_is_compiling_failed
--		ensure
--			compiling_failed_set:  is_compiling_failed = a_is_compiling_failed
--		end

--	set_is_compile_process_launched (a_is_compile_process_launched: BOOLEAN)
--			-- Setter
--		require
--			compile_process_attached: compile_process /= Void
--		do
--			is_compile_process_launched := a_is_compile_process_launched
--		ensure
--			compile_process_launched_set:  is_compile_process_launched = a_is_compile_process_launched
--		end

--	set_is_compile_process_failed (a_is_compile_process_failed: BOOLEAN)
--			-- Setter
--		do
--			is_compile_process_failed := a_is_compile_process_failed
--		ensure
--			compile_process_failed_set: is_compile_process_failed = a_is_compile_process_failed
--		end


	set_compile_process (a_compile_process: detachable PROCESS)
			-- Setter
		do
			compile_process := a_compile_process
		ensure
			compile_process_set: process = a_compile_process
		end


feature -- Status Setting Process

--	set_is_launched (a_is_launched: BOOLEAN)
--			-- Setter
--		require
--			process_attached: process /= Void
--		do
--			is_launched := a_is_launched
--		ensure
--			is_launched_set: is_launched = a_is_launched
--		end

--	set_is_launch_failed (a_is_launch_failed: BOOLEAN)
--			-- Sets launched_failed to True
--		require
--			process_attached: process /= Void
--		do
--			is_launch_failed  := a_is_launch_failed
--		ensure
--			launch_failed_set: is_launch_failed  = a_is_launch_failed
--		end

	set_process (a_process: detachable PROCESS)
			-- Setter
		do
			process := a_process
		ensure
			process_set: process = a_process
		end


feature -- Access Attributes

	set_name (a_name: STRING)
			-- Setter
		require
			name_not_empty: not a_name.is_empty
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

	set_root (a_root: STRING)
			-- Setter
		require
			root_not_empty: not a_root.is_empty
		do
			root := a_root
		ensure
			root_set: root = a_root
		end

	set_port (a_port: INTEGER)
			-- Setter
		require
			a_port_pos: a_port >= 0
		do
			port := a_port
		ensure
			port_set: port = a_port
		end
end
