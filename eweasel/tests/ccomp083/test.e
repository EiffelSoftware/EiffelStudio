class TEST

create
	make

feature

	make is
		local
			a2: A2
		do
			create a2
			a2.f
		end

	a1: A [ANY]

end
