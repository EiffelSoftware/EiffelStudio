class
	TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run tests.
		local
			x: attached TEST
		do
			if a /= Void then
				x := a
				a.f
				g (a)
			elseif a = Current then
				create a.make
			else
				a := Current
			end
			x := a
		end

feature {TEST} -- Tests

	a: detachable TEST
		note
			option: stable
		attribute
		end

	f
		require
			a_attached: a /= Void
		do
			a.f
		end

	g (x: attached TEST)
		do
		end

end