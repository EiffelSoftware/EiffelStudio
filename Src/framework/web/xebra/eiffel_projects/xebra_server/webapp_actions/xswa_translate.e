note
	description: "[
		The action that runs the translator to translate the webapp.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XSWA_TRANSLATE

inherit
	XS_WEBAPP_ACTION

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.	
		do
			force := False
		end

feature {NONE} -- Access

	force: BOOLEAN assign set_force
		-- If true, translation is alsways neccesary

	translate_process: detachable PROCESS
			-- Used to translate the xeb files


feature {NONE} -- Status report

	translator_args: STRING
			-- The arguments that are passed to the translator
		require
			webapp_attached: webapp /= Void
		do
			Result := ""
			if attached webapp as l_webapp then
				Result := " -n %"" + l_webapp.app_config.name.out + "%""
				Result.append ( " -i . ")
				Result.append (" -o . ")
				Result.append (" -l %"" + config.file.lib.out + "%"")
				Result.append (" -d " + config.args.debug_level.out)
				if force then
					Result.append (" -f")
				end
			end
		ensure
			Result_attached: Result /= Void
		end

	action_name: STRING
			-- The name of the action as it appears in the status messages
		do
			Result := "Translate Webapp"
		end

	internal_is_execution_needed (a_with_cleaning: BOOLEAN): TUPLE [BOOLEAN, detachable LIST [XSWA_STATUS]]
			-- <Precursor>
			--
			-- Reasons can be:
			-- Returns True if:
			--  - The translated-file is older than any xeb file in app_dir.
			--  - The servlet_gen_exf file does not exist.
			--  - Forced.
		local
			translator_executed_file: FILE_NAME
			l_f_utils: XU_FILE_UTILITIES
			l_inc: LINKED_LIST [STRING]
			l_errors: ARRAYED_LIST [XSWA_STATUS]
		do
			create l_errors.make (1)
			create l_inc.make
			l_inc.force ("*.xeb")
			create l_f_utils

			create translator_executed_file.make_from_string (app_dir.string)
			translator_executed_file.extend ({XU_CONSTANTS}.Generated_folder_name)
			translator_executed_file.set_file_name ({XU_CONSTANTS}.Translator_executed_file)

			if l_f_utils.file_is_newer (translator_executed_file, app_dir, l_inc) then
				l_errors.force (create {XSWA_STATUS_FILE_OLDER_THAN_XEB}.make ("translator-executed-file"))
			end

			if not l_f_utils.is_readable_file (servlet_gen_ecf_file) then
				l_errors.force (create {XSWA_STATUS_FILE_NOT_EXIST}.make (servlet_gen_ecf_file))
			end

			if a_with_cleaning and force then
				l_errors.force (create {XSWA_STATUS_FORCE}.make)
			end
			Result := [not l_errors.is_empty, l_errors]
		end

feature -- Status setting

	stop
			-- <Precursor>
		require else
			webapp_attached: webapp /= Void
		do
			if attached webapp as l_webapp then
				if attached {PROCESS} translate_process as l_process and then l_process.is_running  then
					log.dprint ("Terminating translate_process for " + l_webapp.app_config.name.out  + "", log.debug_tasks)
					l_process.terminate
					l_process.wait_for_exit
				end
				set_running (False)
			end
		end

	set_force (a_force: BOOLEAN)
			-- Sets is_force
		do
			force := a_force
		ensure
			set: force ~ a_force
		end

feature {NONE} -- Internal Status Setting

	set_running (a_running: BOOLEAN)
			-- Sets is_running
		do
			if attached webapp as l_webapp then
				is_running := a_running
				l_webapp.is_translating := a_running
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
					if can_launch_process (config.file.translator_filename, app_dir) then

						if attached translate_process as l_process then
							if l_process.is_running then
								log.eprint ("About to launch translate process but it was still running... So I'm going to kill it.", generating_type)
								l_process.terminate
							end
						end

						log.dprint("-=-=-=--=-=LAUNCHING TRANSLATE -=-=-=-=-=-=", log.debug_verbose_subtasks)
						translate_process := launch_process (config.file.translator_filename,
																translator_args,
																app_dir,
																agent translate_process_exited,
																agent output_regular,
																agent output_error)
						set_running (True)
					end
				end
				internal_last_response := (create {XER_APP_COMPILING}.make (l_webapp.app_config.name.out)).render_to_command_response
			end
		end

feature {NONE} -- Agents

	translate_process_exited
			-- Launch compiling of servlet_gen in gen_compile_process
		do
			set_running (False)
			set_force (False)
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

