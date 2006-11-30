
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Finish_freezing.  Execute `test'.
	-- Finally runs out of memory.

class TEST
creation
	make
feature
	make is
		local
			s: STRING;
			k, len: INTEGER;
			list: LINKED_LIST [STRING];
		do
			from
				!!list.make;
				k := 100_000
			until
				k > 300_000
			loop
				len := 4 * k + 8;
				if k \\ 10000 = 0 then
					io.put_string ("Starting iteration "); 
					io.put_integer (k); 
					io.put_string (" with length "); 
					io.put_integer (len); 
					io.new_line;
				end
				!!s.make (len);
				s.fill_blank;
				big_string (k);
				if (k \\ 10) = 0 then
					list.wipe_out;
					eiffel_gc;
				end;
				list.extend (s);
				k := k + 1;
			end
		end;
		
	big_string (count: INTEGER) is
		local
			s: STRING;
		do
			!!s.make (count);
			s.fill_blank;
		end;

	eiffel_gc is
		local
			m: MEMORY;
		do
			-- io.putstring ("Doing Eiffel GC%N");
			!!m;
			m.allocate_tiny;
			m.full_collect;
			m.full_coalesce;
		end;

end

