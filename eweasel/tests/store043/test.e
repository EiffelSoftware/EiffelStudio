note
	description: "System's root class"

class
	TEST

inherit
	SERIALIZATION_HELPER

	ARGUMENTS

create
	make, default_create

feature -- Initialization

	make
			-- Creation procedure.
		local
			l_obj: ANY
			l_objects: like retrieved_objects
			l_expected_successful_retrieval: INTEGER
		do
			set_is_pointer_value_stored (True)
				-- Only store the object when no argument is provided
			if argument_count = 0 then
				l_obj := (create {STORABLE_TEST}.make)
				store_object (l_obj, "stored")
				l_expected_successful_retrieval := recoverable_types.count
			end
			l_objects := retrieved_recoverable_objects ("stored")
			if l_objects.count /= l_expected_successful_retrieval then
				io.put_string ("Got " + l_objects.count.out + " successful retrieval when " + l_expected_successful_retrieval.out + " should have succeeded%N")
				across l_objects as l_item loop
					io.put_string ("Retrieved " + l_item.key + "%N")
					if attached {STORABLE_TEST} l_item.item as l_stored_obj then
						l_stored_obj.test
					else
						io.put_string ("Not of a valid type%N")
					end
				end
			end
		end

end
