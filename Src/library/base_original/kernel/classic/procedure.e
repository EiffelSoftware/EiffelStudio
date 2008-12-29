note
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

	apply
			-- Call procedure with `args' as last set.
		do
			call (operands)
		end

	call (args: OPEN_ARGS)
			-- Call procedure with `args'.
		local
			l_closed_count: INTEGER
		do
			l_closed_count :=  closed_operands.count
			fast_call (encaps_rout_disp, calc_rout_addr, $closed_operands, $args, class_id, feature_id,
				       is_precompiled, is_basic, is_inline_agent, l_closed_count, open_count, $open_map)
		end

feature {NONE} -- Implementation

	fast_call (a_rout_disp, a_calc_rout_addr: POINTER;
		       a_closed_operands: POINTER; a_operands: POINTER;
			   a_class_id, a_feature_id: INTEGER; a_is_precompiled, a_is_basic, a_is_inline_agent: BOOLEAN;
			   a_closed_count, a_open_count: INTEGER; a_open_map: POINTER)
		external
			"C inline use %"eif_rout_obj.h%""
		alias
			"[
			#ifdef WORKBENCH
				if ($a_rout_disp != 0) {
					(FUNCTION_CAST(void, (EIF_POINTER, EIF_REFERENCE, EIF_REFERENCE)) $a_rout_disp)(
						$a_calc_rout_addr, $a_closed_operands, $a_operands);
				} else {
					rout_obj_call_procedure_dynamic (
						$a_class_id,
						$a_feature_id,
						$a_is_precompiled,
						$a_is_basic,
						$a_is_inline_agent,
						$a_closed_operands,
						$a_closed_count,
						$a_operands,
						$a_open_count,
						$a_open_map);
				}
			#else
				(FUNCTION_CAST(void, (EIF_POINTER, EIF_REFERENCE, EIF_REFERENCE)) $a_rout_disp)(
					$a_calc_rout_addr, $a_closed_operands, $a_operands);
			#endif
			]"
		end

note
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

