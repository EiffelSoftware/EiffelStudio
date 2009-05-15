note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XSWA_TRANSLATE

inherit
	XS_WEBAPP_ACTION

create
	make

feature -- Access

	translate_process: detachable PROCESS
			-- Used to translate the xeb files

	generate_process: detachable PROCESS
			-- Used to run the servlet_gen

	gen_compile_process: detachable PROCESS
			-- Used to compile the servlet_gen			

	translator_args: STRING
			-- The arguments that are passed to the translator
		do
			Result := " -n " + webapp.config.name.out + " -i . -o . -s " + servlet_gen_path.string + " -t ."
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
		ensure
			Result_attached: Result /= void
		end

	servlet_gen_path: FILE_NAME
			-- The path to the servlet_gen
		do
			Result := app_dir.twin
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
			l_file: FILE_NAME
		do
			l_file := app_dir.twin
			l_file.set_file_name ("g_" + webapp.config.name.out + "_application.e")

			Result := file_is_newer (l_file ,
									app_dir,
									".xeb",
									".xeb")

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
			if attached {PROCESS} translate_process as p then
				o.dprint ("Terminating translate_process for " + webapp.config.name.out  + "", 2)
				p.terminate
			end
			if attached {PROCESS} generate_process as p then
				o.dprint ("Terminating generate_process for " + webapp.config.name.out  + "", 2)
				p.terminate
			end
			if attached {PROCESS} gen_compile_process as p then
				o.dprint ("Terminating gen_compile_process for " + webapp.config.name.out  + "", 2)
				p.terminate
			end
			is_running := False
		end

feature {NONE} -- Implementation

	internal_execute: XH_RESPONSE
			-- <Precursor>
		do
			if not is_running then
				webapp.shutdown
				o.dprint("-=-=-=--=-=LAUNCHING TRANSLATE (5)-=-=-=-=-=-=", 10)
				translate_process := launch_process (config.translator_filename,
														translator_args,
														app_dir,
														agent translate_process_exited)
													--	agent translator_output_handler)
				is_running := True
			end
			Result := (create {XER_APP_COMPILING}.make (webapp.config.name.out)).render_to_response
		end

	compile_servlet_gen
			-- Launches the process to compile the servlet_gen
		do
			o.dprint("-=-=-=--=-=LAUNCHING COMPILE SERVLET GEN (4)-=-=-=-=-=-=", 10)
			gen_compile_process := launch_process (config.compiler_filename,
													gen_compiler_args,
													app_dir,
													agent gen_compile_process_exited)
												--	agent compiler_output_handler)
		end

	generate
			-- Launches the process to execute servlet_gen
		do
			o.dprint("-=-=-=--=-=LAUNCHING SERVLET GENERATOR (3) -=-=-=-=-=-=", 10)
			generate_process := launch_process (servlet_gen_exe,
												generate_args,
												app_dir,
												agent generate_process_exited)
											--	agent generator_output_handler)
		end

feature -- Agents

	translator_output_handler (a_ouput: STRING)
			-- Forwards output to console
		do
			o.set_name ("TRANSLATOR")
			o.dprintn (a_ouput, 3)
			o.set_name ({XS_MAIN_SERVER}.name)
		end

	generator_output_handler (a_ouput: STRING)
			-- Forwards output to console
		do
			o.set_name ("SERVLET_GEN")
			o.dprintn (a_ouput, 3)
			o.set_name ({XS_MAIN_SERVER}.name)
		end

	compiler_output_handler (a_ouput: STRING)
			-- Forwards output to console
		do
			o.set_name ("COMPILER")
			o.dprintn (a_ouput, 3)
			o.set_name ({XS_MAIN_SERVER}.name)
		end

	translate_process_exited
			-- Launch compiling of servlet_gen in gen_compile_process
		do
			set_outputter_name ({XS_MAIN_SERVER}.Name)
			compile_servlet_gen
		end

	gen_compile_process_exited
			-- Launch executing of servlet_gen in genrate_process
		do
			set_outputter_name ({XS_MAIN_SERVER}.Name)
			generate
		end

	generate_process_exited
			-- Sets is_running := False and executes next action
		do
			set_outputter_name ({XS_MAIN_SERVER}.Name)
			is_running := False
			next_action.execute.do_nothing
		end
end

