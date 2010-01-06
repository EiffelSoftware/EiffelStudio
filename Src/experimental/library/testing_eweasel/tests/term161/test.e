class
	TEST

create

	make

feature {NONE} -- Initialization

	make is
		local
			t2: TEST1
		do
			create t2.make (<<a, b>>)
		end

	a: LIST [INTEGER]
	b: LIST [INTEGER]

end
