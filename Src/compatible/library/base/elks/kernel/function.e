note
	description: "[
		Objects representing delayed calls to a function,
		with some arguments possibly still open.
		
		Note: Features are the same as those of ROUTINE,
			with `apply' made effective, and the addition
			of `last_result' and `item'.
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	FUNCTION [BASE_TYPE, OPEN_ARGS -> detachable TUPLE create default_create end, RESULT_TYPE]

inherit
	ROUTINE [BASE_TYPE, OPEN_ARGS]
		redefine
			is_equal, copy
		end

create {NONE}
	set_rout_disp

feature -- Access

	last_result: detachable RESULT_TYPE
			-- Result of last call, if any

	call (args: detachable OPEN_ARGS)
			-- <Precursor>
		do
			last_result := item (args)
		end

	item (args: detachable OPEN_ARGS): RESULT_TYPE
			-- Result of calling function with `args' as operands.
		require
			valid_operands: valid_operands (args)
		local
			l_closed_count: INTEGER
			c: like closed_operands
		do
			c := closed_operands
			if c/= Void then
				l_closed_count :=  c.count
			end
			Result := fast_item (encaps_rout_disp, calc_rout_addr, $closed_operands, $args, routine_id,
				is_basic, written_type_id_inline_agent, l_closed_count, open_count, $open_map)
		end

	apply
			-- Call function with `operands' as last set.
		do
			last_result := item (operands)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is associated function the same as the one
			-- associated with `other'?
		do
			Result := Precursor (other) and then (last_result ~ other.last_result)
		end

feature -- Duplication

	copy (other: like Current)
			-- Use same function as `other'.
		do
			if other /= Current then
				Precursor (other)
				last_result := other.last_result
			end
		end

feature -- Obsolete

	eval (args: detachable OPEN_ARGS): RESULT_TYPE
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
			-- Reset content of `last_result' to its default value.
		local
			l_result: detachable RESULT_TYPE
		do
			last_result := l_result
		end

feature {NONE} -- Implementation

	fast_item (a_rout_disp, a_calc_rout_addr: POINTER
		       a_closed_operands: POINTER; a_operands: POINTER
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
