class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		do
			test (agent do end)
			test (agent bar)
		end

	bar 
		do
		end

	test (a_routine: ROUTINE [ANY, TUPLE])
		do
		end

end

