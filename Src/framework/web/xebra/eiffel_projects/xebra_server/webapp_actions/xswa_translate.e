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
			Result := webapp.config.name.out + " ./ ./ ./" + config.servlet_gen_path + "/ ./"
		end

	generate_args: STRING
			-- The arguments that are passed to the servlet_gen
		do
			Result :=  "./"
		end

	gen_compiler_args: STRING
			-- The arguments that are passed to compile the servlet_gen	
		do
			Result  := " -config " + config.servlet_gen_ecf + " -target servlet_gen -c_compile -stop"
		end

feature -- Status report

	is_necessary: BOOLEAN
			-- <Precursor>
			-- Check if the webapps has to be (re)translated
			-- (which includes, executing translator, compiling servlet_gen and executing servlet_gen)
			-- Returns True iff for every *.xeb in app_dir a corresponding g_* does is older or does not exist.
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
				translate_process := launch_process (config.translator,
														translator_args,
														app_dir,
														agent translate_process_exited,
														agent translator_output_handler)
				is_running := True
			end
			Result := (create {XER_APP_COMPILING}.make (webapp.config.name.out)).render_to_response
		end

	compile_servlet_gen
			-- Launches the process to compile the servlet_gen
		do
			gen_compile_process := launch_process (config.compiler,
													gen_compiler_args,
													app_dir,
													agent gen_compile_process_exited,
													agent compiler_output_handler)
		end

	generate
			-- Launches the process to execute servlet_gen
		do
			generate_process := launch_process (app_dir + "/" + config.servlet_gen_exe,
												generate_args,
												app_dir,
												agent generate_process_exited,
												agent generator_output_handler)
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
		local
			l_dummy: XH_RESPONSE
		do
			set_outputter_name ({XS_MAIN_SERVER}.Name)
			is_running := False
			l_dummy := next_action.execute
		end
end

