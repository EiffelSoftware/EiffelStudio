class TEST

inherit
	A
		undefine
			a1, a2
		redefine
			a3, a4, z, w
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

	z
		once ("OBJECT")
		end

	w
		once ("OBJECT")
		end

end