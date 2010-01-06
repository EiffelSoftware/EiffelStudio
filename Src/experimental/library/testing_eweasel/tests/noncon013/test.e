class
	TEST

inherit {NONE}
	P1

create
	make

feature -- Initialization

	make is
			-- Run application.
		local
			p2: P2
		do
			create p2
		end

end -- class APPLICATION
