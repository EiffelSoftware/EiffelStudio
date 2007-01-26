class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local
			i: INTEGER
		do
			inspect i8
			when -1 then
				i := -1
			when 1 then
				i := 1
			else
			end
			io.put_integer (i)
			io.put_new_line
			i := 0
			inspect i16
			when -1 then
				i := -1
			when 1 then
				i := 1
			else
			end
			io.put_integer (i)
			io.put_new_line
			i := 0
			inspect i32
			when -1 then
				i := -1
			when 1 then
				i := 1
			else
			end
			io.put_integer (i)
			io.put_new_line
			i := 0
			inspect i64
			when -1 then
				i := -1
			when 1 then
				i := 1
			else
			end
			io.put_integer (i)
			io.put_new_line
			i := 0
			inspect n8
			when 0xFF then
				i := -1
			when 1 then
				i := 1
			else
			end
			io.put_integer (i)
			io.put_new_line
			i := 0
			inspect n16
			when 0xFFFF then
				i := -1
			when 1 then
				i := 1
			else
			end
			io.put_integer (i)
			io.put_new_line
			i := 0
			inspect n32
			when 0xFFFFFFFF then
				i := -1
			when 1 then
				i := 1
			else
			end
			io.put_integer (i)
			io.put_new_line
			i := 0
			inspect n64
			when 0xFFFFFFFFFFFFFFFF then
				i := -1
			when 1 then
				i := 1
			else
			end
			io.put_integer (i)
			io.put_new_line
			i := 0
		end

feature {NONE} -- Implementation

	i8: INTEGER_8 is
		do
		end

	i16: INTEGER_16 is
		do
		end

	i32: INTEGER_32 is
		do
		end

	i64: INTEGER_64 is
		do
		end

	n8: NATURAL_8 is
		do
		end

	n16: NATURAL_16 is
		do
		end

	n32: NATURAL_32 is
		do
		end

	n64: NATURAL_64 is
		do
		end

end
