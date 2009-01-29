
class TEST

create
	make

feature

	make
		do
			create x
			x.try
		end

	x: TEST1 [TEST2]
end
