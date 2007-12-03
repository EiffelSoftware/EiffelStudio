indexing
	description: "[
		An observer for events implemented on a {EVENT_LIST_S} service interface.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class
	EVENT_LIST_EVENT_OBSERVER

inherit
	EVENT_OBSERVER_I

feature {EVENT_LIST_S} -- Event handlers

	on_event_item_added (a_service: EVENT_LIST_S; a_event_item: EVENT_LIST_ITEM_I)
			-- Called when a event item is added to the event service.
			--
			-- `a_service': Event service where event was added.
			-- `a_event_item': The event item added to the service.
		require
			is_interface_usable: is_interface_usable
			a_service_attached: a_service /= Void
			a_event_attached: a_event_item /= Void
		do
		end

	on_event_item_removed (a_service: EVENT_LIST_S; a_event_item: EVENT_LIST_ITEM_I) is
			-- Called after a event item has been removed from the service `a_service'
			--
			-- `a_service': Event service where the event was removed.
			-- `a_event_item': The event item removed from the service.
		require
			is_interface_usable: is_interface_usable
			a_service_attached: a_service /= Void
			a_event_attached: a_event_item /= Void
		do
		end

	on_event_item_changed (a_service: EVENT_LIST_S; a_event_item: EVENT_LIST_ITEM_I)
			-- Called after a event item has been changed.
			--
			-- `a_service': Event service where the event was changed.
			-- `a_event_item': The event item that was changed.
		require
			is_interface_usable: is_interface_usable
			a_service_attached: a_service /= Void
			a_event_attached: a_event_item /= Void
		do
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
