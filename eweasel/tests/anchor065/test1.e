
class TEST1 [G -> TEST2 create default_create end]
create
	make, default_create
feature
	make
		do
			create y
			x.try
		end

	x: like {G}.default
		do
			create Result
		end
			
	
	y: TEST2
end
