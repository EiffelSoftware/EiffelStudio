class
	TEST

inherit
	SERIALIZATION_HELPER

create
	make

feature -- Initialization

	make
			-- Creation procedure.
		local
			a: A
			b: B
			l_objects: like retrieved_objects
			l_counter: INTEGER
		do
			create b
			create a.make_reference

			set_is_pointer_value_stored (True)
			store_object (a, "stored_reference")
			l_objects := retrieved_objects ("stored_reference")
			if l_objects.count /= storable_types.count then
				io.put_string ("Error occurred. List of successful retrieval:%N")
				across l_objects as l_item loop
					io.put_string ("Retrieved " + l_item.key + "%N")
				end
			else
				across l_objects as l_item loop
					if attached {A} l_item.item as l_a then
						if l_a.b1 = l_a.b2 then
							io.put_string ("In " + l_item.key + " retrieval: %N")
							io.put_string ("b1 and b2 should not be equal%N")
						end
					else
						io.put_string ("In " + l_item.key + " retrieval:%N")
						io.put_string ("Unable to retrieve the items%N")
					end
				end
			end

			create a.make_expanded

			set_is_pointer_value_stored (True)
			store_object (a, "stored_expanded")
			l_objects := retrieved_objects ("stored_expanded")
			if l_objects.count /= storable_types.count then
				io.put_string ("Error occurred. List of successful retrieval:%N")
				across l_objects as l_item loop
					io.put_string ("Retrieved " + l_item.key + "%N")
				end
			else
				across l_objects as l_item loop
					if attached {A} l_item.item as l_a then
						l_counter := b.counter.item
						if l_a.b1 /= l_a.b2 then
							io.put_string ("In " + l_item.key + " retrieval: %N")
							io.put_string ("b1 and b2 should be equal%N")
						elseif b.counter.item = l_counter then
							io.put_string ("In " + l_item.key + " retrieval: %N")
							io.put_string ("{B}.is_equal was not called%N")
						end
					else
						io.put_string ("In " + l_item.key + " retrieval: %N")
						io.put_string ("Unable to retrieve the items%N")
					end
				end
			end
		end

end
