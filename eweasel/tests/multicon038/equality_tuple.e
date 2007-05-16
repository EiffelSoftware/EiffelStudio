indexing

class
	EQUALITY_TUPLE [G -> TUPLE create default_create end]

inherit
	ANY
		redefine
			is_equal
		end

feature 

	g: G

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Does table contain the same information as `other'?
		local
			l_other: ANY
			i: INTEGER
		do
			l_other := other.g [i]
		end

end -- class {EQUALITY_TUPLE}

