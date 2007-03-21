class
	TEST1

feature

	item: STRING

	display_agent_type is
		local
			a: ANY
		do
			a := agent f
			print (a.generating_type)
			print ("%N")
		end

	f: LIST [like item] is
		do

		end

end
