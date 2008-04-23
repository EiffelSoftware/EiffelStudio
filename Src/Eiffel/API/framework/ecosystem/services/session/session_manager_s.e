indexing
	description: "[
		Abstract interface for a session persistance manager, for retrieving an storing sessions from a user's home profile.
	]"
	doc: "wiki://Session Manager Service"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class
	SESSION_MANAGER_S

inherit
	SERVICE_I

	USABLE_I

feature -- Access

	active_sessions: !DS_ARRAYED_LIST [SESSION_I]
			-- List of currently active sessions.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_has_attached_items: not Result.has (Void)
		end

feature -- Storage

	store (a_session: SESSION_I)
			-- Stores a particual session.
			--
			-- `a_session': Session to store.
		require
			is_interface_usable: is_interface_usable
			a_session_attached: a_session /= Void
			a_session_is_interface_usable: a_session.is_interface_usable
		deferred
		ensure
			a_session_is_clean: not a_session.is_dirty
		end

	store_all
			-- Stores all sessions
		require
			is_interface_usable: is_interface_usable
		deferred
		end

feature -- Retrieval

	retrieve (a_per_project: BOOLEAN): ?SESSION_I
			-- Retrieve's a session based on specified paramaters.
			--
			-- `a_per_project': True to retireve a session for the active project, False otherwise
			--                  Note: If no project is loaded then no sessions can be retrieved and the Result will be Void.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: not a_per_project implies Result /= Void
			result_is_per_project: Result /= Void implies (a_per_project implies Result.is_per_project)
			not_result_is_per_window: Result /= Void implies (not Result.is_per_window)
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
		end

	retrieve_extended (a_per_project: BOOLEAN; a_extension: ?STRING_8): ?SESSION_I
			-- Retrieve's a session based on specified paramaters, using a extension name for non-global conflicting session objects.
			--
			-- `a_per_project': True to retireve a session for the active project, False otherwise
			--                  Note: If no project is loaded then no sessions can be retrieved and the Result will be Void.
			-- `a_extension': An optional session extension name used to "localize" a session from a global session. Passing
			--                Void will retrieve the global version of a session.
		require
			is_interface_usable: is_interface_usable
			not_a_extension_is_empty: a_extension /= Void implies not a_extension.is_empty
		deferred
		ensure
			result_attached: not a_per_project implies Result /= Void
			result_is_per_project: Result /= Void implies (a_per_project implies Result.is_per_project)
			not_result_is_per_window: Result /= Void implies (not Result.is_per_window)
			result_extension_set: Result /= Void implies equal (a_extension, Result.extension_name)
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
		end

	retrieve_per_window (a_window: EB_DEVELOPMENT_WINDOW; a_per_project: BOOLEAN): ?SESSION_I
			-- Retrieve's a window session based on specified paramaters.
			--
			-- `a_window': The window to retrieve a window-based session for.
			-- `a_per_project': True to retireve a session for the active project, False otherwise
			--                  Note: If no project is loaded then no sessions can be retrieved and the Result will be Void.
		require
			is_interface_usable: is_interface_usable
			a_window_attached: a_window /= Void
			not_a_window_is_recycled: not a_window.is_recycled
		deferred
		ensure
			result_attached: not a_per_project implies Result /= Void
			result_is_per_project: Result /= Void implies (a_per_project implies Result.is_per_project)
			result_is_per_window: Result /= Void implies Result.is_per_window
			result_window_id_set: Result /= Void implies (Result.window_id = a_window.window_id)
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
		end

	retrieve_per_window_extended (a_window: EB_DEVELOPMENT_WINDOW; a_per_project: BOOLEAN; a_extension: ?STRING_8): ?SESSION_I
			-- Retrieve's a window session based on specified paramaters, using a extension name for non-global conflicting session objects.
			--
			-- `a_window': The window to retrieve a window-based session for.
			-- `a_per_project': True to retireve a session for the active project, False otherwise
			--                  Note: If no project is loaded then no sessions can be retrieved and the Result will be Void.
			-- `a_extension': An optional session extension name used to "localize" a session from a global session. Passing
			--                Void will retrieve the global version of a session.
		require
			is_interface_usable: is_interface_usable
			a_window_attached: a_window /= Void
			not_a_window_is_recycled: not a_window.is_recycled
		deferred
		ensure
			result_attached: not a_per_project implies Result /= Void
			result_is_per_project: Result /= Void implies (a_per_project implies Result.is_per_project)
			result_is_per_window: Result /= Void implies Result.is_per_window
			result_window_id_set: Result /= Void implies (Result.window_id = a_window.window_id)
			result_extension_set: Result /= Void implies equal (a_extension, Result.extension_name)
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
		end

	retrieve_from_disk (a_file_name: STRING_8): ?SESSION_I
			-- Retrieves a session object from disk, if it exists.
			-- If no file exists then a new session is created.
			--
			-- `a_file_name': The full path to a file on disk to retrieve session data from.
		require
			is_interface_usable: is_interface_usable
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		deferred
		ensure
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
		end

	reload (a_session: SESSION_I)
			-- Reload a session and resets any changed session data
			--
			-- `a_session': The session to reload
		require
			is_interface_usable: is_interface_usable
			a_session_attached: a_session /= Void
			a_session_is_interface_usable: a_session.is_interface_usable
		deferred
		ensure
			a_session_is_clean: not a_session.is_dirty
		end

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
