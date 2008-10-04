indexing
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

	SAFE_AUTO_DISPOSABLE
		redefine
			safe_dispose
		end

	EIFFEL_LAYOUT

create
	default_create

feature -- Clean up

	close_session (a_session: SESSION_I)
			-- Closes a session object.
			--
			-- `a_session': The session object to close.
		local
			l_sessions: ?like internal_sessions
		do
			if is_interface_usable then
				l_sessions := internal_sessions
				if l_sessions /= Void and then l_sessions.has (a_session) then
						-- Removes the session object from the list of managed objects.
					l_sessions.start
					l_sessions.search_forth (a_session)
					check a_session_found: not l_sessions.after end
					l_sessions.remove_at

						-- Cleans up the session object.
					if a_session.is_interface_usable and then {l_disposable: DISPOSABLE} a_session then
						l_disposable.dispose
					end
				end
			end
		end

feature {NONE} -- Clean up

	safe_dispose (a_disposing: BOOLEAN)
			-- <Precursor>
		local
			l_sessions: like internal_sessions
			l_cursor: DS_ARRAYED_LIST_CURSOR [SESSION_I]
		do
			if a_disposing then
					-- Store all unsaved session data
				store_all
				l_sessions := internal_sessions
				if l_sessions /= Void then
						-- Clean up sessions
					l_cursor := l_sessions.new_cursor
					from l_cursor.start until l_cursor.after loop
						if {l_disposable: DISPOSABLE} l_cursor.item then
							l_disposable.dispose
						end
						l_cursor.forth
					end
				end
			end

			Precursor {SAFE_AUTO_DISPOSABLE} (a_disposing)
		end

feature -- Access

	active_sessions: !DS_ARRAYED_LIST [SESSION_I]
			-- <Precursor>
		do
			create Result.make_from_linear (sessions)
		end

feature {NONE} -- Access

	sessions: !DS_ARRAYED_LIST [SESSION_I]
			-- List of retrieve sessions
		require
			is_interface_usable: is_interface_usable
		do
			if internal_sessions = Void then
				create Result.make_default
				internal_sessions := Result
			else
				Result ?= internal_sessions
			end
		ensure
			result_consistent: Result = sessions
		end

feature {NONE} -- Query

	session_file_path (a_session: SESSION_I): !STRING_8
			-- <Precursor>
		require
			is_interface_usable: is_interface_usable
			a_session_attached: a_session /= Void
			a_session_is_interface_usable: a_session.is_interface_usable
			project_loaded: not a_session.is_per_project or else (create {SHARED_WORKBENCH}).workbench.system_defined
		local
			l_formatter: STRING_FORMATTER
			l_kinds: SESSION_KINDS
			l_kind: UUID
			l_fn: STRING_8
			l_path: FILE_NAME
			l_conf_target: CONF_TARGET
			l_ver: STRING_8
			l_target: STRING_8
			l_workbench: ?WORKBENCH_I
			l_window_id: NATURAL_32
			l_extension: ?STRING_8
			l_name: ?STRING_8
		do
			create l_formatter
			create l_kinds

			if {l_session: !CUSTOM_SESSION_I} a_session then
				Result ?= l_session.file_name
			else
					-- Determine session type		
				l_kind := a_session.kind
				if l_kind.is_equal (l_kinds.environment) then
					l_fn := environment_file_name
				elseif l_kind.is_equal (l_kinds.window) then
					l_fn := window_file_name
				elseif l_kind.is_equal (l_kinds.project) then
					l_fn := project_file_name
				elseif l_kind.is_equal (l_kinds.project_window) then
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
						if {l_uuid: !UUID} (create {USER_OPTIONS_FACTORY}).mapped_uuid (l_workbench.lace.file_name) then
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
				if l_name /= Void then
					create l_extension.make (l_name.count + 1)
					l_extension.append_character ('.')
					l_extension.append (l_name.as_lower)
				end

				check
					l_fn_attached: l_fn /= Void
					not_l_fn_is_empty: not l_fn.is_empty
				end

					-- Format path using collected parts
				l_fn := l_formatter.format (l_fn, [l_ver, l_target, l_window_id, l_extension])

					-- Create full path
				create l_path.make_from_string (eiffel_layout.user_session_path.string)
				l_path.set_file_name (l_fn)
				Result ?= l_path.out
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Helpers

	logger_service: !SERVICE_CONSUMER [LOGGER_S]
			-- Access to logger service
		do
			if {l_service: !SERVICE_CONSUMER [LOGGER_S]} internal_logger_service then
				Result := l_service
			else
				check sited: site /= Void end
				create Result.make_with_provider (site)
				internal_logger_service := Result
			end
		end

	file_utilities: !FILE_UTILITIES
			-- Access to file utilities
		once
			create Result
		end

feature -- Storage

	store (a_session: SESSION_I)
			-- <Precursor>
		local
			l_logger: like logger_service
			l_file_name: like session_file_path
			l_file: RAW_FILE
			l_sed_util: SED_STORABLE_FACILITIES
			l_writer: SED_MEDIUM_READER_WRITER
			l_message: !STRING_32
			retried: BOOLEAN
		do
			if not retried then
				if a_session.is_dirty and then (not a_session.is_per_project or else (create {SHARED_WORKBENCH}).workbench.system_defined) then
						-- Retrieve file name and ensure the directory exists.
					l_file_name := session_file_path (a_session)
					file_utilities.create_directory_for_file (l_file_name)

						-- Ensure the project is loaded for project sessions.
					create l_sed_util
					create l_file.make_open_write (l_file_name)
					create l_writer.make (l_file)
					l_writer.set_for_writing

						-- Encode and emit object
					a_session.on_begin_store
					l_sed_util.independent_store (a_session.session_object, l_writer, False)
					l_file.flush
					a_session.on_end_store
				end

					-- Reset dirty state.
					-- Note: When using a project session, with no project we have to reset the dirty state
					--       because there is no way to retrieve a session file name.
				a_session.reset_is_dirty
			else
					-- Problem with storage, log.
				l_logger := logger_service
				if l_logger.is_service_available then
						-- Log deserialization error.
					create l_message.make_from_string ("Unable to store the session data file: ")
					if not a_session.is_per_project or else (create {SHARED_WORKBENCH}).workbench.system_defined then
						l_message.append (session_file_path (a_session))
					else
						l_message.append ("<unloaded project>")
					end
					l_logger.service.put_message_with_severity (l_message, {ENVIRONMENT_CATEGORIES}.internal_event, {PRIORITY_LEVELS}.high)
				end
			end

			if l_file /= Void and then not l_file.is_closed then
				l_file.close
			end
		rescue
			retried := True
			retry
		end

	store_all
			-- <Precursor>
		local
			l_sessions: like internal_sessions
			l_cursor: DS_ARRAYED_LIST_CURSOR [SESSION_I]
		do
			l_sessions := internal_sessions
			if l_sessions /= Void then
				l_cursor := l_sessions.new_cursor
				from l_cursor.start until l_cursor.after loop
					store (l_cursor.item)
					l_cursor.forth
				end
			end
		ensure then
			sessions_are_clean: internal_sessions /= Void implies internal_sessions.for_all (agent (a_ia_session: SESSION_I): BOOLEAN
				do
					Result := not a_ia_session.is_dirty
				end)
		end

feature -- Retrieval

	retrieve (a_per_project: BOOLEAN): ?SESSION_I
			-- <Precursor>
		do
			Result := retrieve_extended (a_per_project, Void)
		ensure then
			sessions_has_result: Result /= Void implies sessions.has (Result)
			result_consistent: Result /= Void implies Result = retrieve (a_per_project)
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
		end

	retrieve_extended (a_per_project: BOOLEAN; a_extension: ?STRING_8): ?SESSION_I
			-- <Precursor>
		local
			l_cursor: DS_ARRAYED_LIST_CURSOR [SESSION_I]
			l_session: SESSION_I
		do
			l_cursor := sessions.new_cursor
			from l_cursor.start until l_cursor.after loop
				if Result = Void then
						-- We need to use a conditional check because of a memory leak with Gobo data structures.
						-- The cursor has to be run out to avoid the leak.
					l_session := l_cursor.item
					if l_session.is_interface_usable then
						if a_per_project = l_session.is_per_project and not l_session.is_per_window and then equal (l_session.extension_name, a_extension) then
							Result := l_session
						end
					end
				end
				l_cursor.forth
			end

			if Result = Void then
					-- Create a new session
				Result := create_new_session (Void, a_per_project, a_extension)
				if Result /= Void then
					sessions.force_last (Result)
				end
			end
		ensure then
			sessions_has_result: Result /= Void implies sessions.has (Result)
			result_consistent: Result /= Void implies Result = retrieve_extended (a_per_project, a_extension)
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
		end

	retrieve_per_window (a_window: SHELL_WINDOW_I; a_per_project: BOOLEAN): ?SESSION_I
			-- <Precursor>
		do
			Result := retrieve_per_window_extended (a_window, a_per_project, Void)
		ensure then
			sessions_has_result: Result /= Void implies sessions.has (Result)
			result_consistent: Result /= Void implies Result = retrieve_per_window (a_window, a_per_project)
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
		end

	retrieve_per_window_extended (a_window: SHELL_WINDOW_I; a_per_project: BOOLEAN; a_extension: ?STRING_8): ?SESSION_I
			-- <Precursor>
		local
			l_cursor: DS_ARRAYED_LIST_CURSOR [SESSION_I]
			l_session: SESSION_I
		do
			l_cursor := sessions.new_cursor
			from l_cursor.start until l_cursor.after loop
				if Result = Void then
					l_session := l_cursor.item
					if l_session.is_interface_usable then
						if a_per_project = l_session.is_per_project and then l_session.is_per_window and then l_session.window_id = a_window.window_id and then equal (l_session.extension_name, a_extension) then
							Result := l_session
						end
					end
				end
				l_cursor.forth
			end

			if Result = Void then
					-- Create a new session
				Result := create_new_session (a_window, a_per_project, a_extension)
				if Result /= Void then
					sessions.force_last (Result)
				end
			end
		ensure then
			sessions_has_result: Result /= Void implies sessions.has (Result)
			result_consistent: Result /= Void implies Result = retrieve_per_window_extended (a_window, a_per_project, a_extension)
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
		end

	retrieve_from_disk (a_file_name: !STRING_8): ?SESSION_I
			-- <Precursor>
		do
				-- Create a new custom session
			Result := create_new_custom_session (a_file_name)
			if Result /= Void then
				sessions.force_last (Result)
			end
		ensure then
			sessions_has_result: Result /= Void implies sessions.has (Result)
		end

	reload (a_session: SESSION_I)
			-- <Precursor>
		do
			check
				internal_sessions_attached: internal_sessions /= Void
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
			a_session_attached: a_session /= Void
			a_session_is_interface_usable: a_session.is_interface_usable
			project_loaded: not a_session.is_per_project or else (create {SHARED_WORKBENCH}).workbench.system_defined
		local
			l_sed_util: SED_STORABLE_FACILITIES
			l_reader: SED_MEDIUM_READER_WRITER
			l_object: ANY
			l_file: RAW_FILE
			l_logger: SERVICE_CONSUMER [LOGGER_S]
			l_message: !STRING_32
			retried: BOOLEAN
		do
			if not retried then
				create l_sed_util
				create l_file.make (session_file_path (a_session))
				if l_file.exists then
					l_file.open_read

					create l_reader.make (l_file)
					l_reader.set_for_reading

						-- Encode and emit object
					l_object := l_sed_util.retrieved (l_reader, True)
					if l_object /= Void then
						a_session.set_session_object (l_object)
					else
							-- Problem with compatibility, log.
						l_logger := logger_service
						if l_logger.is_service_available then
								-- Log deserialization error.
							create l_message.make_from_string ("Unable to deserialize the session data file: " + l_file.name)
							l_logger.service.put_message_with_severity (l_message, {ENVIRONMENT_CATEGORIES}.internal_event, {PRIORITY_LEVELS}.high)
						end
					end
				end
			end

			if l_file /= Void and then not l_file.is_closed then
				l_file.close
			end
		ensure
			a_session_is_dirty_preserved: old a_session.is_dirty = a_session.is_dirty
		rescue
			retried := True
			retry
		end

feature {NONE} -- Factory

	create_new_session (a_window: ?SHELL_WINDOW_I; a_per_project: BOOLEAN; a_extension: ?STRING_8): ?SESSION_I
			-- Creates a new session object
			--
			-- `a_window': The window to bind the session object to; False to make a session for the entire IDE.
			-- `a_per_project': True to retireve a session for the active project, False otherwise
		require
			is_interface_usable: is_interface_usable
			a_window_is_interface_usable: a_window /= Void implies a_window.is_interface_usable
			not_a_extension_is_empty: a_extension /= Void implies not a_extension.is_empty
		local
			l_inner_session: SESSION_I
			l_shared: SHARED_EIFFEL_PROJECT
			l_set_object: BOOLEAN
			l_load_agents: ACTION_SEQUENCE [TUPLE]
			l_load_agent: PROCEDURE [ANY, TUPLE]
		do
			l_set_object := True

				-- Fetch inner session for aggregation. See {AGGREGATED_SESSION} for details on session aggregation.
			if a_window /= Void then
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
			if l_inner_session /= Void then
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
						l_load_agents.extend_kamikaze (l_load_agent)
						if {l_safe_disposable: SAFE_AUTO_DISPOSABLE} Result then
								-- We have to be sure to remove the load agent on dispose. When a new window is opened
								-- with no project loaded, then the window is closed and then project is opened, the agent
								-- will still be called. We cannot have this.
							l_safe_disposable.perform_auto_dispose (agent (ia_load_agents: ACTION_SEQUENCE [TUPLE]; ia_agent: PROCEDURE [ANY, TUPLE])
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
					Result.set_extension_name (a_extension)
				end
			end

			check result_attached: Result /= Void end

			if l_set_object then
				set_session_object (Result)
			end
			auto_dispose (Result)
		ensure
			result_attached: not a_per_project implies Result /= Void
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
			result_is_clean: Result /= Void implies not Result.is_dirty
			result_is_per_project: Result /= Void implies (a_per_project implies Result.is_per_project)
			result_is_per_window: (Result /= Void and a_window /= Void) implies Result.is_per_window
			result_window_id_set: (Result /= Void and a_window /= Void) implies (Result.window_id = a_window.window_id)
			result_extension_set: Result /= Void implies equal (a_extension, Result.extension_name)
		end

	create_new_custom_session (a_file_name: !STRING_8): ?CUSTOM_SESSION_I
			-- Creates a new session object
			--
			-- `a_file_name': The full path to a file on disk to retrieve session data from.
		require
			is_interface_usable: is_interface_usable
			not_a_file_name_is_empty: not a_file_name.is_empty
		do
			create {CUSTOM_SESSION} Result.make (a_file_name, Current)
			set_session_object (Result)
			auto_dispose (Result)
		ensure
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
			result_is_clean: Result /= Void implies not Result.is_dirty
			result_file_name_set: Result /= Void implies a_file_name.is_equal (Result.file_name)
		end

feature {NONE} -- Constants

	environment_file_name: STRING_8 = "environment{4}.ses"
	window_file_name: STRING_8 = "window_{3}{4}.ses"
	project_file_name: STRING_8 = "{1}.{2}{4}.ses"
	project_window_file_name: STRING_8 = "{1}.{2}.window_{3}{4}.ses"

feature {NONE} -- Internal implementation cache

	internal_sessions: ?like sessions
			-- Cached version of `sessions'
			-- Note: Do not use directly!

	internal_logger_service: SERVICE_CONSUMER [LOGGER_S]
			-- Cached version of `logger_service'
			-- Note: Do not use directly!

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
