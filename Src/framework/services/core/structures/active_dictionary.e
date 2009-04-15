note
	description: "[

		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ACTIVE_DICTIONARY [G, K -> HASHABLE]

inherit
	ACTIVE_DICTIONARY_I [G, K]

	DISPOSABLE_SAFE

--create
--	make

feature {NONE} -- Initialization

	make
			-- Initialize a new set
		do
			create table.make_default
			create adoptions.make_default
		end

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		local
			l_items: like table
			l_adoptions: like adoptions
			l_item: detachable G
			l_key: detachable K
			l_automation: like automation
			l_action: PROCEDURE [ANY, TUPLE]
		do
			if a_explicit then
				l_items := table
				if not l_items.is_empty then
					l_automation := automation
					from l_items.start until l_items.after loop
						l_key := l_items.key_for_iteration
						l_item := l_items.item_for_iteration
						check
							l_key_attached: l_key /= Void
							l_item_attached: l_item /= Void
						end
						deactivate_object (l_item, l_key)
						l_items.remove (l_key)
					end
				end
				adoptions.wipe_out
			end
		ensure then
			table_is_empty: a_explicit implies table.is_empty
			adoptions_is_empty: a_explicit implies adoptions.is_empty
		end

feature -- Access

	items: DS_LINEAR [G]
			-- <Precursor>
		do
			Result := table
		end

	keys: DS_SET [K]
			-- <Precursor>
		local
			l_result: DS_HASH_SET [K]
		do
			create l_result.make_default
			l_result.extend_last (table.keys)
			Result := l_result
		end

feature {NONE} -- Access

	table: DS_HASH_TABLE [G, K]
			-- Actual table used to store active dictionary items.

	adoptions: DS_ARRAYED_LIST [ANY]
			-- List of adopted objects.

feature -- Status report

	is_valid_key (a_key: K): BOOLEAN
			-- <Precursor>
		do
			Result := (attached {USABLE_I} a_key as l_usable) implies l_usable.is_interface_usable
		end

	is_valid_item (a_item: G): BOOLEAN
			-- <Precursor>
		do
			Result := (attached {USABLE_I} a_item as l_usable) implies l_usable.is_interface_usable
		end

	has (a_key: K): BOOLEAN
			-- <Precursor>
		do
			Result := table.has (a_key)
		end

feature -- Query

	item alias "[]" (a_key: K): G
			-- <Precursor>
		local
			l_result: detachable G
		do
			l_result := table.item (a_key)
			check l_result_attached: l_result /= Void end
			Result := l_result
		end

feature -- Basic operations

	extend (a_item: G a_key: K)
			-- <Precursor>
		do
			extend_internal (a_item, a_key, False)
		end

	extend_adopted (a_item: !G a_key: !K)
			-- <Precursor>
		do
				-- Perform extension.
			extend_internal (a_item, a_key, True)
		end

	force (a_item: G a_key: K)
			-- <Precursor>
		do
			extend_internal (a_item, a_key, False)
		end

	force_adopted (a_item: !G a_key: !K)
			-- <Precursor>
		do
				-- Perform extension.
			extend_internal (a_item, a_key, True)
		end

	prune (a_key: K)
			-- <Precursor>
		local
			l_table: like table
			l_adoptions: like adoptions
			l_item: ?G
			l_action: PROCEDURE [ANY, TUPLE]
			l_adopted: BOOLEAN
		do
			l_table := table
			if l_table.has (a_key) then
				l_item := l_table.item (a_key)
				check l_item_attached: l_item /= Void end
				deactivate_object (l_item, a_key)
				l_table.remove (a_key)

				if attached internal_item_pruned_event as l_event then
						-- Publish changed event
					l_event.publish ([Current, l_item, a_key])
				end
			end
		end

	find_keys (a_item: G): DS_HASH_SET [K]
			-- <Precursor>
		local
			l_table: like table
		do
			create Result.make_default
			l_table := table
			from l_table.start until l_table.after loop
				if l_table.item_for_iteration ~ a_item then
					Result.force_last (l_table.key_for_iteration)
				end
				l_table.forth
			end
		end

feature {NONE} -- Basic operations

	extend_internal (a_item: G; a_key: K; a_adopt: BOOLEAN)
			-- <Precursor>
		local
			l_table: like table
			l_adoptions: like adoptions
			l_old_item: detachable G
			l_action: PROCEDURE [ANY, TUPLE]
		do
			l_table := table
			l_adoptions := adoptions
			if l_table.has (a_key) then
				l_old_item := l_table.item (a_key)
				check l_old_item_attached: l_old_item /= Void end

				deactivate_object (l_old_item, a_key)
			end

				-- Add the new item.
			l_table.force_last (a_item, a_key)

				-- Active the new item.			
			activate_object (a_item, a_key, a_adopt)

			if l_old_item = Void then
				if attached internal_item_extended_event as l_event then
						-- Publish extended event
					l_event.publish ([Current, a_item, a_key])
				end
			else
				if attached internal_item_changed_event as l_event then
						-- Publish changed event
					l_event.publish ([Current, a_item, l_old_item, a_key])
				end
				if attached internal_item_pruned_event as l_event then
						-- Publish changed event
					l_event.publish ([Current, l_old_item, a_key])
				end
			end
		end

feature {NONE} -- Basic operations

	activate_object (a_object: G; a_key: K; a_adopt: BOOLEAN)
			-- Activates a dictionary object.
			--
			-- `a_object': A registration object {G} or a concealed registration object {CONCEALER_I}[G].
			-- `a_key': The key used to register the registration object.
		require
			is_interface_usable: is_interface_usable
			a_object_attached: a_object /= Void
			a_object_is_valid_item: is_valid_item (a_object)
			a_key_attached: a_key /= Void
			a_key_is_valid_registration_key: is_valid_key (a_key)
			has_a_key: has (a_key)
		local
			l_adoptions: like adoptions
		do
				-- Site the active item.
			if attached {SITE [ACTIVE_DICTIONARY_I [G, K]]} a_object as l_site then
				check not_sited: not l_site.is_sited end
				if l_site.is_valid_site (Current) then
					l_site.site := Current
				end
			end

			if a_adopt then
				l_adoptions := adoptions
				check not_l_adoptions_has_a_object: not l_adoptions.has (a_object) end
				l_adoptions.force_last (a_object)

					-- Set disposable actions to automatically remove the item.
				if attached {DISPOSABLE_I} a_object as l_disposable then
						-- Add subscription to dispose notification so the item can be removed automatically
						-- from the list
					l_disposable.automation.notify_on_disposed (agent prune (a_key))
				end
			end
		end

	deactivate_object (a_object: G; a_key: K)
			-- Deactivates a registration object, one that was activated using `activate_registration'.
			--
			-- `a_registration': A registration object {G} or a concealed registration object {CONCEALER_I}[G].
			-- `a_key': The key used to register the registration object.
		require
			is_interface_usable: is_interface_usable
			a_object_attached: a_object /= Void
		local
			l_adoptions: like adoptions
			l_action: PROCEDURE [ANY, TUPLE]
		do
			l_adoptions := adoptions
			if l_adoptions.has (a_object) then
					-- The item is adopted, clean in up.
				l_adoptions.start
				l_adoptions.search_forth (a_object)
				l_adoptions.remove_at

				if attached {DISPOSABLE_I} a_object as l_disposable then
						-- Clean up item
					if l_disposable.is_interface_usable then
							-- Remove subscription to dispose because the item is being cleaned up now.
						l_action := agent prune (a_key)
						if l_disposable.automation.is_notified_on_disposed (l_action) then
							l_disposable.automation.ignore_on_disposed (l_action)
						end
						l_disposable.dispose
					end
				end
			end

				-- Remove any site object.
			if attached {SITE [ACTIVE_DICTIONARY_I [G, K]]} a_object as l_old_site then
				if l_old_site.is_sited then
					check sited_to_current: l_old_site.site = Current end
					l_old_site.site := Void
				end
			end
		ensure
			not_adoptions_has_a_object: not adoptions.has (a_object)
		end

feature -- Events

	item_extended_event: EVENT_TYPE [TUPLE [sender: ACTIVE_DICTIONARY [G, K]; object: G; key: K]]
			-- <Precursor>
		do
			if attached internal_item_extended_event as l_result then
				Result := l_result
			else
				create Result
				internal_item_extended_event := Result
				automation.auto_dispose (Result)
			end
		end

	item_changed_event: EVENT_TYPE [TUPLE [sender: ACTIVE_DICTIONARY [G, K]; object: G; old_object: G; key: K]]
			-- <Precursor>
		do
			if attached internal_item_changed_event as l_result then
				Result := l_result
			else
				create Result
				internal_item_changed_event := Result
				automation.auto_dispose (Result)
			end
		end

	item_pruned_event: EVENT_TYPE [TUPLE [sender: ACTIVE_DICTIONARY [G, K]; object: G; key: K]]
			-- <Precursor>
		do
			if attached internal_item_pruned_event as l_result then
				Result := l_result
			else
				create Result
				internal_item_pruned_event := Result
				automation.auto_dispose (Result)
			end
		end

feature -- Events: Connection point

	frozen active_dictionary_connection: EVENT_CONNECTION_I [ACTIVE_DICTIONARY_OBSERVER [G, K], ACTIVE_DICTIONARY_I [G, K]]
			-- <Precursor>
		local
			l_result: like internal_active_dictionary_connection
		do
			l_result := internal_active_dictionary_connection
			if l_result = Void then
				create {EVENT_CONNECTION [ACTIVE_DICTIONARY_OBSERVER [G, K], ACTIVE_DICTIONARY_I [G, K]]} Result.make (
					agent (ia_observer: ACTIVE_DICTIONARY_OBSERVER [G, K]): ARRAY [TUPLE [event: EVENT_TYPE [TUPLE]; action: PROCEDURE [ANY, TUPLE]]]
						do
							Result := <<
								[item_extended_event, agent ia_observer.on_dictionary_item_extended],
								[item_changed_event, agent ia_observer.on_dictionary_item_changed],
								[item_pruned_event, agent ia_observer.on_dictionary_item_pruned] >>
						end)
				automation.auto_dispose (Result)
				internal_active_dictionary_connection := Result
			else
				Result := l_result
			end
		end

feature {NONE} -- Implementation: Internal cache

	internal_item_extended_event: ?like item_extended_event
			-- Cached version of `item_extended_event'.
			-- Note: Do not use directly!

	internal_item_changed_event: ?like item_changed_event
			-- Cached version of `item_changed_event'.
			-- Note: Do not use directly!

	internal_item_pruned_event: ?like item_pruned_event
			-- Cached version of `item_pruned_event'.
			-- Note: Do not use directly!

	internal_active_dictionary_connection: ? like active_dictionary_connection
			-- Cached version of `active_dictionary_connection'.
			-- Note: Do not use directly!

invariant
	table_attached: table /= Void
	adoptions_attached: adoptions /= Void
--	table_contains_attached_items: (attached {DS_LINEAR [detachable ANY]} as l_table) and then not l_table.has (Void)
--	adoptions_contains_attached_items: (attached {DS_LINEAR [detachable ANY]} as l_adoptions) and then not l_adoptions.has (Void)

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
