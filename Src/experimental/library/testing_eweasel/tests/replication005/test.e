class
	TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			a: A
		do
				-- testing qualified calls.
			create {D}a.make
		end

end
