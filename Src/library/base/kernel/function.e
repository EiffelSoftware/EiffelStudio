class FUNCTION [T_T -> ANY, A_T ->TUPLE, R_T]

inherit
	ROUTINE [T_T, A_T]
		redefine
			call, apply_to, is_equal, copy
		end
feature -- Access
	
	last_result : R_T

feature -- Calls

	call (tgt : T_T; args : A_T) is

		do
			target := tgt
			rout_set_arguments (args)
			call_function
		end

	apply is

		do
			call_function
		end

	apply_to (tgt : T_T) is

		do
			target := tgt
			rout_set_cargs
			call_function
		end

	eval (tgt : T_T; args : A_T) : R_T is
			-- Evaluate function for `tgt' with `args'.
		require
			valid_target : tgt /= Void
			valid_arguments: valid_arguments (args)
			callable: callable
		do
			target := tgt
			rout_set_arguments (args)
			call_function
			Result := last_result
		end

	eval_for (tgt : T_T) : R_T is
			-- Evaluate function for `tgt' with `arguments'.
		require
			valid_target : tgt /= Void
			callable: callable
		do
			target := tgt
			rout_set_cargs
			call_function
			Result := last_result
		end

feature -- Comparison

	is_equal (other : like Current) : BOOLEAN is

		do
			Result := Precursor (other) and then
					  equal (last_result, other.last_result)
		end

feature -- Duplication

	copy (other : like Current) is

		do
			Precursor (other)
			last_result := other.last_result
		end

feature {NONE} -- Implementation

	-- WARNING:
	-- Modifying or using one of the following
	-- features may give unpredictable results.

	frozen call_function is
		-- Execute function call. 
		local
			ra : ARRAY [R_T]
		do
			!!ra.make (1, 1)
			rout_obj_call_function ($Current, $ra, 
									rout_disp, rout_cargs)
			last_result := ra.item (1)
		end

	rout_obj_call_function (cur, res, rout, args : POINTER) is

		external "C | %"eif_rout_obj.h%""
		end

end -- class FUNCTION

