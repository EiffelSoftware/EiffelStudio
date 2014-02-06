class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			c: detachable COMPARABLE
			i
			n: detachable NUMERIC
		do
			i := c
			i := n
			print (i)
		end

end
