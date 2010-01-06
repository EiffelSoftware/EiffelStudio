
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
			i8: INTEGER_8
			i16: INTEGER_16
			i32: INTEGER
			i64: INTEGER_64
		do
			i8 := (1).to_integer_8
			i16 := (1).to_integer_16
			i32 := 1
			i64 := (1).to_integer_64

			print (i8) print ("%N")
			print (i16) print ("%N")
			print (i32) print ("%N")
			print (i64) print ("%N")

			i8 := -i8
			i16 := -i16
			i32 := -i32
			i64 := -i64

			print (i8) print ("%N")
			print (i16) print ("%N")
			print (i32) print ("%N")
			print (i64) print ("%N")
		end
end
