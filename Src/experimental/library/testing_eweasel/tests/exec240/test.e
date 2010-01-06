indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

create
	make

feature
	make is
		local
			a: B
		do
			create a
			print (a.test (""))
		end

end
