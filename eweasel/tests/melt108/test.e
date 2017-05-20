class TEST

create

	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			xi1, yi1: INTEGER_8
			xi2, yi2: INTEGER_16
			xi4, yi4: INTEGER_32
			xn1, yn1: NATURAL_8
			xn2, yn2: NATURAL_16
		do
				-- INTEGER_8
			xi1 := 1
			yi1 := 5
			across
				xi1 |..| yi1 as i
			loop
				io.put_integer (i.item)
			end
			io.put_new_line
				-- INTEGER_16
			xi2 := 1
			yi2 := 5
			across
				xi2 |..| yi2 as i
			loop
				io.put_integer (i.item)
			end
			io.put_new_line
				-- INTEGER_32
			xi4 := 1
			yi4 := 5
			across
				xi4 |..| yi4 as i
			loop
				io.put_integer (i.item)
			end
			io.put_new_line
				-- NATURAL_8
			xn1 := 1
			yn1 := 5
			across
				xn1 |..| yn1 as i
			loop
				io.put_integer (i.item)
			end
			io.put_new_line
				-- NATURAL_16
			xn2 := 1
			yn2 := 5
			across
				xn2 |..| yn2 as i
			loop
				io.put_integer (i.item)
			end
			io.put_new_line
		end

end