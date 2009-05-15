note
	description: "[
		no comment yet
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

	webapp_exe: FILE_NAME
			-- The executable of the webapp
		do
			Result := app_dir.twin
			Result.extend ("EIFGENs")
			Result.extend (webapp.config.name.out)
			Result.extend ("W_code")


			if {PLATFORM}.is_windows then
				Result.set_file_name (webapp.config.name.out + ".exe")
			else
				Result.set_file_name (webapp.config.name.out)
			end
		ensure
			Result_attached: Result /= Void
		end

	run_args: STRING
			-- The arguments for running the webapp
		local
			l_f: FILE_NAME
		do
			l_f := app_dir.twin
			l_f.set_file_name ("config.ini")
			Result := l_f.string
		ensure
			Result_attached: Result /= Void
		end


feature -- Status report

	is_necessary: BOOLEAN
			-- <Precursor>
		do
			Result := not is_running
		end

feature -- Status setting

	stop
			-- <Precursor>
		do
			if attached {PROCESS} run_process as p then
				o.dprint ("Terminating run_process for " + webapp.config.name.out  + "", 2)
				p.terminate
			end
			is_running := False
		end

feature {NONE} -- Implementation

	internal_execute: XH_RESPONSE
			-- <Precursor>
		do
			if  not is_running then
				if can_launch_process (webapp_exe, run_workdir) then
					o.dprint("-=-=-=--=-=LAUNCHING WEBAPP (1) -=-=-=-=-=-=", 10)
					run_process := launch_process (webapp_exe,
												run_args,
												run_workdir,
												agent run_process_exited)
											--	Void)
					is_running := True
				end
			end
			Result := (create {XER_APP_STARTING}.make (webapp.config.name.out)).render_to_response
		end

feature -- Agents

	run_process_exited
			-- Sets is_running := False
		do
			is_running := False
		end

	run_output_handler (a_ouput: STRING)
			 -- Forwards output to console
		do
			print (a_ouput)
		end
end

