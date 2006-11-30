indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

create
	make

feature
	make 
		local
			b: B
		do
			create b
			b.f
		end

end
