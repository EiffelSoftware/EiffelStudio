indexing

	description: "[
		Objects representing delayed calls to a procedure.
		with some operands possibly still open.
		]"

	note: "[
		Features are the same as those of ROUTINE,
		with `apply' made effective, and no further
		redefinition of `is_equal' and `copy'.
		]"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	PROCEDURE [BASE_TYPE, OPEN_ARGS ->TUPLE]

inherit
	ROUTINE [BASE_TYPE, OPEN_ARGS]

feature -- Calls

	apply is
			-- Call procedure with `operands' as last set.
		do
			rout_set_cargs
			rout_obj_call_procedure (rout_disp, rout_cargs)
		end

feature {NONE} -- Implementation

	rout_obj_call_procedure (rout: POINTER; args: POINTER) is
			-- Perform call to `rout' with `args'.
		external
			"C [macro %"eif_rout_obj.h%"]"
		end

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class PROCEDURE

