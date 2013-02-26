note
	description: "System's root class"

class
	TEST

inherit
	SERIALIZATION_HELPER

create
	make, default_create

feature -- Initialization

	make
			-- Creation procedure.
		local
			l_obj: ANY
			l_objects: like retrieved_objects
		do
			set_is_pointer_value_stored (True)
			l_obj := (create {STORABLE_TEST}.make)
			store_object (l_obj, "stored")
			l_objects := retrieved_objects ("stored")
			if l_objects.count /= storable_types.count then
				io.put_string ("Error occurred. List of successful retrieval:%N")
				across l_objects as l_item loop
					io.put_string ("Retrieved " + l_item.key + "%N")
				end
			elseif not across l_objects as l_item all deep_equal (l_item.item, l_obj) end then
				io.put_string ("Some objects are not equal!%N")
			end
		end

end
