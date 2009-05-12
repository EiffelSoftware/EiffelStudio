note
	description: "[
		INTEGER implementation of SETTABLE_TYPES [G]
	]"
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SETTABLE_INTEGER

inherit
	SETTABLE_TYPES [INTEGER]

create
	set_value,
	make_empty

convert
	set_value ({INTEGER}),
	value: {INTEGER}

feature -- Element change

	create_internal_value
			-- <Precursor:
		do
			internal_value := 0
		end
end

