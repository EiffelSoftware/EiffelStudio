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
		end

feature -- Access

	to_integer: INTEGER = 5

end
