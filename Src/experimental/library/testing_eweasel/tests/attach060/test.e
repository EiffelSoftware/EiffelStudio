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

	test (a: !TEST; d: ?TEST)
		local
			l_a: !TEST
			l_d: ?TEST
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