class
	TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		local
			a: A
			t: detachable TEST
		do
			t := Current
			a := t
		end

end