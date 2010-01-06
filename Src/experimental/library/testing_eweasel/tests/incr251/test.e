class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		local
			b: B
		do
			create b
			b.a := 5
			io.put_string ("Get a=")
			io.put_integer (b.a)
			io.put_new_line
		end

end