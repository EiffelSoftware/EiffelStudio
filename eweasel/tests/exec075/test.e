
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	MEM_CONST
create
	make

feature

	make (args: ARRAY [STRING])
		local
			k, interval, max: INTEGER;
		do 
			create mem.make (Eiffel_memory);
			interval :=  args.item (1).to_integer;
			max :=  args.item (2).to_integer;
			from
				k := 1;
			until
				k > max
			loop
				if (k \\ interval) = 0 then
					verify_memory_consistency;
				end ;
				create s.make (k);
				k := k + 1;
			end
		end;

	s: STRING;
			
	verify_memory_consistency
		do
			mem.update (Eiffel_memory);
			check_memory (mem);
			mem.update (C_memory);
			check_memory (mem);
			mem.update (Total_memory);
			check_memory (mem);
		end
	
	mem: MEM_INFO;

	check_memory (m: MEM_INFO)
		do
			if m.used < 0 or m.free < 0 or m.overhead < 0 or
			   m.total < 0 or (m.used + m.free + m.overhead /=
			   m.total) then
				display_memory (m);
			end
		end
	
	display_memory (m: MEM_INFO)
		do
			io.putint (m.type);
			io.putchar ('%T');
			io.putint (m.used);
			io.putchar ('%T');
			io.putint (m.free);
			io.putchar ('%T');
			io.putint (m.overhead);
			io.putchar ('%T');
			io.putint (m.total);
			io.new_line;
		end
end
