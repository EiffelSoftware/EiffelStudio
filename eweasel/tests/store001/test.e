
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

inherit
	SERIALIZATION_HELPER

create
	make

feature -- Initialization

	make
		local
			manu: MANU [STRING]
			$LOCAL
			l_objects: like retrieved_objects
		do
			create manu.make ("Fdsfds", 123)
			store_object (manu, "stored")
			l_objects := retrieved_objects ("stored")
			if l_objects.count /= storable_types.count then
				io.put_string ("Error occurred. List of successful retrieval:%N")
				across l_objects as l_item loop
					io.put_string ("Retrieved " + l_item.key + "%N")
				end
			elseif not across l_objects as l_item all deep_equal (l_item.item, manu) end then
				io.put_string ("Some objects are not equal!%N")
			end
		end 
		
end
