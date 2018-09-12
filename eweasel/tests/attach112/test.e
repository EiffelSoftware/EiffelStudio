class TEST

create
	make

feature {NONE} -- Creation

	make
		local
			x: detachable ITERABLE [TEST]
		do
			across
				x as c
			loop
			end
			across
				x is c
			loop
			end
		end

end