class PROCEDURE [T_T -> ANY, A_T ->TUPLE]

inherit
	ROUTINE [T_T, A_T]
		redefine
			call, apply_to
		end

feature -- Calls

	call (tgt : T_T; args : A_T) is

		do
			target := tgt
			rout_set_arguments (args)
			rout_obj_call_procedure (rout_disp, rout_cargs)
		end

	apply is

		do
			rout_obj_call_procedure (rout_disp, rout_cargs)
		end

	apply_to (tgt : T_T) is

		do
			target := tgt
			rout_set_cargs
			rout_obj_call_procedure (rout_disp, rout_cargs)
		end

feature {NONE} -- Implementation

	-- WARNING:
	-- Modifying or using one of the following
	-- features may give unpredictable results.

	rout_obj_call_procedure (rout : POINTER; args : POINTER) is

		external "C[macro %"eif_rout_obj.h%"]"
		end

end -- class PROCEDURE

