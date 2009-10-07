note
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

	DISPOSABLE_SAFE

	LOCKABLE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize event service
		do
			create internal_event_items.make (20)
			create internal_event_items_index.make (5)

				-- Initialize events
			create item_added_event
			auto_dispose (item_added_event)
			create item_removed_event
			auto_dispose (item_removed_event)
			create item_changed_event
			auto_dispose (item_changed_event)
			create item_adopted_event
			auto_dispose (item_adopted_event)
		end

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
			if a_explicit then
				if internal_event_items /= Void then
					internal_event_items.wipe_out
				end
				if internal_event_items_index /= Void then
					internal_event_items_index.wipe_out
				end
			end
		ensure then
			internal_event_items_is_empty: internal_event_items /= Void implies internal_event_items.is_empty
			internal_event_items_index_is_empty: internal_event_items_index /= Void implies internal_event_items_index.is_empty
		end

feature -- Access

	items (a_context_cookie: UUID): DS_BILINEAR [EVENT_LIST_ITEM_I]
			-- <Precursor>
		do
			if internal_event_items_index.has (a_context_cookie) then
				Result := internal_event_items_index.item (a_context_cookie)
			end

			if Result = Void then
					-- It's possible that an invalid context was specified.
				create {DS_ARRAYED_LIST [EVENT_LIST_ITEM_I]}Result.make (0)
			end
		end

	all_items: DS_BILINEAR [EVENT_LIST_ITEM_I]
			-- <Precursor>
		do
			Result := internal_event_items
		end

feature -- Extension

	put_event_item (a_context_cookie: UUID; a_event_item: EVENT_LIST_ITEM_I)
			-- <Precursor>
		local
			l_event_items: DS_ARRAYED_LIST [EVENT_LIST_ITEM_I]
		do
			if a_event_item.is_persistent then
				internal_event_items.force_last (a_event_item)
				if internal_event_items_index.has (a_context_cookie) then
					l_event_items := internal_event_items_index.item (a_context_cookie)
				end
				if l_event_items = Void then
					create l_event_items.make (1)
					internal_event_items_index.force_last (l_event_items, a_context_cookie)
				end
				l_event_items.force_last (a_event_item)
			end

				-- Fire events
			on_item_added (a_event_item)
		end

feature -- Removal

	prune_event_item (a_event_item: EVENT_LIST_ITEM_I)
			-- <Precursor>
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
						l_index_cursor.go_after
					else
						l_index_cursor.forth
					end
				end
			end
			check gobo_cursor_cleanup: l_index_cursor.after end
		end

	prune_event_items (a_context_cookie: UUID)
			-- <Precursor>
		local
			l_index_events: DS_ARRAYED_LIST [EVENT_LIST_ITEM_I]
			l_event_items: DS_ARRAYED_LIST [EVENT_LIST_ITEM_I]
			l_event_item: EVENT_LIST_ITEM_I
			l_locked: BOOLEAN
		do
			if internal_event_items_index.has (a_context_cookie) then
				l_index_events := internal_event_items_index.item (a_context_cookie)
				if l_index_events /= Void then
					lock
					l_locked := True

					l_event_items := internal_event_items
						-- Iterate backwards as it is more optimal when removing items.
					from l_index_events.finish until l_index_events.before loop
						l_event_item := l_index_events.item_for_iteration

						from l_event_items.finish until l_event_items.before loop
							l_event_items.search_back (l_event_item)
							if not l_event_items.before then
									-- Remove event
								l_event_items.remove_at

									-- Fire events
								on_item_removed (l_event_item)
								l_event_items.finish
							end
						end

						l_index_events.back
					end

						-- Remove all index events
					internal_event_items_index.remove (a_context_cookie)

					unlock
					l_locked := False
				end
			end
		rescue
			if l_locked then
				unlock
			end
		end

feature -- Basic operations

	adopt_event_item (a_new_cookie: UUID; a_event_item: EVENT_LIST_ITEM_I)
			-- <Precursor>
		local
			l_cursor: DS_HASH_TABLE_CURSOR [DS_ARRAYED_LIST [EVENT_LIST_ITEM_I], UUID]
			l_items: DS_ARRAYED_LIST [EVENT_LIST_ITEM_I]
			l_old_cookie: UUID
			l_stop: BOOLEAN
		do
			l_cursor := internal_event_items_index.new_cursor
			from l_cursor.start until l_cursor.after or l_stop loop
				l_items := l_cursor.item
				l_stop := l_items.has (a_event_item)
				if l_stop then
					l_old_cookie := l_cursor.key
					if not l_items.off and then l_items.item_for_iteration = a_event_item then
							-- Quick removal
						l_items.remove_at
					else
							-- Slower removal
						l_items.start
						l_items.search_forth (a_event_item)
						l_items.remove_at
					end
					l_cursor.go_after
				else
					l_cursor.forth
				end
			end
			check gobo_cursor_cleanup: l_cursor.after end

			check
				item_found: l_stop
				l_old_cookie_attached: l_old_cookie /= Void
			end
			if internal_event_items_index.has (a_new_cookie) then
				l_items := internal_event_items_index.item (a_new_cookie)
			else
				create l_items.make (1)
				internal_event_items_index.put_last (l_items, a_new_cookie)
			end
			l_items.force_last (a_event_item)

				-- Publish events
			on_item_adopted (a_event_item, a_new_cookie, l_old_cookie)
		end

feature -- Events

	item_added_event: attached EVENT_TYPE [TUPLE [service: EVENT_LIST_S; event_item: EVENT_LIST_ITEM_I]]
			-- <Precursor>

	item_removed_event: attached EVENT_TYPE [TUPLE [service: EVENT_LIST_S; event_item: EVENT_LIST_ITEM_I]]
			-- <Precursor>

	item_changed_event: attached EVENT_TYPE [TUPLE [service: EVENT_LIST_S; event_item: EVENT_LIST_ITEM_I]]
			-- <Precursor>

	item_adopted_event: attached EVENT_TYPE [TUPLE [service: EVENT_LIST_S; event_item: EVENT_LIST_ITEM_I; new_cookie: UUID; old_cookie: UUID]]
			-- <Precursor>

feature -- Events: Connection point

	event_list_connection: attached EVENT_CONNECTION_I [EVENT_LIST_OBSERVER, EVENT_LIST_S]
			-- <Precursor>
		local
			l_result: like internal_event_list_connection
		do
			l_result := internal_event_list_connection
			if l_result = Void then
				create {EVENT_CHAINED_CONNECTION [EVENT_LIST_OBSERVER, EVENT_LIST_S, LOCKABLE_OBSERVER, LOCKABLE_I]} Result.make (
					agent (ia_observer: EVENT_LIST_OBSERVER): ARRAY [TUPLE [event: EVENT_TYPE [TUPLE]; action: PROCEDURE [ANY, TUPLE]]]
						do
							Result := << [item_added_event, agent ia_observer.on_event_item_added],
								[item_adopted_event, agent ia_observer.on_event_item_adopted],
								[item_changed_event, agent ia_observer.on_event_item_changed],
								[item_removed_event, agent ia_observer.on_event_item_removed] >>
						end, lockable_connection)
				automation.auto_dispose (Result)
				internal_event_list_connection := Result
			else
				Result := l_result
			end
		end

feature {NONE} -- Events

	on_item_added (a_event_item: EVENT_LIST_ITEM_I)
			-- Called when a event item is added to the event service.
			--
			-- `a_event_item': The event item added to the service.
		require
			is_interface_usable: is_interface_usable
			a_event_attached: a_event_item /= Void
			current_contains_a_event: a_event_item.is_persistent implies all_items.has (a_event_item)
		do
			if is_interface_usable and then item_added_event.is_interface_usable then
				item_added_event.publish ([Current, a_event_item])
			end
		end

	on_item_removed (a_event_item: EVENT_LIST_ITEM_I)
			-- Called after a event item has been removed from the service `a_service'
			--
			-- `a_event_item': The event item removed from the service.
		require
			is_interface_usable: is_interface_usable
			a_event_attached: a_event_item /= Void
			a_event_item_is_persistent: a_event_item.is_persistent
			not_current_contains_a_event: not all_items.has (a_event_item)
		do
			if is_interface_usable and then item_added_event.is_interface_usable then
				item_removed_event.publish ([Current, a_event_item])
			end
		end

	on_item_changed (a_event_item: EVENT_LIST_ITEM_I)
			-- Called after a event item has been changed.
			--
			-- `a_event_item': The event item that was changed.
		require
			is_interface_usable: is_interface_usable
			a_event_attached: a_event_item /= Void
			a_event_item_is_persistent: a_event_item.is_persistent
			current_contains_a_event: all_items.has (a_event_item)
		do
			if is_interface_usable and then item_changed_event.is_interface_usable then
				item_changed_event.publish ([Current, a_event_item])
			end
		end

	on_item_adopted (a_event_item: EVENT_LIST_ITEM_I; a_new_cookie: UUID; a_old_cookie: UUID)
			-- Called after a event item has been adopted.
			--
			-- `a_event_item': The event item that was adopted.
			-- `a_new_cookie': New owner cookie, that adopted the event item.
			-- `a_old_cookie': Previous owner's cookie, that used to own the event item.
		require
			is_interface_usable: is_interface_usable
			a_old_cookie_is_valid_context_cookie: is_valid_context_cookie (a_old_cookie)
			a_new_cookie_is_valid_context_cookie: is_valid_context_cookie (a_new_cookie)
			a_event_attached: a_event_item /= Void
			a_event_item_is_persistent: a_event_item.is_persistent
			not_a_event_item_is_invalidated: not a_event_item.is_invalidated
			current_contains_a_event: all_items.has (a_event_item)
			not_a_old_cookie_items_contains_a_event_item: not items (a_old_cookie).has (a_event_item)
			a_new_cookie_items_contains_a_event_item: items (a_new_cookie).has (a_event_item)
		do
			if is_interface_usable and then item_adopted_event.is_interface_usable then
				item_adopted_event.publish ([Current, a_event_item, a_new_cookie, a_old_cookie])
			end
		end

feature {NONE} -- Implementation: Internal cache

	internal_event_items: DS_ARRAYED_LIST [EVENT_LIST_ITEM_I]
			-- Mutable events, ordered by addition for the purpose of correct indexing

	internal_event_items_index: DS_HASH_TABLE [DS_ARRAYED_LIST [EVENT_LIST_ITEM_I], UUID]
			-- Mutable event index for fast and context-based access

	internal_event_list_connection: detachable like event_list_connection
			-- Cached version of `event_list_connection'.
			-- Note: Do not use directly!

invariant
	internal_event_items_attached: attached internal_event_items
	internal_event_items_contains_attached_items: not internal_event_items.has (Void)
	internal_event_items_index_attached: attached  internal_event_items_index
	internal_event_items_index_contains_attached_items: not internal_event_items_index.has_item (Void)

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
