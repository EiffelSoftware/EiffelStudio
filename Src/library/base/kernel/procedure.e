class PROCEDURE [TBASE, TOPEN ->TUPLE]

inherit
	ROUTINE [TBASE, TOPEN]
		redefine
			call
		end

feature -- Calls

	call (args: TOPEN) is

		do
			arguments := args
			rout_set_cargs
			rout_obj_call_procedure (rout_disp, rout_cargs)
		end

	apply is

		do
			rout_set_cargs
			rout_obj_call_procedure (rout_disp, rout_cargs)
		end

feature {NONE} -- Implementation

	rout_obj_call_procedure (rout: POINTER; args: POINTER) is

		external "C[macro %"eif_rout_obj.h%"]"
		end

end -- class PROCEDURE

