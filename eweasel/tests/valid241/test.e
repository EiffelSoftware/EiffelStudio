class TEST

inherit
	B [A [TEST], TEST]
	D

create
	make

feature

	make
		local
			x: C [TEST, TEST, A [TEST], TEST]
		do
			create x.make
		end

end
