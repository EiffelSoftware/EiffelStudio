
class TEST
create
	make
feature
	make
		do
			print (a.out.count > 0); io.new_line
		end 
    
	a: ARRAY [TEST2]
	   do
	   	create Result.make_filled (create {TEST2}, 1, 2)
	   end

end
