class TEST

create
	make

feature {NONE} -- Creation

	make is
		local
			a: A [INTEGER]
		do
			create a.make (5)
			io.put_integer (a.test_deep_twin)
			io.put_new_line
		end

end
