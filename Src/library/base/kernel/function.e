indexing
	description:
		"Objects representing delayed calls to a funtion,%N%
		%with some arguments possibly sill open."
	note:
		"Features are the same as those of RUOTINE,%N%
		%with `apply' made effective, and the addition%N%
		%of `last_result' and `item'."
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	FUNCTION [BASE_TYPE, OPEN_ARGS -> TUPLE, RESULT_TYPE]

inherit
	ROUTINE [BASE_TYPE, OPEN_ARGS]
		redefine
			call, is_equal, copy, func_init
		end

feature -- Access
	
	last_result: RESULT_TYPE is
			-- Result of last call, if any.
		do
			Result := result_array.item (1)
		end

	item (args: OPEN_ARGS): RESULT_TYPE is
			-- Result of calling function with `args' as operands.
		require
			valid_operands: valid_operands (args)
			callable: callable
		do
			operands := args
			rout_set_cargs
			rout_obj_call_function ($Current, $result_array, 
					rout_disp, rout_cargs)
			Result := last_result
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is associated funtion the same as the one
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
			result_array.put (other.last_result, 1)
		end

feature -- Basic operations

	call (args: OPEN_ARGS) is
			-- Call function with operands `args'.
		do
			operands := args
			rout_set_cargs
			rout_obj_call_function ($Current, $result_array, 
									rout_disp, rout_cargs)
		end

	apply is
			-- Call function with `operands' as last set.
		do
			rout_set_cargs
			rout_obj_call_function ($Current, $result_array, 
									rout_disp, rout_cargs)
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

	func_init is
			-- Initialize object.
		do
			create result_array.make (1, 1)
		end

	result_array : ARRAY [RESULT_TYPE]
			-- Array used to return result.

	rout_obj_call_function (cur, res, rout, args: POINTER) is
			-- Perform call to `rout' on `cur' object with `args'
			-- as operands and return `res'.
		external
			"C | %"eif_rout_obj.h%""
		end

end -- class FUNCTION

--|----------------------------------------------------------------
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------
