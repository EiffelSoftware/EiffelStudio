class
	TEST

create
	make

feature -- Initialization

	make is
			-- Tests
		local
			att: $CLASS
			det: ?$CLASS
		do
			att := det
		end

end
