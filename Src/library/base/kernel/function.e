indexing
	description: "";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class FUNCTION [TBASE, TOPEN -> TUPLE, TRESULT]

inherit
	ROUTINE [TBASE, TOPEN]
		redefine
			call, is_equal, copy, func_init
		end

feature -- Access
	
	last_result: TRESULT is
			-- Result of last call
		do
			Result := result_array.item (1)
		end

feature -- Calls

	call (args: TOPEN) is

		do
			arguments := args
			rout_set_cargs
			rout_obj_call_function ($Current, $result_array, 
									rout_disp, rout_cargs)
		end

	apply is

		do
			rout_set_cargs
			rout_obj_call_function ($Current, $result_array, 
									rout_disp, rout_cargs)
		end

	eval (args: TOPEN): TRESULT is
			-- Evaluate function for `args'.
		require
			valid_arguments: valid_arguments (args)
			callable: callable
		do
			arguments := args
			rout_set_cargs
			rout_obj_call_function ($Current, $result_array, 
									rout_disp, rout_cargs)
			Result := result_array.item (1)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is

		do
			Result := Precursor (other) and then
					  equal (last_result, other.last_result)
		end

feature -- Duplication

	copy (other: like Current) is

		do
			Precursor (other)
			result_array.put (other.last_result, 1)
		end

feature {NONE} -- Implementation

	func_init is
			-- Initialisation
		do
			!!result_array.make (1, 1)
		end

	result_array : ARRAY [TRESULT]
			-- Array used to return result.

	rout_obj_call_function (cur, res, rout, args: POINTER) is

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
