indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$" 

class
	TEST
creation
	make
feature
	make is
		do
			(agent 
				local
					l_a: A
				do
					create l_a
					print ("hello") 
					print (l_a.out)
				end).call ([])
		end

	a: A
	
end
