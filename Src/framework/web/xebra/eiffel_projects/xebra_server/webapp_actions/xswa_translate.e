note
	description: "[
		The translate action which includes running the translator, 
		compiling the servlet_gen and running the servlet_Gen
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
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
			create output_handler_compile.make
			create output_handler_translate.make
			create output_handler_gen.make
		ensure then
			output_handler_compile_attached: output_handler_compile /= Void
			output_handler_translate_attached: output_handler_translate /= Void
			output_handler_gen_attached: output_handler_gen /= Void
		end

feature -- Access

	output_handler_compile: XSOH_COMPILE
			-- Output handler for compilation process

	output_handler_translate: XSOH_TRANSLATE
		-- Output handler for translate process

	output_handler_gen: XSOH_GEN
		-- Output handler for compilation of servletget process

	translate_process: detachable PROCESS
			-- Used to translate the xeb files

	generate_process: detachable PROCESS
			-- Used to run the servlet_gen

	gen_compile_process: detachable PROCESS
			-- Used to compile the servlet_gen			

	translator_args: STRING
			-- The arguments that are passed to the translator
		do
			Result := " -n " + webapp.app_config.name.out + " -i . -o .  -t " + config.file.taglib.out + " -d " + config.args.debug_level.out
		ensure
			Result_attached: Result /= void
		end

	generate_args: STRING
			-- The arguments that are passed to the servlet_gen
		do
			Result :=  "."
		ensure
			Result_attached: Result /= void
		end

	gen_compiler_args: STRING
			-- The arguments that are passed to compile the servlet_gen	
		local
			l_f_utils: XU_FILE_UTILITIES
		do
			create l_f_utils.make
			Result  := " -config " + servlet_gen_ecf.string + " -target servlet_gen -c_compile -stop"
			if webapp.needs_cleaning then
				Result.append (" -clean")
			end
			if not l_f_utils.is_readable_file (servlet_gen_exe) then
				Result.append (" -clean")
			end
		ensure
			Result_attached: Result /= void
		end

	servlet_gen_path: FILE_NAME
			-- The path to the servlet_gen
		do
			Result := app_dir.twin
			Result.extend (".generated")
			Result.extend ("servlet_gen")
		ensure
			Result_attached: Result /= void
		end

	servlet_gen_exe: FILE_NAME
			-- The path to the servlet_gen executable
		do
			Result := servlet_gen_path.twin
			Result.extend ("EIFGENs")
			Result.extend ("servlet_gen")
			Result.extend ("W_code")
			if {PLATFORM}.is_windows then
				Result.set_file_name ("servlet_gen.exe")
			else
					Result.set_file_name ("servlet_gen")
			end

		ensure
			Result_attached: Result /= void
		end

	servlet_gen_ecf: FILE_NAME
			-- The path to the servlet_gen executable
		do
			Result := servlet_gen_path.twin
			Result.set_file_name ("servlet_gen.ecf")
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
		local
			l_application_file: FILE_NAME
			l_f_utils: XU_FILE_UTILITIES
			l_g_application_is_old: BOOLEAN
			l_servlet_gen_exe_not_exist: BOOLEAN
			l_servet_gen_ecf_not_exist: BOOLEAN
		do
			create l_f_utils.make
			l_application_file := app_dir.twin
			l_application_file.extend (".generated")
			l_application_file.set_file_name ("g_" + webapp.app_config.name.out + "_application.e")

			l_g_application_is_old := l_f_utils.file_is_newer (l_application_file,
									app_dir,
									"\w+\.xeb")

			l_servlet_gen_exe_not_exist := not l_f_utils.is_readable_file (servlet_gen_exe)

			l_servet_gen_ecf_not_exist := not  l_f_utils.is_readable_file (servlet_gen_ecf)

			Result := l_g_application_is_old or
						l_servlet_gen_exe_not_exist or
						l_servet_gen_ecf_not_exist or
					 	webapp.needs_cleaning


			if Result then
				o.dprint ("Translating is necessary", 3)
				if l_g_application_is_old then
					o.dprint ("Translating is necessary because: g_" + webapp.app_config.name.out + "_application.e is old", 5)
				end

				if l_servlet_gen_exe_not_exist then
					o.dprint ("Translating is necessary because: servlet_gen exe does not exist.", 5)
				end

				if l_servet_gen_ecf_not_exist then
					o.dprint ("Translating is necessary because: servlet_gen ecf does not exist.", 5)
				end

				if webapp.needs_cleaning then
					o.dprint ("Translating is necessary because: webapp needs cleaning.", 5)
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
			if attached {PROCESS} generate_process as p and then p.is_running  then
				o.dprint ("Terminating generate_process for " + webapp.app_config.name.out  + "", 2)
				p.terminate
				p.wait_for_exit
			end
			if attached {PROCESS} gen_compile_process as p and then p.is_running  then
				o.dprint ("Terminating gen_compile_process for " + webapp.app_config.name.out  + "", 2)
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
			webapp.is_translating := a_running
		ensure
			set: equal (is_running, a_running)
			set: equal (is_running, webapp.is_translating)
		end

feature {NONE} -- Implementation

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

					o.dprint("-=-=-=--=-=LAUNCHING TRANSLATE (5)-=-=-=-=-=-=", 10)
					translate_process := launch_process (config.file.translator_filename,
															translator_args,
															app_dir,
															agent translate_process_exited,
															agent output_handler_translate.handle_output,
															agent output_handler_translate.handle_output)
					set_running (True)
				end
			end
			Result := (create {XER_APP_COMPILING}.make (webapp.app_config.name.out)).render_to_command_response
		end

	compile_servlet_gen
			-- Launches the process to compile the servlet_gen
		local
			l_f_utils: XU_FILE_UTILITIES
		do
			create l_f_utils.make
			if can_launch_process (config.file.compiler_filename, app_dir) and then l_f_utils.is_readable_file (servlet_gen_ecf) then
				if attached gen_compile_process as p  then
					if p.is_running then
						o.eprint ("About to launch gen_compile_process but it was still running... So I'm going to kill it.", generating_type)
						p.terminate
					end
				end
				o.dprint("-=-=-=--=-=LAUNCHING COMPILE SERVLET GEN (4)-=-=-=-=-=-=", 10)
				gen_compile_process := launch_process (config.file.compiler_filename,
														gen_compiler_args,
														app_dir,
														agent gen_compile_process_exited,
														agent output_handler_compile.handle_output,
														agent output_handler_compile.handle_output)
			end
		end

	generate
			-- Launches the process to execute servlet_gen
		do
			if can_launch_process (servlet_gen_exe, app_dir) then
				if attached generate_process as p then
					if p.is_running then
						o.eprint ("About to launch generate_process but it was still running... So I'm going to kill it.", generating_type)
						p.terminate
					end
				end
				o.dprint("-=-=-=--=-=LAUNCHING SERVLET GENERATOR (3) -=-=-=-=-=-=", 10)
				generate_process := launch_process (servlet_gen_exe,
													generate_args,
													app_dir,
													agent generate_process_exited,
													agent output_handler_gen.handle_output,
													agent output_handler_gen.handle_output)
			end
		end

feature -- Agents

	translate_process_exited
			-- Launch compiling of servlet_gen in gen_compile_process
		do
			if output_handler_translate.has_successfully_terminated then
				compile_servlet_gen
			else
				o.eprint ("TRANSLATION FAILED", generating_type)
				set_running (False)
			end

		end

	gen_compile_process_exited
			-- Launch executing of servlet_gen in genrate_process
		do
			if output_handler_compile.has_successfully_terminated then
				generate
			else
				o.eprint ("COMPILATION OF SERVLET_GEN FAILED", generating_type)
				set_running (False)
			end
		end

	generate_process_exited
			-- Sets is_running := False and executes next action
		do
			set_running (False)
			if output_handler_gen.has_successfully_terminated then
				next_action.execute.do_nothing
			else
				o.eprint ("GENERATION FAILED", generating_type)
			end
		end

invariant
	output_handler_compile_attached: output_handler_compile /= Void
	output_handler_translate_attached: output_handler_translate /= Void
	output_handler_gen_attached: output_handler_gen /= Void
end

