class
	TEST1

feature

	item: STRING

	display_agent_type
		local
			a: ANY
		do
			a := agent g
			print (a.generating_type)
			print ("%N")
			a := agent f
			print (a.generating_type)
			print ("%N")
		end

	f (v: LIST [like item]): LIST [like item]
		do

		end

	g (v: like item): like item
		do

		end

end
