
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make
feature

	make (args: ARRAY [STRING])
		do
			try (args.item (1).to_integer);
			io.putstring (x.weasel); io.new_line;
			waste_memory (args.item (1).to_integer);
			io.putstring (x.weasel); io.new_line;
		end;

	try (limit: INTEGER)
		local
			source: TEST1;
		do 
			create source;
			source.sub_object.set_weasel ("weasel");
			x ?= source.sub_object;
			if x /= Void then
				io.putstring (x.weasel); io.new_line;
			else
				io.putstring ("Void%N");
			end
		end;

	x: TEST2;

	waste_memory (limit: INTEGER)
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
	
end
