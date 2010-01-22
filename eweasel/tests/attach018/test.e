class TEST

create
	make

feature {NONE} -- Creation

	make
		local
			i, j: INTEGER
		do
			if attached {STRING} f as a then
				a.substring (i, j).do_nothing
			end
		end

	f: detachable STRING
		do
		end

	test1: TEST1

invariant
	f_not_void: attached {STRING} f as a

end
