class
	TEST

create
	make

feature {NONE} -- Initialization

	make is
			-- Entry point.
		local
			i: INTEGER
		do
			inspect i
			when {TEST}.x then
			end
		end

feature $EXPORT -- Data

	x: INTEGER is 5

end
