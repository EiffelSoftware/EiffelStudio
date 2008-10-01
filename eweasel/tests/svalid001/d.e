class D

create
	make_from_a,
	make_from_e

convert
	make_from_a ({A}),
	make_from_e ({E})

feature

	make_from_a (a: A) is
			--
		do

		end

	make_from_e (e: E) is
			--
		do

		end

	plus alias "+" (other: D): INTEGER is
		do
		end

end
