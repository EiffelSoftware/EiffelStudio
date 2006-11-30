
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

creation
	make
feature 

	make is
		do
			!!a.make (1, 1);
			a.put (47, 1);
			Current.weasel;
		end
			
	weasel is
		require
			show ("Precondition", a.item (1) = 47);
		local
			k: INTEGER;
		do
			io.putstring ("Weaseling%N");
			from
				k := 1
			invariant
				show ("Loop invariant", a.item (1) = 47);
			variant
				show_int ("Loop variant", k)
			until
				k < 1
			loop
				k := k - 1;
			end
			check
				show ("Check instruction", a.item (1) = 47);
			end
		ensure
			show ("Postcondition", a.item (1) = 47);
		end

	a: ARRAY [INTEGER];
	
	show (s: STRING; b: BOOLEAN): BOOLEAN is
		do
			io.putstring (s);
			io.new_line;
			Result := b;
		end

	show_int (s: STRING; i: INTEGER): INTEGER is
		do
			io.putstring (s);
			io.new_line;
			Result := i;
		end

invariant
	
	wimp: show ("Invariant", $ENTITY .item (1) = 47);

end
