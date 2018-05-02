class PROCEDURE [OPEN_ARGS -> detachable TUPLE create default_create end]

feature -- Calls

	call alias "()" (args: detachable separate OPEN_ARGS)
		local
			closed_arguments_count: like closed_count
		do
				-- Avoid making any calls that may trigger GC when passing pointers to reference variables
				-- and use temporary locals to record results of the calls (this fixes test#thread024).
			closed_arguments_count := closed_count
			fast_call (encaps_rout_disp, calc_rout_addr, $closed_operands, $args, routine_id,
				       is_basic, written_type_id_inline_agent, closed_arguments_count, open_count, $open_map)
		end

feature {NONE} -- Implementation

	fast_call (a_rout_disp, a_calc_rout_addr: POINTER;
		       a_closed_operands: POINTER; a_operands: POINTER;
			   a_routine_id: INTEGER; a_is_basic: BOOLEAN; a_class_id_inline_agent: INTEGER;
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
						$a_routine_id,
						$a_is_basic,
						$a_class_id_inline_agent,
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
		
end
