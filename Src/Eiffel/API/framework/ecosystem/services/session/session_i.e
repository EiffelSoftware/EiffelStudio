indexing
	description: "[
		An abstract interface for a collection of managed session data, bound to a IDE/project context.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class
	SESSION_I

inherit
	USABLE_I

	EVENT_OBSERVER_CONNECTION_I [!SESSION_EVENT_OBSERVER]

feature -- Access

	kind: UUID
			-- Kind of session. See {SESSION_KINDS} for all representations.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_default: not Result.is_equal (create {UUID})
		end

	window_id: NATURAL_32
			-- Window identifier the session is attached to.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

feature {SESSION_MANAGER_S} -- Access

	session_object: ANY assign set_session_object
			-- Session object, used during serialization of data
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
		end

feature {SESSION_MANAGER_S} -- Element change

	set_session_object (a_object: like session_object)
			-- Set the session object, used during deserialization.
			-- Note: Implementers should remember to fire the change events for the set properties
			--
			-- `a_object': The new session object to set.
		require
			is_interface_usable: is_interface_usable
			a_object_attached: a_object /= Void
			alternative_a_object: a_object /= session_object
		deferred
		end

feature -- Query

	value (a_id: STRING_8): ANY assign set_value
			-- Retrieve a piece of sessions data, indexed by an ID.
			--
			-- `a_id': An id to retrieve session data for
		require
			is_interface_usable: is_interface_usable
			a_id_attached: a_id /= Void
			not_a_id_is_empty: not a_id.is_empty
		deferred
		ensure
			result_is_valid_session_value: is_valid_session_value (Result)
		end

	value_or_default (a_id: STRING_8; a_default_value: ANY): ANY
			-- Retrieve a piece of sessions data, indexed by an ID.
			--
			-- `a_id': An id to retrieve session data for
		require
			is_interface_usable: is_interface_usable
			a_id_attached: a_id /= Void
			not_a_id_is_empty: not a_id.is_empty
		deferred
		ensure
			result_is_valid_session_value: is_valid_session_value (Result)
		end

	is_valid_session_value (a_value: ANY): BOOLEAN
			-- Determines if `a_valud' is a valid session value
		require
			is_interface_usable: is_interface_usable
		deferred
		end

feature {NONE} -- Query

	events (a_observer: !SESSION_EVENT_OBSERVER): DS_ARRAYED_LIST [TUPLE [event: EVENT_TYPE [TUPLE]; action: PROCEDURE [ANY, TUPLE]]] is
			-- List of events and associated action.
			--
			-- `a_observer': Event observer interface to bind agent actions to.
			-- `Result': A list of event types paired with a associated action on the passed observer
		do
			create Result.make (1)
			Result.put_last ([value_changed_event, agent a_observer.on_session_value_changed])
		end

feature -- Element change

	set_value (a_value: ANY; a_id: STRING_8)
			-- Sets a piece of sessions data
			--
			-- `a_value': Data to set in sessions, or Void to remove it.
			-- `a_id': An id to index and store the session data with.
		require
			is_interface_usable: is_interface_usable
			a_id_attached: a_id /= Void
			not_a_id_is_empty: not a_id.is_empty
			a_value_is_valid_session_value: is_valid_session_value (a_value)
		deferred
		ensure
			value_set: equal (a_value, value (a_id))
			is_dirty: not equal (a_value, old value (a_id)) implies is_dirty
			session_set_on_session_data: {l_session_data: !SESSION_DATA_I} a_value and then (({SESSION_DATA_I}) #? a_value).session = Current
		end

feature -- Status report

	is_dirty: BOOLEAN
			-- Indicates if the session has modifications
		require
			is_interface_usable: is_interface_usable
		deferred
		end

	is_per_project: BOOLEAN
			-- Indicates if the session is a per-project session object
		require
			is_interface_usable: is_interface_usable
		deferred
		end

	is_per_window: BOOLEAN
			-- Indicates if the session is a per-window session object
		require
			is_interface_usable: is_interface_usable
		do
			Result := window_id > 0
		end

feature {SESSION_MANAGER_S} -- Status setting

	reset_is_dirty
			-- Resets dirty state of session
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			not_is_dirty: not is_dirty
		end

feature {SESSION_DATA_I, SESSION_I} -- Basic operations

	notify_value_changed (a_value: !SESSION_DATA_I)
			-- Used by complex session data objects to notify the session that an inner value has changed.
			--
			-- `a_value': The changed session data value.
		require
			is_interface_usable: is_interface_usable
			a_value_belongs_to_session: a_value.session = Current
		deferred
		ensure
			is_dirty: is_dirty
		end

feature -- Events

	value_changed_event: EVENT_TYPE [TUPLE [session: SESSION_I; id: STRING_8]]
			-- Events fired when a value, indexed by an id, in the session object changes.
			--
			-- `session': The session where the change occured.
			-- `id': The session data identifier index that the value changed for
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
		end

feature {SESSION_MANAGER_S} -- Action Handlers

	on_begin_store
			-- Called to notify the session that a store is about to take place.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

	on_end_store
			-- Called to notify the session that a store is complete.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

invariant
	window_id_positive: is_per_window implies window_id > 0
	session_object_attached: session_object /= Void

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
