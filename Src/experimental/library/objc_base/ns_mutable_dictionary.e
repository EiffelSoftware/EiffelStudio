note
	description: "Eiffel wrapper for NSMutableDictionary."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MUTABLE_DICTIONARY

inherit
	NS_DICTIONARY

create
	make,
	make_with_capacity
create {NS_OBJECT}
	make_from_pointer,
	share_from_pointer

feature -- Creating and Initializing a Mutable Dictionary

	make_with_capacity (a_capacity: like ns_uinteger)
			-- Creates a mutable dictionary, initially giving it enough allocated memory to hold a given number of entries.
		do
			make_from_pointer ({NS_MUTABLE_DICTIONARY_API}.alloc)
			item := {NS_MUTABLE_DICTIONARY_API}.init_with_capacity (item, a_capacity)
		end

feature -- Adding Entries to a Mutable Dictionary

	set_object_for_key (a_object: NS_OBJECT; a_key: NS_OBJECT)
		do
			{NS_MUTABLE_DICTIONARY_API}.set_object_for_key (item, a_object.item, a_key.item)
		end

feature -- Removing Entries From a Mutable Dictionary

end
