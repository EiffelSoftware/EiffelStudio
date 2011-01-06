
class TEST
create 
	make
feature
	make
		do
			create x
			create y
			
			print (x.value); io.new_line
			print (y.value); io.new_line
		end

	x: TEST2 [INTEGER]

	y: TEST2 [STRING]

end
