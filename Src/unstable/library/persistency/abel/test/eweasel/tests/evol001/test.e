note
	description: "Objects of this class are meant to test serialization on file, using different strategies."
	author: "Marco Piccioni"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create manager.make ("version_1")
			if argument (1).same_string ("serialize") then
				serialize
			elseif argument (1).same_string ("deserialize") then
				deserialize
			end
		end

feature -- Access

	manager: PERSISTENCE_MANAGER
			-- EiffelStore2 client API for serialization.

	object_to_store: FLAT_CLASS
			-- The object on which the schema evolution tests will be performed.
		do
			create Result.make
		end

feature -- Basic operations

	serialize
				-- Store version 1 of object_to_store.
		do
			manager.store (object_to_store)
			print ("OK%N")
		end

	deserialize
				-- Retrieve version 1 of object_to_store into version 2 class structure.
		do
			manager.retrieve
			if attached {FLAT_CLASS} (manager.retrieved_items.i_th (1)) as l_obj then
				if l_obj.is_deep_equal (object_to_store) then
					print ("OK%N")
				end
			end
		end

end
