note
	description: "[
		The action that executes the servlet_gen.
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XSWA_GENERATE

inherit
	XS_WEBAPP_ACTION

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.	
		do

		end

feature {NONE} -- Access

	generate_process: detachable PROCESS
			-- Used to run the servlet_gen

	needs_cleaning: BOOLEAN assign set_needs_cleaning
			-- Can be used to force the action to execute and add -clean option to compilation	

feature {NONE} -- Status report

	generate_args: STRING
			-- The arguments that are passed to the servlet_gen
		do
			Result :=  "-o ."
		ensure
			Result_attached: Result /= Void
		end

	action_name: STRING
			-- The name of the action as it appears in the status messages
		do
			Result := "Generate Webapp"
		end

	internal_is_execution_needed (a_with_cleaning: BOOLEAN): TUPLE [BOOLEAN, detachable LIST [XSWA_STATUS]]
			-- <Precursor>
			--
			-- Reasons can be:
			--  - There is a xeb file that is newer than servlet_gen_executed_file in app_dir
			--  - Needs cleaning
		local
			l_f_utils: XU_FILE_UTILITIES
			l_inc: LINKED_LIST [STRING]
			l_errors: ARRAYED_LIST [XSWA_STATUS]
		do
			create l_errors.make (1)
			create l_inc.make
			l_inc.force ("*.xeb")
			create l_f_utils
			if l_f_utils.file_is_newer (servlet_gen_executed_file, app_dir, l_inc) then
				l_errors.force (create {XSWA_STATUS_FILE_OLDER_THAN_XEB}.make ("Servlet-generator-executed-file"))
			end

			if a_with_cleaning and needs_cleaning then
				l_errors.force (create {XSWA_STATUS_NEEDS_CLEANING})
			end
			Result := [not l_errors.is_empty, l_errors]
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
				if attached {PROCESS} generate_process as l_process and then l_process.is_running  then
					log.dprint ("Terminating generate_process for " + l_webapp.app_config.name.out  + "", log.debug_tasks)
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
				l_webapp.is_generating := a_running
			end
		end

feature {NONE} -- Implementation

	internal_execute
			-- <Precursor>
		require else
			webapp_attached: webapp /= Void
		do
			create {XCCR_INTERNAL_SERVER_ERROR}internal_last_response
			if attached webapp as l_webapp then
				if not is_running then
					if can_launch_process (servlet_gen_exe_file, app_dir) then
						if attached generate_process as l_process then
							if l_process.is_running then
								log.eprint ("About to launch generate_process but it was still running... So I'm going to kill it.", generating_type)
								l_process.terminate
							end
						end
						set_running (True)
						log.dprint("-=-=-=--=-=LAUNCHING SERVLET GENERATOR  -=-=-=-=-=-=", log.debug_verbose_subtasks)
						generate_process := launch_process (servlet_gen_exe_file,
															generate_args,
															app_dir,
															agent generate_process_exited,
															agent output_regular,
															agent output_error)
					end
				end
				internal_last_response := (create {XER_APP_COMPILING}.make (l_webapp.app_config.name.out)).render_to_command_response
			end
		end

feature {NONE} -- Agents

	generate_process_exited
			-- Sets is_running := False and executes next action
		do
			set_running (False)
			set_needs_cleaning (False)
			if is_successful then
				execute_next_action
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

