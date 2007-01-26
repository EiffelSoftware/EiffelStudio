class
	TEST2 [G]

feature

	make is
		local
			g: G
			l: LINKED_LIST [G]
		do
			if g /= Void then
				print (g.generating_type)
				print ("%N")
			end
			create l.make
			print (l.generating_type)
			print ("%N")
		end

end
