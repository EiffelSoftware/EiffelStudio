
class TEST

create
	make

feature

	make
		do
			create y
			print (y.to_test2.value); io.new_line
		end
	
	y: TEST1

end

