note
	description: "[
		The action that compiles servlet_gen.
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XSWA_COMPILE_SGEN

inherit
	XSWA_COMPILE

create
	make

feature {NONE} -- Access

	gen_compile_process: detachable PROCESS
			-- Used to compile the servlet_gen			

feature {NONE} -- Status report

	action_name: STRING
			-- The name of the action as it appears in the status messages
		do
			Result := "Compile Servlet Generator"
		end

	internal_is_execution_needed (a_with_cleaning: BOOLEAN): TUPLE [BOOLEAN, detachable LIST [XSWA_STATUS]]
			-- <Precursor>
			--
			-- Reasons can be:
			--	- There is a e or ecf file in servlet_gen_path that is newer than `servlet_gen_melted_file'
			--  - servlet_gen_exe does not exist or is not executable
			--  - Needs cleaning (if `a_with_cleaning' set)
		local
			l_f_util: XU_FILE_UTILITIES
			l_errors: ARRAYED_LIST [XSWA_STATUS]
			l_inc: LINKED_LIST [STRING]
		do
			create l_errors.make (1)
			create l_inc.make
			l_inc.force ("*.ecf")
			l_inc.force ("*.e")
			create l_f_util


			if l_f_util.file_is_newer (servlet_gen_melted_file, servlet_gen_dir, l_inc) then
				l_errors.force (create {XSWA_STATUS_FILE_OLDER_THAN_E}.make (servlet_gen_melted_file))
			end

			if not l_f_util.is_executable_file (servlet_gen_exe_file) then
				l_errors.force (create {XSWA_STATUS_FILE_NOT_EXIST}.make (servlet_gen_exe_file))
			end

			if a_with_cleaning and needs_cleaning then
				l_errors.force (create {XSWA_STATUS_NEEDS_CLEANING})
			end
			Result := [not l_errors.is_empty, l_errors]
		end

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

feature -- Status setting

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
		do
			if attached webapp as l_webapp then
				is_running := a_running
				l_webapp.is_compiling_servlet_gen := a_running
			end
		end

feature {NONE} -- Implementation

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
						error_output_cache.wipe_out
						gen_compile_process := launch_process (config.file.compiler_filename,
																gen_compiler_args,
																app_dir,
																agent compile_process_exited,
																agent handle_compile_output,
																agent handle_compile_output)
					end
				end
				internal_last_response := (create {XER_APP_COMPILING}.make (l_webapp.app_config.name.out)).render_to_command_response
			end
		end



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

