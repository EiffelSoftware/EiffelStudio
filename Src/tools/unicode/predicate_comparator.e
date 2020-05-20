note
	description: "Comparator based on an agent."

class PREDICATE_COMPARATOR [G]

inherit
	COMPARATOR [G]

create
	make

feature {NONE} -- Creation

	make (predicate: like is_less)
		do
			is_less := predicate
		ensure
			is_less_set: is_less = predicate
		end

feature -- Status report

	less_than (u, v: G): BOOLEAN
			-- <Precursor>
		do
			Result := is_less (u, v)
		end

feature -- Access

	is_less: PREDICATE [G, G];
			-- A predicate that tells whether one value is less than another.

note
	author: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

end
