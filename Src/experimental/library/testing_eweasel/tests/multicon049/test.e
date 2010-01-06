
class TEST

create
	make

feature

	make is
		do
			create x.default_create
			x.try
		end

	x: TEST1 [TEST2]

end
