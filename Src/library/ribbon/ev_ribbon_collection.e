note
	description: "[
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
			--
		require
			not_void: a_item /= Void
		do
			c_add (item.item, a_item.item.item)
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
			"C inline use <ribbon.h>"
		alias
			"return sizeof(IUICollection);"
		end

	query_interface_with_prop_variant (a_item: POINTER)
			--
		external
			"C inline use <ribbon.h>"
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
			"C inline use <ribbon.h>"
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
			"C++ inline use <ribbon.h>"
		alias
			"((IUICollection *) $a_item)->Release();"
		end

	c_add (a_collection_item: POINTER; a_item: POINTER)
			--
		external
			"C++ inline use <ribbon.h>"
		alias
			"((IUICollection *) $a_collection_item)->Add ((IUnknown *) $a_item);"
		end
end
