class TEST

inherit
	A
		undefine
			a1, a2, c1, e1, f1, o1
		redefine
			a3, a4, c2, e2, f2, o2
		end

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
		end

feature {NONE} -- Tests

	a1: detachable TEST

	a2: detachable TEST
		attribute
		end

	a3: detachable TEST

	a4: detachable TEST
		attribute
		end

	a5: detachable TEST

	a6: detachable TEST
		attribute
		end

	c1: INTEGER_8 = 1

	c2: INTEGER_8 = 2

	c3: INTEGER_8 = 3

	e1
		external "C inline"
			alias "return"
		end

	e2
		external "C inline"
			alias "return"
		end

	e3
		external "C inline"
			alias "return"
		end

	f1
		do
		end

	f2
		do
		end

	f3
		do
		end

	o1
		once ("OBJECT")
		end

	o2
		once ("OBJECT")
		end

	o3
		once ("OBJECT")
		end

end