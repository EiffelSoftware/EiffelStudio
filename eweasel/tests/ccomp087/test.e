class TEST

create
	make

feature

	make
		do
			f (pulse)
		end

	f (p: like pulse)
		local
			p1: like p
		do
			p1.do_nothing
		end

	pulse: TEST1 [REAL_64]

end
