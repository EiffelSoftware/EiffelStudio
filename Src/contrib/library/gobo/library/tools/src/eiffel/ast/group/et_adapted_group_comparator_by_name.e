note

	description:

		"Adapted group comparators by name"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2011-2016, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_ADAPTED_GROUP_COMPARATOR_BY_NAME [G -> ET_ADAPTED_GROUP]

inherit

	KL_COMPARATOR [G]

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

create

	make

feature {NONE} -- Initialization

	make
			-- Create a new comparator.
		do
		end

feature -- Status report

	less_than (u, v: G): BOOLEAN
			-- Is `u' considered less than `v'?
		do
			Result := (STRING_.three_way_case_insensitive_comparison (u.name, v.name) = -1)
		end

end
