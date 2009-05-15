note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XSWA_COMPILE

inherit
	XS_WEBAPP_ACTION

create
	make

feature -- Access

	compile_process: detachable PROCESS
			-- Used to compile the webapp

	melted_file_path: FILE_NAME
			-- Returns the path to the melted file
		do
			Result := run_workdir.twin
			Result.set_file_name (webapp.config.name.out + ".melted")
		end

	compiler_args: STRING
			-- The arguments that are passed to compile the webapp
		do
			Result  := " -config " + webapp.config.name.out + "-voidunsafe.ecf -target " + webapp.config.name.out + " -c_compile -stop"
--			if config.finalize_webapps then
--				Result := Result + " -finalize"
--			end
		end

feature -- Status report

	is_necessary: BOOLEAN
			-- <Precursor>
		do
			Result := file_is_newer (melted_file_path,
											app_dir,
											"*.e",
											"*.ecf")
			if Result then
				o.dprint ("Compiling is necessary", 5)
			else
				o.dprint ("Compiling is not necessary", 5)
			end
		end


feature -- Status setting

	stop
			-- <Precursor>
		do
			if attached {PROCESS} compile_process as p then
				o.dprint ("Terminating compile_process for " + webapp.config.name.out  + "", 2)
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
				if can_launch_process (config.compiler_filename, app_dir) then
					o.dprint("-=-=-=--=-=LAUNCHING COMPILE WEBAPP (2) -=-=-=-=-=-=", 10)
					compile_process := launch_process (config.compiler_filename,
													compiler_args,
													app_dir,
													agent compile_process_exited)
												--	agent compiler_output_handler)
					is_running := True
				end
			end
			Result := (create {XER_APP_COMPILING}.make (webapp.config.name.out)).render_to_response
		end

feature -- Agent

	compile_process_exited
			-- Sets is_running := False
		do
			is_running := False
			next_action.execute.do_nothing
		end

	compiler_output_handler (a_ouput: STRING)
			-- Forwards output to console
		do
			o.set_name ("COMPILER")
			o.dprintn (a_ouput, 3)
			o.set_name ({XS_MAIN_SERVER}.name)
		end
end


