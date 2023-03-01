note
	description: "[
		Session persistance manager, for retrieving an storing sessions from a user's home profile.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	SESSION_MANAGER

inherit
	SESSION_MANAGER_S

	DISPOSABLE_SAFE

--inherit {NONE}
	EIFFEL_LAYOUT

create
	default_create

feature -- Clean up

	close_session (a_session: SESSION_I)
			-- Closes a session object.
			--
			-- `a_session': The session object to close.
		do
			if is_interface_usable then
				if attached internal_sessions as l_sessions and then l_sessions.has (a_session) then
						-- Removes the session object from the list of managed objects.
					l_sessions.start
					l_sessions.search (a_session)
					check a_session_found: not l_sessions.after end
					l_sessions.remove

						-- Cleans up the session object.
					if a_session.is_interface_usable and then attached {DISPOSABLE_I} a_session as l_disposable then
						l_disposable.dispose
					end
				end
			end
		end

feature {NONE} -- Clean up

	safe_dispose (a_disposing: BOOLEAN)
			-- <Precursor>
		do
			if a_disposing then
					-- Store all unsaved session data
				store_all
				if attached internal_sessions as l_sessions then
						-- Clean up sessions
					from l_sessions.start until l_sessions.after loop
						if attached {DISPOSABLE} l_sessions.item_for_iteration as l_disposable then
							l_disposable.dispose
						end
						l_sessions.forth
					end
				end
			end
		end

feature -- Access

	active_sessions: ARRAYED_LIST [SESSION_I]
			-- <Precursor>
		do
			if attached internal_sessions as l_sessions then
				create Result.make (l_sessions.count)
				Result.append (l_sessions)
			else
				create Result.make (0)
			end
		end

feature {NONE} -- Access

	sessions: ARRAYED_LIST [SESSION_I]
			-- List of retrieve sessions
		require
			is_interface_usable: is_interface_usable
		do
			if attached internal_sessions as l_sessions then
				Result := l_sessions
			else
				create Result.make (1)
				internal_sessions := Result
			end
		ensure
			result_attached: attached Result
			result_consistent: Result = sessions
		end

feature {NONE} -- Query

	session_file_path (a_session: SESSION_I): PATH
			-- <Precursor>
		require
			is_interface_usable: is_interface_usable
			a_session_attached: attached a_session
			a_session_is_interface_usable: a_session.is_interface_usable
			project_loaded: not a_session.is_per_project or else (create {SHARED_WORKBENCH}).workbench.system_defined
		local
			l_formatter: STRING_FORMATTER
			l_kinds: SESSION_KINDS
			l_kind: UUID
			l_fn: detachable STRING_32
			l_conf_target: CONF_TARGET
			l_ver: STRING_8
			l_target: STRING_32
			l_workbench: detachable WORKBENCH_I
			l_window_id: NATURAL_32
			l_extension: detachable STRING_32
			l_name: detachable IMMUTABLE_STRING_32
		do
			create l_formatter
			create l_kinds

			if attached {CUSTOM_SESSION_I} a_session as l_session then
				Result := l_session.file_name
			else
					-- Determine session type		
				l_kind := a_session.kind
				if l_kind ~ l_kinds.environment then
					l_fn := environment_file_name
				elseif l_kind ~ l_kinds.window then
					l_fn := window_file_name
				elseif l_kind ~ l_kinds.project then
					l_fn := project_file_name
				elseif l_kind ~ l_kinds.project_window then
					l_fn := project_window_file_name
				else
						-- Unknown session kind
					check False end
				end

					-- Project UUID
				if a_session.is_per_project then
						-- Retrieve project specific information
					l_workbench := (create {SHARED_WORKBENCH}).workbench
					if l_workbench.system_defined then
						l_conf_target := l_workbench.lace.target
						if attached (create {USER_OPTIONS_FACTORY}).mapped_uuid (l_workbench.lace.file_name) as l_uuid then
							l_ver := l_uuid.out
						else
							l_ver := l_conf_target.system.uuid.out
						end
						l_ver.replace_substring_all ("-", "")
						l_target := l_conf_target.name
					end
				end

					-- Window ID
				if a_session.is_per_window then
					l_window_id := a_session.window_id
				end

					-- Extension name
				l_name := a_session.extension_name
				if attached l_name then
					create l_extension.make (l_name.count + 1)
					l_extension.append_character ('.')
					l_extension.append (l_name.as_lower)
				end

				check
					l_fn_attached: attached l_fn
					not_l_fn_is_empty: not l_fn.is_empty
				end

					-- Format path using collected parts
				l_fn := l_formatter.format_unicode (l_fn, [l_ver, l_target, l_window_id, l_extension])

					-- Create full path
				Result := eiffel_layout.session_data_path.extended (l_fn)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Helpers

	logger_service: attached SERVICE_CONSUMER [LOGGER_S]
			-- Access to logger service
		local
			l_site: like site
		do
			if attached internal_logger_service as l_service then
				Result := l_service
			else
				l_site := site
				check
					sited: is_sited and then attached l_site
				end
				create Result.make_with_provider (l_site)
				internal_logger_service := Result
			end
		end

feature -- Storage

	store (a_session: SESSION_I)
			-- <Precursor>
		local
			l_file_name: like session_file_path
			l_file: detachable RAW_FILE
			l_sed_util: SED_STORABLE_FACILITIES
			l_writer: SED_MEDIUM_READER_WRITER
			l_message: STRING_32
			retried: BOOLEAN
			u: FILE_UTILITIES
		do
			if not retried then
				if a_session.is_dirty and then (not a_session.is_per_project or else (create {SHARED_WORKBENCH}).workbench.system_defined) then
						-- Retrieve file name and ensure the directory exists.
					l_file_name := session_file_path (a_session)
					if attached l_file_name.canonical_path.parent as l_parent then
						u.create_directory_path (l_parent)
					else
						-- `l_file_name' has no parent, i.e. it will be created in the current working directory.
					end

						-- Ensure the project is loaded for project sessions.
					create l_sed_util
					create l_file.make_with_path (l_file_name)
					l_file.open_write
					create l_writer.make (l_file)
					l_writer.set_for_writing

						-- Encode and emit object
					a_session.on_begin_store
					l_sed_util.store (a_session.session_object, l_writer)
					l_file.flush
					a_session.on_end_store
				end

					-- Reset dirty state.
					-- Note: When using a project session, with no project we have to reset the dirty state
					--       because there is no way to retrieve a session file name.
				a_session.reset_is_dirty
			else
					-- Problem with storage, log.
				if attached logger_service.service as l_service then
						-- Log deserialization error.
					create l_message.make_from_string ("Unable to store the session data file: ")
					if not a_session.is_per_project or else (create {SHARED_WORKBENCH}).workbench.system_defined then
						l_message.append (session_file_path (a_session).name)
					else
						l_message.append ("<unloaded project>")
					end
					l_service.put_message_with_severity (l_message, {ENVIRONMENT_CATEGORIES}.internal_event, {PRIORITY_LEVELS}.high)
				end
			end

			if attached l_file and then not l_file.is_closed then
				l_file.close
			end
		rescue
			retried := True
			retry
		end

	store_all
			-- <Precursor>
		local
			l_cursor: CURSOR
		do
			if attached internal_sessions as l_sessions then
				l_cursor := l_sessions.cursor
				from l_sessions.start until l_sessions.after loop
					store (l_sessions.item_for_iteration)
					l_sessions.forth
				end
				l_sessions.go_to (l_cursor)
			end
		ensure then
			sessions_are_clean: attached internal_sessions as l_sessions implies l_sessions.for_all (agent (a_ia_session: SESSION_I): BOOLEAN
				do
					Result := not a_ia_session.is_dirty
				end)
		end

feature -- Retrieval

	retrieve (a_per_project: BOOLEAN): detachable SESSION_I
			-- <Precursor>
		do
			Result := retrieve_extended (a_per_project, Void)
		ensure then
			sessions_has_result: attached Result implies sessions.has (Result)
			result_consistent: attached Result implies Result = retrieve (a_per_project)
			result_is_interface_usable: attached Result implies Result.is_interface_usable
		end

	retrieve_extended (a_per_project: BOOLEAN; a_extension: detachable READABLE_STRING_GENERAL): detachable SESSION_I
			-- <Precursor>
		local
			l_sessions: like sessions
			l_session: SESSION_I
			l_cursor: CURSOR
		do
			l_sessions := sessions
			l_cursor := l_sessions.cursor
			from l_sessions.start until l_sessions.after loop
				if Result = Void then
						-- We need to use a conditional check because of a memory leak with Gobo data structures.
						-- The cursor has to be run out to avoid the leak.
					l_session := l_sessions.item_for_iteration
					if l_session.is_interface_usable then
						if
							a_per_project = l_session.is_per_project and then
							not l_session.is_per_window
						then
							if a_extension /= Void then
								if
									attached l_session.extension_name as l_other_ext and then
									a_extension.same_string (l_other_ext)
								then
									Result := l_session
								end
							elseif l_session.extension_name = Void then
								Result := l_session
							end
						end
					end
				end
				l_sessions.forth
			end
			l_sessions.go_to (l_cursor)

			if Result = Void then
					-- Create a new session
				Result := new_session (Void, a_per_project, a_extension)
				if Result /= Void then
					l_sessions.extend (Result)
				end
			end
		ensure then
			sessions_has_result: attached Result implies sessions.has (Result)
			result_consistent: attached Result implies Result = retrieve_extended (a_per_project, a_extension)
			result_is_interface_usable: attached Result implies Result.is_interface_usable
		end

	retrieve_per_window (a_window: SHELL_WINDOW_I; a_per_project: BOOLEAN): detachable SESSION_I
			-- <Precursor>
		do
			Result := retrieve_per_window_extended (a_window, a_per_project, Void)
		ensure then
			sessions_has_result: attached Result implies sessions.has (Result)
			result_consistent: attached Result implies Result = retrieve_per_window (a_window, a_per_project)
			result_is_interface_usable: attached Result implies Result.is_interface_usable
		end

	retrieve_per_window_extended (a_window: SHELL_WINDOW_I; a_per_project: BOOLEAN; a_extension: detachable READABLE_STRING_GENERAL): detachable SESSION_I
			-- <Precursor>
		local
			l_sessions: like sessions
			l_session: SESSION_I
			l_cursor: CURSOR
		do
			l_sessions := sessions
			l_cursor := l_sessions.cursor
			from l_sessions.start until l_sessions.after loop
				if Result = Void then
					l_session := l_sessions.item_for_iteration
					if l_session.is_interface_usable then
						if
							a_per_project = l_session.is_per_project and then
							l_session.is_per_window and then
							l_session.window_id = a_window.window_id and then
							((a_extension /= Void and attached l_session.extension_name as l_other_ext) implies a_extension.same_string (l_other_ext))
						then
							Result := l_session
						end
					end
				end
				l_sessions.forth
			end
			l_sessions.go_to (l_cursor)

			if Result = Void then
					-- Create a new session
				Result := new_session (a_window, a_per_project, a_extension)
				if Result /= Void then
					l_sessions.extend (Result)
				end
			end
		ensure then
			sessions_has_result: attached Result implies sessions.has (Result)
			result_consistent: attached Result implies Result = retrieve_per_window_extended (a_window, a_per_project, a_extension)
			result_is_interface_usable: attached Result implies Result.is_interface_usable
		end

	retrieve_from_disk (a_file_name: PATH): detachable SESSION_I
			-- <Precursor>
		do
				-- Create a new custom session
			Result := new_custom_session (a_file_name)
			if attached Result then
				sessions.extend (Result)
			end
		ensure then
			sessions_has_result: attached Result implies sessions.has (Result)
		end

	reload (a_session: SESSION_I)
			-- <Precursor>
		do
			check
				internal_sessions_attached: attached internal_sessions
				internal_sessions_has_a_session: internal_sessions.has (a_session)
			end
			set_session_object (a_session)
			a_session.reset_is_dirty
		end

feature {NONE} -- Basic operation

	set_session_object (a_session: SESSION_I)
			-- Sets a session's session object by reloading a session from disk.
			--
			-- `a_session': A session to set a session object for.
		require
			is_interface_usable: is_interface_usable
			a_session_attached: attached a_session
			a_session_is_interface_usable: a_session.is_interface_usable
			project_loaded: not a_session.is_per_project or else (create {SHARED_WORKBENCH}).workbench.system_defined
		local
			l_sed_util: SED_STORABLE_FACILITIES
			l_reader: SED_MEDIUM_READER_WRITER
			l_object: ANY
			l_file: detachable RAW_FILE
			l_message: attached STRING_32
			retried: BOOLEAN
		do
			if not retried then
				create l_sed_util
				create l_file.make_with_path (session_file_path (a_session))
				if l_file.exists then
					l_file.open_read

					create l_reader.make (l_file)
					l_reader.set_for_reading

						-- Encode and emit object
					l_object := l_sed_util.retrieved (l_reader, True)
					if attached l_object then
						a_session.set_session_object (l_object)
					else
							-- Problem with compatibility, log.
						if attached logger_service.service as l_service then
								-- Log deserialization error.
							create l_message.make_from_string ({STRING_32} "Unable to deserialize the session data file: " + l_file.path.name)
							l_service.put_message_with_severity (l_message, {ENVIRONMENT_CATEGORIES}.internal_event, {PRIORITY_LEVELS}.high)
						end
					end
				end
			end

			if attached l_file and then not l_file.is_closed then
				l_file.close
			end
		ensure
			a_session_is_dirty_preserved: old a_session.is_dirty = a_session.is_dirty
		rescue
			retried := True
			retry
		end

feature {NONE} -- Factory

	new_session (a_window: detachable SHELL_WINDOW_I; a_per_project: BOOLEAN; a_extension: detachable READABLE_STRING_GENERAL): detachable SESSION_I
			-- Creates a new session object
			--
			-- `a_window': The window to bind the session object to; False to make a session for the entire IDE.
			-- `a_per_project': True to retireve a session for the active project, False otherwise
		require
			is_interface_usable: is_interface_usable
			a_window_is_interface_usable: attached a_window implies a_window.is_interface_usable
			not_a_extension_is_empty: attached a_extension implies not a_extension.is_empty
		local
			l_inner_session: detachable SESSION_I
			l_shared: SHARED_EIFFEL_PROJECT
			l_set_object: BOOLEAN
			l_existing_load_agents: ACTION_SEQUENCE [TUPLE]
			l_load_agents: ACTION_SEQUENCE [TUPLE]
			l_load_agent: PROCEDURE
		do
			l_set_object := True

				-- Fetch inner session for aggregation. See {AGGREGATED_SESSION} for details on session aggregation.
			if attached a_window then
					-- Retrieve higher level session for aggregation
				if a_per_project then
					l_inner_session := retrieve_per_window_extended (a_window, False, a_extension)
				else
					l_inner_session := retrieve_extended (False, a_extension)
				end
			elseif a_per_project then
				l_inner_session := retrieve_extended (False, a_extension)
			end

				-- Create session object
			if attached l_inner_session then
				if a_window = Void then
						-- Must be a per-project session because there is no parent window
					check a_per_project: a_per_project end
					create {AGGREGATED_SESSION} Result.make (True, Current, l_inner_session)
				else
					create {AGGREGATED_SESSION} Result.make_per_window (a_per_project, a_window, Current, l_inner_session)
				end

				if a_per_project then
					create l_shared
					if not l_shared.eiffel_project.workbench.system_defined then
							-- No project is loaded so we have to initialize the project session once it is loaded.
						l_load_agents := l_shared.eiffel_project.manager.load_agents
						l_load_agent := agent (ia_session: SESSION_I)
							do
								if is_interface_usable and then ia_session.is_interface_usable then
										-- For protection, make sure both objects are usable.
									set_session_object (ia_session)
								end
							end (Result)
							-- Hack to force the session to be the first load action, so we can be sure the session
							-- is correctly initialized before anyone trys to use it in other load actions.
						l_existing_load_agents := l_load_agents.twin
						l_load_agents.wipe_out
							-- Extend the session resurrect action.
						l_load_agents.extend_kamikaze (l_load_agent)
							-- Add all the other actions.
						from l_existing_load_agents.start until l_existing_load_agents.after loop
							l_load_agent := l_existing_load_agents.item
							if l_existing_load_agents.has_kamikaze_action (l_load_agent) then
								l_load_agents.extend_kamikaze (l_load_agent)
							else
								l_load_agents.extend (l_load_agent)
							end
							l_existing_load_agents.forth
						end

						if attached {DISPOSABLE_I} Result as l_disposable then
								-- We have to be sure to remove the load agent on dispose. When a new window is opened
								-- with no project loaded, then the window is closed and then project is opened, the agent
								-- will still be called. We cannot have this.
							l_disposable.automation.notify_on_disposing (
								agent (ia_load_agents: ACTION_SEQUENCE [TUPLE]; ia_agent: PROCEDURE)
									do
										ia_load_agents.prune (ia_agent)
									end (l_load_agents,l_load_agent))
						else
								-- Sanity check. This should only happen if there is alternative implementation (possibly external)
								-- for {SESSSION_I}.
							check False end
						end
						l_set_object := False
					end
				end
			else
					-- Project based session are always aggregated
				check not_a_per_project: not a_per_project end

				if a_window = Void then
					create {SESSION} Result.make (False, Current)
				else
					create {SESSION} Result.make_per_window (False, a_window, Current)
				end
				if a_extension /= Void then
					Result.set_extension_name (create {IMMUTABLE_STRING_32}.make_from_string_general (a_extension))
				end
			end

			check result_attached: attached Result end

			if l_set_object then
				set_session_object (Result)
			end
			auto_dispose (Result)
		ensure
			result_attached: not a_per_project implies attached Result
			result_is_interface_usable: attached Result implies Result.is_interface_usable
			result_is_clean: attached Result implies not Result.is_dirty
			result_is_per_project: attached Result implies (a_per_project implies Result.is_per_project)
			result_is_per_window: (attached Result and attached a_window) implies Result.is_per_window
			result_window_id_set: (attached Result and attached a_window) implies (Result.window_id = a_window.window_id)
			result_extension_set: (attached Result and attached a_extension) implies a_extension.same_string (Result.extension_name)
		end

	new_custom_session (a_file_name: PATH): detachable CUSTOM_SESSION_I
			-- Creates a new session object
			--
			-- `a_file_name': The full path to a file on disk to retrieve session data from.
		require
			is_interface_usable: is_interface_usable
			a_file_name_attached: attached a_file_name
			not_a_file_name_is_empty: not a_file_name.is_empty
		do
			create {CUSTOM_SESSION} Result.make (a_file_name, Current)
			set_session_object (Result)
			auto_dispose (Result)
		ensure
			result_is_interface_usable: attached Result implies Result.is_interface_usable
			result_is_clean: attached Result implies not Result.is_dirty
			result_file_name_set: attached Result implies (a_file_name ~ Result.file_name)
		end

feature {NONE} -- Constants

	environment_file_name: STRING_8 = "environment{4}.ses"
	window_file_name: STRING_8 = "window_{3}{4}.ses"
	project_file_name: STRING_8 = "{1}.{2}{4}.ses"
	project_window_file_name: STRING_8 = "{1}.{2}.window_{3}{4}.ses"

feature {NONE} -- Internal implementation cache

	internal_sessions: detachable like sessions
			-- Cached version of `sessions'
			-- Note: Do not use directly!

	internal_logger_service: SERVICE_CONSUMER [LOGGER_S]
			-- Cached version of `logger_service'
			-- Note: Do not use directly!

;note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
