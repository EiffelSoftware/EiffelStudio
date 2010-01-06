
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	EXCEPTIONS
creation
	make
feature
	
	make is
		do
			f
		end
			
	f is
		do
		ensure
			true_statement: val implies old g = g
		end

	val: BOOLEAN is $VAL

	g: INTEGER is
		do
			io.put_string ("In g%N")
		end
			
end
