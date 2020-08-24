
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	SERIALIZATION_HELPER

create
	make
feature
	make
		local
			list: TWO_WAY_LIST [TEST2];
			i: INTEGER;
			x: TEST2
			l_objects: like retrieved_objects
		do
			from 
				create list.make;
				i := 1
			until
				i > 1000
			loop
				list.put_front (x);
				i := i + 1;
			end;
			store_object (list, "stored")
			l_objects := retrieved_objects ("stored")
			if l_objects.count /= storable_types.count then
				io.put_string ("Error occurred. List of successful retrieval:%N")
				across l_objects as l_item loop
					io.put_string ("Retrieved " + l_item.key + "%N")
				end
			elseif not across l_objects as l_item all deep_equal (l_item.item, list) end then
				io.put_string ("Some objects are not equal!%N")
			end
		end

end
