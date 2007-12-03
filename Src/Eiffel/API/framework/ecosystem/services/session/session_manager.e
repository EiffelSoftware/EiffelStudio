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

inherit {NONE}
	EIFFEL_LAYOUT

create
	default_create

feature {NONE} -- Clean up

	safe_dispose (a_disposing: BOOLEAN) is
			-- Action to be executed just before garbage collection
			-- reclaims an object.
			--
			-- `a_disposing': True if Current is being explictly disposed of, False to indicate finalization.
		local
			l_sessions: like internal_sessions
		do
				-- Store all unsaved session data
			store_all
			l_sessions := internal_sessions
			if l_sessions /= Void then
					-- Clean up sessions
				l_sessions.do_all (agent (a_ia_session: SESSION_I)
					local
						l_disposable: DISPOSABLE
					do
						l_disposable ?= a_ia_session
						if l_disposable /= Void then
							l_disposable.dispose
						end
					end)
			end
			Precursor {SAFE_AUTO_DISPOSABLE} (a_disposing)
		end

feature {NONE} -- Access

	sessions: DS_ARRAYED_LIST [SESSION_I]
			-- List of retrieve sessions
		require
			is_interface_usable: is_interface_usable
		do
			Result := internal_sessions
			if Result = Void then
				create Result.make_default
				internal_sessions := Result
			end
		ensure
			result_attached: Result /= Void
			result_consistent: Result = sessions
		end

feature {NONE} -- Query

	session_file_path (a_session: SESSION_I): STRING_32 is
			-- Retrieve a session's persisted file path
			--
			-- `a_session': A session to retrive a file path for
			-- `Result': Path to a session file, which may or may not exist yet.
		require
			is_interface_usable: is_interface_usable
		local
			l_formatter: STRING_FORMATTER
			l_kinds: SESSION_KINDS
			l_kind: UUID
			l_fn: STRING_8
			l_path: FILE_NAME
			l_ver: STRING_8
			l_workbench: WORKBENCH_I
			l_project_opened: BOOLEAN
		do
			create l_formatter
			create l_kinds

			l_workbench := (create {SHARED_WORKBENCH}).workbench
			l_project_opened := l_workbench.project_location.is_path_writable
			l_ver := eiffel_layout.major_version.out + eiffel_layout.minor_version.out

				-- Determine session type
			l_kind := a_session.kind
			if l_kind.is_equal (l_kinds.environment) then
				l_fn := environment_file_name
			elseif l_kind.is_equal (l_kinds.window) then
				l_fn := window_file_name
			elseif l_kind.is_equal (l_kinds.project) then
				if l_project_opened then
					l_fn := project_file_name
				else
						-- Fall back to environment
					l_fn := environment_file_name
				end
			elseif l_kind.is_equal (l_kinds.project_window) then
				if l_project_opened then
					l_fn := project_window_file_name
				else
						-- Fall back to window
					l_fn := window_file_name
				end
			else
					-- Unknown session kind
				check False end
			end

			check
				l_fn_attached: l_fn /= Void
				not_l_fn_is_empty: not l_fn.is_empty
			end

				-- Format path using collected parts
			l_fn := l_formatter.format (l_fn, [l_ver])

				-- Create full path
			create l_path.make_from_string (eiffel_layout.eiffel_home.out)
			l_path.set_file_name (l_fn)
			Result := l_path.out
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature -- Storage

	store (a_session: SESSION_I) is
			-- Stores a particular session.
			--
			-- `a_session': Session to store.
		local
			l_sed_util: SED_STORABLE_FACILITIES
			l_writer: SED_MEDIUM_READER_WRITER
			l_file: RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
				if a_session.is_dirty then
					create l_sed_util
					create l_file.make_open_write (session_file_path (a_session))
					create l_writer.make (l_file)
					l_writer.set_for_writing

						-- Encode and emit object
					l_sed_util.independent_store (a_session.session_object, l_writer, False)
					l_file.flush

						-- Reset direty state
					a_session.reset_is_dirty
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
			-- Stores all sessions
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

	retrieve (a_per_project: BOOLEAN): SESSION_I
			-- Retrieve's a sessions based on a session type id
			--
			-- `a_per_project': True to retireve a session for the active project, False otherwise
			--                  Note: If no project is loaded then no sessions can be retrieved and the Result will be Void.
		local
			l_cursor: DS_ARRAYED_LIST_CURSOR [SESSION_I]
			l_session: SESSION_I
		do
			l_cursor := sessions.new_cursor
			from l_cursor.start until l_cursor.after or Result /= Void loop
				l_session := l_cursor.item
				if l_session.is_interface_usable then
					if a_per_project = l_session.is_per_project and not l_session.is_per_window then
						Result := l_session
					end
				end
				if Result = Void then
					l_cursor.forth
				end
			end

			if Result = Void then
					-- Create a new session
				Result := create_new_session (Void, a_per_project)
				if Result /= Void then
					sessions.force_last (Result)
				end
			end
		ensure then
			sessions_has_result: Result /= Void implies sessions.has (Result)
			result_consistent: Result /= Void implies Result = retrieve (a_per_project)
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
		end

	retrieve_per_window (a_window: EB_DEVELOPMENT_WINDOW; a_per_project: BOOLEAN): SESSION_I is
			-- Retrieve's a sessions based on a session type id
			--
			-- `a_window': The window to retrieve a window-based session for.
			-- `a_per_project': True to retireve a session for the active project, False otherwise
			--                  Note: If no project is loaded then no sessions can be retrieved and the Result will be Void.
		local
			l_cursor: DS_ARRAYED_LIST_CURSOR [SESSION_I]
			l_session: SESSION_I
		do
			l_cursor := sessions.new_cursor
			from l_cursor.start until l_cursor.after or Result /= Void loop
				l_session := l_cursor.item
				if l_session.is_interface_usable then
					if a_per_project = l_session.is_per_project and then l_session.is_per_window and then l_session.window_id = a_window.window_id then
						Result := l_session
					end
				end
				if Result = Void then
					l_cursor.forth
				end
			end

			if Result = Void then
					-- Create a new session
				Result := create_new_session (a_window, a_per_project)
				if Result /= Void then
					sessions.force_last (Result)
				end
			end
		ensure then
			sessions_has_result: Result /= Void implies sessions.has (Result)
			result_consistent: Result /= Void implies Result = retrieve_per_window (a_window, a_per_project)
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
		end

	reload (a_session: SESSION_I) is
			-- Reload a session and resets any changed session data.
			--
			-- `a_session': The session to reload session data for.
		do
			check
				internal_sessions_attached: internal_sessions /= Void
				internal_sessions_has_a_session: internal_sessions.has (a_session)
			end
			set_session_object (a_session)
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
		local
			l_sed_util: SED_STORABLE_FACILITIES
			l_reader: SED_MEDIUM_READER_WRITER
			l_object: ANY
			l_file: RAW_FILE
			l_is_dirty: BOOLEAN
			retried: BOOLEAN
		do
			if not retried then
				l_is_dirty := a_session.is_dirty

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
					end

					if not l_is_dirty then
							-- Reset direty state
						a_session.reset_is_dirty
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

	create_new_session (a_window: EB_DEVELOPMENT_WINDOW; a_per_project: BOOLEAN): SESSION_I is
			-- Creates a new session object
			--
			-- `a_window': The window to bind the session object to; False to make a session for the entire IDE.
			-- `a_per_project': True to retireve a session for the active project, False otherwise
		require
			not_a_window_is_recycled: a_window /= Void implies not a_window.is_recycled
		local
			l_inner_session: SESSION_I
		do
				-- Fetch inner session for aggregation. See {AGGREGATED_SESSION} for details on session aggregation.
			if a_window /= Void then
					-- Retrieve higher level session for aggregation
				if a_per_project then
					l_inner_session := retrieve_per_window (a_window, False)
				else
					l_inner_session := retrieve (False)
				end
			elseif a_per_project then
				l_inner_session := retrieve (False)
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
			else
					-- Project based session are always aggregated
				check not_a_per_project: not a_per_project end

				if a_window = Void then
					create {SESSION} Result.make (False, Current)
				else
					create {SESSION} Result.make_per_window (False, a_window, Current)
				end
			end

			check result_attached: Result /= Void end

			set_session_object (Result)
			auto_dispose (Result)
		ensure
			result_attached: not a_per_project implies Result /= Void
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
			result_is_clean: Result /= Void implies not Result.is_dirty
		end

feature {NONE} -- Constants

	environment_file_name: STRING_8 = ".environment{1}"
	window_file_name: STRING_8 = ".window{1}"
	project_file_name: STRING_8 = ".project{1}"
	project_window_file_name: STRING_8 = ".window{1}"

feature {NONE} -- Internal implementation cache

	internal_sessions: like sessions
			-- Cached version of `sessions'
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
