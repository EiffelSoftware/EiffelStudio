class
	TEST

create
	make

feature -- Initialization

	make
		local
			l_agent: ?ANY
			t: TEST
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

			l_agent := agent twin.bar
			if {l_rout3: ROUTINE [ANY, TUPLE [BOOLEAN]]} l_agent then
				print ("OK%N")
			else
				print ("Agent3 not conforming%N")
			end

			t := Current
			l_agent := agent t.bar
			if {l_rout4: ROUTINE [ANY, TUPLE [BOOLEAN]]} l_agent then
				print ("OK%N")
			else
				print ("Agent4 not conforming%N")
			end

			l_agent := agent {TEST}.bar
			if {l_rout5: ROUTINE [ANY, TUPLE [TEST, BOOLEAN]]} l_agent then
				print ("OK%N")
			else
				print ("Agent5 not conforming%N")
			end

			l_agent := agent {?TEST}.bar
			if {l_rout6: ROUTINE [ANY, TUPLE [TEST, BOOLEAN]]} l_agent then
				print ("OK%N")
			else
				print ("Agent6 not conforming%N")
			end
		end
	
	bar (a_bool: BOOLEAN)
		do
		end

end

