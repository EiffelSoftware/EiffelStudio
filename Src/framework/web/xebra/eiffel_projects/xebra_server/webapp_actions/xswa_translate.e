note
	description: "[
		The translate action which includes running the translator, 
		compiling the servlet_gen and running the servlet_Gen
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XSWA_TRANSLATE

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
			create output_handler_translate.make
			force := False
		ensure then
			output_handler_translate_attached: output_handler_translate /= Void
		end

feature -- Access

	force: BOOLEAN assign set_force
		-- If true, translation is alsways neccesary

	output_handler_translate: XSOH_TRANSLATE
		-- Output handler for translate process

	translate_process: detachable PROCESS
			-- Used to translate the xeb files

	translator_args: STRING
			-- The arguments that are passed to the translator
		do
			Result := " -n " + webapp.app_config.name.out
			Result.append ( " -i . ")
			Result.append (" -o . ")
			Result.append (" -t " + config.file.taglib.out)
			Result.append (" -d " + config.args.debug_level.out)
			if force or webapp.needs_cleaning then
				Result.append (" -f")
			end
		ensure
			Result_attached: Result /= void
		end


feature -- Status report

	is_necessary: BOOLEAN
			-- <Precursor>
			-- Check if the webapps has to be (re)translated
			-- (which includes, executing translator, compiling servlet_gen and executing servlet_gen)
			-- Returns True iff:
			--		- There is a *.xeb file in app_dir (recursively) which is newer than app_dir/.generated/g_name_application.e
			--		- The servlet_gen exe does not exist
			--		- The servlet_gen ecf does not exist
			--		- The webapp has set to need cleaning
			--		- If execute_file from servlet_gen is older than ... (not yet implemented)
			--		- If forced			
			--		- servlet_gen has not been executed (recently enough)
		local
			l_application_file: FILE_NAME
			l_f_utils: XU_FILE_UTILITIES
			l_g_application_is_old: BOOLEAN
			l_servlet_gen_exe_not_exist: BOOLEAN
			l_servet_gen_ecf_not_exist: BOOLEAN
			l_servlet_gen_not_executed: BOOLEAN
		do
			create l_f_utils
			l_application_file := app_dir.twin
			l_application_file.extend ({XU_CONSTANTS}.Generated_folder_name)
			l_application_file.set_file_name ("g_" + webapp.app_config.name.out + "_application.e")

			l_g_application_is_old := l_f_utils.file_is_newer (l_application_file,
									app_dir,
									"\w+\.xeb")

			l_servet_gen_ecf_not_exist := not  l_f_utils.is_readable_file (servlet_gen_ecf)


			Result := l_g_application_is_old or
						l_servlet_gen_exe_not_exist or
						l_servet_gen_ecf_not_exist or
					 	webapp.needs_cleaning or
					 	force or
					 	l_servlet_gen_not_executed

			if Result then
				o.dprint ("Translating is necessary", 3)
				if l_g_application_is_old then
					o.dprint ("Translating is necessary because: g_" + webapp.app_config.name.out + "_application.e is old", 5)
				end

				if l_servet_gen_ecf_not_exist then
					o.dprint ("Translating is necessary because: servlet_gen ecf does not exist.", 5)
				end

				if webapp.needs_cleaning then
					o.dprint ("Translating is necessary because: webapp needs cleaning.", 5)
				end

				if force then
					o.dprint ("Translating is necessary because: force.", 5)
				end

			else
				o.dprint ("Translating is not necessary", 3)
			end
		end

feature -- Status setting

	stop
			-- <Precursor>
		do
			if attached {PROCESS} translate_process as p and then p.is_running  then
				o.dprint ("Terminating translate_process for " + webapp.app_config.name.out  + "", 2)
				p.terminate
				p.wait_for_exit
			end
			set_running (False)
		end

	set_force (a_force: BOOLEAN)
			-- Sets is_force
		do
			force := a_force
		ensure
			set: equal (force, a_force)
		end

feature {NONE} -- Internal Status Setting

	set_running (a_running: BOOLEAN)
			-- Sets is_running
		do
			is_running := a_running
			webapp.is_translating := a_running
		ensure
			set: equal (is_running, a_running)
			set: equal (is_running, webapp.is_translating)
		end

feature {TEST_WEBAPPS} -- Implementation

	internal_execute: XC_COMMAND_RESPONSE
			-- <Precursor>
		do
			if not is_running then
				webapp.shutdown
				if can_launch_process (config.file.translator_filename, app_dir) then

					if attached translate_process as p then
						if p.is_running then
							o.eprint ("About to launch translate process but it was still running... So I'm going to kill it.", generating_type)
							p.terminate
						end
					end

					o.dprint("-=-=-=--=-=LAUNCHING TRANSLATE -=-=-=-=-=-=", 6)
					translate_process := launch_process (config.file.translator_filename,
															translator_args,
															app_dir,
															agent translate_process_exited,
															agent output_handler_translate.handle_output,
															agent output_handler_translate.handle_output)
					set_running (True)
						-- Set force back to false (for next time)
					force := False
				end
			end
			Result := (create {XER_APP_COMPILING}.make (webapp.app_config.name.out)).render_to_command_response
		end

feature -- Agents

	translate_process_exited
			-- Launch compiling of servlet_gen in gen_compile_process
		do
			set_running (False)
			if translate_process.exit_code = 0  then
				execute_next_action.do_nothing
			else
				o.eprint ("TRANSLATION FAILED", generating_type)
			end
		end

invariant
	output_handler_translate_attached: output_handler_translate /= Void
end

