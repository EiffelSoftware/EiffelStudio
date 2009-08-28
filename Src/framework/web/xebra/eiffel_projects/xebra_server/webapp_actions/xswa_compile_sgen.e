note
	description: "[
		The action that compiles servlet_gen.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XSWA_COMPILE_SGEN

inherit
	XS_WEBAPP_ACTION

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.	
		do
			create output_handler_compile.make
		ensure then
			output_handler_compile_attached: output_handler_compile /= Void
		end

feature -- Access

	output_handler_compile: XSOH_COMPILE
			-- Output handler for compilation process

	gen_compile_process: detachable PROCESS
			-- Used to compile the servlet_gen			

	needs_cleaning: BOOLEAN assign set_needs_cleaning
			-- Can be used to force the action to execute and add -clean option to compilation

	gen_compiler_args: STRING
			-- The arguments that are passed to compile the servlet_gen	
		local
			l_f_utils: XU_FILE_UTILITIES
		do
			create l_f_utils
			Result  := " -config %"" + servlet_gen_ecf_file.string + "%" -target servlet_gen -c_compile -stop -project_path %"" + servlet_gen_dir + "%" "

			if needs_cleaning then
				Result.append (" -clean")
			end
--			if not l_f_utils.is_readable_file (servlet_gen_exe) then
--				Result.append (" -clean")
--			end

			Result.append (" " + config.file.compiler_flags.value + " ")
		ensure
			Result_attached: Result /= Void
		end


feature -- Status report


	is_necessary: BOOLEAN
		-- <Precursor>
		--
		-- Returns true if:
		--	- There is a e or ecf file in servlet_gen_path that is newer than servlet_gen_melted_file
		--  - servlet_gen_exe does not exist or is not executable
		--  - Needs cleaning

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
			l_melted_file_is_old := l_f_util.file_is_newer (servlet_gen_melted_file,
												servlet_gen_dir,
												l_inc)
			l_executable_does_not_exist := not l_f_util.is_executable_file (servlet_gen_exe_file)

			Result := l_melted_file_is_old or l_executable_does_not_exist or needs_cleaning

			if Result then
				log.dprint ("Compiling servlet_gen is necessary", log.debug_tasks)
				if l_melted_file_is_old then
					log.dprint ("Compiling servlet_gen is necessary because: " + servlet_gen_melted_file + " is older than .e files or .ecf file or does not exist.", log.debug_verbose_subtasks)
				end

				if l_executable_does_not_exist then
					log.dprint ("Compiling servlet_gen is necessary because: " + servlet_gen_exe_file + " does not exist or is not executable.", log.debug_verbose_subtasks)
				end

					if needs_cleaning then
					log.dprint ("Compiling servlet_gen is necessary because: servlet_gen compilation cleaning not yet performed.", log.debug_verbose_subtasks)
				end

			else
				log.dprint ("Compiling servlet_gen is not necessary", log.debug_tasks)
			end
		end

feature -- Status setting

	set_needs_cleaning (a_needs_cleaning: like needs_cleaning)
			-- Setts needs_cleaning
		do
			needs_cleaning := a_needs_cleaning
		ensure
			needs_cleaning_set: needs_cleaning ~ a_needs_cleaning
		end

	stop
			-- <Precursor>
		require else
			webapp_attached: webapp /= Void
		do
			if attached webapp as l_webapp then
				if attached {PROCESS} gen_compile_process as l_process and then l_process.is_running  then
					log.dprint ("Terminating gen_compile_process for " + l_webapp.app_config.name.out  + "", log.debug_subtasks)
					l_process.terminate
					l_process.wait_for_exit
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
			if attached webapp as l_webapp then
				is_running := a_running
				l_webapp.is_compiling_servlet_gen := a_running
			end
		ensure
			set: is_running ~ a_running
		end

feature {TEST_WEBAPPS} -- Implementation

	internal_execute
			-- <Precursor>
		require else
			webapp_attached: webapp /= Void
		local
			l_f_utils: XU_FILE_UTILITIES
		do
			create {XCCR_INTERNAL_SERVER_ERROR}internal_last_response
			if attached webapp as l_webapp then
				if not is_running then
					create l_f_utils
					if can_launch_process (config.file.compiler_filename, app_dir) and then l_f_utils.is_readable_file (servlet_gen_ecf_file) then
						if attached gen_compile_process as l_process  then
							if l_process.is_running then
								log.eprint ("About to launch gen_compile_process but it was still running... So I'm going to kill it.", generating_type)
								l_process.terminate
							end
						end
						set_running (True)
						log.dprint("-=-=-=--=-=LAUNCHING COMPILE SERVLET GEN-=-=-=-=-=-=", log.debug_verbose_subtasks)
						gen_compile_process := launch_process (config.file.compiler_filename,
																gen_compiler_args,
																app_dir,
																agent gen_compile_process_exited,
																agent output_handler_compile.handle_output,
																agent output_handler_compile.handle_output)
					end
				end
				internal_last_response := (create {XER_APP_COMPILING}.make (l_webapp.app_config.name.out)).render_to_command_response
			end
		end


feature -- Agents

	gen_compile_process_exited
			-- Launch executing of servlet_gen in genrate_process
		do
			set_running (False)
			set_needs_cleaning (False)
			if not is_necessary then
				execute_next_action
			else
				log.eprint ("COMPILATION OF SERVLET_GEN FAILED", generating_type)

			end
		end

invariant
	output_handler_compile_attached: output_handler_compile /= Void
note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

