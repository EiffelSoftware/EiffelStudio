note
	description: "[
		The action which runs the webapp.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
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

	run_args: STRING
			-- The arguments for running the webapp
		local
			l_f: FILE_NAME
		do
			l_f := app_dir.twin
			l_f.set_file_name ({XU_CONSTANTS}.Webapp_config_file)
			Result := "%"" + l_f.string + "%" -d " + config.args.debug_level.out + ""
						--webapp_debug_level.out
		ensure
			Result_attached: Result /= Void
		end


feature -- Status report

	is_necessary: BOOLEAN
			-- <Precursor>
			-- Necessary if:
			--	- The action is not running
		do
			Result := not is_running

			if Result then
				o.dprint ("Run is necessary.", o.Debug_tasks)
			else
				o.dprint ("Run is not necessary", o.Debug_tasks)
			end
		end

	wait_for_exit
			-- Waits until process is terminated
		do
			if attached {PROCESS} run_process as p  and then p.is_running then
				o.dprint ("Waiting for run_process to exit...", o.Debug_tasks)
				p.wait_for_exit
				set_running (False)
			end
		end

feature -- Status setting

	stop
			-- <Precursor>
		require else
			webapp_attached: webapp /= Void
		do
			if attached webapp as l_wa then
				if attached {PROCESS} run_process as p  and then p.is_running then
					o.dprint ("Terminating run_process for " + l_wa.app_config.name.out  + "", o.Debug_tasks)
					p.terminate
					p.wait_for_exit
				end
				set_running (False)
			end
		end


feature {NONE} -- Implementation

	internal_execute: XC_COMMAND_RESPONSE
			-- <Precursor>
		require else
			webapp_attached: webapp /= Void
		do
			if attached webapp as l_wa then
				if  not is_running then
					if can_launch_process (webapp_exe, run_workdir) then
						o.dprint("-=-=-=--=-=LAUNCHING WEBAPP  -=-=-=-=-=-=", o.Debug_verbose_subtasks)
						run_process := launch_process (webapp_exe,
													run_args,
													run_workdir,
													agent run_process_exited,
													agent run_output_handler,
													agent run_output_handler)
						set_running (True)
					end
				end
				Result := (create {XER_APP_STARTING}.make (l_wa.app_config.name.out)).render_to_command_response
			else
				create {XCCR_INTERNAL_SERVER_ERROR}Result
			end
		end

feature {NONE} -- Internal Status Setting

	set_running (a_running: BOOLEAN)
			-- Sets is_running
		require
			webapp_attached: webapp /= Void
		do
			if attached webapp as l_wa then
				is_running := a_running
				l_wa.is_running := a_running
			end
		ensure
			set: equal (is_running, a_running)
		end

feature -- Agents


	run_process_exited
			-- Sets is_running := False
		require
			webapp_attached: webapp /= Void
		do
			if attached webapp as l_wa then
				set_running (False)
				o.dprint ("Run process for " + l_wa.app_config.name.out + " has exited.", o.Debug_subtasks)
			end
		end

	run_output_handler (a_ouput: STRING)
			 -- Forwards output to console
		do
			print (a_ouput)
		end
end

