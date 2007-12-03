indexing
	description: "[
		Base interface for connecting observers to an interface, to be notified when an event is published on the inheriting interface.
		
		The default implementation is {EVENT_OBSERVER_CONNECTION}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class
	EVENT_OBSERVER_CONNECTION_I [G -> !EVENT_OBSERVER_I]

inherit
	USEABLE_I

feature -- Event connection

	connect_events (a_observer: G)
			-- Connects event handler interface to Current.
			--
			-- `a_observer': Event handler interface to connection to current.
		require
			is_interface_usable: is_interface_usable
			a_observer_attached: a_observer /= Void
			a_observer_is_interface_usable: a_observer.is_interface_usable
			not_a_observer_is_connected: not is_connected (a_observer)
			a_observer_is_valid: ({G}) #? a_observer /= Void
		deferred
		ensure
			a_observer_is_connected: is_connected (a_observer)
		end

	disconnect_events (a_observer: G)
			-- Connects event handler interface from Current.
			--
			-- `a_observer': Event handler interface to disconnection from current.
		require
			is_interface_usable: is_interface_usable
			a_observer_attached: a_observer /= Void
			a_observer_is_connected: is_connected (a_observer)
			a_observer_is_valid: ({G}) #? a_observer /= Void
		deferred
		ensure
			not_a_observer_is_connected: not is_connected (a_observer)
		end

feature -- Query

	is_connected (a_observer: G): BOOLEAN
			-- Determines if an event handler interface has already been connected to Current.
			--
			-- `a_observer': The event handler interface to test for an establish connection.
			-- `Result': True if the event handler interface has already been connected, False otherwise.
		require
			is_interface_usable: is_interface_usable
			a_observer_attached: a_observer /= Void
		deferred
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
