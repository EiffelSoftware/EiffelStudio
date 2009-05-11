note
	description: "[
		BOOLEAN implementation of INITIALIZABLE [G]
	]"
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INITIALIZABLE_BOOLEAN

inherit
	INITIALIZABLE [BOOLEAN]

create
	set_value,
	make_empty

convert
	set_value ({BOOLEAN}),
	value: {BOOLEAN}
end

