indexing
	description	: "System's root class"

class
	TEST

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		do
				-- 8 bit
			io.put_string ("8bit tests%N")
			io.put_boolean (0 = 0c0)
			io.put_new_line
			io.put_boolean (0 = 0b0)
			io.put_new_line
			io.put_boolean (0xA5 = 0c245)
			io.put_new_line
			io.put_boolean (0xA5 = 0b1010_0101)
			io.put_new_line
			io.put_boolean (0c245 = 0b010_100_101)
			io.put_new_line
			io.put_boolean (0c377 = 0b11_111_111)
			io.put_new_line
				-- 64 bit
			io.put_string ("64bit tests%N")
			io.put_boolean (0xFFFF_FFFF_FFFF_FFFF = 0c1_777_777_777_777_777_777_777)
			io.put_new_line
			io.put_boolean (0xFFFF_FFFF_FFFF_FFFF = 0b11111111_11111111_11111111_11111111_11111111_11111111_11111111_11111111)
			io.put_new_line
			io.put_boolean (0xDEAD_BEEF_FFFF_FFFF = 0b11011110_10101101_10111110_11101111_11111111_11111111_11111111_11111111)
			io.put_new_line
			io.put_boolean (0b1_101_111_010_101_101_101_111_101_110_111_111_111_111_111_111_111_111_111_111_111_111 = 0c1_572_555_756_777_777_777_777)
			io.put_new_line
				-- negative numbers
			io.put_string ("negative numbers tests%N")
			io.put_boolean (-0xBABE = -0b10111010_10111110)
			io.put_new_line
			io.put_boolean (-0xBABE = -0c135276)
			io.put_new_line
				-- leading zeros
			io.put_string ("leading zeros%N")
			io.put_boolean (0xFF = 0b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011111111)
			io.put_new_line
			io.put_boolean (0x1FF = 0c000000000000000000000000000000000000000000000000000000000777)
			io.put_new_line
		end

end
