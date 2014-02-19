class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			a: A [INTEGER]
		do
			create a
			a.f (5)
		end

end
