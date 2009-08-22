note
	description: "[
		The action which compiles the webapp.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XSWA_COMPILE_WEBAPP

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
			create output_handler.make
		ensure then
			output_handler_attached: output_handler /= Void
		end


feature -- Access

	compile_process: detachable PROCESS
			-- Used to compile the webapp

	output_handler: XSOH_COMPILE
			-- Handles output from process	

	needs_cleaning: BOOLEAN assign set_needs_cleaning
			-- Can be used to force the action to execute and add -clean option to compilation

	compiler_args: STRING
			-- The arguments that are passed to compile the webapp
		require
			webapp_attached: webapp /= Void
		local
			l_f_utils: XU_FILE_UTILITIES
			l_wapp_ecf: STRING
		do

			Result := ""
			if attached webapp as l_wa then
				create l_f_utils
				l_wapp_ecf := l_wa.app_config.ecf.out
				if {PLATFORM}.is_windows then
					l_wapp_ecf.replace_substring_all ("/", "\")
				end
				Result  := " -config %"" + l_wapp_ecf + "%" -target %"" + l_wa.app_config.name.out + "%" -c_compile -stop -project_path %"" + app_dir + "%" "
				if config.file.finalize_webapps.value then
					Result := Result + " -finalize"
				end
				if needs_cleaning then
					Result.append (" -clean")
				end
				Result.append (" " + config.file.compiler_flags.value + " ")
			end

		ensure
			Result_attached: Result /= Void
		end

feature -- Status report

	is_necessary: BOOLEAN
			-- <Precursor>
			--
			-- Returns true if:
			--	- There is a .e or .ecf file somewhere in app_dir (recursively) that is newer than the melted file
			--	- The executable is missing
			--	- The webapp needs cleaning
		local
			l_f_util: XU_FILE_UTILITIES
			l_melted_file_is_old: BOOLEAN
			l_executable_does_not_exist: BOOLEAN
			l_inc: LINKED_LIST [STRING]
		do
			create l_inc.make
			l_inc.force ("*.ecf")
			l_inc.force ("*.e")
			create l_f_util
			l_melted_file_is_old := l_f_util.file_is_newer (webapp_melted_file_path,
												app_dir,
												l_inc)
			l_executable_does_not_exist := not l_f_util.is_executable_file (webapp_exe)



			Result := l_melted_file_is_old or l_executable_does_not_exist or needs_cleaning


			if Result then
				o.dprint ("Compiling webapp is necessary", o.Debug_tasks)
				if l_melted_file_is_old then
					o.dprint ("Compiling webapp is necessary because: " + webapp_melted_file_path + " is older than .e files or .ecf file or does not exist.", o.Debug_verbose_subtasks)
				end

				if l_executable_does_not_exist then
					o.dprint ("Compiling webapp is necessary because: " + webapp_exe + " does not exist or is not executable", o.Debug_verbose_subtasks)
				end

					if needs_cleaning then
					o.dprint ("Compiling webapp is necessary because: webapp compilation cleaning not yet performed", o.Debug_verbose_subtasks)
				end

			else
				o.dprint ("Compiling webapp is not necessary", o.Debug_tasks)
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
				if attached {PROCESS} compile_process as p and then p.is_running  then
					o.dprint ("Terminating compile_process_webapp  for " + l_wa.app_config.name.out  + "", o.Debug_subtasks)
					p.terminate
					p.wait_for_exit
				end
				set_running (False)
			end
		end

feature {TEST_WEBAPPS} -- Implementation

	internal_execute: XC_COMMAND_RESPONSE
			-- <Precursor>
		require else
			webapp_attached: webapp /= Void
		do
			create {XCCR_INTERNAL_SERVER_ERROR}Result
			if attached {XS_MANAGED_WEBAPP} webapp as l_wa then
				if not is_running then
					l_wa.shutdown
					if can_launch_process (config.file.compiler_filename, app_dir) then
						if attached compile_process as p then
							if p.is_running then
								o.eprint ("About to launch generate_process but it was still running... So I'm going to kill it.", generating_type)
								p.terminate
							end
						end
						o.dprint("-=-=-=--=-=LAUNCHING COMPILE WEBAPP -=-=-=-=-=-=", o.Debug_verbose_subtasks)
						compile_process := launch_process (config.file.compiler_filename,
														compiler_args,
														app_dir,
														agent compile_process_exited,
														agent output_handler.handle_output ,
														agent output_handler.handle_output)
						set_running (True)
					end
				end
				Result := (create {XER_APP_COMPILING}.make (l_wa.app_config.name.out)).render_to_command_response
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
				l_wa.is_compiling_webapp := a_running
			end
		ensure
			set: equal (is_running, a_running)
		end


feature -- Agent

	compile_process_exited
			-- Sets
		do
			set_running (False)
			set_needs_cleaning (False)
			if not is_necessary then
				execute_next_action.do_nothing
			else
				o.eprint ("COMPILATION OF WEBAPP FAILED", generating_type)
			end
		end

invariant
	output_handler_attached: output_handler /= Void
end


