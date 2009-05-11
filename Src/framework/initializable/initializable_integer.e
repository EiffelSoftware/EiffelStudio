note
	description: "[
		INTEGER implementation of INITIALIZABLE [G]
	]"
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INITIALIZABLE_INTEGER

inherit
	INITIALIZABLE [INTEGER]

create
	set_value,
	make_empty

convert
	set_value ({INTEGER}),
	value: {INTEGER}
end

