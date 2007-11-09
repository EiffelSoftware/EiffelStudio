class
	APPLICATION

inherit
	ANY

inherit {NONE}
	P1

create
	make

feature -- Initialization

	make is
			-- Run application.
		do
			from_p1
		end

end -- class APPLICATION
