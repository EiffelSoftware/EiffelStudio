indexing
	description: "[
		Base interface for all session data object structures
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class
	SESSION_DATA_I

feature -- Access

	frozen session: ?SESSION_I
			-- Session object the current data is part of.
			-- Note: During a storage operation this will be Void!

feature {SESSION_I} -- Element change

	frozen set_session (a_session: like session)
			-- Sets the session for the session data.
			--
			-- `a_session': The session object the session data is a part of
		require
			session_not_set: a_session /= Void implies session = Void
		do
			session := a_session
		ensure
			session_set: session = a_session
		end

feature -- Status report

	frozen is_part_of_session: BOOLEAN
			-- Inidciates if the current data is part of a session object
		do
			Result := session /= Void and then session.is_interface_usable
		ensure
			session_attached: Result implies (session /= Void and then session.is_interface_usable)
		end

feature {NONE} -- Basic operations

	frozen notify_session_of_value_change
			-- Notifies the owner session that the current session data has changed in someway.
		require
			is_part_of_session: is_part_of_session
		do
			if {l_data: !SESSION_DATA_I} Current then
				session.notify_value_changed (l_data)
			end
		ensure
			session_is_dirty: session.is_dirty
		end

feature {SESSION_I} -- Action handlers

	on_begin_store (a_session: !SESSION_I)
			-- Called to notify the session that a store is about to take place.
			--
			-- `a_session': The session object that the session data is part of.
			--              This object is passed because `session' will be detached during
			--              actual storage.
		require
			session_detached: session = Void
		do
		ensure
			session_detached: session = Void
		end

	on_end_store
			-- Called to notify the session that a store is complete.
		require
			session_attached: session /= Void
		do
		ensure
			session_attached: session /= Void
		end

invariant
	session_attached: is_part_of_session implies session /= Void

indexing
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
