note
	description: "[
		The action that executes the servlet_gen.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
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
			create output_handler_gen.make
		ensure then
			output_handler_gen_attached: output_handler_gen /= Void
		end

feature -- Access

	output_handler_gen: XSOH_GEN
		-- Output handler for compilation of servletget process

	generate_process: detachable PROCESS
			-- Used to run the servlet_gen

	generate_args: STRING
			-- The arguments that are passed to the servlet_gen
		do
			Result :=  "-o ."
		ensure
			Result_attached: Result /= Void
		end

	needs_cleaning: BOOLEAN assign set_needs_cleaning
			-- Can be used to force the action to execute and add -clean option to compilation	

feature -- Status report

	is_necessary: BOOLEAN
			-- <Precursor>
			--
			-- Returns true if:
			--  - There is a xeb file that is newer than servlet_gen_executed_file in app_dir
			--  - Needs cleaning
		local
			l_servlet_gen_not_executed: BOOLEAN
			l_f_utils: XU_FILE_UTILITIES
			l_inc: LINKED_LIST [STRING]
		do
			create l_inc.make
			l_inc.force ("*.xeb")
			create l_f_utils
			l_servlet_gen_not_executed := l_f_utils.file_is_newer (servlet_gen_executed_file,
									app_dir,
									l_inc)

			Result :=  	needs_cleaning or l_servlet_gen_not_executed

			if Result then
				log.dprint ("Generating is necessary", log.debug_tasks)

				if l_servlet_gen_not_executed then
					log.dprint ("Generating is necessary because: Servlet_gen_executed file is older than xeb files in app_dir or does not exist.", log.debug_verbose_subtasks)
				end

				if needs_cleaning then
					log.dprint ("Generating is necessary because: generate cleaning not yet performed.", log.debug_verbose_subtasks)
				end
			else
				log.dprint ("Generating is not necessary", log.debug_tasks)
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
		require
			webapp_attached: webapp /= Void
		do
			if attached webapp as l_webapp then
				is_running := a_running
				l_webapp.is_generating := a_running
			end
		ensure
			set: is_running ~ a_running
		end

feature {TEST_WEBAPPS} -- Implementation

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
															agent output_handler_gen.handle_output,
															agent output_handler_gen.handle_output)
					end
				end
				internal_last_response := (create {XER_APP_COMPILING}.make (l_webapp.app_config.name.out)).render_to_command_response
			end
		end

feature -- Agents

	generate_process_exited
			-- Sets is_running := False and executes next action
		do
			set_running (False)
			set_needs_cleaning (False)
			if not is_necessary then
				execute_next_action
			else
				log.eprint ("GENERATION FAILED", generating_type)
			end
		end
invariant
		output_handler_gen_attached: output_handler_gen /= Void
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

