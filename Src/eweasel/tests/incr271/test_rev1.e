class
	TEST
inherit
	TEST1

create 
	make

feature
	make 
		local
			x: LINKED_LIST [TUPLE [TEST1]]
		do
			create x.make
			print (x.generating_type)
			print ("%N")
		end

end
