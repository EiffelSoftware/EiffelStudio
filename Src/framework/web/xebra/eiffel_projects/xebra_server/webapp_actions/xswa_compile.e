note
	description: "[
		The action which compiles the webapp
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XSWA_COMPILE

inherit
	XS_WEBAPP_ACTION
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make (a_webapp: XS_WEBAPP)
			-- Initialization for `Current'.	
		do
			Precursor (a_webapp)
			create output_handler.make
		ensure then
			output_handler_attached: output_handler /= Void
		end


feature -- Access

	compile_process: detachable PROCESS
			-- Used to compile the webapp

	output_handler: XSOH_COMPILE
			-- Handles output from process	

	compiler_args: STRING
			-- The arguments that are passed to compile the webapp
		local
			l_f_utils: XU_FILE_UTILITIES
		do
			create l_f_utils.make
			Result  := " -config " + webapp.app_config.name.out + ".ecf -target " + webapp.app_config.name.out + " -c_compile -stop"
--			if config.finalize_webapps then
--				Result := Result + " -finalize"
--			end
			if webapp.needs_cleaning then
				Result.append (" -clean")
			end
			if not l_f_utils.is_readable_file (webapp_exe) then
				Result.append (" -clean")
			end
		ensure
			Result_attached: Result /= Void
		end

feature -- Status report

	is_necessary: BOOLEAN
			-- <Precursor>
		local
			l_f_util: XU_FILE_UTILITIES

		do
			create l_f_util.make
			Result := l_f_util.file_is_newer (melted_file_path,
											app_dir,
											"\w+\.(e|ecf)")
					or not l_f_util.is_executable_file (webapp_exe)
					or webapp.needs_cleaning
			if Result then
				o.dprint ("Compiling is necessary", 5)
			else
				o.dprint ("Compiling is not necessary", 5)
			end
		end


feature -- Status setting

	stop
			-- <Precursor>
		do
			if attached {PROCESS} compile_process as p and then p.is_running  then
				o.dprint ("Terminating compile_process for " + webapp.app_config.name.out  + "", 2)
				p.terminate
				p.wait_for_exit
			end
			set_running (False)
		end

feature {NONE} -- Implementation

	internal_execute: XH_RESPONSE
			-- <Precursor>
		do
			if not is_running then
				webapp.shutdown
				if can_launch_process (config.file.compiler_filename, app_dir) then
					if attached compile_process as p then
						if p.is_running then
							o.eprint ("About to launch generate_process but it was still running... So I'm going to kill it.", generating_type)
							p.terminate
						end
					end
					o.dprint("-=-=-=--=-=LAUNCHING COMPILE WEBAPP (2) -=-=-=-=-=-=", 10)
					compile_process := launch_process (config.file.compiler_filename,
													compiler_args,
													app_dir,
													agent compile_process_exited,
													agent output_handler.handle_output,
													agent output_handler.handle_output)
					set_running (True)
				end
			end
			Result := (create {XER_APP_COMPILING}.make (webapp.app_config.name.out)).render_to_response
		end

feature {NONE} -- Internal Status Setting

	set_running (a_running: BOOLEAN)
			-- Sets is_running
		do
			is_running := a_running
			webapp.is_compiling := a_running
		ensure
			set: equal (is_running, a_running)
			set: equal (is_running, webapp.is_compiling)
		end


feature -- Agent

	compile_process_exited
			-- Sets
		do
			set_running (False)
			if output_handler.has_successfully_terminated then
				webapp.needs_cleaning := False
				next_action.execute.do_nothing
			else
				o.eprint ("COMPILATION OF WEBAPP FAILED", generating_type)
			end
		end

	compiler_output_handler (a_ouput: STRING)
			-- Forwards output to console
		do
			--o.set_name ("COMPILER")
			o.dprintn (a_ouput, 3)
			--o.set_name ({XS_MAIN_SERVER}.name)
		end

invariant
	output_handler_attached: output_handler /= Void
end


