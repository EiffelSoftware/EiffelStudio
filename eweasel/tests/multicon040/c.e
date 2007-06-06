class C

inherit

	ANY
		redefine
			out
		end

create
	make

feature {NONE} -- Creation

	make (v: INTEGER) is
		do
			i := v
		end

feature -- Access

	f: C assign ff is
		do
			create Result.make (- i)
		end

	g (a: C): C assign gg is
		do
			create Result.make (i + a.i)
		end

	h (a: C): C assign hh is
		do
			create Result.make (i * a.i)
		end

	ff (a: C) is
		do
			i := - a.i
		end

	gg (a: C; b: C) is
		do
			i := i + a.i
		end

	hh (a: C; b: C) is
		do
			i := i * a.i
		end

feature -- Output

	out: STRING is
		do
			Result := i.out
		end

feature {C} -- Status

	i: INTEGER

end
