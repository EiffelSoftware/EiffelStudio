note
	description: "[
		Represents a freshly retrieved collection.
		The collection items are stored as strings, no matter if they are a basic value or a foreign key.
		Every collection item is also attached to the class name of its generating class as well.
		A NULL value in the database is represented as an empty string, and the class name of a NULL value is `NONE'.
	]"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_RETRIEVED_COLLECTION

inherit

	PS_ABEL_EXPORT

feature {PS_ABEL_EXPORT} -- Access

	collection_items: LINKED_LIST [PS_PAIR [STRING, STRING]]
			-- All objects that are stored inside this collection.
			-- The first item in the PS_PAIR is the actual value of the item (foreign key or basic value), and the second item is the class name of the generating class of the first item.

feature {PS_READ_ONLY_BACKEND} -- Element change

	add_item (item_value, class_name_of_item_value: STRING)
			-- Add the value `item_value' and its `class_name_of_item_value' to the end of the `collection_items' list.
		require
			class_name_not_empty: not class_name_of_item_value.is_empty
			void_value_means_none_type: item_value.is_empty implies class_name_of_item_value.is_equal ("NONE")
		do
			collection_items.extend (create {PS_PAIR [STRING, STRING]}.make (item_value, class_name_of_item_value))
		ensure
			item_inserted: collection_items.last.first.is_equal (item_value)
			class_name_inserted: collection_items.last.second.is_equal (class_name_of_item_value)
		end

feature {NONE} -- Consistency checks

	check_void_types: BOOLEAN
			-- Check that all Void items have `NONE' as the generating class.
		do
			Result := across collection_items as item_cursor all item_cursor.item.first.is_empty implies item_cursor.item.second.is_equal ("NONE") end
		end

invariant
	all_void_values_have_none_type: check_void_types

end
