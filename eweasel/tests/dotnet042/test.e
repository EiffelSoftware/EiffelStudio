class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local
			i: IMPL
		do
			create i
			io.put_integer (i.clone ($i))
			io.put_new_line
		end

end
