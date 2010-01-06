class TEST

create 
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local
			aa: ARRAY [A]
			a: A
		do
			create aa.make (1, 2)
			a := aa.item (1).default.default
			io.put_new_line
		end

end
