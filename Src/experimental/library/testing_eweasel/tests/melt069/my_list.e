class
	MY_LIST [G]

inherit
	LINKED_LIST [G]
		redefine
			default_create
		end

create
	default_create, make

feature -- Initialization

	default_create is
			-- Initialize
		do
			make
		end

end -- class MY_LIST
