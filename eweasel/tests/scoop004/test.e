class TEST

create
	make

feature {NONE} -- Creation

	make
		local
			a: separate A [INTEGER]
		do
			create a
			g (a)
		end

	g (a: separate A [INTEGER])
		do
			a.f (1, create {A [INTEGER]})
			a.f_bis (2)
			a.g (3)
		end

	end
