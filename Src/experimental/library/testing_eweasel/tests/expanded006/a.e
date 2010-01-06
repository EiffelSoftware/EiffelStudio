class
	A [G] 

inherit
	ANY
		redefine
			default_create
		end

create
	default_create

feature

	default_create is
		do
			create c1.make
			create c2.make
			create d1.make
			create d2.make
		end

feature

	a: G
	b: like a

	c1: LINKED_LIST [G]
	c2: LINKED_LIST [like a]

	d1: like c1
	d2: like c2

	f_a: G is
		do
		end

	f_b: like a is
		do
		end

	f_c1: LINKED_LIST [G] is
		do
			create Result.make
		end

	f_c2: LINKED_LIST [like a] is
		do
			create Result.make
		end

	f_d1: like c1 is
		do
			create Result.make
		end

	f_d2: like c2 is
		do
			create Result.make
		end


invariant
	c1 /= Void
	c2 /= Void
	d1 /= Void
	d2 /= Void
end
