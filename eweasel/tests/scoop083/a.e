class
	A [G]

inherit

	CELL [G]
		redefine
			put
		end

create
	put

feature

	put (v: G)
		do
			Precursor (v)
		end

end
