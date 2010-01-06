class
	TEST
create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		do
			if test (1) /= 4 then
				io.put_string ("Failed")
				io.put_new_line
			end
		end

feature {NONE} -- Tests

	k: INTEGER

	test (i: INTEGER): INTEGER is
		local
			j: INTEGER
		do
			io.put_integer (i)
			io.put_new_line
			Result.set_item (2)
			i.set_item (Result)
			j.set_item (i)
			k.set_item (j)
			io.put_integer (k)
			io.put_new_line
			Result.deep_copy (3)
			i.deep_copy (Result)
			j.deep_copy (i)
			k.deep_copy (j)
			io.put_integer (k)
			io.put_new_line
			Result.copy (4)
			i.copy (Result)
			j.copy (i)
			k.copy (j)
			io.put_integer (k)
			io.put_new_line
		end

end
