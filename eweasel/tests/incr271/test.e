class
	TEST

create 
	make

feature
	make 
		local
			x: LINKED_LIST [TUPLE [TEST]]
		do
			create x.make
			print (x.generating_type)
			print ("%N")
		end

end
