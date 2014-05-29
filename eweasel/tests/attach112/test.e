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
		end

end