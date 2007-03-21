class TEST

create
	make

feature

	make is
		local
			t: TEST1
			t2: TEST2
			a: ANY
		do
			create t2
			t := t2
			t.display_agent_type
			a := agent t.g
			print (a.generating_type)
			print ("%N")
			a := agent t.f
			print (a.generating_type)
			print ("%N")
		end

end
