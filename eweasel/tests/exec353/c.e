expanded class C

inherit
	B
		redefine
			is_equal,
			make_0,
			make_1
		end

create
	make_0, make_1

feature {NONE} -- Initialization

	make_0
			-- <Precursor>
			-- Set `salt' to `1'.
		do
			Precursor
			salt := 1
		ensure then
			salt_set: salt = 1
		end

	make_1
			-- <Precursor>
			-- Set `salt' to `1'.
		do
			Precursor
			salt := 1
		ensure then
			salt_set: salt = 1
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- <Precusor>
		do
			Result := Precursor (other) and then salt = other.salt
		end

end