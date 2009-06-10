note
	description: "Wrapper for NSDictionary."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_DICTIONARY

inherit
	NS_OBJECT

create
	make,
	make_with_object_for_key
create {NS_OBJECT}
	make_from_pointer

feature -- Creation

	make
		do
			make_from_pointer ({NS_DICTIONARY_API}.dictionary)
		end

	make_with_object_for_key (a_object, a_key: NS_OBJECT)
		do
			make_from_pointer ({NS_DICTIONARY_API}.dictionary_with_object_for_key (a_object.item, a_key.item))
		end

feature -- Accessing Keys and Values

	object_for_key (a_key: POINTER): POINTER
		do
			Result := {NS_DICTIONARY_API}.object_for_key (item, a_key)
		end
end
