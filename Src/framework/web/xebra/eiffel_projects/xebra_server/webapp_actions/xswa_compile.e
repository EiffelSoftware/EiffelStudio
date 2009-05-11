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

	melted_file_path: STRING
			-- Returns the path to the melted file
		do
			Result := run_workdir_w  + "/" + webapp.config.name.out + ".melted"
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

	file_is_newer (a_file, a_dir, a_ext1, a_ext2: STRING): BOOLEAN
				-- Returns True iff there is a file in a_dir with a_ext1 or a_ext2
				-- that is newer than a_file or a_file does not exist
		local
			l_dir: DIRECTORY
			l_files: LIST [STRING]
			l_file: RAW_FILE
			l_exec_access_date: INTEGER
		do
			Result := False
			if file_exists (a_file) then
				l_exec_access_date := (create {RAW_FILE}.make (a_file)).date
				create l_dir.make (a_dir)
				l_files := l_dir.linear_representation
				from
					l_files.start
				until
					l_files.after or Result
				loop
					if l_files.item_for_iteration.ends_with (a_ext1) or l_files.item_for_iteration.ends_with (a_ext2) then
						create l_file.make (a_dir + "/" + l_files.item_for_iteration)
						if (l_file.date > l_exec_access_date) then
							Result := True
							o.dprint ("File '" + l_file.name + "' is newer (" + l_file.date.out + ")  than  (" + l_exec_access_date.out + ")",5)
						end
					end
					l_files.forth
				end
			else
				Result := True
				o.dprint ("File '" + a_file + "' does not exist.", 5)
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
				compile_process := launch_process (config.compiler,
												compiler_args,
												app_dir,
												agent compile_process_exited,
												agent compiler_output_handler)
				is_running := True
			end
			Result := (create {XER_APP_COMPILING}.make (webapp.config.name.out)).render_to_response
		end

feature -- Agent

	compile_process_exited
			-- Sets is_running := False
		local
			l_dummy: XH_RESPONSE
		do
			is_running := False
		--	l_dummy := next_action.execute
		end

	compiler_output_handler (a_ouput: STRING)
			-- Forwards output to console
		do
			o.set_name ("COMPILER")
			o.dprintn (a_ouput, 3)
			o.set_name ({XS_MAIN_SERVER}.name)
		end
end


