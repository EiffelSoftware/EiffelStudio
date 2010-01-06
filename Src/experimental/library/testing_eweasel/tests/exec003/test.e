
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce problem:
	-- Compile classes as is.  Compiler does not complain, even
	-- though actual generic parameter REAL does not conform to
	-- DOUBLE.
	-- Finish_freezing.  Execute `test'.  Output is not as expected.
class 
	TEST
inherit 
	TEST1 [$ACTUAL_GENERIC]
		rename
			square as square_real
		end;
		
	TEST1 [DOUBLE]
		rename
			square as square_double
		select
			square_double
		end;

	DOUBLE_MATH;

creation	
	make
feature
	
	make is 
		local
			r: REAL;
			d: DOUBLE;
			n1, n2: NUMERIC;
		do
			n1 := r;
			n2 := d;
			io.putstring ("Real conforms to double: ");
			io.putbool (n1.conforms_to (n2)); io.new_line;
			r := square_real ({REAL_32} 9.876543).truncated_to_real;
			d := square_double (9.876543);
			io.putstring ("Real square of 9.876543: ");
			io.putreal (r); io.new_line;
			io.putstring ("Double square of 9.876543: ");
			io.putdouble (d); io.new_line;
			io.putstring ("Double square minus real square close to zero: ");
			io.putbool (dabs (d - r) < 1.0); io.new_line;
		end;


end
