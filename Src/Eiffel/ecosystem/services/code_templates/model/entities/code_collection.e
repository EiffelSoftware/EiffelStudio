note
	description: "[
		Interface for simple collections used in code template models.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	CODE_COLLECTION [G -> ANY]

inherit
	CODE_SUB_NODE [CODE_NODE]

feature {NONE} -- Initialization

	initialize_nodes (a_factory: like code_factory)
			-- <Precursor>
		do
			create internal_items.make_default
			internal_items.set_equality_tester (item_equality_tester)
		end

feature -- Access

	items: DS_BILINEAR [G]
			-- List of current code templates
		do
			Result := internal_items
		ensure
			result_attached: Result /= Void
			result_contains_attached_items:
				(attached {DS_BILINEAR [detachable G]} Result as l_result) and then
				not l_result.has (internal_default_item)
		end

feature {NONE} -- Access

	item_equality_tester: detachable KL_EQUALITY_TESTER_A [G]
			-- Optional equality tester for item comparison.
		do
		end

feature -- Query

	has (a_item: G): BOOLEAN
			-- Determines if a given item exists in the collection
		require
			a_item_attached: a_item /= Void
		do
			Result := internal_items.has (a_item)
		end

feature -- Extension

	extend (a_item: G)
			-- Extends the collection with an item.
			--
			-- `a_item': The item to add to the collection.
		require
			a_item_attached: a_item /= Void
			not_items_has_a_items: not has (a_item)
		do
			internal_items.force_last (a_item)
		ensure
			items_has_a_items: has (a_item)
		end

feature -- Removal

	prune (a_item: G)
			-- Removed an item from the collection.
			--
			-- `a_item': The item to remove from the collection.
		require
			a_item_attached: a_item /= Void
			items_has_a_items: has (a_item)
		do
			internal_items.start
			internal_items.search_forth (a_item)
			internal_items.remove_at
		ensure
			not_items_has_a_items: not has (a_item)
		end

feature {NONE} -- Implementation: Internal cache

	internal_items: DS_ARRAYED_LIST [G]
			-- Mutable version of `items'

	internal_default_item: detachable G
			-- Default generic item

invariant
	internal_items_attached: is_initialized implies internal_items /= Void
	internal_items_contains_attached_items: is_initialized implies
		((attached {DS_LIST [detachable G]} internal_items as l_internal_items) and then not l_internal_items.has (internal_default_item))

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
