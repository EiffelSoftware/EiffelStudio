indexing
	description: "[
		Objects representing delayed calls to a function,
		with some arguments possibly still open.
		]"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	FUNCTION [BASE_TYPE, OPEN_ARGS -> TUPLE create default_create end, RESULT_TYPE]

inherit
	ROUTINE [BASE_TYPE, OPEN_ARGS]
		redefine
			is_equal, copy
		end

feature -- Access
	
	last_result: RESULT_TYPE
			-- Result of last call, if any.

	item (args: OPEN_ARGS): RESULT_TYPE is
			-- Result of calling function with `args' as operands.
		require
			valid_operands: valid_operands (args)
			callable: callable
		do
			set_operands (args)
			Result := rout_obj_call_function (rout_disp, $internal_operands)
			last_result := Result
			if is_cleanup_needed then
				remove_gc_reference
			end
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is associated function the same as the one
			-- associated with `other'?
		do
			Result := Precursor (other) and then
					 equal (last_result, other.last_result)
		end

feature -- Duplication

	copy (other: like Current) is
			-- Use same function as `other'.
		do
			Precursor (other)
			last_result := other.last_result
		end

feature -- Basic operations

	apply is
			-- Call function with `operands' as last set.
		do
			last_result := rout_obj_call_function (rout_disp, $internal_operands)
		end

feature -- Obsolete

	eval (args: OPEN_ARGS): RESULT_TYPE is
			-- Result of evaluating function for `args'.
		obsolete
			"Please use `item' instead"
		require
			valid_operands: valid_operands (args)
			callable: callable
		do
			Result := item (args)
		end

feature {NONE} -- Implementation

	rout_obj_call_function (rout, args: POINTER): RESULT_TYPE is
			-- Perform call to `rout' with `args' as operands.
		external
			"C inline use %"eif_rout_obj.h%""
		alias
			"rout_obj_call_agent($rout, $args, $$_result_type)"
		end

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
--| Copyright (c) 1993-2006 University of Southern California and contributors.
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

end -- class FUNCTION

