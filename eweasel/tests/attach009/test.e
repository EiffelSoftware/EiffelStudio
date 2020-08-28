class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			i: attached INTEGER
		do
			io.put_integer (i)
			io.put_new_line
		end

end