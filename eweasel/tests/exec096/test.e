
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	EXCEPTIONS
	MEM_CONST
create
	make
feature
	make (args: ARRAY [STRING])
		local
			k, count: INTEGER;
		do
			no_message_on_failure
			count := args.item (1).to_integer ;
			create mem.make (Eiffel_memory);
			from 
				k := 1; 
			until 
				k > count 
			loop
				try (args.item (2).to_integer);
				k := k + 1;
			end
		end
	
	try (max: INTEGER)
		local
			tried: BOOLEAN
			count: INTEGER;
		do
			if count < max then
				weasel;
			end
		rescue
			count := count + 1;
			retry;
		end
	
	weasel
		local
			x: TEST1;
			y: INTEGER;
		do
			y := x.wimp;
		end
	
	mem: MEM_INFO;

	threshold: INTEGER = 4_000_000;

	check_memory
		do
			mem.update (C_memory);
			if mem.used > threshold then
				io.putstring ("C memory used is ");
				io.putint (mem.used);
				io.putstring (" bytes - probably have a memory leak%N")
				die (0);
			end
		end
	
end
