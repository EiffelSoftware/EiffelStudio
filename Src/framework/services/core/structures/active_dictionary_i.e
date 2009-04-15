note
	description: "[

		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ACTIVE_DICTIONARY_I [G, K -> HASHABLE]

inherit
	USABLE_I

	DISPOSABLE_I

	EVENT_CONNECTION_POINT_I [ACTIVE_DICTIONARY_OBSERVER [G, K], ACTIVE_DICTIONARY_I [G, K]]
		rename
			connection as active_dictionary_connection
		end

feature -- Access

	items: DS_LINEAR [G]
			-- Current list of items held in the dictionary.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
--			result_contains_attached_items: (attached {DS_LINEAR [detachable G]} as l_result) and then not l_result.has (Void)
--			result_contains_usable_items: Result.for_all (agent (ia_item: G): BOOLEAN
--				do
--					Result := (attached {USABLE_I} ia_item as l_usable) implies l_usable.is_interface_usable
--				end)
			result_consistent: Result = items
		end

	keys: DS_SET [K]
			-- Current list of keys held in the dictionary.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
--			result_contains_attached_items: (attached {DS_LINEAR [detachable G]} as l_result) and then not l_result.has (Void)
--			result_contains_usable_items: Result.for_all (agent (ia_item: G): BOOLEAN
--				do
--					Result := (attached {USABLE_I} ia_item as l_usable) implies l_usable.is_interface_usable
--				end)
			result_consistent: Result = keys
		end

feature -- Status report

	is_valid_key (a_key: K): BOOLEAN
			-- Determines if a dictionaty key is valid for the dictionary.
			--
			-- `a_key': The key to determine validity for.
			-- `Result': True if the key is valid; False otherwise.
		require
			is_interface_usable: is_interface_usable
			a_key_attached: a_key /= Void
		deferred
		ensure
			a_key_is_interface_usable: attached {USABLE_I} a_key as l_usable implies l_usable.is_interface_usable
		end

	is_valid_item (a_item: detachable G): BOOLEAN
			-- Determines if a dictionary object is valid for the dictionary.
			--
			-- `a_key': The object to determine validity for.
			-- `Result': True if the key is valid; False otherwise.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			a_key_is_interface_usable: attached {USABLE_I} a_item as l_usable implies l_usable.is_interface_usable
		end

	has (a_key: K): BOOLEAN
			-- Determines if an object has already been registered with an specific key.
			--
			-- `a_key': A dictionary key to test against the current dictionary.
			-- `Result': True if the key has an attached object associated with the key; False otherwise.
		require
			is_interface_usable: is_interface_usable
			a_key_attached: a_key /= Void
			a_item_is_valid_key: is_valid_key (a_key)
		deferred
		ensure
			keys_has_a_key: Result implies keys.has (a_key)
		end

feature -- Query

	item alias "[]" (a_key: K): G
			-- Retrieves a dictionary object associated with a key.
			--
			-- `a_key': A dictionary key to retrieve an associated object for.
			-- `Result': A dictionary object.
		require
			is_interface_usable: is_interface_usable
			a_key_attached: a_key /= Void
			a_key_is_valid_key: is_valid_key (a_key)
			has_a_key: has (a_key)
		deferred
		end

feature -- Basic operations

	extend (a_item: G; a_key: K)
			-- Extends the dictionary with an object, associated with a key.
			--
			-- `a_item': An object to extend the dictionary with.
			-- `a_key' : A dictionary key to associated with the object.
		require
			is_interface_usable: is_interface_usable
			a_item_attached: a_item /= Void
			a_item_is_valid_item: is_valid_item (a_item)
			a_key_attached: a_key /= Void
			a_item_is_valid_key: is_valid_key (a_key)
			not_has_a_key: not has (a_key)
		deferred
		ensure
			has_a_key: has (a_key)
			a_item_sited: (attached {SITE [ACTIVE_DICTIONARY_I [G, K]]} a_item as l_site) implies (l_site.is_sited and then l_site.site = Current)
		end

	extend_adopted (a_item: G; a_key: K)
			-- Extends the dictionary with an object, associated with a key, and adopts the disposing of the
			-- object if it implements {DISPOSABLE_I}
			--
			-- `a_item': An object to extend the dictionary with.
			-- `a_key' : A dictionary key to associated with the object.
		require
			is_interface_usable: is_interface_usable
			a_item_attached: a_item /= Void
			a_item_is_valid_item: is_valid_item (a_item)
			a_key_attached: a_key /= Void
			a_item_is_valid_key: is_valid_key (a_key)
			not_has_a_key: not has (a_key)
		deferred
		ensure
			has_a_key: has (a_key)
			a_item_sited: (attached {SITE [ACTIVE_DICTIONARY_I [G, K]]} a_item as l_site) implies (l_site.is_sited and then l_site.site = Current)
		end

	force (a_item: G; a_key: K)
			-- Extends the dictionary with an object, associated with a key.
			--
			-- `a_item': An object to extend the dictionary with.
			-- `a_key' : A dictionary key to associated with the object.
		require
			is_interface_usable: is_interface_usable
			a_item_attached: a_item /= Void
			a_item_is_valid_item: is_valid_item (a_item)
			a_key_attached: a_key /= Void
			a_item_is_valid_key: is_valid_key (a_key)
		deferred
		ensure
			has_a_key: has (a_key)
			a_item_sited: (attached {SITE [ACTIVE_DICTIONARY_I [G, K]]} a_item as l_site) implies (l_site.is_sited and then l_site.site = Current)
--			old_a_item_unsited: old has (a_key) implies (
--				(old attached {SITE [ACTIVE_DICTIONARY_I [G, K]]} a_item as l_site) implies
--				not l_site.is_sited)
		end

	force_adopted (a_item: G; a_key: K)
			-- Extends the dictionary with an object, associated with a key, and adopts the disposing of the
			-- object if it implements {DISPOSABLE_I}
			--
			-- `a_item': An object to extend the dictionary with.
			-- `a_key' : A dictionary key to associated with the object.
		require
			is_interface_usable: is_interface_usable
			a_item_attached: a_item /= Void
			a_item_is_valid_item: is_valid_item (a_item)
			a_key_attached: a_key /= Void
			a_item_is_valid_key: is_valid_key (a_key)
		deferred
		ensure
			has_a_key: has (a_key)
			a_item_sited: (attached {SITE [ACTIVE_DICTIONARY_I [G, K]]} a_item as l_site) implies (l_site.is_sited and then l_site.site = Current)
--			old_a_item_unsited: old has (a_key) implies (
--				(old attached {SITE [ACTIVE_DICTIONARY_I [G, K]]} a_item as l_site) implies
--				not l_site.is_sited)
		end

	prune (a_key: K)
			-- Removes a previous extended object from the dictionary using a key.
			--
			-- `a_key': A dictionary key to remove an associated object with.
		require
			is_interface_usable: is_interface_usable
			a_key_attached: a_key /= Void
			a_item_is_valid_key: is_valid_key (a_key)
			has_a_key: has (a_key)
		deferred
		ensure
			not_has_a_key: not has (a_key)
			a_item_unsited: (attached {SITE [ACTIVE_DICTIONARY_I [G, K]]} old item (a_key) as l_site) implies not l_site.is_sited
		end

	find (a_item: G): DS_HASH_SET [K]
			-- Attempts to find an existing dictionary object and returns a set of keys
		require
			is_interface_usable: is_interface_usable
			a_item_attached: a_item /= Void
			a_item_is_valid_item: is_valid_item (a_item)
		deferred
		ensure
			result_attached: Result /= Void
--			result_contains_attached_items: (attached {DS_SET [detachable K]} as l_result) and then not l_result.has (Void)
--			result_contains_usable_items: Result.for_all (agent (ia_item: K): BOOLEAN
--				do
--					Result := (attached {USABLE_I} ia_item as l_usable) implies l_usable.is_interface_usable
--				end)
--			result_is_subset_of_keys: Result.for_all (agent (ia_key: K): BOOLEAN
--				do
--					Result := ia_key /= Void and then has (ia_key)
--				end)
		end

feature -- Events

	item_extended_event: EVENT_TYPE [TUPLE [sender: ACTIVE_DICTIONARY [G, K]; object: G; key: K]]
			-- Events called after an item was added to the dictionary.
			--
			-- 'sender': Dictionary object sending the event.
			-- 'object': The context item added to the dictionary.
			-- 'key'   : Item's dictionary indexing key.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			result_is_interface_usable: Result.is_interface_usable
			result_consistent: Result = item_extended_event
		end

	item_changed_event: EVENT_TYPE [TUPLE [sender: ACTIVE_DICTIONARY [G, K]; object: G; old_object: G; key: K]]
			-- Events called after an item was removed to the dictionary.
			--
			-- 'sender'    : Dictionary object sending the event.
			-- 'object'    : The object changed to in the dictionary.
			-- 'old_object': The object changed from in the dictionary.
			-- 'key'       : Object's dictionary indexing key.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
		result_attached: Result /= Void
			result_is_interface_usable: Result.is_interface_usable
			result_consistent: Result = item_changed_event
		end

	item_pruned_event: EVENT_TYPE [TUPLE [sender: ACTIVE_DICTIONARY [G, K]; object: G; key: K]]
			-- Events called after an item was removed to the dictionary.
			--
			-- 'sender': Dictionary object sending the event.
			-- 'object': The object removed from the dictionary.
			-- 'key'   : Item's dictionary indexing key.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			result_is_interface_usable: Result.is_interface_usable
			result_consistent: Result = item_pruned_event
		end

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
