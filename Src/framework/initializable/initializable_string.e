note
	description: "[
		STRING implementation of INITIALIZABLE [G]
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"
class
	INITIALIZABLE_STRING

inherit
	INITIALIZABLE [STRING]

create
	set_value,
	make_empty

convert
	set_value ({STRING}),
	value: {STRING}
end

