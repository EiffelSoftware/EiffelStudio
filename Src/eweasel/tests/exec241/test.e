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
			b: B
			a: A
		do
			create a
			a.f
			create b
			b.f
		end

end
