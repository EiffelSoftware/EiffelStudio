
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

create
	make
feature
	make (args: ARRAY [STRING]) is
		do
			i8 := feature {INTEGER_8}.Min_value
			print (i8); io.new_line
			i8 := i8 + 1
			print (i8); io.new_line
			
			i16 := feature {INTEGER_16}.Min_value
			print (i16); io.new_line
			i16 := i16 + 1
			print (i16); io.new_line
			
			i := feature {INTEGER}.Min_value
			print (i); io.new_line
			i := i + 1
			print (i); io.new_line
			
			i64 := feature {INTEGER_64}.Min_value
			print (i64); io.new_line
			i64 := i64 + 1
			print (i64); io.new_line
			
			i8 := feature {INTEGER_8}.Max_value
			print (i8); io.new_line
			i8 := i8 - 1
			print (i8); io.new_line
			
			i16 := feature {INTEGER_16}.Max_value
			print (i16); io.new_line
			i16 := i16 - 1
			print (i16); io.new_line
			
			i := feature {INTEGER}.Max_value
			print (i); io.new_line
			i := i - 1
			print (i); io.new_line
			
			i64 := feature {INTEGER_64}.Max_value
			print (i64); io.new_line
			i64 := i64 - 1
			print (i64); io.new_line
		end

	i8: INTEGER_8
	i16: INTEGER_16
	i: INTEGER
	i64: INTEGER_64
end
