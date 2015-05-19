class TEST

create
	make

convert
	to_integer: {INTEGER}

feature {NONE} -- Creation

	make
		local
			x: INTEGER
		do
			x := Current
			io.put_integer (x)
			io.put_new_line
		end

feature -- Access

	to_integer: INTEGER = 5

end
