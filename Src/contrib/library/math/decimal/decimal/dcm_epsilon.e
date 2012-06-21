note
	description:
		"[
		This class is used to create the epsilon which is used for approximately_equal feature.
		]"
	copyright: "Copyright (c) 2011, SEL, York University, Toronto and others."
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class
	DCM_EPSILON

create
	make

feature {NONE} -- Initialization

	make

		do
			epsilon := 5
		end

feature -- Access

	epsilon: INTEGER

	set_epsilon (n: INTEGER)
			--This will set the epsilon to `n'E-27.
		require
			n_greater_equal_zero: n >= 0
		do
			epsilon := n
		ensure
			answer_is_n: epsilon = n
		end



note
	copyright: "Copyright (c) 2011, SEL, York University, Toronto and others."
	license: "MIT license"
	details: "[
			Originally developed by Jonathan Ostroff and Moksh Khurana. 
			Revised by Jonathan Ostroff, Manu Stapf, and Moksh Khurana.
		]"

end
