
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is with `assertion (ensure)'.  
	-- Finish_freezing.  Execute `test 10000'.

class TEST

inherit
	ARGUMENTS
create
	make
feature

	make
		local
			s: STRING;
			k, count: INTEGER;
		do
			count := argument (1).to_integer ;
			create s.make (20);
			s.append ("turkey");
			from
				k := 1;
			until
				k > count
			loop
				io.putstring (concat (
					<< "Hey there ", int_to_string (k), "%N" >>));
				k := k + 1;
			end
		end;

	animal: STRING = "weasel";

	concat (list: ARRAY [STRING]): STRING
		local
			k, total_len: INTEGER;
		do
			from
				k := list.lower;
			until
				k > list.upper
			loop
				total_len := total_len + list.item (k).count;
				k := k + 1;
			end ;
			
			create Result.make (total_len);
			from
				k := list.lower;
			until
				k > list.upper
			loop
				Result.append (list.item (k));
				k := k + 1;
			end
		end;

	int_to_string (n: INTEGER): STRING
		do 
			create Result.make (13);
			Result.append_integer (n);
		end;
	
	double_to_string (n: DOUBLE): STRING
		do 
			create Result.make (13);
			Result.append_double (n);
		end
end

