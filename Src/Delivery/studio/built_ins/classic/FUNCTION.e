class FUNCTION [OPEN_ARGS -> detachable TUPLE create default_create end, RESULT_TYPE]

feature -- Access
		
	item alias "()" (args: detachable separate OPEN_ARGS): RESULT_TYPE
			-- Result of calling function with `args' as operands.
		require
			valid_operands: valid_operands (args)
		local
			closed_arguments_count: like closed_count
		do
				-- Avoid making any calls that may trigger GC when passing pointers to reference variables
				-- and use temporary locals to record results of the calls (this fixes test#thread024).
			closed_arguments_count := closed_count
			Result := fast_item (encaps_rout_disp, calc_rout_addr, $closed_operands, $args, routine_id,
				is_basic, written_type_id_inline_agent, closed_arguments_count, open_count, $open_map)
		end

feature {NONE} -- Implementation

	fast_item (a_rout_disp, a_calc_rout_addr: POINTER;
		       a_closed_operands: POINTER; a_operands: POINTER;
			   a_routine_id: INTEGER; a_is_basic: BOOLEAN; a_class_id_inline_agent: INTEGER;
			   a_closed_count, a_open_count: INTEGER; a_open_map: POINTER): RESULT_TYPE
		external
			"C inline use %"eif_rout_obj.h%""
		alias
			"[
			#ifdef WORKBENCH
				$$_result_type result;
				if ($a_rout_disp != 0) {
					return (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_POINTER, EIF_REFERENCE, EIF_REFERENCE)) $a_rout_disp)(
						$a_calc_rout_addr, $a_closed_operands, $a_operands).$$_result_value;
				} else {
					rout_obj_call_function_dynamic (
						$a_routine_id,
						$a_is_basic,
						$a_class_id_inline_agent,
						$a_closed_operands,
						$a_closed_count,
						$a_operands,
						$a_open_count,
						$a_open_map, 
						&result);
					return result;
				}
			#else
				return (FUNCTION_CAST($$_result_type, (EIF_POINTER, EIF_REFERENCE, EIF_REFERENCE)) $a_rout_disp)(
					$a_calc_rout_addr, $a_closed_operands, $a_operands);
			#endif
			]"
		end
		
end
