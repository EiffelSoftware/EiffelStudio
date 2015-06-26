class TEST

create
	make

feature
	
	make
		do
			create x
			create y
			if attached x / y as l_y then
			end
		end


	x, y: TEST1

end
