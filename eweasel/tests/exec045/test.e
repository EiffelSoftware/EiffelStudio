
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature
	make (args: ARRAY [STRING]) is
		do
			try;
			show (z);
			waste_memory (args.item (1).to_integer);
			show (z);
		end
	
	try is
		local
			$LOCAL
		do
			z := m.try;
			show (z);
		end
	
	$ATTRIBUTE;
	
	show (arg: TEST1) is
		do
			print (arg.s); io.new_line;
		end
	
	waste_memory (limit: INTEGER) is
		local
			k: INTEGER;
			s: STRING;
		do
			from
				k := 1;
			until
				k > limit
			loop
				create s.make (100);
				s.fill_blank;
				k := k + 1;
			end
		end
	

	z: TEST1;
end
