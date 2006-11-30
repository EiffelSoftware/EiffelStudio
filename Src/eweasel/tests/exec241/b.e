indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	B
inherit
	A
		redefine f end

feature
	f is 
		do 
			c:= Current 
			print (c.s)
		end
end
