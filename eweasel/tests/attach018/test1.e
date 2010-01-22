class TEST1

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
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

invariant
	f_not_void: attached {STRING} f as a

end
