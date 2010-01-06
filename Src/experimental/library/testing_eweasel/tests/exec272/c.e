class C [G]

inherit

	B [G]
		redefine
			f
		end

create

	make

feature {NONE} -- Creation

	make (a: G) is
		do
			i := a
		end

feature

	f (a: G): G is
		do
			io.put_string ("C.f")
			io.put_new_line
			Result := a
			h := a
		end

	g (a: G): G is
		do
			io.put_string ("C.g")
			io.put_new_line
			Result := a
			h := a
		end

	h: G

	p (a: G; b: INTEGER) is
		do
			io.put_string ("C.p")
			io.put_new_line
			h := a
		end

end