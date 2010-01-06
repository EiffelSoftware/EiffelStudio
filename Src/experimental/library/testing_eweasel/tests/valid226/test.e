
class TEST

create
	make

feature

	make is
		do
			create x
			x.modify
		end

	x: TEST1 [CHILD]

end
