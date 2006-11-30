
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
			test_integer_64
		end

	test_integer_64 is
		local
			b00, b01, b10, b11: INTEGER_64
			t00, t01, t10, t11: INTEGER_64
			all_zero, all_one: INTEGER_64
			k: INTEGER
		do
			b00 := 0
			b01 := 1
			b10 := 2
			b11 := 3
			t00 := b00 |<< 62
			t01 := b01 |<< 62
			t10 := b10 |<< 62
			t11 := b11 |<< 62
			all_zero := 0
			all_one := all_zero.bit_not
			
			print ("INTEGER_64 bit and%N")
			print (i64_to_hex (b00 & b00)); io.new_line
			print (i64_to_hex (b00 & b01)); io.new_line
			print (i64_to_hex (b00 & b10)); io.new_line
			print (i64_to_hex (b00 & b11)); io.new_line
			print (i64_to_hex (b01 & b00)); io.new_line
			print (i64_to_hex (b01 & b01)); io.new_line
			print (i64_to_hex (b01 & b10)); io.new_line
			print (i64_to_hex (b01 & b11)); io.new_line
			print (i64_to_hex (b10 & b00)); io.new_line
			print (i64_to_hex (b10 & b01)); io.new_line
			print (i64_to_hex (b10 & b10)); io.new_line
			print (i64_to_hex (b10 & b11)); io.new_line
			print (i64_to_hex (b11 & b00)); io.new_line
			print (i64_to_hex (b11 & b01)); io.new_line
			print (i64_to_hex (b11 & b10)); io.new_line
			print (i64_to_hex (b11 & b11)); io.new_line
			
			print ("INTEGER_64 bit or%N")
			print (i64_to_hex (b00 | b00)); io.new_line
			print (i64_to_hex (b00 | b01)); io.new_line
			print (i64_to_hex (b00 | b10)); io.new_line
			print (i64_to_hex (b00 | b11)); io.new_line
			print (i64_to_hex (b01 | b00)); io.new_line
			print (i64_to_hex (b01 | b01)); io.new_line
			print (i64_to_hex (b01 | b10)); io.new_line
			print (i64_to_hex (b01 | b11)); io.new_line
			print (i64_to_hex (b10 | b00)); io.new_line
			print (i64_to_hex (b10 | b01)); io.new_line
			print (i64_to_hex (b10 | b10)); io.new_line
			print (i64_to_hex (b10 | b11)); io.new_line
			print (i64_to_hex (b11 | b00)); io.new_line
			print (i64_to_hex (b11 | b01)); io.new_line
			print (i64_to_hex (b11 | b10)); io.new_line
			print (i64_to_hex (b11 | b11)); io.new_line
			
			print ("INTEGER_64 bit xor%N")
			print (i64_to_hex (b00.bit_xor (b00))); io.new_line
			print (i64_to_hex (b00.bit_xor (b01))); io.new_line
			print (i64_to_hex (b00.bit_xor (b10))); io.new_line
			print (i64_to_hex (b00.bit_xor (b11))); io.new_line
			print (i64_to_hex (b01.bit_xor (b00))); io.new_line
			print (i64_to_hex (b01.bit_xor (b01))); io.new_line
			print (i64_to_hex (b01.bit_xor (b10))); io.new_line
			print (i64_to_hex (b01.bit_xor (b11))); io.new_line
			print (i64_to_hex (b10.bit_xor (b00))); io.new_line
			print (i64_to_hex (b10.bit_xor (b01))); io.new_line
			print (i64_to_hex (b10.bit_xor (b10))); io.new_line
			print (i64_to_hex (b10.bit_xor (b11))); io.new_line
			print (i64_to_hex (b11.bit_xor (b00))); io.new_line
			print (i64_to_hex (b11.bit_xor (b01))); io.new_line
			print (i64_to_hex (b11.bit_xor (b10))); io.new_line
			print (i64_to_hex (b11.bit_xor (b11))); io.new_line
			
			print ("INTEGER_64 bit not%N")
			print (i64_to_hex (b00.bit_not)); io.new_line
			print (i64_to_hex (b01.bit_not)); io.new_line
			print (i64_to_hex (b10.bit_not)); io.new_line
			print (i64_to_hex (b11.bit_not)); io.new_line
			print (i64_to_hex (all_zero.bit_not)); io.new_line
			print (i64_to_hex (all_one.bit_not)); io.new_line
			
			print ("INTEGER_64 bit shift left%N")
			from k := 0 until k > 64 loop
				print (i64_to_hex (b00 |<< k)); io.new_line
				k := k + 1
			end
			from k := 0 until k > 64 loop
				print (i64_to_hex (b01 |<< k)); io.new_line
				k := k + 1
			end
			from k := 0 until k > 64 loop
				print (i64_to_hex (b10 |<< k)); io.new_line
				k := k + 1
			end
			from k := 0 until k > 64 loop
				print (i64_to_hex (b11 |<< k)); io.new_line
				k := k + 1
			end
			print (i64_to_hex (b00 |<< 64)); io.new_line
			print (i64_to_hex (b01 |<< 64)); io.new_line
			print (i64_to_hex (b10 |<< 64)); io.new_line
			print (i64_to_hex (b11 |<< 64)); io.new_line
			from k := 0 until k > 64 loop
				print (i64_to_hex (all_one |<< k)); io.new_line
				k := k + 1
			end
			
			print ("INTEGER_64 bit shift right%N")
			print (i64_to_hex (b00 |>> 64)); io.new_line
			print (i64_to_hex (b01 |>> 64)); io.new_line
			print (i64_to_hex (b10 |>> 64)); io.new_line
			print (i64_to_hex (b11 |>> 64)); io.new_line
			from k := 0 until k > 64 loop
				print (i64_to_hex (t00 |>> k)); io.new_line
				k := k + 1
			end
			from k := 0 until k > 64 loop
				print (i64_to_hex (t01 |>> k)); io.new_line
				k := k + 1
			end
			from k := 0 until k > 64 loop
				print (i64_to_hex (t10 |>> k)); io.new_line
				k := k + 1
			end
			from k := 0 until k > 64 loop
				print (i64_to_hex (t11 |>> k)); io.new_line
				k := k + 1
			end
			from k := 0 until k > 64 loop
				print (i64_to_hex (all_one |>> k)); io.new_line
				k := k + 1
			end
			
			
			print ("INTEGER_64 bit shift (positive)%N")
			from k := 0 until k > 64 loop
				print (i64_to_hex (b00.bit_shift (k))); io.new_line
				k := k + 1
			end
			from k := 0 until k > 64 loop
				print (i64_to_hex (b01.bit_shift (k))); io.new_line
				k := k + 1
			end
			from k := 0 until k > 64 loop
				print (i64_to_hex (b10.bit_shift (k))); io.new_line
				k := k + 1
			end
			from k := 0 until k > 64 loop
				print (i64_to_hex (b11.bit_shift (k))); io.new_line
				k := k + 1
			end
			from k := 0 until k > 64 loop
				print (i64_to_hex (all_one.bit_shift (k))); io.new_line
				k := k + 1
			end
			
			print ("INTEGER_64 bit shift (negative)%N")
			from k := 0 until k > 64 loop
				print (i64_to_hex (t00.bit_shift (-k))); io.new_line
				k := k + 1
			end
			from k := 0 until k > 64 loop
				print (i64_to_hex (t01.bit_shift (-k))); io.new_line
				k := k + 1
			end
			from k := 0 until k > 64 loop
				print (i64_to_hex (t10.bit_shift (-k))); io.new_line
				k := k + 1
			end
			from k := 0 until k > 64 loop
				print (i64_to_hex (t11.bit_shift (-k))); io.new_line
				k := k + 1
			end
			from k := 0 until k < -64 loop
				print (i64_to_hex (all_one.bit_shift (k))); io.new_line
				k := k - 1
			end
			
			print ("INTEGER_64 bit test%N")
			from k := 0 until k >= 64 loop
				print (b00.bit_test (k)); io.new_line
				k := k + 1
			end
			from k := 0 until k >= 64 loop
				print (b01.bit_test (k)); io.new_line
				k := k + 1
			end
			from k := 0 until k >= 64 loop
				print (b10.bit_test (k)); io.new_line
				k := k + 1
			end
			from k := 0 until k >= 64 loop
				print (b11.bit_test (k)); io.new_line
				k := k + 1
			end
			from k := 0 until k >= 64 loop
				print (all_zero.bit_test (k)); io.new_line
				k := k + 1
			end
			from k := 0 until k >= 64 loop
				print (all_one.bit_test (k)); io.new_line
				k := k + 1
			end
			
			print ("INTEGER_64 bit set%N")
			from k := 0 until k >= 64 loop
				print (i64_to_hex (all_zero.set_bit (True, k))); io.new_line
				k := k + 1
			end
			from k := 0 until k >= 64 loop
				print (i64_to_hex (all_one.set_bit (False, k))); io.new_line
				k := k + 1
			end
			
			print ("INTEGER_64 bit set with mask%N")
			from k := 0 until k >= 64 loop
				print (i64_to_hex (all_zero.set_bit_with_mask (True, ((1).to_integer_64 |<< k)))); io.new_line
				k := k + 1
			end
			from k := 0 until k >= 64 loop
				print (i64_to_hex (all_one.set_bit_with_mask (False, ((1).to_integer_64 |<< k)))); io.new_line
				k := k + 1
			end
			
		end

        i64_to_hex (n: INTEGER_64): STRING is
                        -- Convert `n' into an hexadecimal string.
                local
                        i: INTEGER
                        val, a_digit: INTEGER_64
                do
                        from
                                i := 64 // 4
                                create Result.make (i)
                                Result.fill_blank
                                val := n
                        until
                                i = 0
                        loop
                                a_digit := (val & 0xF)
                                Result.put (to_hex_character (a_digit), i)
                                val := val |>> 4
                                i := i - 1
                        end
                ensure
                        Result_not_void: Result /= Void
                        Result_valid_count: Result.count = 64 // 4
                end

        to_hex_character (n: INTEGER_64): CHARACTER is
                        -- Convert `n' into an hexadecimal character.
                require
                        in_bounds: 0 <= n and n <= 15
                do
                        if n <= 9 then
                                Result := (n + ('0').code).to_character_8
                        else
                                Result := (('A').code + (n - 10)).to_character_8
                        end
                ensure
                        valid_character: ("0123456789ABCDEF").has (Result)
                end


end
