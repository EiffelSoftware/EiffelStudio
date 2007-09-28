class
	TEST1

create
	make

feature {NONE} -- Initialization

	make is
		do
			create target
			create any
			create target2_string
			create target2_integer
			create target3
		end

feature -- Access

	target: ANY
	any: ANY
	target2_string: TEST2 [STRING_32]
	target2_integer: TEST2 [INTEGER]
	target3: TEST3


end
