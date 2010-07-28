
class TEST1 [G -> TEST2 create default_create end]
create
	make
feature
	make
		do
			create y
			x.try
		end

	x: G
		do
			create Result
		end
			
	
	y: TEST2
end
