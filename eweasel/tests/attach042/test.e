class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			l_agent: ?ANY
		do
			l_agent := agent (a_bool: BOOLEAN) do end
			if {l_rout1: ROUTINE [ANY, TUPLE [BOOLEAN]]} l_agent then
				print ("OK%N")
			else
				print ("Agent1 not conforming%N")
			end

			l_agent := agent bar
			if {l_rout2: ROUTINE [ANY, TUPLE [BOOLEAN]]} l_agent then
				print ("OK%N")
			else
				print ("Agent2 not conforming%N")
			end
		end

	bar (a_bool: BOOLEAN)
		do
		end

end

