
class TEST

create
	make

feature

	make is
		do
			create x
			x.try
		end

	x: TEST1 [STRING]

end
