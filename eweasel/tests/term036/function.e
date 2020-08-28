note

	description: "[
		Objects representing delayed calls to a function,
		with some arguments possibly still open.
		]"

	status: "See notice at end of class"

	date: "$Date$"

	revision: "$Revision$"

class
	FUNCTION [OPEN_ARGS -> TUPLE, RESULT_TYPE]

inherit
	ROUTINE [ANY, OPEN_ARGS]
		redefine
			is_equal, copy
		end

feature -- Access
	
	last_result: RESULT_TYPE
			-- Result of last call, if any.
		do
			if result_array /= Void then
				Result := result_array.item (1)
			end
		end

	item (args: OPEN_ARGS): RESULT_TYPE
			-- Result of calling function with `args' as operands.
		require
			valid_operands: valid_operands (args)
			callable: callable
		do
			operands := args
			apply
			Result := last_result
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is associated function the same as the one
			-- associated with `other'?
		do
			Result := Precursor (other) and then
					 last_result ~ other.last_result
		end

feature -- Duplication

	copy (other: like Current)
			-- Use same function as `other'.
		do
			Precursor (other)
			if result_array = Void then
				create result_array.make (1, 1)
			end
			result_array.put (other.last_result, 1)
		end

feature -- Basic operations

	apply
			-- Call function with `operands' as last set.
		do
			if result_array = Void then
				create result_array.make (1, 1)
			end
			rout_set_cargs
			rout_obj_call_function ($result_array, 
									rout_disp, rout_cargs)
		end

feature -- Obsolete

	eval (args: OPEN_ARGS): RESULT_TYPE
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

	result_array: ARRAY [RESULT_TYPE]
			-- Array used to return result.

	rout_obj_call_function (res, rout, args: POINTER)
			-- Perform call to `rout' on `cur' object with `args'
			-- as operands and return `res'.
		external
			"C | %"eif_rout_obj.h%""
		end

note

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

