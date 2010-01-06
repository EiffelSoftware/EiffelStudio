class STORABLE_B55

inherit

	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create is
		do
			int := 123
		end

feature -- Access

	int: INTEGER

end
