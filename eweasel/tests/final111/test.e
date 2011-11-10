
class TEST
	
create
	make

feature

	make
		do
			create x
			x.try
			create y
			y.try
		end

	x: TEST2 [TEST4]

	y: TEST2 [TEST5]

end
