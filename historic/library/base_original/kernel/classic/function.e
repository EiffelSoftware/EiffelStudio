note
	description: "[
		Objects representing delayed calls to a function,
		with some arguments possibly still open.
		
		Note: Features are the same as those of ROUTINE,
			with `apply' made effective, and the addition
			of `last_result' and `item'.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FUNCTION [BASE_TYPE, OPEN_ARGS -> TUPLE create default_create end, RESULT_TYPE]

inherit
	ROUTINE [BASE_TYPE, OPEN_ARGS]
		redefine
			is_equal, copy
		end

feature -- Access

	last_result: RESULT_TYPE
			-- Result of last call, if any.

	call (args: OPEN_ARGS)
		local
			l_closed_count: INTEGER
		do
			l_closed_count :=  closed_operands.count
			last_result := fast_item (encaps_rout_disp, calc_rout_addr, $closed_operands, $args, class_id, feature_id,
				is_precompiled, is_basic, is_inline_agent, l_closed_count, open_count, $open_map)
		end

	item (args: OPEN_ARGS): RESULT_TYPE
			-- Result of calling function with `args' as operands.
		require
			valid_operands: valid_operands (args)
		local
			l_closed_count: INTEGER
		do
			l_closed_count :=  closed_operands.count
			Result := fast_item (encaps_rout_disp, calc_rout_addr, $closed_operands, $args, class_id, feature_id,
				is_precompiled, is_basic, is_inline_agent, l_closed_count, open_count, $open_map)
		end

	apply
			-- Call function with `operands' as last set.
		local
			l_closed_count: INTEGER
		do
			l_closed_count :=  closed_operands.count
			last_result := fast_item (encaps_rout_disp, calc_rout_addr, $closed_operands, $operands, class_id, feature_id,
				is_precompiled, is_basic, is_inline_agent, l_closed_count, open_count, $open_map)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is associated function the same as the one
			-- associated with `other'?
		do
			Result := Precursor (other) and then
					 equal (last_result, other.last_result)
		end

feature -- Duplication

	copy (other: like Current)
			-- Use same function as `other'.
		do
			Precursor (other)
			last_result := other.last_result
		end

feature -- Obsolete

	eval (args: OPEN_ARGS): RESULT_TYPE
			-- Result of evaluating function for `args'.
		obsolete
			"Please use `item' instead"
		require
			valid_operands: valid_operands (args)
		do
			Result := item (args)
		end

feature -- Removal

	clear_last_result
			-- Reset content of `last_result' to its default value
		local
			l_result: RESULT_TYPE
		do
			last_result := l_result
		end

feature {NONE} -- Implementation

	fast_item (a_rout_disp, a_calc_rout_addr: POINTER
		       a_closed_operands: POINTER; a_operands: POINTER
			   a_class_id, a_feature_id: INTEGER; a_is_precompiled, a_is_basic, a_is_inline_agent: BOOLEAN
			   a_closed_count, a_open_count: INTEGER; a_open_map: POINTER): RESULT_TYPE
		external
			"C inline use %"eif_rout_obj.h%""
		alias
			"[
			#ifdef WORKBENCH
				$$_result_type result;
				if ($a_rout_disp != 0) {
					return (FUNCTION_CAST($$_result_type, (EIF_POINTER, EIF_REFERENCE, EIF_REFERENCE)) $a_rout_disp)(
						$a_calc_rout_addr, $a_closed_operands, $a_operands);
				} else {
					rout_obj_call_function_dynamic (
						$a_class_id,
						$a_feature_id,
						$a_is_precompiled,
						$a_is_basic,
						$a_is_inline_agent,
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

end -- class FUNCTION

