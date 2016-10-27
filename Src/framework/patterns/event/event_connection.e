note
	description: "[
		Default implementation for {EVENT_OBSERVER_CONNECTION_I} for interface implementations.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	EVENT_CONNECTION [G -> EVENT_OBSERVER_I, I -> USABLE_I]

inherit
	EVENT_CONNECTION_I [G, I]

	DISPOSABLE_I

	DISPOSABLE_SAFE

create
	make

feature {NONE} -- Initialization

	make (a_agent: like observer_event_action_map_fetch_action)
			-- Initializes a connection using a event-action connection map function.
			--
			-- `a_agent': An agent to call to retrieve an observer's event-action map.
		do
			observer_event_action_map_fetch_action := a_agent
		ensure
			observer_event_action_map_fetch_action_set: observer_event_action_map_fetch_action ~ a_agent
		end

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		local
			l_connection_copy: like internal_connections
		do
			if a_explicit then
				if attached internal_connections as l_connections then
						-- If the following is violated then some object did not disconnect the events
					check l_connections_is_empty: l_connections.is_empty end
					l_connection_copy := l_connections.twin
					from l_connection_copy.start until l_connection_copy.after loop
						if attached l_connection_copy.item_for_iteration as l_connection then
							disconnect_events (l_connection)
						end
						l_connection_copy.forth
					end
					l_connections.wipe_out
				end
			end
		ensure then
			internal_connections_is_empty:
				attached old internal_connections as l_connections implies l_connections.is_empty
		end

feature {NONE} -- Access

	frozen connections: ARRAYED_LIST [G]
			-- Current connections to event connections.
		require
			is_interface_usable: is_interface_usable
		do
			if attached internal_connections as l_result then
				Result := l_result
			else
				create Result.make (1)
				internal_connections := Result
			end
		ensure
			result_attached: Result /= Void
			result_consistent: Result = connections
		end

	frozen observer_event_action_map_fetch_action: FUNCTION [TUPLE [observer: G], ARRAY [TUPLE [event: EVENT_TYPE_I [TUPLE]; action: PROCEDURE]]]
			-- A very confusing looking agent to retrieve an array of tuples, containing an event type and event handler routine on an observer {G}.
			-- The function should be implemented on the interface {I}.

feature -- Status report

	frozen is_connected (a_observer: G): BOOLEAN
			-- <Precursor>
		do
			if
				is_interface_usable and then
				attached internal_connections as l_connections
			then
				Result := l_connections.has (a_observer)
			end
		ensure then
			connections_has_a_observer: Result implies connections.has (a_observer)
		end

feature -- Event connection

	connect_events (a_observer: G)
			-- <Precursor>
		local
			l_event_maps: ARRAY [TUPLE [event: EVENT_TYPE_I [TUPLE]; action: PROCEDURE]]
			l_event_map: TUPLE [event: EVENT_TYPE_I [TUPLE]; action: PROCEDURE]
			l_upper, i: INTEGER
		do
				-- Subscribe to events on the observer.
			l_event_maps := observer_event_action_map_fetch_action.item ([a_observer])
			check l_event_maps_attached: attached l_event_maps end
			if not l_event_maps.is_empty then
				from
					i := l_event_maps.lower
					l_upper := l_event_maps.upper
				until
					i > l_upper
				loop
					l_event_map := l_event_maps[i]
					if attached l_event_map then
						l_event_map.event.subscribe (l_event_map.action)
					end
					i := i + 1
				end
			end

				-- Add the connection to the list of managed connections.
			connections.extend (a_observer)
		ensure then
			connections_has_a_observer: connections.has (a_observer)
		end

	disconnect_events (a_observer: G)
			-- <Precursor>
		local
			l_connections: like connections
			l_action: PROCEDURE
			l_event: EVENT_TYPE_I [TUPLE]
			l_upper, i: INTEGER
		do
				-- Remove the connection from the list of managed connections
			l_connections := connections
			l_connections.start
			l_connections.search (a_observer)
			check not_l_connections_after: not l_connections.after end
			if not l_connections.after then
					-- Unsubscribe to events on the observer.
				if (attached observer_event_action_map_fetch_action.item ([a_observer]) as l_maps) and then not l_maps.is_empty then
					from
						i := l_maps.lower
						l_upper := l_maps.upper
					until
						i > l_upper
					loop
						if attached l_maps[i] as l_map then
							l_action := l_map.action
							l_event := l_map.event
							if l_event.is_subscribed (l_action) then
								l_event.unsubscribe (l_action)
							end
						end
						i := i + 1
					end
				end
					-- Remove the connection.
				l_connections.remove
			end
		ensure then
			not_connections_has_a_observer: not connections.has (a_observer)
		end

feature {NONE} -- Internal implementation cache

	internal_connections: detachable like connections
			-- Cached version of `connections'
			-- Note: Do not use directly!

invariant
	observer_event_action_map_fetch_action_attached: attached observer_event_action_map_fetch_action

;note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
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
