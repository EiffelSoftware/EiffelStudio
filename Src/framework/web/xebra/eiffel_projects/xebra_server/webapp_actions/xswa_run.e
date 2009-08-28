note
	description: "[
		The action which runs the webapp.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XSWA_RUN

inherit
	XS_WEBAPP_ACTION

feature -- Access

	run_process: detachable PROCESS
		-- Used to run the webapp

	run_args: STRING
			-- The arguments for running the webapp
		local
			l_f: FILE_NAME
		do
			create l_f.make_from_string (app_dir)
			l_f.set_file_name ({XU_CONSTANTS}.Webapp_config_file)
			Result := "%"" + l_f.string + "%" -d " + config.args.debug_level.out + ""
						--webapp_debug_level.out
		ensure
			Result_attached: Result /= Void
		end


feature {NONE} -- Status report

	action_name: STRING
			-- The name of the action as it appears in the status messages
		do
			Result := "Run Webapp"
		end

	internal_is_execution_needed (a_with_cleaning: BOOLEAN): TUPLE [BOOLEAN, detachable LIST [XSWA_STATUS]]
			-- <Precursor>
			--
			-- Reasons can be:
			--	- The action is not running
		do
			Result := [not is_running, Void]
		end

feature -- Status setting

	stop
			-- <Precursor>
		require else
			webapp_attached: webapp /= Void
		do
			if attached webapp as l_webapp then
				if attached {PROCESS} run_process as l_process  and then l_process.is_running then
					log.dprint ("Terminating run_process for " + l_webapp.app_config.name.out  + "", log.debug_tasks)
					l_process.terminate
					l_process.wait_for_exit
				end
				set_running (False)
			end
		end

	wait_for_exit
			-- Waits until process is terminated
		do
			if attached {PROCESS} run_process as l_process  and then l_process.is_running then
				log.dprint ("Waiting for run_process to exit...", log.debug_tasks)
				l_process.wait_for_exit
				set_running (False)
			end
		end

feature {NONE} -- Implementation

	internal_execute
			-- <Precursor>
		require else
			webapp_attached: webapp /= Void
		do
			if attached webapp as l_webapp then
				if  not is_running then
					if can_launch_process (webapp_exe_file, run_workdir) then
						log.dprint("-=-=-=--=-=LAUNCHING WEBAPP  -=-=-=-=-=-=", log.debug_verbose_subtasks)
						run_process := launch_process (webapp_exe_file,
													run_args,
													run_workdir,
													agent run_process_exited,
													agent output_regular,
													agent output_error)
						set_running (True)
					end
				end
				internal_last_response := (create {XER_APP_STARTING}.make (l_webapp.app_config.name.out)).render_to_command_response
			else
				create {XCCR_INTERNAL_SERVER_ERROR}internal_last_response
			end
		end

feature {NONE} -- Internal Status Setting

	set_running (a_running: BOOLEAN)
			-- Sets is_running
		do
			if attached webapp as l_webapp then
				is_running := a_running
				l_webapp.is_running := a_running
			end
		end

feature {NONE} -- Agents

	run_process_exited
			-- Sets is_running := False
		require
			webapp_attached: webapp /= Void
		do
			if attached webapp as l_webapp then
				set_running (False)
				log.dprint ("Run process for " + l_webapp.app_config.name.out + " has exited.", log.debug_subtasks)
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

