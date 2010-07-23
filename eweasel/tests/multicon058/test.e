class TEST

inherit
	C [F]
		redefine
			g,
			h
		end

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			g (create {A [F]})
			h (create {F})
			(create {C [F]}).g (create {A[F]})
			(create {C [F]}).h (create {F})
		end

feature {NONE} -- Test

	g (a: A [F])
		do
		end

	h (a: F)
		do
		end

end
