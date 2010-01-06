
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
			b64: INTEGER_64
			b32: INTEGER
			b16: INTEGER_16
			b8: INTEGER_8
		do
			b64 := 0
			b32 := 0
			b16 := 0
			b8 := 0
			print (double_to_integer (b64.bit_shift (1))); io.new_line
			print (double_to_integer (b32.bit_shift (1))); io.new_line
			print (double_to_integer (b16.bit_shift (1))); io.new_line
			print (double_to_integer (b8.bit_shift (1))); io.new_line
			
			print (i64_to_integer (b64.bit_shift (1))); io.new_line
			print (i64_to_integer (b32.bit_shift (1))); io.new_line
			print (i64_to_integer (b16.bit_shift (1))); io.new_line
			print (i64_to_integer (b8.bit_shift (1))); io.new_line
			
			print (i32_to_integer (b32.bit_shift (1))); io.new_line
			print (i32_to_integer (b16.bit_shift (1))); io.new_line
			print (i32_to_integer (b8.bit_shift (1))); io.new_line
			
			print (i16_to_integer (b16.bit_shift (1))); io.new_line
			print (i16_to_integer (b8.bit_shift (1))); io.new_line
			
			print (i8_to_integer (b8.bit_shift (1))); io.new_line
			
		end

        double_to_integer (n: DOUBLE): INTEGER is
                do
                end

        i64_to_integer (n: INTEGER_64): INTEGER is
                do
                end

        i32_to_integer (n: INTEGER): INTEGER is
                do
                end

        i16_to_integer (n: INTEGER_16): INTEGER_16 is
                do
                end

        i8_to_integer (n: INTEGER_8): INTEGER_8 is
                do
                end

end
