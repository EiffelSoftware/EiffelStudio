note
	description: "[
					The IUICollection interface is implemented by the Ribbon framework. The IUICollection
					interface defines the methods for dynamically manipulating collection-based controls,
					such as the various Ribbon galleries and the Quick Access Toolbar (QAT), at run time.
					
					Collection used by combo box
					IUICollection
																										]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RIBBON_COLLECTION

create
	make_with_prop_variant

feature {NONE} -- Initialization

	make_with_prop_variant (a_prop_variant: EV_PROPERTY_VARIANT)
			-- Creation method
		require
			not_void: a_prop_variant /= Void
		local
			l_pointer: POINTER
		do
			query_interface_with_prop_variant (a_prop_variant.item)
			l_pointer := get_ui_collection
			create item.share_from_pointer (l_pointer, size)
		end

feature -- Command

	add (a_item: EV_SIMPLE_PROPERTY_SET)
			-- Adds an item to the end of the IUICollection.
		require
			not_void: a_item /= Void
		do
			c_add (item.item, a_item.item.item)
		end

	clear
			-- Deletes all items from the IUICollection.
		do
			c_clear (item.item)
		end

	get_count: NATURAL_32
			-- Retrieves the number of items contained in the IUICollection.
		do
			c_get_count (item.item, $Result)
		end

	get_item (a_index: NATURAL_32): detachable EV_SIMPLE_PROPERTY_SET
			-- Retrieves an item from the IUICollection at the specified index.
			-- `a_index' The zero-based index of item to retrieve from the IUICollection.
		local
			l_result: POINTER
		do
			c_get_item (item.item, a_index, $l_result)
			if l_result /= default_pointer then
				create Result.share_with_pointer (l_result)
			end
		end

	insert (a_index: NATURAL_32; a_item: EV_SIMPLE_PROPERTY_SET)
			-- Inserts an item into the IUICollection at the specified index.
			-- `a_index' The zero-based index at which item is inserted into the IUICollection.
		do
			c_insert (item.item, a_index, a_item.item.item)
		end

	remove_at (a_index: NATURAL_32)
			-- Removes an item from the IUICollection at the specified index.
			-- `a_index' The zero-based index of the item to remove from the IUICollection.
		do
			c_remove_at (item.item, a_index)
		end

	replace (a_index: NATURAL_32; a_item: EV_SIMPLE_PROPERTY_SET)
			-- Replaces an item at the specified index of the IUICollection with another item.
			-- `a_index' The zero-based index of item to be replaced in the IUICollection.
		do
			c_replace (item.item, a_index, a_item.item.item)
		end

	release
			-- Release COM object
		do
			c_release (item.item)
		end

feature {NONE} -- Implementation

	item: MANAGED_POINTER
			--

feature {NONE} -- C external

	size: INTEGER
			--
		external
			"C inline use <common.h>"
		alias
			"return sizeof(IUICollection);"
		end

	query_interface_with_prop_variant (a_item: POINTER)
			--
		external
			"C inline use <common.h>"
		alias
			"[
			{
				QueryInterfaceIUICollectionWithPropVariant ((PROPVARIANT *) $a_item);	
			}
			]"
		end

	get_ui_collection: POINTER
			--
		external
			"C inline use <common.h>"
		alias
			"[
			{
				return GetUICollection ();
			}
			]"
		end

	c_release (a_item: POINTER)
			--
		external
			"C++ inline use <common.h>"
		alias
			"((IUICollection *) $a_item)->Release();"
		end

	c_add (a_collection_item: POINTER; a_item: POINTER)
			--
		external
			"C++ inline use <common.h>"
		alias
			"((IUICollection *) $a_collection_item)->Add ((IUnknown *) $a_item);"
		end

	c_clear (a_collection_item: POINTER)
			--
		external
			"C++ inline use <common.h>"
		alias
			"((IUICollection *) $a_collection_item)->Clear ();"
		end

	c_get_count (a_collection_item: POINTER; a_result: TYPED_POINTER [NATURAL_32])
			--
		external
			"C++ inline use <common.h>"
		alias
			"((IUICollection *) $a_collection_item)->GetCount ($a_result);"
		end

	c_get_item (a_collection_item: POINTER; a_index: NATURAL_32; a_result: TYPED_POINTER [POINTER])
			--
		external
			"C++ inline use <common.h>"
		alias
			"((IUICollection *) $a_collection_item)->GetItem ($a_index, (IUnknown **)$a_result);"
		end

	c_insert (a_collection_item: POINTER; a_index: NATURAL_32; a_item: POINTER)
			--
		external
			"C++ inline use <common.h>"
		alias
			"((IUICollection *) $a_collection_item)->Insert ($a_index, (IUnknown *) $a_item);"
		end

	c_remove_at (a_collection_item: POINTER; a_index: NATURAL_32)
			--
		external
			"C++ inline use <common.h>"
		alias
			"((IUICollection *) $a_collection_item)->RemoveAt ($a_index);"
		end

	c_replace (a_collection_item: POINTER; a_index: NATURAL_32; a_item: POINTER)
			--
		external
			"C++ inline use <common.h>"
		alias
			"((IUICollection *) $a_collection_item)->Replace ($a_index, (IUnknown *) $a_item);"
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
