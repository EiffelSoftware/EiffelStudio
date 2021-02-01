class
	APPLICATION

inherit
	$PARENT

inherit {NONE}
	P1

create
	make

feature -- Initialization

	make
			-- Run application.
		do
			from_p1
		end

end
