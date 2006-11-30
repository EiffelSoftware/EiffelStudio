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

	to_reference: STORABLE_B55 is
		do
			create Result
		end

end
