indexing
	description: "[
		Objects representing delayed calls to a procedure.
		with some operands possibly still open.
		
		Note: Features are the same as those of ROUTINE,
			with `apply' made effective, and no further
			redefinition of `is_equal' and `copy'.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PROCEDURE [BASE_TYPE, OPEN_ARGS -> TUPLE create default_create end]

inherit
	ROUTINE [BASE_TYPE, OPEN_ARGS]

feature -- Calls

	apply is
			-- Call procedure with `args' as last set.
		do
			if class_id /= -1 then
				rout_obj_call_procedure_lazy (class_id, feature_id, is_precompiled,
											  is_basic, $internal_operands, internal_operands.count)
			else
				rout_obj_call_procedure (rout_disp, $internal_operands)
			end
		end

feature {NONE} -- Implementation

	rout_obj_call_procedure (rout: POINTER; args: POINTER) is
			-- Perform call to `rout' with `args'.
		external
			"C inline use %"eif_rout_obj.h%""
		alias
			"rout_obj_call_agent($rout, $args, $$_result_type);"
		end


	rout_obj_call_procedure_lazy (a_class_id, a_feature_id: INTEGER;
								 a_is_precompiled, a_is_basic: BOOLEAN
								 args: POINTER
								 arg_count: INTEGER) is
			-- Perform call to `rout' with `args' as operands.
		external
			"C inline use %"eif_rout_obj.h%""
		alias
			"[
				#ifdef WORKBENCH
				 	rout_obj_call_procedure_dynamic (
				 		$a_class_id, $a_feature_id, $a_is_precompiled, $a_is_basic, $args, $arg_count);
				#endif
			]"
		end

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"







end -- class PROCEDURE

