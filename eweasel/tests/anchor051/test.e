
class TEST
create
	make
feature
	make 
		do
			create x
			print (x.generating_type); io.new_line
			print (x.value.generating_type); io.new_line
		end 
    
        x: TEST1 [DOUBLE]
    
end

