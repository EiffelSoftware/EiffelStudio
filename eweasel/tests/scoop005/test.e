class TEST

create
	make

feature {NONE} -- Creation

	make
		local
			a: separate A
		do
			create a
			g (a)
		end

feature {NONE} -- Test

	g (a: separate A)
		do
			a.f (1, create {A})
		end

end
