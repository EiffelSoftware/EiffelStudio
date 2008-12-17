indexing
	description: "[
		Default implementation for {EVENT_OBSERVER_CONNECTION_I} for interface implementations.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class
	EVENT_OBSERVER_CONNECTION [G -> EVENT_OBSERVER_I]

inherit
	EVENT_OBSERVER_CONNECTION_I [G]

	SAFE_AUTO_DISPOSABLE
		redefine
			safe_dispose
		end

feature {NONE} -- Clean up

	safe_dispose (a_disposing: BOOLEAN)
			-- <Precursor>
		do
			if a_disposing then
				check
						-- If the following is violated then some object did not disconnect the events
					internal_connected_event_observers_is_empty: internal_connected_event_observers /= Void implies internal_connected_event_observers.is_empty
				end

				if internal_connected_event_observers /= Void then
					internal_connected_event_observers.do_all (agent (a_ia_observer: !G)
						do
							disconnect_events (internal_connected_event_observers.item_for_iteration)
						end)
					internal_connected_event_observers.wipe_out
				end
			end
			Precursor {SAFE_AUTO_DISPOSABLE} (a_disposing)
		ensure then
			internal_connected_event_observers_is_empty: old internal_connected_event_observers /= Void implies (old internal_connected_event_observers).is_empty
		end

feature {NONE} -- Access

	frozen connected_event_observers: !DS_ARRAYED_LIST [!G]
			-- Current connections to event observers
		require
			is_interface_usable: is_interface_usable
		do
			if {l_result: DS_ARRAYED_LIST [!G]} internal_connected_event_observers then
				Result := l_result
			else
				create Result.make_default
				internal_connected_event_observers := Result
			end
		ensure
			result_consistent: Result = connected_event_observers
		end

feature -- Query

	frozen is_connected (a_observer: !G): BOOLEAN
			-- <Precursor>
		do
			Result := is_interface_usable and then connected_event_observers.has (a_observer)
		ensure then
			is_interface_usable: Result implies is_interface_usable
			connected_event_observers_has_a_observer: Result implies connected_event_observers.has (a_observer)
		end

feature -- Event connection

	frozen connect_events (a_observer: !G)
			-- <Precursor>
		local
			l_events: !like events
			l_cursor: DS_LIST_CURSOR [!TUPLE [event: !EVENT_TYPE [TUPLE]; action: !PROCEDURE [ANY, TUPLE]]]
			l_event: !TUPLE [event: !EVENT_TYPE [TUPLE]; action: !PROCEDURE [ANY, TUPLE]]
		do
			l_events := events (a_observer)
			if not l_events.is_empty then
				l_cursor := l_events.new_cursor
				from l_cursor.start until l_cursor.after loop
					l_event := l_cursor.item
					l_event.event.subscribe (l_event.action)
					l_cursor.forth
				end
			end
			connected_event_observers.force_last (a_observer)
		ensure then
			connected_event_observers_has_a_observer: connected_event_observers.has (a_observer)
		end

	frozen disconnect_events (a_observer: !G)
			-- <Precursor>
		local
			l_events: !like events
			l_cursor: DS_LIST_CURSOR [!TUPLE [event: !EVENT_TYPE [TUPLE]; action: !PROCEDURE [ANY, TUPLE]]]
			l_event: !TUPLE [event: !EVENT_TYPE [TUPLE]; action: !PROCEDURE [ANY, TUPLE]]
		do
			l_events := events (a_observer)
			if not l_events.is_empty then
				l_cursor := l_events.new_cursor
				from l_cursor.start until l_cursor.after loop
					l_event := l_cursor.item
					l_event.event.unsubscribe (l_event.action)
					l_cursor.forth
				end
			end
			connected_event_observers.start
			connected_event_observers.search_forth (a_observer)
			connected_event_observers.remove_at
		ensure then
			not_connected_event_observers_has_a_observer: not connected_event_observers.has (a_observer)
		end

feature {NONE} -- Internal implementation cache

	internal_connected_event_observers: ?like connected_event_observers
			-- Cached version of `connected_event_observers'
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
