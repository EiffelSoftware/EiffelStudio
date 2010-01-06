
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST 
creation
	make
feature 

	make is
		do
			char := '5';
			char_ref := char;
			print (char); io.new_line;
			print (char_ref); io.new_line;
			print (char_ref = char); io.new_line;
			print (char = char_ref); io.new_line;
			print (char_ref > char); io.new_line;
			print (char_ref >= char); io.new_line;
			print (char_ref < char); io.new_line;
			print (char_ref <= char); io.new_line;
			
			int := 5;
			int_ref := int;
			print (int); io.new_line;
			print (int_ref); io.new_line;
			print (int_ref = int); io.new_line;
			print (int = int_ref); io.new_line;
			print (int_ref > int); io.new_line;
			print (int_ref >= int); io.new_line;
			print (int_ref < int); io.new_line;
			print (int_ref <= int); io.new_line;
			
			real := {REAL_32} 5.0;
			real_ref := real;
			print (real); io.new_line;
			print (real_ref); io.new_line;
			print (real_ref = real); io.new_line;
			print (real = real_ref); io.new_line;
			print (real_ref > real); io.new_line;
			print (real_ref >= real); io.new_line;
			print (real_ref < real); io.new_line;
			print (real_ref <= real); io.new_line;
			
			double := 5.0;
			double_ref := double;
			print (double); io.new_line;
			print (double_ref); io.new_line;
			print (double_ref = double); io.new_line;
			print (double = double_ref); io.new_line;
			print (double_ref > double); io.new_line;
			print (double_ref >= double); io.new_line;
			print (double_ref < double); io.new_line;
			print (double_ref <= double); io.new_line;
		end	

	int: INTEGER;
	int_ref: INTEGER_REF;

	real: REAL;
	real_ref: REAL_REF;

	double: DOUBLE;
	double_ref: DOUBLE_REF;

	char: CHARACTER;
	char_ref: CHARACTER_REF;

end
