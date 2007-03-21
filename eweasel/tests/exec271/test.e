class TEST

create
	make

feature

	make is
		local
			t: TEST2
			a: ANY
		do
			create t
			t.display_agent_type
			a := agent t.f
			print (a.generating_type)
			print ("%N")
		end

end
