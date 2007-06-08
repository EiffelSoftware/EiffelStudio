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

	f alias "-": C is
		do
			create Result.make (- i)
		end

	g alias "+" (a: C): C is
		do
			create Result.make (i + a.i)
		end

	h alias "[]" (a: C): C is
		do
			create Result.make (i * a.i)
		end

feature -- Output

	out: STRING is
		do
			Result := i.out
		end

feature {C} -- Status

	i: INTEGER

end
