class TEST

create
	make

feature {NONE} -- Creation

	make is
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

	test1: TEST1

invariant
	f_not_void: {a: STRING} f

end
