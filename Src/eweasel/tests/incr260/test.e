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
		local
			l_a: A
		do
			create l_a
			print (l_a.agent_on_a.item ([]).out)
			io.new_line
		end
	
end
