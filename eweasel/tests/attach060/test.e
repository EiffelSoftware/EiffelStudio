class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			test (Current, Void)
		end

feature

	test (a: attached TEST; d: detachable TEST)
		local
			l_a: attached TEST
			l_d: detachable TEST
		do
			l_a := a.f
			l_d := a.f
			if d /= Void then
				l_a := d.f
				l_d := d.f
			end
		end

	f: like Current
		do
			-- Return Void
		end

end