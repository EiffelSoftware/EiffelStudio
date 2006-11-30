
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

create
	make
	
feature
	make is
		local
			a, b: ANY
			f: RAW_FILE
			mem: MEMORY
		do
			a := compound_object (75000)
			create f.make_open_write ("data")
			f.independent_store (a)
			f.close

			create mem
			mem.collect
			mem.full_collect
			mem.full_coalesce
			mem.full_collect
	
			create f.make_open_read ("data")
			b := f.retrieved
			f.close
			
			print (deep_equal (a, b))
			io.new_line
			
			memory_consistency_test
		end
		
feature

	memory_consistency_test is
			-- 
		local
			i: INTEGER
			p: POINTER
		do
			from
				i := 0
			until
				i > 10
			loop
				p := calloc (65000, 4)
				i := i + 1
			end
		end
		
	calloc (n, s: INTEGER): POINTER is
		external
			"C signature (unsigned int, unsigned int): EIF_POINTER use %"eif_malloc.h%""
		alias
			"eif_rt_xcalloc"
		end
		
	compound_object (count: INTEGER): ARRAY [ANY] is
		require
			multiple_copies: count > 1
		local
			i: INTEGER
			obj: STRING
		do
			from
				create {ARRAY [STRING]} Result.make (1, count)
				i := 1
			until
				i > count
			loop
				create obj.make (0)
				Result.put (obj, i)
				i := i + 1
			end
		end

end
