
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	EXCEPTIONS
	MEM_CONST
creation
	make
feature
	make (args: ARRAY [STRING]) is
		local
			k, count: INTEGER;
		do
			count := args.item (1).to_integer;
			wimp := "wimp";
			create mem.make (Eiffel_memory);
			from 
				k := 1; 
			until 
				k > count 
			loop
				$CALLED_ROUTINE (args.item (2).to_integer);
				verify_memory_consistency;
				k := k + 1;
			end
		end
	
	$NEW_ROUTINE

	try (max: INTEGER) is
		local
			count: INTEGER;
		do
			if count < max then
				weasel;
			end
		rescue
			if is_developer_exception then
				count := count + 1;
				retry;
			end
		end
	
	weasel is
		do
			turkey;
		end
	
	wimp: STRING;
	
	turkey is
		do
			raise ("weasels");
			$INSTRUCTION
		end
	
	mem: MEM_INFO;

	verify_memory_consistency is
		do
			mem.update (Eiffel_memory);
			check_memory (mem);
			mem.update (C_memory);
			check_memory (mem);
			mem.update (Total_memory);
			check_memory (mem);
		end
	
	check_memory (m: MEM_INFO) is
		do
			if m.used < 0 or m.free < 0 or m.overhead < 0 or
			   m.total < 0 or (m.used + m.free + m.overhead /=
			   m.total) then
				display_memory (m);
			end
		end
	
	display_memory (m: MEM_INFO) is
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
