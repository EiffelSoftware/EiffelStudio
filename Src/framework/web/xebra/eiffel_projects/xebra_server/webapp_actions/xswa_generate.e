note
	description: "[
		No comment yet.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XSWA_GENERATE

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
			create output_handler_gen.make
		ensure then
			output_handler_gen_attached: output_handler_gen /= Void
		end

feature -- Access

	output_handler_gen: XSOH_GEN
		-- Output handler for compilation of servletget process

	generate_process: detachable PROCESS
			-- Used to run the servlet_gen

	generate_args: STRING
			-- The arguments that are passed to the servlet_gen
		do
			Result :=  "."
		ensure
			Result_attached: Result /= void
		end


feature -- Status report

	is_necessary: BOOLEAN
			-- <Precursor>
			-- Check if the webapps has to be (re)generated		
			-- Returns True iff:
			--		- There is a xeb file that is newer than servlet_gen_executed_file in app_dir
		local
			l_servlet_gen_not_executed: BOOLEAN
			l_f_utils: XU_FILE_UTILITIES
		do
			create l_f_utils
			l_servlet_gen_not_executed := l_f_utils.file_is_newer (servlet_gen_executed_file,
									app_dir,
									"\w+\.xeb")

			Result :=  	webapp.needs_cleaning or l_servlet_gen_not_executed

			if Result then

				if l_servlet_gen_not_executed then
					o.dprint ("Generating is necessary because: Servlet_gen has not been executed (recently enough).", 5)
				end

				if webapp.needs_cleaning then
					o.dprint ("Generating is necessary because: webapp needs cleaning.", 5)
				end
			else
				o.dprint ("Generating is not necessary", 3)
			end
		end

feature -- Status setting

	stop
			-- <Precursor>
		do
			if attached {PROCESS} generate_process as p and then p.is_running  then
				o.dprint ("Terminating generate_process for " + webapp.app_config.name.out  + "", 2)
				p.terminate
				p.wait_for_exit
			end
			set_running (False)
		end

feature {NONE} -- Internal Status Setting

	set_running (a_running: BOOLEAN)
			-- Sets is_running
		do
			is_running := a_running
			webapp.is_generating := a_running
		ensure
			set: equal (is_running, a_running)
			set: equal (is_running, webapp.is_generating)
		end

feature {TEST_WEBAPPS} -- Implementation

	internal_execute: XC_COMMAND_RESPONSE
			-- <Precursor>
		do
			if not is_running then
				if can_launch_process (servlet_gen_exe, app_dir) then
					if attached generate_process as p then
						if p.is_running then
							o.eprint ("About to launch generate_process but it was still running... So I'm going to kill it.", generating_type)
							p.terminate
						end
					end
					set_running (True)
					o.dprint("-=-=-=--=-=LAUNCHING SERVLET GENERATOR  -=-=-=-=-=-=", 6)
					generate_process := launch_process (servlet_gen_exe,
														generate_args,
														app_dir,
														agent generate_process_exited,
														agent output_handler_gen.handle_output,
														agent output_handler_gen.handle_output)
				end
			end
			Result := (create {XER_APP_COMPILING}.make (webapp.app_config.name.out)).render_to_command_response
		end

feature -- Agents

	generate_process_exited
			-- Sets is_running := False and executes next action
		do
			set_running (False)
			if not is_necessary then
				execute_next_action.do_nothing
			else
				o.eprint ("GENERATION FAILED", generating_type)
			end
		end
invariant
		output_handler_gen_attached: output_handler_gen /= Void
end

