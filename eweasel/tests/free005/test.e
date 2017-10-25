class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			{A [X]}.f
			{A [Y]}.f
			{B}.f
			{C}.f
		end

end