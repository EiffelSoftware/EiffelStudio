
class TEST
inherit
	TEST1
		redefine
			make
		end
create
        make

feature
	make
		do
			create x.make
			create y.make
		end

	x: TEST2
	
	y: TEST1

end

