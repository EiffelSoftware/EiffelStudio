class FUNCTION [TBASE, TOPEN -> TUPLE, TRESULT]

inherit
	ROUTINE [TBASE, TOPEN]
		redefine
			call, is_equal, copy
		end

feature -- Access
	
	last_result: TRESULT

feature -- Calls

	call (args: TOPEN) is

		do
			arguments := args
			rout_set_cargs
			call_function
		end

	apply is

		do
			rout_set_cargs
			call_function
		end

	eval (args: TOPEN): TRESULT is
			-- Evaluate function for `args'.
		require
			valid_arguments: valid_arguments (args)
			callable: callable
		do
			arguments := args
			rout_set_cargs
			call_function
			Result := last_result
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
			last_result := other.last_result
		end

feature {NONE} -- Implementation

	frozen call_function is
		-- Execute function call. 
		local
			ra: ARRAY [TRESULT]
		do
			!!ra.make (1, 1)
			rout_obj_call_function ($Current, $ra, 
									rout_disp, rout_cargs)
			last_result := ra.item (1)
		end

	rout_obj_call_function (cur, res, rout, args: POINTER) is

		external "C | %"eif_rout_obj.h%""
		end

end -- class FUNCTION

