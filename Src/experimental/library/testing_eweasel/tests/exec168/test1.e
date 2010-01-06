
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
feature
	
	weasel (k: DOUBLE): DOUBLE is
		external 
			"C inline"
		alias
			"floor($k)"
		end

	stoat (k: DOUBLE): DOUBLE is
		external 
			"C use <math.h>"
		alias
			"floor"
		end

	ermine (k: DOUBLE): DOUBLE is
		external 
			"C signature (double): double use <math.h>"
		alias
			"floor"
		end

	infix "@@@1" (k: DOUBLE): DOUBLE is
		external 
			"C inline"
		alias
			"floor($k)"
		end

	infix "@@@2" (k: DOUBLE): DOUBLE is
		external 
			"C use <math.h>"
		alias
			"floor"
		end

	infix "@@@3" (k: DOUBLE): DOUBLE is
		external 
			"C signature (double): double use <math.h>"
		alias
			"floor"
		end

	try is
		do
			io.put_double (weasel (47.9)); io.new_line;
			io.put_double (ermine (48.9)); io.new_line;
			io.put_double (stoat (49.9)); io.new_line;
			io.put_double (Current @@@1 29.9); io.new_line;
			io.put_double (Current @@@2 30.9); io.new_line;
			io.put_double (Current @@@3 31.9); io.new_line;
		end
end
