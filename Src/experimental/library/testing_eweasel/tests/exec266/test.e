class TEST

create
	make

feature {NONE} -- Creation

	make is
		local
			a: A [INTEGER]
			b: A [TEST1]
			t: TEST1
		do
			create a.make (5)
			io.put_integer (a.test_deep_twin)
			io.put_new_line

			create b.make (t)
			b.test_deep_twin.display
		end

end
