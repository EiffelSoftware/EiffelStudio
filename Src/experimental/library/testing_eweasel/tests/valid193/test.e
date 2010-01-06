class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local
			i8: INTEGER_8
			i16: INTEGER_16
			i32: INTEGER_32
			i64: INTEGER_64
		do
			i8 := c8
			i16 := c16
			i32 := c32
			i64 := c64
			inspect i8
			when c8 then
				io.put_string ("INTEGER_8: OK")
			else
				io.put_string ("INTEGER_8: Fail")
			end
			io.put_new_line
			inspect i16
			when c16 then
				io.put_string ("INTEGER_16: OK")
			else
				io.put_string ("INTEGER_16: Fail")
			end
			io.put_new_line
			inspect i32
			when c32 then
				io.put_string ("INTEGER_32: OK")
			else
				io.put_string ("INTEGER_32: Fail")
			end
			io.put_new_line
			inspect i64
			when c64 then
				io.put_string ("INTEGER_64: OK")
			else
				io.put_string ("INTEGER_64: Fail")
			end
			io.put_new_line
		end

	c8: INTEGER_8 is unique
	c16: INTEGER_16 is unique
	c32: INTEGER_32 is unique
	c64: INTEGER_64 is unique

end
