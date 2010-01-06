
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature
	make is
		local
			list: TWO_WAY_LIST [TEST2];
			k: INTEGER;
			f: RAW_FILE
			x: TEST2
		do
			from
				!!list.make;
				k := 1
			until
				k > 1000
			loop
				list.put_front (x);
				k := k + 1;
			end;
			create f.make_open_write ("object")
			f.independent_store (list)
			f.close
			list := Void
			io.putstring ("Starting retrieve%N");
			create f.make_open_read ("object")
			list ?= f.retrieved
			f.close
			print (f /= Void); io.new_line
		end

end
