class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			a: A [TEST]
		do
			f.do_nothing
			create a
			a.f (Current).do_nothing
		end

feature {NONE} -- Test

	f: TEST
			-- Test that `Result' can be used as detachable until return
			-- and that locals can be used as detachable all the time.
		local
			x: TEST
		do
			x := Void
			if x = Void and then Result = Void then
				Result := x
				x := Current
			end
			Result := Void
			Result := x
		ensure
			result_set: attached Result.out
		end
end