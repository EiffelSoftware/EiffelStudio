class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			a: A [TEST]
			b: B [TEST]
			c: C [TEST]
		do
			f.do_nothing
			g.do_nothing
			h.do_nothing
			p.do_nothing
			q.do_nothing
			r.do_nothing
			create a
			a.f.do_nothing
			a.g.do_nothing
			a.h.do_nothing
			create b
			b.f.do_nothing
			b.g.do_nothing
			b.h.do_nothing
			create c
			c.f.do_nothing
			c.g.do_nothing
			c.h.do_nothing
		end

feature {NONE} -- Test

	f: TEST
			-- Test that `Result' should be set before return.
		local
			x: TEST
		do
			x := Void
			if x = Void or else Result = Void then
				Result := x
			end
			Result := Void
			Result := x
				-- Error: VEVI for Result.
		ensure
			result_set: attached Result.out
		end

	g: like f
			-- Test that `Result' should be set before return.
		local
			x: like f
		do
			x := Void
			if x = Void or else Result = Void then
				Result := x
			end
			Result := Void
			Result := x
				-- Error: VEVI for Result.
		ensure
			result_set: attached Result.out
		end

	h: like g.f
			-- Test that `Result' should be set before return.
		local
			x: like g.f
		do
			x := Void
			if x = Void or else Result = Void then
				Result := x
			end
			Result := Void
			Result := x
				-- Error: VEVI for Result.
		ensure
			result_set: attached Result.out
		end

	p: TEST
			-- Test that `Result' should be set before return.
		do
			if attached Result then
				Result := Current
			end
				-- Error: VEVI for Result.
		ensure
			result_set: attached Result.out
		end

	q: like p
			-- Test that `Result' should be set before return.
		do
			if attached Result then
				Result := Current
			end
				-- Error: VEVI for Result.
		ensure
			result_set: attached Result.out
		end

	r: like p.q
			-- Test that `Result' should be set before return.
		do
			if attached Result then
				Result := Current
			end
				-- Error: VEVI for Result.
		ensure
			result_set: attached Result.out
		end

end