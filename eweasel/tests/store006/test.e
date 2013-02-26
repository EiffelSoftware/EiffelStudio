class TEST
inherit
	SERIALIZATION_HELPER

create
	make

feature {NONE} -- Initialization

	make
		local
			l_objects: like retrieved_objects
			sa: STORABLE_A55
		do
			create sa
			store_object (sa, "stored")
			l_objects := retrieved_objects ("stored")
			if l_objects.count /= storable_types.count then
				io.put_string ("Error occurred. List of successful retrieval:%N")
				across l_objects as l_item loop
					io.put_string ("Retrieved " + l_item.key + "%N")
				end
			elseif not across l_objects as l_item all deep_equal (l_item.item, sa) end then
				io.put_string ("Some objects are not equal!%N")
			end
		end

end
