
class TEST
create
	make
feature
	make
		do
			x.try
		end 
    
    	x: TEST1 [TEST2]
		do
			create Result
			Result.set_value (create {TEST2})
		end
	
end
