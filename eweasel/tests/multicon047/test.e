
class TEST

create
	make

feature

	make is
		do
			create x
			x.make
		end

	x: TEST1 [STRING]

end
