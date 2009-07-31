note
	description: "Wrapper for NSDictionary."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

	-- TODO: May make sense to add genericity if this class becomes more complete and more used

class
	NS_DICTIONARY

inherit
	NS_OBJECT

create
	make,
	make_with_object_for_key,
	make_with_objects_for_keys
create {NS_OBJECT}
	make_from_pointer,
	share_from_pointer

feature -- Creation

	make
		do
			make_from_pointer ({NS_DICTIONARY_API}.dictionary)
		end

	make_with_object_for_key (a_object, a_key: NS_OBJECT)
		do
			make_from_pointer ({NS_DICTIONARY_API}.dictionary_with_object_for_key (a_object.item, a_key.item))
		end

	make_with_objects_for_keys (a_objects, a_keys: NS_ARRAY[NS_OBJECT])
			-- Creates a dictionary containing entries constructed from the contents of an array of keys and an array of values.
		require
			same_count: a_objects.count = a_keys.count
		do
			make_from_pointer ({NS_DICTIONARY_API}.dictionary_with_objects_for_keys (a_objects.object_item, a_keys.object_item))
		end

feature -- Accessing Keys and Values

	object_for_key (a_key: POINTER): POINTER
		do
			Result := {NS_DICTIONARY_API}.object_for_key (item, a_key)
		end
end
