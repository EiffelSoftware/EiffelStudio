class
	TEST

create
	make

feature -- Initialization

	make
		local
			l_agent: detachable ANY
			t: TEST
		do
			l_agent := agent (a_bool: BOOLEAN) do end
			if attached {ROUTINE [BOOLEAN]} l_agent as l_rout1 then
				print ("OK%N")
			else
				print ("Agent1 not conforming%N")
			end

			l_agent := agent bar
			if attached {ROUTINE [BOOLEAN]} l_agent as l_rout2 then
				print ("OK%N")
			else
				print ("Agent2 not conforming%N")
			end

			l_agent := agent twin.bar
			if attached {ROUTINE [BOOLEAN]} l_agent as l_rout3 then
				print ("OK%N")
			else
				print ("Agent3 not conforming%N")
			end

			t := Current
			l_agent := agent t.bar
			if attached {ROUTINE [BOOLEAN]} l_agent as l_rout4 then
				print ("OK%N")
			else
				print ("Agent4 not conforming%N")
			end

			l_agent := agent {TEST}.bar
			if attached {ROUTINE [TEST, BOOLEAN]} l_agent as l_rout5 then
				print ("OK%N")
			else
				print ("Agent5 not conforming%N")
			end

			$BAD_AGENT
		end
	
	bar (a_bool: BOOLEAN)
		do
		end

end

