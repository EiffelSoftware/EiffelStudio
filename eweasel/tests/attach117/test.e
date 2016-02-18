class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			a: A [TEST]
			b: B [TEST]
		do
			f.do_nothing
			g.do_nothing
			create a
			a.f.do_nothing
			create b
			b.f.do_nothing
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

	g: TEST
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