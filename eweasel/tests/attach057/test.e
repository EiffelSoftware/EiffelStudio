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
			end
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

end