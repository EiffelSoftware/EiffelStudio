class TEST

create
	make

feature {NONE} -- Creation

	make
		local
			b1, b2: B
		do
			create b1
			create b2
			(b1 <= b2).do_nothing
		end

end
