
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

	x: TEST2 [TEST3]

	y: TEST1

end

