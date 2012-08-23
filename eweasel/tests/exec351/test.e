class
	TEST

inherit
	MEMORY

create
	make

feature {NONE} -- Initialization

	make
		local
			rf: EXP
		do
			create rf.make_from_array (<< 2.3 >>)

			collect

			io.put_integer (rf.count)
			io.put_new_line
		end

end
