
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
			n: DOUBLE
		do
			n := 1.0
			print (sum (n, n, n, n, n, n, n, n, n, n, n, n));
			io.new_line
		end

	sum (n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12: DOUBLE): DOUBLE is
		external "C inline"
		alias "$n1 + $n2 + $n3 + $n4 + $n5 + $n6 + $n7 + $n8 + $n9 + $n10 + $n11 + $n12"
		end


end
