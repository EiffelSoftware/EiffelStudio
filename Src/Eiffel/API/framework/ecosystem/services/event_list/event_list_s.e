indexing
	description: "[
		Service interface for working with an event list.
		
		An event list is a maintained list of event items ({EVENT_LIST_ITEM_I}) added by peripheral tools and other services.
		Any service or tool can add and remove event items but removal should only be performed by the same service or tool that
		added the item. To ensure protection every client of the event service should have their own context cookie id, in the form
		of a UUID.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

deferred class
	EVENT_LIST_S

inherit
	SERVICE_I

feature -- Access

	items (a_context_cookie: UUID): DS_BILINEAR [EVENT_LIST_ITEM_I]
			-- Retrieves all event items associated with a context.
			--
			-- `a_context_cookie': A context identifier to retrieve all events for.
			-- `Result': A list of events associated to the specified context.
		require
			a_context_is_valid_context_cookie: is_valid_context_cookie (a_context_cookie)
		deferred
		ensure
			result_attached: Result /= Void
			result_contains_attached_items: not Result.has (Void)
			result_items_exist: Result.for_all (agent all_items.has)
		end

	items_by_type (a_type: TYPE [EVENT_LIST_ITEM_I]; a_exact_type: BOOLEAN): DS_BILINEAR [EVENT_LIST_ITEM_I]
			-- Retrieves all event items of a particual type.
			--
			-- `a_type': The type of event items to retrieve.
			-- `a_exact_type': When True only those events with the exact match type are result, otherwise all conforming types are returned.
			-- `Result': A list of events conforming to `a_type'
		require
			a_type_attached: a_type /= Void
		local
			l_int: INTERNAL
			l_cursor: DS_BILINEAR_CURSOR [EVENT_LIST_ITEM_I]
			l_result: DS_ARRAYED_LIST [EVENT_LIST_ITEM_I]
			l_event: EVENT_LIST_ITEM_I
			l_add: BOOLEAN
		do
			create l_int
			create l_result.make (5)

			l_cursor := all_items.new_cursor
			from l_cursor.start until l_cursor.after loop
				l_add := False
				l_event := l_cursor.item
				if a_exact_type then
					l_add := equal (l_int.type_of (l_event), a_type)
				else
					l_add := a_type.conforms_to (l_int.type_of (l_event))
				end
				if l_add then
					l_result.force_last (l_event)
				end
				l_cursor.forth
			end

			Result := l_result
		ensure
			result_attached: Result /= Void
			result_contains_attached_items: not Result.has (Void)
			result_items_exist: Result.for_all (agent all_items.has)
		end

	all_items: DS_BILINEAR [EVENT_LIST_ITEM_I]
			-- Retrieves all event items managed by the current event service
		deferred
		ensure
			result_attached: Result /= Void
			result_contains_attached_items: not Result.has (Void)
		end

feature {NONE} -- Access

	item_types: EVENT_LIST_ITEM_TYPES
			-- Access to event list item types
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature -- Events

	item_added_events: EVENT_TYPE [TUPLE [service: EVENT_LIST_S; event_item: EVENT_LIST_ITEM_I]]
			-- Events called when an event list item is added
		deferred
		end

	item_removed_events: EVENT_TYPE [TUPLE [service: EVENT_LIST_S; event_item: EVENT_LIST_ITEM_I]]
			-- Events called when an event list item is removed
		deferred
		end

	item_changed_events: EVENT_TYPE [TUPLE [service: EVENT_LIST_S; event_item: EVENT_LIST_ITEM_I]]
			-- Events called when an event list item is changed
		deferred
		end

feature -- Extension

	put_event_item (a_context_cookie: UUID; a_event_item: EVENT_LIST_ITEM_I)
			-- Add a context-bound event item to the list of events managed by this service.
			--
			-- `a_context_cookie': A context identifier used to manage the added event.
			-- `a_event_item': Task items to add to the list of managed events.
		require
			a_context_is_valid_context_cookie: is_valid_context_cookie (a_context_cookie)
			a_event_itemattached: a_event_item /= Void
			not_has_event_a_event_item: not has_event_item (a_event_item)
		deferred
		ensure
			has_event_a_event: has_event_item (a_event_item)
		end

feature -- Removal

	prune_event_item (a_event_item: EVENT_LIST_ITEM_I)
			-- Removes a event from the list of events managed by this service.
			--
			-- `a_event_item': Task items to remove from the list of managed events.
		require
			a_event_item_attached: a_event_item /= Void
			has_event_a_event_item: has_event_item (a_event_item)
		deferred
		ensure
			not_has_event_a_event: not has_event_item (a_event_item)
		end

	prune_event_items (a_context_cookie: UUID)
			-- Removes all events, from the list of events managed by this service, associated with a context.
			--
			-- `a_context_cookie': The context identifier to remove all events for.
		require
			a_context_is_valid_context_cookie: is_valid_context_cookie (a_context_cookie)
		deferred
		ensure
			events_removed: items (a_context_cookie).is_empty
		end

feature -- Query

	is_valid_context_cookie (a_context_cookie: UUID): BOOLEAN
			-- Determines if a context cookie is valid for the current event service
			--
			-- `a_context_cookie': A context identifier used to manage the added event.
			-- `Result': True if `a_context_cookie' is a valid cookie, False otherwise.
		do
			Result := a_context_cookie /= Void and then not a_context_cookie.is_equal (create {UUID})
		ensure
			result_implies_a_context_cookie_attached: Result implies a_context_cookie /= Void
		end

	has_event_item (a_event_item: EVENT_LIST_ITEM_I): BOOLEAN
			-- Determines if the current services maintains a hold on a specific event object.
			--
			-- `a_event_item': A event item that may be managed by the current event service.
			-- `Result': True if `a_event' is held my the event service, False otherwise.
		require
			a_event_item_attached: a_event_item /= Void
		do
			Result := all_items.has (a_event_item)
		end

invariant
	item_added_events_attached: item_added_events /= Void
	item_removed_events_attached: item_removed_events /= Void
	item_changed_events_attached: item_changed_events /= Void

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
