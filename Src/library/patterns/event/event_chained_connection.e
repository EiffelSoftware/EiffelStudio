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
			make as make_connection
		redefine
			is_interface_usable,
			is_valid_connection,
			connect_events,
			disconnect_events
		end

create
	make

feature {NONE} -- Initialization

	make (a_agent: like observer_event_action_map_fetch_action; a_link: like linked_connection)
			-- Initializes a connection using a event-action connection map.
			--
			-- `a_map': A set of event to observer action mappings to use with the connection.
			-- `a_link': The parent chain link, containing parent events.
		require
			a_link_is_interface_usable: a_link.is_interface_usable
		do
			linked_connection := a_link
			make_connection (a_agent)
		ensure
			observer_event_action_map_fetch_action_set: observer_event_action_map_fetch_action ~ a_agent
			linked_connection_set: linked_connection ~ a_link
		end

feature {NONE} -- Access

	linked_connection: EVENT_CONNECTION_I [LINKG, LINKI]
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

	is_valid_connection (a_observer: EVENT_OBSERVER_I): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor (a_observer) and then linked_connection.is_valid_connection (a_observer)
		ensure then
			linked_connection_is_valid_connection: Result implies
				(linked_connection.is_interface_usable and then linked_connection.is_valid_connection (a_observer))
		end

feature -- Event connection

	connect_events (a_observer: G)
			-- <Precursor>
		local
			l_link: like linked_connection
		do
			l_link := linked_connection
			if
				attached {LINKG} a_observer as l_observer and then
				l_link.is_interface_usable and then
				l_link.is_valid_connection (l_observer)
			then
				l_link.connect_events (l_observer)
			else
				check False end
			end
			Precursor (a_observer)
		ensure then
			link_connected:
				attached {LINKG} a_observer as l_observer implies linked_connection.is_connected (l_observer)
		end

	disconnect_events (a_observer: G)
			-- <Precursor>
		local
			l_link: like linked_connection
		do
			l_link := linked_connection
			if attached {LINKG} a_observer as l_observer and then l_link.is_connected (l_observer) then
				l_link.disconnect_events (l_observer)
			else
				check False end
			end
			Precursor (a_observer)
		ensure then
--			link_disconnected:
--				old (attached {LINKG} a_observer as l_old_observer implies linked_connection.is_connected (l_old_observer)) implies
--				(attached {LINKG} a_observer as l_observer and then linked_connection.is_connected (l_observer))
		end

invariant
	linked_connection_attached: linked_connection /= Void

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
