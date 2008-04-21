class TEST1

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local
			i, j: INTEGER
		do
			if {a: STRING} f then
				a.substring (i, j).do_nothing
			end
		end

	f: ?STRING is
		do
		end

invariant
	f_not_void: {a: STRING} f

end
