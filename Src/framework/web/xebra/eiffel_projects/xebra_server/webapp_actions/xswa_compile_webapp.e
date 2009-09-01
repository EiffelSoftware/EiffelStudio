note
	description: "[
		The action which compiles the webapp.
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XSWA_COMPILE_WEBAPP

inherit
	XSWA_COMPILE

create
	make


feature {NONE} -- Access

	compile_process: detachable PROCESS
			-- Used to compile the webapp

feature {NONE} -- Status report

	action_name: STRING
			-- The name of the action as it appears in the status messages
		do
			Result := "Compile Webapp"
		end

	internal_is_execution_needed (a_with_cleaning: BOOLEAN): TUPLE [BOOLEAN, detachable LIST [XSWA_STATUS]]
			-- <Precursor>
			--
			-- Reasons can be:
			--	- There is a .e or .ecf file somewhere in app_dir (recursively) that is newer than the melted file
			--	- The executable is missing
			--	- The webapp needs cleaning
		local
			l_f_util: XU_FILE_UTILITIES
			l_inc: LINKED_LIST [STRING]
			l_errors: ARRAYED_LIST [XSWA_STATUS]
		do
			create l_errors.make (1)
			create l_inc.make
			l_inc.force ("*.ecf")
			l_inc.force ("*.e")
			create l_f_util

			if l_f_util.file_is_newer (webapp_melted_file, app_dir, l_inc) then
				l_errors.force (create {XSWA_STATUS_FILE_OLDER_THAN_E}.make (webapp_melted_file))
			end

			if not l_f_util.is_executable_file (webapp_exe_file) then
				l_errors.force (create {XSWA_STATUS_FILE_NOT_EXIST}.make (webapp_exe_file))
			end

			if a_with_cleaning and needs_cleaning then
				l_errors.force (create {XSWA_STATUS_NEEDS_CLEANING})
			end

			Result := [not l_errors.is_empty, l_errors]
		end

	compiler_args: STRING
			-- The arguments that are passed to compile the webapp
		require
			webapp_attached: webapp /= Void
		local
			l_f_utils: XU_FILE_UTILITIES
			l_wapp_ecf: STRING
		do

			Result := ""
			if attached webapp as l_webapp then
				create l_f_utils
				l_wapp_ecf := l_webapp.app_config.ecf.out
				if {PLATFORM}.is_windows then
					l_wapp_ecf.replace_substring_all ("/", "\")
				end
				Result  := " -config %"" + l_wapp_ecf + "%" -target %"" + l_webapp.app_config.name.out + "%" -c_compile -stop -project_path %"" + app_dir + "%" "
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

feature -- Status setting

	stop
			-- <Precursor>
		require else
			webapp_attached: webapp /= Void
		do
			if attached webapp as l_webapp then
				if attached {PROCESS} compile_process as l_process and then l_process.is_running  then
					log.dprint ("Terminating compile_process_webapp  for " + l_webapp.app_config.name.out  + "", log.debug_subtasks)
					l_process.terminate
					l_process.wait_for_exit
				end
				set_running (False)
			end
		end

feature {NONE} -- Implementation

	internal_execute
			-- <Precursor>
		require else
			webapp_attached: webapp /= Void
		do
			create {XCCR_INTERNAL_SERVER_ERROR}internal_last_response
			if attached {XS_MANAGED_WEBAPP} webapp as l_webapp then
				if not is_running then
					l_webapp.shutdown
					if can_launch_process (config.file.compiler_filename, app_dir) then
						if attached compile_process as l_process then
							if l_process.is_running then
								log.eprint ("About to launch generate_process but it was still running... So I'm going to kill it.", generating_type)
								l_process.terminate
							end
						end
						log.dprint("-=-=-=--=-=LAUNCHING COMPILE WEBAPP -=-=-=-=-=-=", log.debug_verbose_subtasks)
						error_output_cache.wipe_out
						compile_process := launch_process (config.file.compiler_filename,
														compiler_args,
														app_dir,
														agent compile_process_exited,
														agent handle_compile_output ,
														agent handle_compile_output)
						set_running (True)
					end
				end
				internal_last_response := (create {XER_APP_COMPILING}.make (l_webapp.app_config.name.out)).render_to_command_response
			end
		end

feature {NONE} -- Internal Status Setting

	set_running (a_running: BOOLEAN)
			-- Sets is_running
		do
			if attached webapp as l_webapp then
				is_running := a_running
				l_webapp.is_compiling_webapp := a_running
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


