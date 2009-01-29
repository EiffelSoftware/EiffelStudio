
class TEST
inherit
	TEST1 [DOUBLE]
		redefine
			stoat
		end

create
	make

feature

	make
		do
			create x
			x.try
		end

	stoat: TEST2

	x: TEST2
end
