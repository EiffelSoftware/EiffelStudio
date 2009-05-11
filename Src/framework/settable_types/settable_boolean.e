note
	description: "[
		BOOLEAN implementation of SETTABLE_TYPES [G]
	]"
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SETTABLE_BOOLEAN

inherit
	SETTABLE_TYPES [BOOLEAN]

create
	set_value,
	make_empty

convert
	set_value ({BOOLEAN}),
	value: {BOOLEAN}
end

