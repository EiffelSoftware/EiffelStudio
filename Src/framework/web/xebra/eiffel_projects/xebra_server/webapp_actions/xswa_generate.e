note
	description: "[
		The action that executes the servlet_gen.
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

	make
			-- Initialization for `Current'.	
		do
			Precursor
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
			Result :=  "-o ."
		ensure
			Result_attached: Result /= void
		end

	needs_cleaning: BOOLEAN assign set_needs_cleaning
			-- Can be used to force the action to execute and add -clean option to compilation	

feature -- Status report

	is_necessary: BOOLEAN
			-- <Precursor>
			--
			-- Returns true if:
			--  - There is a xeb file that is newer than servlet_gen_executed_file in app_dir
			--  - Needs cleaning
		local
			l_servlet_gen_not_executed: BOOLEAN
			l_f_utils: XU_FILE_UTILITIES
			l_inc: LINKED_LIST [STRING]
		do
			create l_inc.make
			l_inc.force ("*.xeb")
			create l_f_utils
			l_servlet_gen_not_executed := l_f_utils.file_is_newer (servlet_gen_executed_file,
									app_dir,
									l_inc)

			Result :=  	needs_cleaning or l_servlet_gen_not_executed

			if Result then

				if l_servlet_gen_not_executed then
					o.dprint ("Generating is necessary because: Servlet_gen_executed file is older than xeb files in app_dir or does not exist.", 5)
				end

				if needs_cleaning then
					o.dprint ("Generating is necessary because: generate cleaning not yet performed.", 5)
				end
			else
				o.dprint ("Generating is not necessary", 3)
			end
		end

feature -- Status setting

	set_needs_cleaning (a_needs_cleaning: like needs_cleaning)
			-- Setts needs_cleaning
		do
			needs_cleaning := a_needs_cleaning
		ensure
			needs_cleaning_set: equal (needs_cleaning, a_needs_cleaning)
		end

	stop
			-- <Precursor>
		require else
			webapp_attached: webapp /= Void
		do
			if attached webapp as l_wa then
				if attached {PROCESS} generate_process as p and then p.is_running  then
					o.dprint ("Terminating generate_process for " + l_wa.app_config.name.out  + "", 2)
					p.terminate
					p.wait_for_exit
				end
				set_running (False)
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
				l_wa.is_generating := a_running
			end
		ensure
			set: equal (is_running, a_running)
		end

feature {TEST_WEBAPPS} -- Implementation

	internal_execute: XC_COMMAND_RESPONSE
			-- <Precursor>
		require else
			webapp_attached: webapp /= Void
		do
			create {XCCR_INTERNAL_SERVER_ERROR}Result
			if attached webapp as l_wa then
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
				Result := (create {XER_APP_COMPILING}.make (l_wa.app_config.name.out)).render_to_command_response
			end
		end

feature -- Agents

	generate_process_exited
			-- Sets is_running := False and executes next action
		do
			set_running (False)
			set_needs_cleaning (False)
			if not is_necessary then
				execute_next_action.do_nothing
			else
				o.eprint ("GENERATION FAILED", generating_type)
			end
		end
invariant
		output_handler_gen_attached: output_handler_gen /= Void
end

