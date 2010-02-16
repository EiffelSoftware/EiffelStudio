class B

inherit
	A
		redefine
			f
		end

feature

	f (s: like b.c)
		do
		end

	b: C

end
