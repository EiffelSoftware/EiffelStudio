class
	TEST1

feature

	item: STRING

	display_agent_type is
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

	f (v: LIST [like item]): LIST [like item] is
		do

		end

	g (v: like item): like item is
		do

		end

end
