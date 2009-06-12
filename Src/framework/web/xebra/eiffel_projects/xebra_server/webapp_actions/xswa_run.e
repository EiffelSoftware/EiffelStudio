note
	description: "[
		The action which runs the webapp
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XSWA_RUN

inherit
	XS_WEBAPP_ACTION

create
	make

feature -- Access

	run_process: detachable PROCESS
		-- Used to run the webapp

	webapp_debug_level: INTEGER = 10
			-- Sets the debug level when launching the webapp

	run_args: STRING
			-- The arguments for running the webapp
		local
			l_f: FILE_NAME
		do
			l_f := app_dir.twin
			l_f.set_file_name ("config.ini")
			Result := l_f.string + " -d " + config.args.debug_level.out
						--webapp_debug_level.out
		ensure
			Result_attached: Result /= Void
		end


feature -- Status report

	is_necessary: BOOLEAN
			-- <Precursor>
		do
			Result := not is_running
		end

	wait_for_exit
			-- Waits until process is terminated
		do
			if attached {PROCESS} run_process as p  and then p.is_running then
				o.dprint ("Waiting for run_process to exit...", 3)
				p.wait_for_exit
			end
		end

feature -- Status setting

	stop
			-- <Precursor>
		do
			if attached {PROCESS} run_process as p  and then p.is_running then
				o.dprint ("Terminating run_process for " + webapp.app_config.name.out  + "", 2)
				p.terminate
				p.wait_for_exit
			end
			is_running := False
		end


feature {NONE} -- Implementation

	internal_execute: XS_COMMANDS
			-- <Precursor>
		do
			if  not is_running then
				if can_launch_process (webapp_exe, run_workdir) then
					o.dprint("-=-=-=--=-=LAUNCHING WEBAPP (1) -=-=-=-=-=-=", 10)
					run_process := launch_process (webapp_exe,
												run_args,
												run_workdir,
												agent run_process_exited,
												agent run_output_handler,
												agent run_output_handler)
					is_running := True
				end
			end
			Result := create {XS_COMMANDS}.make_with_response((create {XER_APP_STARTING}.make (webapp.app_config.name.out)).render_to_response)
		end

feature -- Agents


	run_process_exited
			-- Sets is_running := False
		do
--			config_outputter
			is_running := False
			o.dprint ("Run process for " + webapp.app_config.name.out + " has exited.", 3)
		end

	run_output_handler (a_ouput: STRING)
			 -- Forwards output to console
		do
			print (a_ouput)
		end
end

