
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create 
	make
feature
	make is
		do
		end

	stoat (p: like b) is
		external
			"C++ delete abc use <stdio.h>"
		end

	cpp_new (AString: POINTER): like b is 
			-- Call single constructor of C++ class.
		external
			"C++ [new MyString %"mystring.h%"] (char *)"
		end

	b: POINTER
end
