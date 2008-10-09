class TEST1
 
feature
 
	f
		local
			a: ANY
		do
			a := agent g
			print (a.generating_type)
			print ("%N")
			a := << g >>
			print (a.generating_type)
			print ("%N")
			a := [ g ]
			print (a.generating_type)
			print ("%N")
		end
 
	g: like h
		do
		end
 
	h: TEST1
		do
		end
 
end
