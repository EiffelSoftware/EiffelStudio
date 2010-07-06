
class TEST
create
	make
feature
	make
		do
			create x
			print (x.a.generating_type); io.new_line
		end 
    
    	x: TEST1 [NATURAL_64]
	
end
