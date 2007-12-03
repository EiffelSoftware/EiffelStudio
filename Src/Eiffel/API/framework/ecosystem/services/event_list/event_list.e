indexing
	description: "[
		The ecosystem's default implementation for the {EVENT_LIST_S} interface.
		It performs the simple event of managing event items and raising the appropriate events to any and all subscribers.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	EVENT_LIST

inherit
	EVENT_LIST_S

	EVENT_OBSERVER_CONNECTION [!EVENT_LIST_EVENT_OBSERVER]
		redefine
			safe_dispose
		end

	SAFE_DISPOSABLE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize event service
		do
			create internal_event_items.make (20)
			create internal_event_items_index.make (5)

				-- Initialize events
			create item_added_events
			create item_removed_events
			create item_changed_events
		end

feature {NONE} -- Clean up

	safe_dispose (a_disposing: BOOLEAN) is
			-- Action to be executed just before garbage collection
			-- reclaims an object.
			--
			-- `a_disposing': True if Current is being explictly disposed of, False to indicate finalization.
		do
			Precursor {EVENT_OBSERVER_CONNECTION} (a_disposing)

			item_added_events.dispose
			item_removed_events.dispose
			item_changed_events.dispose
		end

feature -- Access

	items (a_context_cookie: UUID): DS_BILINEAR [EVENT_LIST_ITEM_I]
			-- Retrieves all event items associated with a context.
			--
			-- `a_context_cookie': A context identifier to retrieve all events for.
			-- `Result': A list of events associated to the specified context.
		do
			Result := internal_event_items_index.item (a_context_cookie)
			if Result = Void then
					-- It's possible that an invalid context was specified.
				create {DS_ARRAYED_LIST [EVENT_LIST_ITEM_I]}Result.make (0)
			end
		end

	all_items: DS_BILINEAR [EVENT_LIST_ITEM_I]
			-- Retrieves all events managed by the current event service
		do
			Result := internal_event_items
		end

feature -- Extension

	put_event_item (a_context_cookie: UUID; a_event_item: EVENT_LIST_ITEM_I)
			-- Add a context-bound event item to the list of events managed by this service.
			--
			-- `a_context_cookie': A context identifier used to manage the added event.
			-- `a_event_item': Event items to add to the list of managed events.
		local
			l_event_items: DS_ARRAYED_LIST [EVENT_LIST_ITEM_I]
		do
			internal_event_items.force_last (a_event_item)
			if internal_event_items_index.has (a_context_cookie) then
				l_event_items := internal_event_items_index.item (a_context_cookie)
			end
			if l_event_items = Void then
				create l_event_items.make (1)
				internal_event_items_index.force_last (l_event_items, a_context_cookie)
			end
			l_event_items.force_last (a_event_item)

				-- Fire events
			on_item_added (a_event_item)
		end

feature -- Removal

	prune_event_item (a_event_item: EVENT_LIST_ITEM_I)
			-- Removes a event item from the list of events managed by this service.
			--
			-- `a_event_item': Event items to remove from the list of managed events.
		local
			l_event_items_cursor: DS_ARRAYED_LIST_CURSOR [EVENT_LIST_ITEM_I]
			l_index_cursor: DS_HASH_TABLE_CURSOR [DS_ARRAYED_LIST [EVENT_LIST_ITEM_I], UUID]
			l_index_events_cursor: DS_ARRAYED_LIST_CURSOR [EVENT_LIST_ITEM_I]
			l_event_item: EVENT_LIST_ITEM_I
			l_remove: BOOLEAN
		do
			l_event_items_cursor := internal_event_items.new_cursor

			l_event_items_cursor.start
			l_event_items_cursor.search_forth (a_event_item)
			if not l_event_items_cursor.after then
					-- Remove from list
				l_event_items_cursor.remove

				l_index_cursor := internal_event_items_index.new_cursor
				from l_index_cursor.start until l_index_cursor.after or l_remove loop
					l_index_events_cursor := l_index_cursor.item.new_cursor
					l_index_events_cursor.start
					l_index_events_cursor.search_forth (a_event_item)
					l_remove := not l_index_events_cursor.after
					if l_remove then
						l_event_item := l_index_events_cursor.item

							-- Remove from index
						l_index_events_cursor.remove

							-- Fire events
						on_item_removed (l_event_item)
					else
						l_index_cursor.forth
					end
				end
			end
		end

	prune_event_items (a_context_cookie: UUID)
			-- Removes all event items, from the list of events managed by this service, associated with a context.
			--
			-- `a_context_cookie': The context identifier to remove all events for.
		local
			l_index_events: DS_ARRAYED_LIST [EVENT_LIST_ITEM_I]
			l_event_items: DS_ARRAYED_LIST [EVENT_LIST_ITEM_I]
			l_event_item: EVENT_LIST_ITEM_I
		do
			if internal_event_items_index.has (a_context_cookie) then
				l_index_events := internal_event_items_index.item (a_context_cookie)
				if l_index_events /= Void then
					l_event_items := internal_event_items
					from l_index_events.start until l_index_events.after loop
						l_event_item := l_index_events.item_for_iteration

						from l_event_items.start until l_event_items.after loop
							l_event_items.search_forth (l_event_item)
							if not l_event_items.after then
									-- Remove event
								l_event_items.remove_at

									-- Fire events
								on_item_removed (l_event_item)
								l_event_items.start
							end
						end

						l_index_events.forth
					end

						-- Remove all index events
					internal_event_items_index.remove (a_context_cookie)
				end
			end
		end

feature -- Events

	item_added_events: EVENT_TYPE [TUPLE [service: EVENT_LIST_S; event_item: EVENT_LIST_ITEM_I]]
			-- Events called when an event list item is added

	item_removed_events: EVENT_TYPE [TUPLE [service: EVENT_LIST_S; event_item: EVENT_LIST_ITEM_I]]
			-- Events called when an event list item is removed

	item_changed_events: EVENT_TYPE [TUPLE [service: EVENT_LIST_S; event_item: EVENT_LIST_ITEM_I]]
			-- Events called when an event list item is changed

feature {NONE} -- Events

	on_item_added (a_event_item: EVENT_LIST_ITEM_I)
			-- Called when a event item is added to the event service.
			--
			-- `a_event_item': The event item added to the service.
		require
			a_event_attached: a_event_item /= Void
			current_contains_a_event: all_items.has (a_event_item)
		do
			if not is_zombie and then not item_added_events.is_zombie then
				item_added_events.publish ([Current, a_event_item])
			end
		end

	on_item_removed (a_event_item: EVENT_LIST_ITEM_I) is
			-- Called after a event item has been removed from the service `a_service'
			--
			-- `a_event_item': The event item removed from the service.
		require
			a_event_attached: a_event_item /= Void
			not_current_contains_a_event: not all_items.has (a_event_item)
		do
			if not is_zombie and then not item_added_events.is_zombie then
				item_removed_events.publish ([Current, a_event_item])
			end
		end

	on_item_changed (a_event_item: EVENT_LIST_ITEM_I)
			-- Called after a event item has been changed.
			--
			-- `a_event_item': The event item that was changed.
		require
			a_event_attached: a_event_item /= Void
			current_contains_a_event: all_items.has (a_event_item)
		do
			if not is_zombie and then not item_changed_events.is_zombie then
				item_changed_events.publish ([Current, a_event_item])
			end
		end

feature {NONE} -- Internal implementation cache

	internal_event_items: DS_ARRAYED_LIST [EVENT_LIST_ITEM_I]
			-- Mutable events, ordered by addition for the purpose of correct indexing

	internal_event_items_index: DS_HASH_TABLE [DS_ARRAYED_LIST [EVENT_LIST_ITEM_I], UUID]
			-- Mutable event index for fast and context-based access

invariant
	internal_event_items_attached: internal_event_items /= Void
	internal_event_items_contains_attached_items: not internal_event_items.has (Void)
	internal_event_items_index_attached: internal_event_items_index /= Void
	internal_event_items_index_contains_attached_items: not internal_event_items_index.has_item (Void)

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
