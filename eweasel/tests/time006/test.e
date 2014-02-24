class
	TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			i: INTEGER_32
			calc: CALC
		do
			from i := 1	until i > 20 loop
				create calc.make
				i := i + 1
			end
			io.readline
		end

end
