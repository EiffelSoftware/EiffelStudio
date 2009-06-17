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
		do
			Result  := " -config " + servlet_gen_ecf.string + " -target servlet_gen -c_compile -stop"
			if not webapp.cleaned then
				Result.append (" -clean")
			end
			if not file_exists (servlet_gen_exe) then
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
			-- Returns True iff there is a *.xeb file in app_dir which is newer than app_dir/g_name_application.e
		local
			l_application_file: FILE_NAME
		do
			l_application_file := app_dir.twin
			l_application_file.set_file_name ("g_" + webapp.app_config.name.out + "_application.e")

			Result := file_is_newer (l_application_file,
									app_dir,
									".xeb",
									".xeb")
						or not file_exists (servlet_gen_exe)
						or not file_exists (servlet_gen_ecf)
						or not webapp.cleaned
			if Result then
				o.dprint ("Translating is necessary", 5)
			else
				o.dprint ("Translating is not necessary", 5)
			end
		end


	is_necessary_obsolete: BOOLEAN
			-- <Precursor>
			-- Check if the webapps has to be (re)translated
			-- (which includes, executing translator, compiling servlet_gen and executing servlet_gen)
			-- Returns True iff for every *.xeb in app_dir a corresponding g_* is older or does not exist.
		local
			l_dir: DIRECTORY
			l_files: LIST [STRING]
			l_xeb_file: RAW_FILE
			l_e_file: RAW_FILE
			l_s_name: STRING
		do
			Result := False
			create l_dir.make (app_dir)
			l_files := l_dir.linear_representation
			from
				l_files.start
			until
				l_files.after or Result
			loop
				if l_files.item_for_iteration.ends_with (".xeb") then
					create l_xeb_file.make (app_dir + "/" + l_files.item_for_iteration)
					l_files.item_for_iteration.remove_tail (4)
					l_s_name := "g_" + l_files.item_for_iteration + "_servlet.e"
					create l_e_file.make (app_dir + "/" + l_s_name)
					if l_e_file.exists then
						if (l_e_file.date < l_xeb_file.date) then
							Result := True
						end
					else
						Result := True
					end
				end
				l_files.forth
			end
			if Result then
				o.dprint ("Translating is necessary", 5)
			else
				o.dprint ("Translating is not necessary", 5)
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
			is_running := False
		end

feature {NONE} -- Implementation

	internal_execute: XH_RESPONSE
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
					is_running := True
				end
			end
			Result := (create {XER_APP_COMPILING}.make (webapp.app_config.name.out)).render_to_response
		end

	compile_servlet_gen
			-- Launches the process to compile the servlet_gen
		do
			if can_launch_process (config.file.compiler_filename, app_dir) and then file_exists (servlet_gen_ecf) then
				if attached gen_compile_process as p then
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
--			config_outputter
			if output_handler_translate.has_successfully_terminated then
				compile_servlet_gen
			else
				o.eprint ("TRANSLATION FAILED", generating_type)
				is_running := False
			end

		end

	gen_compile_process_exited
			-- Launch executing of servlet_gen in genrate_process
		do
--			config_outputter
			if output_handler_compile.has_successfully_terminated then
				generate
			else
				o.eprint ("COMPILATION OF SERVLET_GEN FAILED", generating_type)
				is_running := False
			end
		end

	generate_process_exited
			-- Sets is_running := False and executes next action
		do
--			config_outputter
			is_running := False
			if output_handler_gen.has_successfully_terminated then
				webapp.cleaned := true
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

