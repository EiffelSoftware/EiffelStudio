class
	TEST1 [G]

create
	make

feature

	make is
		local
			t: TEST2 [G]
			g: G
		do
			print (t.generating_type)
			print ("%N")
			if g /= Void then
				print (g.generating_type)
				print ("%N")
			end
		end
end
