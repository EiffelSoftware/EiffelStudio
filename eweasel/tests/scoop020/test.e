class TEST

create
	make

feature {NONE} -- Creation

        make
		do
			test (Current, Current, create {A [TEST]}, create {A [separate TEST]})
		end

feature {NONE} -- Test

	test (x: TEST; y: separate TEST; xx: A [TEST]; yy: A [separate TEST])
		do
			xx.f (x, x)
			xx.f (x, y)
			xx.f (y, x) -- Error.
			xx.f (y, y) -- Error.
			yy.f (x, x)
			yy.f (x, y)
			yy.f (y, x)
			yy.f (y, y)
		end

end
