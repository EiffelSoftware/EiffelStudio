class
	APPLICATION

create
	make

feature -- Initialization

	make
			-- Run application.
		local
			p2: P2
		do
			create {P1} p2
			p2.from_p2
		end

end
