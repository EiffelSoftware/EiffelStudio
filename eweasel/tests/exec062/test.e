
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make
feature
	
	make
		local
			x: TEST1 [STRING];
			y, z: TEST1 [SEQ_STRING];
		do 
			create x ;
			create z;
			x.set_weasel ("weasel");
			io.putbool (x.conforms_to (z)); io.new_line;
			y ?= x;
			if y /= Void then
				io.putstring ("Conforms%N");
				y.weasel.search_string_before ("weasel", 0);
			end
		end
		
end
