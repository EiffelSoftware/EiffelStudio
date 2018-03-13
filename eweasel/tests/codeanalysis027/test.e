class TEST

inherit
	A
		redefine
			f,
			g,
			h
		end

create
	make

feature {NONE} -- Testing

	make
			-- Run test.
		local
			a: detachable ANY
		do
				-- Local entities.
			;(a = a).do_nothing -- CA071: local
			if attached g as o then
				;(o = o).do_nothing -- CA071: object test local
			end
			separate create {separate A} as s do
				;(s = s).do_nothing -- CA071: separate variable
			end
			across
				"" as c
			loop
				;(c = c).do_nothing -- CA071: iteration cursor
			end
			;(across "" as c all c = c end).do_nothing -- CA071: iteration cursor
			;(agent (x: detachable ANY): BOOLEAN
				do
					;(x = x).do_nothing -- CA071: argument
					;(Result = Result).do_nothing -- CA071: result
				end).do_nothing
			;(Current = Current).do_nothing -- CA071: current object
				-- Features.
			;(e = g).do_nothing
			;(e = e).do_nothing -- CA071: constant attribute
			;(f = g).do_nothing
			;(f = f).do_nothing -- CA071: variable attribute
			;(g = g).do_nothing
			;({A}.e = {A}.g).do_nothing
			;({A}.e = {A}.e).do_nothing -- CA071: constant attribute
		end

	f: detachable ANY
			-- <Precursor>
		attribute
			;(Precursor = Precursor).do_nothing -- CA071
		end

	g: detachable ANY
			-- <Precursor>
		do
			;(Precursor = Precursor).do_nothing
		end

	h: detachable ANY
			-- <Precursor>
		attribute
			;(Precursor = Precursor).do_nothing
		end

	test_operators
			-- Test different comparison operators.
		local
			s: STRING
		do
			s := out
			;(s = s).do_nothing -- CA071
			;(s /= s).do_nothing -- CA071
			;(s ~ s).do_nothing -- CA071
			;(s /~ s).do_nothing -- CA071
			;(s < s).do_nothing -- CA071
			;(s <= s).do_nothing -- CA071
			;(s > s).do_nothing -- CA071
			;(s >= s).do_nothing -- CA071
			;(out = out).do_nothing
			;(out /= out).do_nothing
			;(out ~ out).do_nothing
			;(out /~ out).do_nothing
			;(out < out).do_nothing
			;(out <= out).do_nothing
			;(out > out).do_nothing
			;(out >= out).do_nothing
		ensure
			e = g
			e = e -- CA071: constant attribute
			f = g
			f = f -- CA071: variable attribute
			g = g
			{A}.e = {A}.g
			{A}.e = {A}.e -- CA071: constant attribute
		end

invariant
	e = g
	e = e -- CA071: constant attribute
	f = g
	f = f -- CA071: variable attribute
	g = g
	{A}.e = {A}.g
	{A}.e = {A}.e -- CA071: constant attribute

end
