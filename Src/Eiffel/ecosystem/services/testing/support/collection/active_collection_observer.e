note
	description: "[
		Observer for events in {ACTIVE_COLLECTION_I}
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ACTIVE_COLLECTION_OBSERVER [G -> ACTIVE_ITEM_I]

inherit
	EVENT_OBSERVER_I

feature {ACTIVE_COLLECTION_I} -- Events

	on_item_added (a_collection: ACTIVE_COLLECTION_I [G]; a_item: G)
			-- Called when `a_item' is added to items in `a_collection'.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			a_collection_usable: a_collection.is_interface_usable
			a_item_usable: a_item.is_interface_usable
			a_collection_contains_a_item: a_collection.items.has (a_item)
		do
		end

	on_item_removed (a_collection: ACTIVE_COLLECTION_I [G]; a_item: G)
			-- Called when `a_item' is removed from items in `a_collection'.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			a_collection_usable: a_collection.is_interface_usable
			not_a_collection_contains_a_item: not a_collection.items.has (a_item)
		do
		end

	on_item_changed (a_collection: ACTIVE_COLLECTION_I [G]; a_item: G)
			-- Called when `a_item' has changed in items of `a_collection'.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			a_collection_usable: a_collection.is_interface_usable
			a_collection_contains_a_item: a_collection.items.has (a_item)
			a_item_usable: a_item.is_interface_usable
			a_item_changed: a_item.has_changed
		do
		end

	on_items_reset (a_collection: ACTIVE_COLLECTION_I [G])
			-- Called when items of `a_collection' have been wiped out and may or may not be available.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			a_collection_usable: a_collection.is_interface_usable
			items_wiped_out: a_collection.are_items_available implies a_collection.items.is_empty
		do
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
