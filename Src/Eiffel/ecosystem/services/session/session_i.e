note
	description: "[
		An abstract interface for a collection of managed session data, bound to a IDE/project context.
	]"
	doc: "wiki://Session Manager Service:Sessions and Aggregated Sessions"
	doc: "wiki://Session Manager Service:Retrieving Sessions"
	doc: "wiki://Session Manager Service:Using Sessions"
	doc: "wiki://Session Manager Service:Storing Sessions"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class
	SESSION_I

inherit
	INTERFACE_I

	DISPOSABLE_I

	EVENT_CONNECTION_POINT_I [SESSION_EVENT_OBSERVER, SESSION_I]
		rename
			connection as session_connection
		end

feature -- Access

	kind: UUID
			-- Kind of session. See {SESSION_KINDS} for all representations.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: attached Result
			not_result_is_default: Result /~ create {UUID}
		end

	window_id: NATURAL_32
			-- Window identifier the session is attached to.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

feature {SESSION_MANAGER_S, SESSION_I} -- Access

	extension_name: detachable IMMUTABLE_STRING_32 assign set_extension_name
			-- Optional extension name for specialized categories
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			not_result_is_empty: attached Result implies not Result.is_empty
		end

feature {SESSION_MANAGER_S} -- Access

	session_object: ANY assign set_session_object
			-- Session object, used during serialization of data
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: attached Result
		end

feature -- Element change

	set_value (a_value: detachable ANY; a_id: READABLE_STRING_GENERAL)
			-- Sets a piece of sessions data
			--
			-- `a_value': Data to set in sessions, or Void to remove it.
			-- `a_id': An id to index and store the session data with.
		require
			is_interface_usable: is_interface_usable
			a_id_attached: attached a_id
			not_a_id_is_empty: not a_id.is_empty
			a_value_is_valid_session_value: is_valid_session_value (a_value)
		deferred
		ensure
			value_set: a_value ~ value (a_id)
			is_dirty: (a_value /~ old value (a_id)) implies is_dirty
			session_set_on_session_data: attached {SESSION_DATA_I} a_value as l_session_data implies l_session_data.session = Current
		end

feature {SESSION_MANAGER_S, SESSION_I} -- Element change

	set_extension_name (a_name: like extension_name)
			-- Set session extension name. See `extension_name' for more information.
			--
		require
			is_interface_usable: is_interface_usable
			not_a_name_is_empty: attached a_name implies not a_name.is_empty
		deferred
		ensure
			extension_name_set: equal (a_name, extension_name)
		end

 feature {SESSION_MANAGER_S} -- Element change

	set_session_object (a_object: like session_object)
			-- Set the session object, used during deserialization.
			-- Note: Implementers should remember to fire the change events for the set properties
			--
			-- `a_object': The new session object to set.
		require
			is_interface_usable: is_interface_usable
			a_object_attached: attached a_object
			alternative_a_object: a_object /= session_object
		deferred
		end

feature -- Query

	value alias "[]" (a_id: READABLE_STRING_GENERAL): detachable ANY assign set_value
			-- Retrieve a piece of sessions data, indexed by an ID.
			--
			-- `a_id': An id to retrieve session data for
		require
			is_interface_usable: is_interface_usable
			a_id_attached: attached a_id
			not_a_id_is_empty: not a_id.is_empty
		deferred
		ensure
			result_is_valid_session_value: is_valid_session_value (Result)
		end

	value_or_default (a_id: READABLE_STRING_GENERAL; a_default_value: ANY): ANY
			-- Retrieve a piece of sessions data, indexed by an ID.
			--
			-- `a_id': An id to retrieve session data for
		require
			is_interface_usable: is_interface_usable
			a_id_attached: attached a_id
			not_a_id_is_empty: not a_id.is_empty
		deferred
		ensure
			result_is_valid_session_value: is_valid_session_value (Result)
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

	is_valid_session_value (a_value: detachable ANY): BOOLEAN
			-- Determines if `a_valud' is a valid session value
		require
			is_interface_usable: is_interface_usable
		deferred
		end

	has (a_id: READABLE_STRING_GENERAL): BOOLEAN
			-- Indicates if the session contains an entry for a given id.
			--
			-- `a_id': Session key id to test for.
			-- `Result': True if the session contains an entry; False otherwise.
		require
			a_id_attached: attached a_id
			not_a_id_is_empty: not a_id.is_empty
		deferred
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

feature -- Basic operations

	store
			-- Save session data immediately.
			--|Note: Implementers should check `is_dirty' before commiting to storage.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

feature {SESSION_DATA_I, SESSION_I} -- Basic operations

	notify_value_changed (a_value: SESSION_DATA_I)
			-- Used by complex session data objects to notify the session that an inner value has changed.
			--
			-- `a_value': The changed session data value.
		require
			is_interface_usable: is_interface_usable
			a_value_attached: attached a_value
			a_value_belongs_to_session: a_value.session = Current
		deferred
		ensure
			is_dirty: is_dirty
		end

feature -- Events

	value_changed_event: EVENT_TYPE_I [TUPLE [session: SESSION_I; id: READABLE_STRING_GENERAL]]
			-- Events fired when a value, indexed by an id, in the session object changes.
			--
			-- `session': The session where the change occured.
			-- `id': The session data identifier index that the value changed for
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: attached Result
		end

feature -- Events: Connection point

	session_connection: EVENT_CONNECTION_I [SESSION_EVENT_OBSERVER, SESSION_I]
			-- <Precursor>
		local
			l_result: like internal_session_connection
		do
			l_result := internal_session_connection
			if l_result = Void then
				create {EVENT_CONNECTION [SESSION_EVENT_OBSERVER, SESSION_I]} Result.make (
					agent (ia_observer: SESSION_EVENT_OBSERVER): ARRAY [TUPLE [event: EVENT_TYPE_I [TUPLE]; action: PROCEDURE [ANY, TUPLE]]]
						do
							Result := << [value_changed_event, agent ia_observer.on_session_value_changed] >>
						end)
				automation.auto_dispose (Result)
				internal_session_connection := Result
			else
				Result := l_result
			end
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

feature {NONE} -- Implementation: Internal cache

	internal_session_connection: detachable like session_connection
			-- Cached version of `session_connection'
			-- Note: Do not use directly!

invariant
	window_id_positive: is_per_window implies window_id > 0

;note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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
