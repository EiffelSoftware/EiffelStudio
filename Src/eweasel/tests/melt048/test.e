
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
			i8 := i8
			
			i16 := i8
			i16 := i16
			
			i32 := i8
			i32 := i16
			i32 := i32
			
			i64 := i8
			i64 := i16
			i64 := i32
			i64 := i64
			print (i8); io.new_line
			print (i16); io.new_line
			print (i32); io.new_line
			print (i64); io.new_line
		end;

	i8: INTEGER_8
	i16: INTEGER_16
	i32: INTEGER
	i64: INTEGER_64
	
end
