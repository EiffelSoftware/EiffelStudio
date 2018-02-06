--| Copyright (c) 1993-2018 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

expanded class TEST1

inherit
	ANY
		redefine
			default_create
		end

create
	default_create,
	make

feature	
	default_create
		do
			make
		end

	make
		external
			"C | %"eif_garcol.h%""
		alias 
			"eif_gc_run"
		end

	weasel is
		do
			io.putstring ("In weasel%N");
		end

end
