
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Finish_freezing.  Execute `test'.
	-- Dies with exception trace in routine `chunk_coalesce'
	--	(called from `full_collect').

class TEST
inherit
	EXCEPTIONS
creation
	make
feature
	make is
		local
			p, null: POINTER;
			k, len: INTEGER;
			list: LINKED_LIST [POINTER];
		do
			from
				!!list.make;
				k := 100_000
			until
				k > 150_000
			loop
				len := 4 * k + 8;
				io.putstring ("Starting iteration "); 
				io.putint (k); 
				io.putstring ("  with length "); 
				io.putint (len); 
				io.new_line;
				p := malloc (len);
				if p = null then
					io.putstring ("%NOh no!  Malloc failed.%N");
					die (1);
				end;
				-- str_blank(p, len);
				set_nongc_memory (p, ' ', len)
				big_string (k);
				if (k \\ 10) = 0 then
					free_dynamic_memory (list);
					list.wipe_out;
					eiffel_gc;
				end;
				list.extend (p);
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
			io.putstring ("Doing Eiffel GC%N");
			!!m;
			m.allocate_tiny;
			m.full_collect;
			m.full_coalesce;
		end;

	free_dynamic_memory (list: LINKED_LIST [POINTER]) is
		local
		do
			from
				list.start;
			until
				list.after
			loop
				free (list.item);
				list.forth;
			end
		end;

feature {NONE}

	malloc (count: INTEGER): POINTER is
		external
			"C use <stdlib.h>"
		end;

	free (p: POINTER) is
		external
			"C use <stdlib.h>"
		end;

	-- str_blank (c_string: POINTER; n: INTEGER) is
			-- Fill `c_string' with `n' blanks.
		-- external
			-- "C"
		-- end;

	set_nongc_memory (dest: POINTER; c: CHARACTER size: INTEGER) is
			-- Set `size' bytes of memory starting at
			-- `dest' to `c'
		require
			nonnegative_size: size >= 0;
		external
			"C | <string.h>"
		alias
			"memset"
		end;
			
end

