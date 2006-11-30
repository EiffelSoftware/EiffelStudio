
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.
     
class TEST

creation
	make

feature 
	make is
		local
			k: INTEGER
			array: ARRAY [STRING]
		do
			!!the_keys.make (1, 1);
			the_keys.put ("weasel", 1)
			array := current_keys;
			from
				k := array.lower
			until
				k > array.upper
			loop
				io.put_string (array.item (k)); io.new_line;
				k := k + 1
			end
		end

	current_keys: ARRAY [STRING] is
		local 
			k, count: INTEGER
		do  
			from  
				k := 1;
		  		count := the_keys.count;
		  		!!Result.make (1, count);
	    		until 
				k > count
	    		loop  
				Result.put (the_keys.item (k), k)
		  		k := k + 1
	    		end
		end;
	
	the_keys: ARRAY [STRING]

end
