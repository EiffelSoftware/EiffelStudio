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
				o.dprint("-=-=-=--=-=LAUNCHING WEBAPP (1) -=-=-=-=-=-=", 10)
				run_process := launch_process (app_dir + "/EIFGENs/"+ webapp.config.name.out + "/W_code/" + webapp.config.name.out,
											app_dir + "/config.ini",
											run_workdir_w,
											agent run_process_exited)
										--	Void)
				is_running := True
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

