note
	description: "[
	Test objects for serialization, filled in with attributes of the following types:
	ARRAY [ANY], ARRAY2 [ANY], SPECIAL [ANY],
	ARRAYED_LIST [ANY], LINKED_LIST [ANY],
	HASH_TABLE [ANY, STRING], TUPLE [ANY, INTEGER, STRING].
	The specific values inserted into the data structures are of the expanded type
	INTEGER
	]"
	author: "Marco Piccioni"
	date: "$Date$"
	revision: "$Revision$"

class
	DATA_STRUCTURES_CLASS_2

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create polymorphic_linked_list.make
			polymorphic_linked_list.extend ("7")
			polymorphic_linked_list.forth
			polymorphic_linked_list.extend (3)
		end

feature -- Access

	polymorphic_linked_list: LINKED_LIST [ANY]

end
