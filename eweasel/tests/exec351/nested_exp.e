expanded class
	NESTED_EXP

create
	default_create,
	make_from_array

feature -- Creation

	make_from_array (an_array: ARRAY [REAL_64])
		do
			create rep.make_from_array (an_array)
		end

feature -- Status

	count: INTEGER
		do
			if attached rep as l_rep then
				Result := l_rep.count
			end
		end

feature -- Implementation

	rep: detachable ARRAY [REAL_64]

end



