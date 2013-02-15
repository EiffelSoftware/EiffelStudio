
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
			i: INTEGER
		do
			create manu.make ("Fdsfds", 123, 1)
			store_object (manu, "stored")
			across retrieved_objects ("stored") as l_object loop
				if not attached l_object.item then
					io.put_string ("No object was retrieved!!%N")
				end
				i := i + 1
			end
			if i /= storable_types.count then
				io.put_string ("Cannot retrieve all storables%N")
			end
		end 
		
	a: ARRAY [expanded A]

end
