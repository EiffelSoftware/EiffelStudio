note
	description: "[
			A specialized {EVENT_CONNECTION} for use with merging/chaining a parent connection.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EVENT_CHAINED_CONNECTION [G -> LINKG, I -> LINKI, LINKG -> EVENT_OBSERVER_I, LINKI -> USABLE_I]

inherit
	EVENT_CONNECTION [G, I]
		rename
			make as make_connection,
			make_from_array as make_connection_from_array
		redefine
			is_interface_usable,
			is_valid_connection,
			connect_events,
			disconnect_events
		end

create
	make,
	make_from_array

feature {NONE} -- Initialization

	make (a_map: like events_action_map; a_link: like linked_connection)
			-- Initializes a connection using a event-action connection map.
			--
			-- `a_map': A set of event to observer action mappings to use with the connection.
			-- `a_link': The parent chain link, containing parent events.
		require
			a_link_is_interface_usable: a_link.is_interface_usable
		do
			events_action_map := a_map
			linked_connection := a_link
		ensure
			events_action_map_set: events_action_map ~ a_map
			linked_connection_set: linked_connection ~ a_link
		end

	make_from_array (a_array: !ARRAY [!TUPLE [event: !EVENT_TYPE [TUPLE]; action: !PROCEDURE [G, TUPLE]]]; a_link: like linked_connection)
			-- Initializes a connection using a array of event-action connections.
			--
			-- `a_array': An array of event to observer action mappings to use with the connection.
			-- `a_link': The parent chain link, containing parent events.
		require
			not_a_array_is_empty: not a_array.is_empty
			a_array_contains_unique_items: {l_array: ARRAY [!ANY]} a_array and then
				l_array.for_all (agent (ia_item: !ANY; ia_array: !ARRAY [!ANY]): BOOLEAN
					do
						Result := ia_array.occurrences (ia_item) = 1
					end (?, a_array))
			a_link_is_interface_usable: a_link.is_interface_usable
		local
			l_map: like events_action_map
			i, l_upper: INTEGER
		do
			create l_map.make_default
			from
				i := a_array.lower
				l_upper := a_array.upper
			until
				i > l_upper
			loop
				l_map.force_last (a_array [i])
				i := i + 1
			end
			make (l_map, a_link)
		end

feature {NONE} -- Access

	linked_connection: !EVENT_CONNECTION_I [LINKG, LINKI]
			-- Parent connection

feature -- Status report

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := Precursor
			if Result then
				Result := linked_connection.is_interface_usable
			end
		end

	is_valid_connection (a_observer: !EVENT_OBSERVER_I): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor (a_observer) and then linked_connection.is_valid_connection (a_observer)
		ensure then
			linked_connection_is_valid_connection:
				Result implies
				(linked_connection.is_interface_usable and then linked_connection.is_valid_connection (a_observer))
		end

feature -- Event connection

	connect_events (a_observer: !G)
			-- <Precursor>
		local
			l_link: like linked_connection
		do
			l_link := linked_connection
			if {l_observer: LINKG} a_observer and then l_link.is_interface_usable and then l_link.is_valid_connection (l_observer) then
				l_link.connect_events (l_observer)
			else
				check False end
			end
			Precursor (a_observer)
		ensure then
			link_connected:
				{el_observer: LINKG} a_observer implies
				linked_connection.is_connected (el_observer)
		end

	disconnect_events (a_observer: !G)
			-- <Precursor>
		local
			l_link: like linked_connection
		do
			l_link := linked_connection
			if {l_observer: LINKG} a_observer and then l_link.is_connected (l_observer) then
				l_link.disconnect_events (l_observer)
			else
				check False end
			end
			Precursor (a_observer)
		ensure then
			link_disconnected:
				{el_observer: LINKG} a_observer implies
				(old linked_connection.is_connected (el_observer) implies not linked_connection.is_connected (el_observer))
		end

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
