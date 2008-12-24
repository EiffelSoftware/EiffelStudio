indexing
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

	DISPOSABLE_SAFE

create
	make,
	make_from_array

feature {NONE} -- Initialization

	make (a_map: like events_action_map)
			-- Initializes a connection using a event-action connection map.
			--
			-- `a_map': A set of event to observer action mappings to use with the connection.
		do
			events_action_map := a_map.twin
		ensure
			events_action_map_set: events_action_map ~ a_map
		end

	make_from_array (a_array: !ARRAY [!TUPLE [event: !EVENT_TYPE [TUPLE]; action: !PROCEDURE [G, TUPLE]]])
			-- Initializes a connection using a array of event-action connections.
			--
			-- `a_array': An array of event to observer action mappings to use with the connection.
		require
			not_a_array_is_empty: not a_array.is_empty
			a_array_contains_unique_items: {l_array: ARRAY [!ANY]} a_array and then
				l_array.for_all (agent (ia_item: !ANY; ia_array: !ARRAY [!ANY]): BOOLEAN
					do
						Result := ia_array.occurrences (ia_item) = 1
					end (?, a_array))
		local
			l_map: like events_action_map
			i, l_upper: INTEGER
		do
			create events_action_map.make_default
			from
				l_map := events_action_map
				i := a_array.lower
				l_upper := a_array.upper
			until
				i > l_upper
			loop
				l_map.force_last (a_array [i])
				i := i + 1
			end
		end

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		local
			l_connections: like internal_connections
			l_connection: ?G
		do
			if a_explicit then
				l_connections := internal_connections
				if l_connections /= Void then
						-- If the following is violated then some object did not disconnect the events
					check l_connections_is_empty: l_connections.is_empty end
					l_connections := l_connections.twin
					from l_connections.start until l_connections.after loop
						l_connection := l_connections.item_for_iteration
						check l_connection_attached: l_connection /= Void end
						disconnect_events (l_connection)
						l_connections.forth
					end
					internal_connections.wipe_out
				end
			end
		ensure then
			internal_connections_is_empty: {connections_e1: like internal_connections} old internal_connections implies connections_e1.is_empty
		end

feature {NONE} -- Access

	frozen events_action_map: !DS_HASH_SET [!TUPLE [event: !EVENT_TYPE [TUPLE]; action: !PROCEDURE [G, TUPLE]]]
			-- A set of events mapped to an associated observer action.
--		attribute
--			create Result.make_default
--		end

	frozen connections: !DS_ARRAYED_LIST [?G]
			-- Current connections to event connections.
		require
			is_interface_usable: is_interface_usable
		local
			l_result: like internal_connections
		do
			l_result := internal_connections
			if l_result = Void then
				create Result.make (1)
				internal_connections := Result
			else
				Result := l_result
			end
		ensure
			result_consistent: Result ~ connections
		end

feature -- Status report

	frozen is_connected (a_observer: !G): BOOLEAN
			-- <Precursor>
		local
			l_connections: like internal_connections
		do
			Result := is_interface_usable
			if Result then
				l_connections := internal_connections
				if l_connections /= Void then
					Result := l_connections.has (a_observer)
				else
					Result := False
				end
			end
		ensure then
			connections_has_a_observer: Result implies connections.has (a_observer)
		end

feature -- Event connection

	connect_events (a_observer: !G)
			-- <Precursor>
		local
			l_events: like events_action_map
			l_event: ?TUPLE [event: !EVENT_TYPE [TUPLE]; action: !PROCEDURE [G, TUPLE]]
			l_cursor: ?DS_HASH_SET_CURSOR [!TUPLE [event: !EVENT_TYPE [TUPLE]; action: !PROCEDURE [G, TUPLE]]]
			l_action: !PROCEDURE [G, TUPLE]
		do
				-- Subscribe to events on the observer.
			l_events := events_action_map
			if not l_events.is_empty then
					-- Subscribe to all events
				l_cursor := l_events.new_cursor
				check l_cursor_attached: l_cursor /= Void end
				from l_cursor.start until l_cursor.after loop
					l_event := l_cursor.item
					if l_event /= Void then
						l_action := l_event.action.deep_twin
						check l_action_is_target_closed: l_action.is_target_closed end
						l_action.set_target (a_observer)
						l_event.event.subscribe (l_action)
					end
					l_cursor.forth
				end
				check l_cursor_after: l_cursor.after end
			end

				-- Add the connection to the list of managed connections.
			connections.force_last (a_observer)
		ensure then
			connections_has_a_observer: connections.has (a_observer)
		end

	disconnect_events (a_observer: !G)
			-- <Precursor>
		local
			l_events: like events_action_map
			l_cursor: ?DS_HASH_SET_CURSOR [!TUPLE [event: !EVENT_TYPE [TUPLE]; action: !PROCEDURE [G, TUPLE]]]
			l_connections: like connections
			l_connection: ?TUPLE [event: !EVENT_TYPE [TUPLE]; action: !PROCEDURE [G, TUPLE]]
			l_event: !EVENT_TYPE [TUPLE]
			l_action: !PROCEDURE [G, TUPLE]
			l_old_target: ANY
		do
				-- Remove the connection from the list of managed connections
			l_connections := connections
			l_connections.start
			l_connections.search_forth (a_observer)
			check not_l_connections_after: not l_connections.after end
			if not l_connections.after then
					-- Unsubscribe to events on the observer.
				l_events := events_action_map
				if not l_events.is_empty then
					l_cursor := l_events.new_cursor
					from l_cursor.start until l_cursor.after loop
						l_connection := l_cursor.item
						if l_connection /= Void then
							l_event := l_connection.event
							l_action := l_connection.action
								-- Store the target and replace when the action has been unsubscribed
							l_old_target := l_action.target
							l_action.set_target (a_observer)
							if l_event.is_subscribed (l_action) then
								l_event.unsubscribe (l_action)
							end
								-- Restore the old target
							l_action.set_target (l_old_target)
						end
						l_cursor.forth
					end
				end
				l_connections.remove_at
			end
		ensure then
			not_connections_has_a_observer: not connections.has (a_observer)
		end

feature {NONE} -- Internal implementation cache

	internal_connections: ?like connections
			-- Cached version of `connections'
			-- Note: Do not use directly!

;note
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
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
