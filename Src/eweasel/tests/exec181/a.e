class A [G, H]

create
	make
	
feature
	
	item: H
	
	c: C [H]
	
	make is
		do
			create c
		end
		
end
